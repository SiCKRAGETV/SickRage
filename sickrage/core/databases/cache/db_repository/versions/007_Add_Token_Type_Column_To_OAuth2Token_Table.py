# ##############################################################################
#  Author: echel0n <echel0n@sickrage.ca>
#  URL: https://sickrage.ca/
#  Git: https://git.sickrage.ca/SiCKRAGE/sickrage.git
#  -
#  This file is part of SiCKRAGE.
#  -
#  SiCKRAGE is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#  -
#  SiCKRAGE is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#  -
#  You should have received a copy of the GNU General Public License
#  along with SiCKRAGE.  If not, see <http://www.gnu.org/licenses/>.
# ##############################################################################

from sqlalchemy import *


def upgrade(migrate_engine):
    meta = MetaData(bind=migrate_engine)
    oauth2_token = Table('oauth2_token', meta, autoload=True)
    if not hasattr(oauth2_token.c, 'token_type'):
        token_type = Column('token_type', Text, default='bearer')
        token_type.create(oauth2_token)


def downgrade(migrate_engine):
    meta = MetaData(bind=migrate_engine)
    oauth2_token = Table('oauth2_token', meta, autoload=True)
    if hasattr(oauth2_token.c, 'token_type'):
        oauth2_token.c.token_type.drop()
