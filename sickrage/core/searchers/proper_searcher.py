# Author: echel0n <echel0n@sickrage.ca>
# URL: https://sickrage.ca
# Git: https://git.sickrage.ca/SiCKRAGE/sickrage.git
#
# This file is part of SiCKRAGE.
#
# SiCKRAGE is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# SiCKRAGE is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with SiCKRAGE.  If not, see <http://www.gnu.org/licenses/>.


import datetime
import operator
import re
import threading
import time
import traceback

from sqlalchemy import orm

import sickrage
from sickrage.core.common import DOWNLOADED, Quality, SNATCHED, SNATCHED_PROPER, cpu_presets
from sickrage.core.databases.main import MainDB
from sickrage.core.exceptions import AuthException
from sickrage.core.helpers import remove_non_release_groups
from sickrage.core.nameparser import InvalidNameException, InvalidShowException, NameParser
from sickrage.core.search import pick_best_result, snatch_episode
from sickrage.core.tv.episode import TVEpisode
from sickrage.core.tv.show.helpers import find_show, get_show_list
from sickrage.core.tv.show.history import History
from sickrage.providers import NZBProvider, NewznabProvider, TorrentProvider, TorrentRssProvider


class ProperSearcher(object):
    def __init__(self, *args, **kwargs):
        self.name = "PROPERSEARCHER"
        self.amActive = False

    def run(self, force=False):
        """
        Start looking for new propers
        :param force: Start even if already running (currently not used, defaults to False)
        """
        if self.amActive or (not sickrage.app.config.download_propers or sickrage.app.developer) and not force:
            return

        self.amActive = True

        # set thread name
        threading.currentThread().setName(self.name)

        sickrage.app.log.info("Beginning the search for new propers")
        propers = self._getProperList()

        if propers:
            self._downloadPropers(propers)
        else:
            sickrage.app.log.info('No recently aired episodes, no propers to search for')

        sickrage.app.log.info("Completed the search for new propers")

        self.amActive = False

    def _getProperList(self):
        """
        Walk providers for propers
        """

        propers = {}
        final_propers = []

        search_date = datetime.datetime.today() - datetime.timedelta(days=2)

        orig_thread_name = threading.currentThread().getName()

        for show in get_show_list():
            self._lastProperSearch = self._get_last_proper_search(show.indexer_id)

            recently_aired_episode_ids = []
            for episode_obj in TVEpisode.query.filter_by(showid=show.indexer_id).filter(
                    TVEpisode.airdate >= search_date,
                    TVEpisode.status.in_(Quality.DOWNLOADED + Quality.SNATCHED + Quality.SNATCHED_BEST)):
                recently_aired_episode_ids += [episode_obj.indexer_id]

            self._set_last_proper_search(show.indexer_id, datetime.datetime.today().toordinal())

            if not recently_aired_episode_ids:
                continue

            # for each provider get a list of the
            for providerID, providerObj in sickrage.app.search_providers.sort(
                    randomize=sickrage.app.config.randomize_providers).items():
                # check provider type and provider is enabled
                if not sickrage.app.config.use_nzbs and providerObj.type in [NZBProvider.type,
                                                                             NewznabProvider.type]:
                    continue
                elif not sickrage.app.config.use_torrents and providerObj.type in [TorrentProvider.type,
                                                                                   TorrentRssProvider.type]:
                    continue
                elif not providerObj.isEnabled:
                    continue

                threading.currentThread().setName(orig_thread_name + " :: [" + providerObj.name + "]")

                sickrage.app.log.info("Searching for any new PROPER releases from " + providerObj.name)

                try:
                    cur_propers = providerObj.find_propers(show.indexer_id, recently_aired_episode_ids)
                except AuthException as e:
                    sickrage.app.log.warning("Authentication error: {}".format(e))
                    continue
                except Exception as e:
                    sickrage.app.log.debug(
                        "Error while searching " + providerObj.name + ", skipping: {}".format(e))
                    sickrage.app.log.debug(traceback.format_exc())
                    continue

                # if they haven't been added by a different provider than add the proper to the list
                for x in cur_propers:
                    if not re.search(r'(^|[. _-])(proper|repack)([. _-]|$)', x.name, re.I):
                        sickrage.app.log.debug('findPropers returned a non-proper, we have caught and skipped it.')
                        continue

                    name = self._generic_name(x.name)
                    if name not in propers:
                        sickrage.app.log.debug("Found new proper: " + x.name)
                        x.provider = providerObj
                        propers[name] = x

                threading.currentThread().setName(orig_thread_name)

        # take the list of unique propers and get it sorted by
        sorted_propers = sorted(propers.values(), key=operator.attrgetter('date'), reverse=True)
        for curProper in sorted_propers:
            try:
                parse_result = NameParser(False).parse(curProper.name)
            except InvalidNameException:
                sickrage.app.log.debug(
                    "Unable to parse the filename " + curProper.name + " into a valid episode")
                continue
            except InvalidShowException:
                sickrage.app.log.debug("Unable to parse the filename " + curProper.name + " into a valid show")
                continue

            if not parse_result.series_name:
                continue

            if not parse_result.episode_numbers:
                sickrage.app.log.debug(
                    "Ignoring " + curProper.name + " because it's for a full season rather than specific episode")
                continue

            show = find_show(parse_result.indexer_id)
            sickrage.app.log.debug(
                "Successful match! Result " + parse_result.original_name + " matched to show " + show.name)

            # set the indexer_id in the db to the show's indexer_id
            curProper.indexer_id = parse_result.indexer_id

            # set the indexer in the db to the show's indexer
            curProper.indexer = show.indexer

            # populate our Proper instance
            curProper.season = parse_result.season_number if parse_result.season_number is not None else 1
            curProper.episode = parse_result.episode_numbers[0]
            curProper.release_group = parse_result.release_group
            curProper.version = parse_result.version
            curProper.quality = Quality.name_quality(curProper.name, parse_result.is_anime)
            curProper.content = None

            # filter release
            best_result = pick_best_result(curProper)
            if not best_result:
                sickrage.app.log.debug("Proper " + curProper.name + " were rejected by our release filters.")
                continue

            # only get anime proper if it has release group and version
            if show.is_anime:
                if not best_result.release_group and best_result.version == -1:
                    sickrage.app.log.debug(
                        "Proper " + best_result.name + " doesn't have a release group and version, ignoring it")
                    continue

            # check if we actually want this proper (if it's the right quality)            
            try:
                dbData = TVEpisode.query.filter_by(showid=best_result.indexer_id, season=best_result.season,
                                                   episode=best_result.episode).one()

                # only keep the proper if we have already retrieved the same quality ep (don't get better/worse ones)
                old_status, old_quality = Quality.split_composite_status(int(dbData.status))
                if old_status not in (DOWNLOADED, SNATCHED) or old_quality != best_result.quality:
                    continue
            except orm.exc.NoResultFound:
                continue

            # check if we actually want this proper (if it's the right release group and a higher version)
            if show.is_anime:
                dbData = TVEpisode.query.filter_by(showid=best_result.indexer_id, season=best_result.season,
                                                   episode=best_result.episode).one()
                old_version = int(dbData.version)
                old_release_group = dbData.release_group
                if not -1 < old_version < best_result.version:
                    continue

                sickrage.app.log.info(
                    "Found new anime v" + str(best_result.version) + " to replace existing v" + str(old_version))

                if old_release_group != best_result.release_group:
                    sickrage.app.log.info("Skipping proper from release group: {}, does not match existing release "
                                          "group: {}".format(best_result.release_group, old_release_group))
                    continue

            # if the show is in our list and there hasn't been a proper already added for that particular episode
            # then add it to our list of propers
            if best_result.indexer_id != -1 and (
                    best_result.indexer_id, best_result.season, best_result.episode) not in map(
                operator.attrgetter('indexer_id', 'season', 'episode'), final_propers):
                sickrage.app.log.info("Found a proper that we need: " + str(best_result.name))
                final_propers.append(best_result)

        return final_propers

    def _downloadPropers(self, proper_list):
        """
        Download proper (snatch it)

        :param proper_list:
        """

        for curProper in proper_list:
            history_limit = datetime.datetime.today() - datetime.timedelta(days=30)

            # make sure the episode has been downloaded before
            history_results = [x for x in
                               MainDB.History.query.filter_by(showid=curProper.indexer_id, season=curProper.season,
                                                              episode=curProper.episode,
                                                              quality=curProper.quality).filter(
                                   MainDB.History.date >= history_limit.strftime(History.date_format),
                                   MainDB.History.action.in_(Quality.SNATCHED + Quality.DOWNLOADED))]

            # if we didn't download this episode in the first place we don't know what quality to use for the proper
            # so we can't do it
            if len(history_results) == 0:
                sickrage.app.log.info("Unable to find an original history entry for proper {} so I'm not downloading "
                                      "it.".format(curProper.name))
                continue

            # make sure that none of the existing history downloads are the same proper we're trying to download
            is_same = False
            clean_proper_name = self._generic_name(remove_non_release_groups(curProper.name))

            for curResult in history_results:
                # if the result exists in history already we need to skip it
                if self._generic_name(
                        remove_non_release_groups(curResult.resource)) == clean_proper_name:
                    is_same = True
                    break

            if is_same:
                sickrage.app.log.debug("This proper is already in history, skipping it")
                continue

            # make the result object
            show = find_show(curProper.indexer_id)
            result = curProper.provider.getResult([show.get_episode(curProper.season, curProper.episode).indexer_id])
            result.show_id = show.indexer_id
            result.url = curProper.url
            result.name = curProper.name
            result.quality = curProper.quality
            result.release_group = curProper.release_group
            result.version = curProper.version
            result.seeders = curProper.seeders
            result.leechers = curProper.leechers
            result.size = curProper.size
            result.files = curProper.files
            result.content = curProper.content

            # snatch it
            snatch_episode(result, SNATCHED_PROPER)
            time.sleep(cpu_presets[sickrage.app.config.cpu_preset])

    def _generic_name(self, name):
        return name.replace(".", " ").replace("-", " ").replace("_", " ").lower()

    def _set_last_proper_search(self, show, when):
        """
        Record last propersearch in DB

        :param when: When was the last proper search
        """

        sickrage.app.log.debug("Setting the last proper search in database to " + str(when))

        try:
            show.last_proper_search = when
        except orm.exc.NoResultFound:
            pass

    @staticmethod
    def _get_last_proper_search(show):
        """
        Find last propersearch from DB
        """

        sickrage.app.log.debug("Retrieving the last check time from the DB")

        try:
            return int(show.last_proper_search)
        except orm.exc.NoResultFound:
            return 1
