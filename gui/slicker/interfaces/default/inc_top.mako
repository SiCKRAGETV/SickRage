<%!
    import sickbeard
%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width">

		<!-- These values come from css/dark.css and css/light.css -->
		% if sickbeard.THEME_NAME == "dark":
		<meta name="theme-color" content="#15528F">
		% elif sickbeard.THEME_NAME == "light":
		<meta name="theme-color" content="#333333">
		% endif

		<title>SickRage - BRANCH:[${sickbeard.BRANCH}] - ${title}</title>

		<!--[if lt IE 9]>
			<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
			<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
		<![endif]-->

		<link rel="shortcut icon" href="${sbRoot}/images/ico/favicon.ico">
		<link rel="icon" sizes="16x16 32x32 64x64" href="${sbRoot}/images/ico/favicon.ico">
		<link rel="icon" type="image/png" sizes="196x196" href="${sbRoot}/images/ico/favicon-196.png">
		<link rel="icon" type="image/png" sizes="160x160" href="${sbRoot}/images/ico/favicon-160.png">
		<link rel="icon" type="image/png" sizes="96x96" href="${sbRoot}/images/ico/favicon-96.png">
		<link rel="icon" type="image/png" sizes="64x64" href="${sbRoot}/images/ico/favicon-64.png">
		<link rel="icon" type="image/png" sizes="32x32" href="${sbRoot}/images/ico/favicon-32.png">
		<link rel="icon" type="image/png" sizes="16x16" href="${sbRoot}/images/ico/favicon-16.png">
		<link rel="apple-touch-icon" sizes="152x152" href="${sbRoot}/images/ico/favicon-152.png">
		<link rel="apple-touch-icon" sizes="144x144" href="${sbRoot}/images/ico/favicon-144.png">
		<link rel="apple-touch-icon" sizes="120x120" href="${sbRoot}/images/ico/favicon-120.png">
		<link rel="apple-touch-icon" sizes="114x114" href="${sbRoot}/images/ico/favicon-114.png">
		<link rel="apple-touch-icon" sizes="76x76" href="${sbRoot}/images/ico/favicon-76.png">
		<link rel="apple-touch-icon" sizes="72x72" href="${sbRoot}/images/ico/favicon-72.png">
		<link rel="apple-touch-icon" href="${sbRoot}/images/ico/favicon-57.png">
		<meta name="msapplication-TileColor" content="#FFFFFF">
		<meta name="msapplication-TileImage" content="${sbRoot}/images/ico/favicon-144.png">
		<meta name="msapplication-config" content="${sbRoot}/css/browserconfig.xml">

		<link rel="stylesheet" type="text/css" href="${sbRoot}/css/lib/bootstrap.css?${sbPID}"/>
		<link rel="stylesheet" type="text/css" href="${sbRoot}/css/browser.css?${sbPID}" />
		<link rel="stylesheet" type="text/css" href="${sbRoot}/css/lib/jquery-ui-1.10.4.custom.css?${sbPID}" />
		<link rel="stylesheet" type="text/css" href="${sbRoot}/css/lib/jquery.qtip-2.2.1.min.css?${sbPID}"/>
		<link rel="stylesheet" type="text/css" href="${sbRoot}/css/style.css?${sbPID}"/>
		<link rel="stylesheet" type="text/css" href="${sbRoot}/css/${sickbeard.THEME_NAME}.css?${sbPID}" />
		<link rel="stylesheet" type="text/css" href="http://bootswatch.com/cosmo/bootstrap.min.css" />
		<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
		% if sbLogin:
		<link rel="stylesheet" type="text/css" href="${sbRoot}/css/lib/pnotify.custom.min.css?${sbPID}" />
		<link rel="stylesheet" type="text/css" href="${sbRoot}/css/country-flags.css?${sbPID}"/>
		% endif

		<script type="text/javascript" src="${sbRoot}/js/lib/jquery-1.11.2.min.js?${sbPID}"></script>
		<script type="text/javascript" src="${sbRoot}/js/lib/bootstrap.min.js?${sbPID}"></script>
		<script type="text/javascript" src="${sbRoot}/js/lib/bootstrap-hover-dropdown.min.js?${sbPID}"></script>
		<script type="text/javascript" src="${sbRoot}/js/lib/jquery-ui-1.10.4.custom.min.js?${sbPID}"></script>

		% if sbLogin:
		<script type="text/javascript" src="${sbRoot}/js/lib/jquery.cookie.js?${sbPID}"></script>
		<script type="text/javascript" src="${sbRoot}/js/lib/jquery.cookiejar.js?${sbPID}"></script>
		<script type="text/javascript" src="${sbRoot}/js/lib/jquery.json-2.2.min.js?${sbPID}"></script>
		<script type="text/javascript" src="${sbRoot}/js/lib/jquery.selectboxes.min.js?${sbPID}"></script>
		<script type="text/javascript" src="${sbRoot}/js/lib/jquery.tablesorter-2.17.7.min.js?${sbPID}"></script>
		<script type="text/javascript" src="${sbRoot}/js/lib/jquery.tablesorter.widgets-2.17.7.min.js?${sbPID}"></script>
		<script type="text/javascript" src="${sbRoot}/js/lib/jquery.tablesorter.widget-columnSelector-2.17.7.js?${sbPID}"></script>
		<script type="text/javascript" src="${sbRoot}/js/lib/jquery.qtip-2.2.1.min.js?${sbPID}"></script>
		<script type="text/javascript" src="${sbRoot}/js/lib/pnotify.custom.min.js"></script>
		<script type="text/javascript" src="${sbRoot}/js/lib/jquery.form-3.35.js?${sbPID}"></script>
		<script type="text/javascript" src="${sbRoot}/js/lib/jquery.ui.touch-punch-0.2.2.min.js?${sbPID}"></script>
		<script type="text/javascript" src="${sbRoot}/js/lib/isotope.pkgd.min.js?${sbPID}"></script>
		<script type="text/javascript" src="${sbRoot}/js/lib/jquery.confirm.js?${sbPID}"></script>
		<script type="text/javascript" src="${sbRoot}/js/script.js?${sbPID}"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-backstretch/2.0.4/jquery.backstretch.min.js"></script>
        <link rel="stylesheet" href="${sbRoot}/css/jquery.mCustomScrollbar.min.css?${sbPID}" />
		<script src="${sbRoot}/js/jquery.mCustomScrollbar.concat.min.js?${sbPID}"></script>
		<link rel="stylesheet" href="${sbRoot}/css/coverflow.css?${sbPID}" />

		% if sickbeard.FUZZY_DATING:
		<script type="text/javascript" src="${sbRoot}/js/moment/moment.min.js?${sbPID}"></script>
		<script type="text/javascript" src="${sbRoot}/js/fuzzyMoment.js?${sbPID}"></script>
		% endif
		<script type="text/javascript" charset="utf-8">
			sbRoot = '${sbRoot}'; // needed for browser.js & ajaxNotifications.js
			//HTML for scrolltopcontrol, which is auto wrapped in DIV w/ ID="topcontrol"
			top_image_html = '<img src="${sbRoot}/images/top.gif" width="31" height="11" alt="Jump to top" />';
			themeSpinner = ${('', '-dark')[sickbeard.THEME_NAME == 'dark']};
			anonURL = ${sickbeard.ANON_REDIRECT};
		</script>
		<script type="text/javascript" src="${sbRoot}/js/lib/jquery.scrolltopcontrol-1.1.js"></script>
		<script type="text/javascript" src="${sbRoot}/js/browser.js"></script>
		<script type="text/javascript" src="${sbRoot}/js/ajaxNotifications.js"></script>
		<script type="text/javascript">
			function initActions() {
				$("#SubMenu a[href*='/home/restart/']").addClass('restart').html('<span class="submenu-icon-restart"></span> Restart');
                $("#SubMenu a[href*='/home/shutdown/']").addClass('shutdown').html('<span class="submenu-icon-shutdown"></span> Shutdown');
                $("#SubMenu a[href*='/home/logout/']").html('<span class="ui-icon ui-icon-power"></span> Logout');
                $("#SubMenu a:contains('Edit')").html('<span class="ui-icon ui-icon-pencil"></span> Edit');
                $("#SubMenu a:contains('Remove')").addClass('remove').html('<span class="ui-icon ui-icon-trash"></span> Remove');
                $("#SubMenu a:contains('Clear History')").addClass('clearhistory').html('<span class="ui-icon ui-icon-trash"></span> Clear History');
                $("#SubMenu a:contains('Trim History')").addClass('trimhistory').html('<span class="ui-icon ui-icon-trash"></span> Trim History');
                $("#SubMenu a[href$='/errorlogs/clearerrors/']").html('<span class="ui-icon ui-icon-trash"></span> Clear Errors');
                $("#SubMenu a[href$='/errorlogs/submit_errors/']").html('<span class="ui-icon ui-icon-arrowreturnthick-1-n"></span> Submit Errors');
                $("#SubMenu a:contains('Re-scan')").html('<span class="ui-icon ui-icon-refresh"></span> Re-scan');
                $("#SubMenu a:contains('Backlog Overview')").html('<span class="ui-icon ui-icon-refresh"></span> Backlog Overview');
                $("#SubMenu a[href$='/home/updatePLEX/']").html('<span class="ui-icon ui-icon-refresh"></span> Update PLEX');
                $("#SubMenu a:contains('Force')").html('<span class="ui-icon ui-icon-transfer-e-w"></span> Force Full Update');
                $("#SubMenu a:contains('Rename')").html('<span class="ui-icon ui-icon-tag"></span> Preview Rename');
                $("#SubMenu a[href$='/config/subtitles/']").html('<span class="ui-icon ui-icon-comment"></span> Search Subtitles');
                $("#SubMenu a[href*='/home/subtitleShow']").html('<span class="ui-icon ui-icon-comment"></span> Download Subtitles');
                $("#SubMenu a:contains('Anime')").html('<span class="submenu-icon-anime"></span> Anime');
                $("#SubMenu a:contains('Settings')").html('<span class="ui-icon ui-icon-search"></span> Search Settings');
                $("#SubMenu a:contains('Provider')").html('<span class="ui-icon ui-icon-search"></span> Search Providers');
                $("#SubMenu a:contains('Backup/Restore')").html('<span class="ui-icon ui-icon-gear"></span> Backup/Restore');
                $("#SubMenu a:contains('General')").html('<span class="ui-icon ui-icon-gear"></span> General');
                $("#SubMenu a:contains('Episode Status')").html('<span class="ui-icon ui-icon-transferthick-e-w"></span> Episode Status Management');
                $("#SubMenu a:contains('Missed Subtitle')").html('<span class="ui-icon ui-icon-transferthick-e-w"></span> Missed Subtitles');
                $("#SubMenu a[href$='/home/addShows/']").html('<span class="ui-icon ui-icon-video"></span> Add Show');
                $("#SubMenu a:contains('Processing')").html('<span class="ui-icon ui-icon-folder-open"></span> Post-Processing');
                $("#SubMenu a:contains('Manage Searches')").html('<span class="ui-icon ui-icon-search"></span> Manage Searches');
                $("#SubMenu a:contains('Manage Torrents')").html('<span class="submenu-icon-bittorrent"></span> Manage Torrents');
                $("#SubMenu a[href$='/manage/failedDownloads/']").html('<span class="submenu-icon-failed-download"></span> Failed Downloads');
                $("#SubMenu a:contains('Notification')").html('<span class="ui-icon ui-icon-note"></span> Notifications');
                $("#SubMenu a:contains('Update show in KODI')").html('<span class="submenu-icon-kodi"></span> Update show in KODI');
                $("#SubMenu a[href$='/home/updateKODI/']").html('<span class="submenu-icon-kodi"></span> Update KODI');
                $("#SubMenu a:contains('Update show in Emby')").html('<span class="ui-icon ui-icon-refresh"></span> Update show in Emby');
                $("#SubMenu a[href$='/home/updateEMBY/']").html('<span class="ui-icon ui-icon-refresh"></span> Update Emby');
                $("#SubMenu a:contains('Pause')").html('<span class="ui-icon ui-icon-pause"></span> Pause');
                $("#SubMenu a:contains('Resume')").html('<span class="ui-icon ui-icon-play"></span> Resume');

                $('#SubMenu a span').addClass('pull-left');
			}

			$(document).ready(function() {
				initActions();
			});
		</script>
		<script type="text/javascript" src="${sbRoot}/js/confirmations.js?${sbPID}"></script>
<script>
$(document).ready(function(){
	// Toggle the sidebar panel and save state to cookie
	$('#menu-toggle').click(function(){
		$("#wrapper").toggleClass("toggled");
		$("#toggleIcon").toggleClass("left");
		Cookies.set('sidebarTogglePref', $('#wrapper').attr('class'));
	});

	// Load preference
    $('#wrapper').addClass(Cookies.get('sidebarTogglePref'));
});
</script>
	% endif
<script type="text/javascript">
$(document).ready(function() {
    $('#wrapper').show();
    $('#loading-screen').fadeOut(800);
});
</script>
	</head>

	<body>

	<div id="loading-screen">
		<div class="loading-center">
			<i class="fa fa-spinner fa-spin"></i> Loading page... Please wait!
		</div>
	</div>

    <div id="wrapper" style="display:none;">
    	<div id="sidebar-wrapper" class="sidepanel-collapse-menu" >
    		% if sbLogin:
        	<ul class="sidebar-nav">
        		<li class="sidebar-brand"><a href="${sbRoot}/home/">SickRage</a></li>
        		<li><a href="#menu-toggle" id="menu-toggle"><span class="left"><i class="fa fa-bars"></i></span>Toggle panel</a></li>
        		<li><a href="${sbRoot}/home/"><span class="left"><i class="fa fa-home"></i></span>Home</a></li>
            		<li id="NAVhome" class="dropdown">
                            <a href="#homeCollapse" class="dropdown-toggle" data-toggle="collapse"><span class="left"><i class="fa fa-film"></i></span>Shows<span class="right"><i class="fa fa-plus"></i></span></a>
                            <ul id="homeCollapse" class="panel-collapse collapse">
                                <li><a href="${sbRoot}/home/addShows/"><span class="left"><i class="fa fa-plus"></i></span>Add Shows</a></li>
                                <li><a href="${sbRoot}/home/postprocess/"><span class="left"><i class="fa fa-heartbeat"></i></span>Manual Post-Processing</a></li>
                            </ul>
                        </li>

						<li id="NAVcomingEpisodes">
                            <a href="${sbRoot}/comingEpisodes/"><span class="left"><i class="fa fa-calendar"></i></span>Coming Episodes</a>
                        </li>

						<li id="NAVhistory">
                            <a href="${sbRoot}/history/"><span class="left"><i class="fa fa-history"></i></span>History</a>
                        </li>

						<li id="NAVnews" class="dropdown">
                            <a href="#manageCollapse" class="dropdown-toggle" data-toggle="collapse"><span class="left"><i class="fa fa-newspaper-o"></i></span>News<span class="right"><i class="fa fa-plus"></i></span></a>
                            <ul id="manageCollapse" class="panel-collapse collapse">
								<li>
		                            <a href="${sbRoot}/news/"><span class="left"><i class="fa fa-newspaper-o"></i></span> News</a>
		                        </li>
								<li>
		                            <a href="${sbRoot}/IRC/"><span class="left"><i class="fa fa-comments-o"></i></span> IRC</a>
		                        </li>
							</ul>
						</li>
						<li id="NAVmanage" class="dropdown">
                            <a href="#manageCollapse" class="dropdown-toggle" data-toggle="collapse"><span class="left"><i class="fa fa-wrench"></i></span>Manage<span class="right"><i class="fa fa-plus"></i></span></a>
                            <ul id="manageCollapse" class="panel-collapse collapse">
                                <li><a href="${sbRoot}/manage/"><span class="left"><i class="fa fa-tasks"></i></span>Mass Update</a></li>
                                <li><a href="${sbRoot}/manage/backlogOverview/"><span class="left"><i class="fa fa-eye"></i></span>Backlog Overview</a></li>
                                <li><a href="${sbRoot}/manage/manageSearches/"><span class="left"><i class="fa fa-search"></i></span>Manage Searches</a></li>
                                <li><a href="${sbRoot}/manage/episodeStatuses/"><span class="left"><i class="fa fa-check-square-o"></i></span>Episode Status Management</a></li>
                            % if sickbeard.USE_PLEX and sickbeard.PLEX_SERVER_HOST != "":
								<li><a href="${sbRoot}/home/updatePLEX/"><span class="left"><i class="fa fa-share-alt"></i></span>Update PLEX</a></li>
							% endif
							% if sickbeard.USE_KODI and sickbeard.KODI_HOST != "":
								<li><a href="${sbRoot}/home/updateKODI/"><span class="left"><i class="fa fa-share-alt"></i></span>Update KODI</a></li>
							% endif
							% if $sickbeard.USE_TORRENTS and sickbeard.TORRENT_METHOD != 'blackhole' \
							and ($sickbeard.ENABLE_HTTPS and sickbeard.TORRENT_HOST[:5] == 'https' \
							or not $sickbeard.ENABLE_HTTPS and sickbeard.TORRENT_HOST[:5] == 'http:'):
								<li><a href="${sbRoot}/manage/manageTorrents/"><span class="left"><i class="fa fa-download"></i></span>Manage Torrents</a></li>
							% endif
							% if $sickbeard.USE_FAILED_DOWNLOADS:
								<li><a href="${sbRoot}/manage/failedDownloads/"><span class="left"><i class="fa fa-exclamation-triangle"></i></span>Failed Downloads</a></li>
							% endif
							% if sickbeard.USE_SUBTITLES:
								<li><a href="${sbRoot}/manage/subtitleMissed/"><span class="left"><i class="fa fa-file-text-o"></i></span>Missed Subtitle Management</a></li>
							% endif
                            </ul>
                        </li>

						<li id="NAVerrorlogs" class="dropdown">
                            <a href="#errorCollapse" class="dropdown-toggle" data-toggle="collapse"><span class="left"><i class="fa fa-file-text-o"></i></span>Logs<span class="right"><i class="fa fa-plus"></i></span></a>
                            <ul id="errorCollapse" class="panel-collapse collapse">
                                <li><a href="${sbRoot}/errorlogs/"><span class="left"><i class="fa fa-exclamation-triangle"></i></span>View Error Log</a></li>
                                <li><a href="${sbRoot}/errorlogs/viewlog/"><span class="left"><i class="fa fa-file-text"></i></span>View Log</a></li>
                            </ul>
                        </li>

						<li id="NAVconfig" class="dropdown">
                            <a href="#configCollapse" class="collapse-toggle" data-toggle="collapse"><span class="left"><i class="fa fa-cogs"></i></span>Config<span class="right"><i class="fa fa-plus"></i></span></a>
                            <ul id="configCollapse" class="panel-collapse collapse">
                                <li><a href="${sbRoot}/config/"><span class="left"><i class="fa fa-question"></i></span>Help &amp; Info</a></li>
                                <li><a href="${sbRoot}/config/general/"><span class="left"><i class="fa fa-cogs"></i></span>General</a></li>
								<li><a href="${sbRoot}/config/backuprestore/"><span class="left"><i class="fa fa-database"></i></span>Backup &amp; Restore</a></li>
                                <li><a href="${sbRoot}/config/search/"><span class="left"><i class="fa fa-search"></i></span>Search Settings</a></li>
                                <li><a href="${sbRoot}/config/providers/"><span class="left"><i class="fa fa-globe"></i></span>Search Providers</a></li>
								<li><a href="${sbRoot}/config/subtitles/"><span class="left"><i class="fa fa-comments"></i></span>Subtitles Settings</a></li>
                                <li><a href="${sbRoot}/config/postProcessing/"><span class="left"><i class="fa fa-heartbeat"></i></span>Post Processing</a></li>
                                <li><a href="${sbRoot}/config/notifications/"><span class="left"><i class="fa fa-bullhorn"></i></span>Notifications</a></li>
								<li><a href="${sbRoot}/config/anime/"><span class="left"><i class="fa fa-fighter-jet"></i></span>Anime</a></li>
                            </ul>
                        </li>

						<li class="dropdown">
							<a href="#serverCollapse" class="dropdown-toggle" data-toggle="collapse"><span class="left"><i class="fa fa-server"></i></span>Server<span class="right"><i class="fa fa-plus"></i></span></a>
							<ul id="serverCollapse" class="panel-collapse collapse">
								<li><a href="${sbRoot}/home/updateCheck?pid=${sbPID}"><span class="left"><i class="fa fa-check-square-o"></i></span>Check For Updates</a></li>
								<li><a href="${sbRoot}/changes"><i class="menu-icon-help"></i>&nbsp;Changelog</a></li>
                                <li><a href="${sbRoot}/home/restart/?pid=${sbPID}" class="confirm restart"><span class="left"><i class="fa fa-refresh"></i></span>Restart</a></li>
                                <li><a href="${sbRoot}/home/shutdown/?pid=${sbPID}" class="confirm shutdown"><span class="left"><i class="fa fa-power-off"></i></span>Shutdown</a></li>
                                <li><a href="${sbRoot}/logout" class="confirm logout"><span class="left"><i class="fa fa-sign-out"></i></span>Logout</a></li>
                                <li><a href="${sbRoot}/home/status/"><span class="left"><i class="fa fa-server"></i></span>Server Status</a></li>
							</ul>
						</li>
    		    	</ul>
            	% endif
    	</div>

<div id="page-content-wrapper">
		% if not submenu is UNDEFINED:
		<div id="SubMenu">
		<span>
		<% first = True %>
		% for menuItem in submenu:
			% if 'requires' not in menuItem or menuItem['requires']:
				  % if type(menuItem['path']) == dict:
					  ${("</span><span>", "")[bool(first)]}<b>${menuItem['title']}</b>
					  <%
						  first = False
						  inner_first = True
					  %>
					  % for cur_link in menuItem['path']:
						  ${("&middot; ", "")[bool(inner_first)]}<a class="inner" href="${sbRoot}/${menuItem['path'][cur_link]}">${cur_link}</a>
						  <% inner_first = False %>
					  % endfor
				  % else:
					  <a href="${sbRoot}/${menuItem['path']}" class="btn${('', ' confirm')['confirm' in menuItem]}">${menuItem['title']}</a>
					  <% first = False %>
				  % endif
			% endif
		% endfor
		</span>
		</div>
		% endif

		% if sickbeard.BRANCH and sickbeard.BRANCH != 'master' and not sickbeard.DEVELOPER and sbLogin:
		<div class="alert alert-danger upgrade-notification" role="alert">
			<span>You're using the ${sickbeard.BRANCH} branch. Please use 'master' unless specifically asked</span>
		</div>
		% endif

		% if sickbeard.NEWEST_VERSION_STRING and sbLogin:
		<div class="alert alert-info upgrade-notification" role="alert">
			<span>${sickbeard.NEWEST_VERSION_STRING}</span>
		</div>
		% endif
