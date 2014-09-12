var search_status_url = sbRoot + '/getManualSearchStatus';
$.pnotify.defaults.width = "400px";
$.pnotify.defaults.styling = "jqueryui";
$.pnotify.defaults.history = false;
$.pnotify.defaults.shadow = false;
$.pnotify.defaults.delay = 4000;
$.pnotify.defaults.maxonscreen = 5;

$.fn.manualSearches = [];

function check_manual_searches() {
    var poll_interval = 5000;
    $.ajax({
        url: search_status_url + '?show=' + $('#showID').val(),
        success: function (data) {
            if (data.episodes) {
            	poll_interval = 5000;
            }
            else {
            	poll_interval = 15000;
            }
        	
            updateImages(data);
            //cleanupManualSearches(data);
        },
        error: function () {
            poll_interval = 30000;
        },
        type: "GET",
        dataType: "json",
        complete: function () {
            setTimeout(check_manual_searches, poll_interval);
        },
        timeout: 15000 // timeout every 15 secs
    });
}


function updateImages(data) {
	$.each(data.episodes, function (name, ep) {
		console.debug(ep.searchstatus);
		// Get td element for current ep
		var loadingImage = 'loading16_dddddd.gif';
        var queuedImage = 'queued.png';
        var searchImage = 'search32.png';
        var status = null;
        //Try to get the <a> Element
        el=$('a[id=' + ep.season + 'x' + ep.episode+']');
        img=el.children('img');
        parent=el.parent();        
        if (el) {
        	if (ep.searchstatus == 'searching') {
				//el=$('td#' + ep.season + 'x' + ep.episode + '.search img');
				img.attr('title','Searching');
				img.attr('alt','searching');
				img.attr('src','/images/' + loadingImage);
				disableLink(el);
				// Update Status and Quality
				var rSearchTerm = /(\w+)\s\((.+?)\)/;
	            HtmlContent = ep.searchstatus;
	            
        	}
        	else if (ep.searchstatus == 'queued') {
				//el=$('td#' + ep.season + 'x' + ep.episode + '.search img');
				img.attr('title','Queued');
				img.attr('alt','queued');
				img.attr('src','/images/' + queuedImage );
				disableLink(el);
				HtmlContent = ep.searchstatus;
			}
        	else if (ep.searchstatus == 'finished') {
				//el=$('td#' + ep.season + 'x' + ep.episode + '.search img');
				img.attr('title','Searching');
				img.attr('alt','searching');
				img.parent().attr('class','epRetry');
				img.attr('src','/images/' + searchImage);
				enableLink(el);
				
				// Update Status and Quality
				var rSearchTerm = /(\w+)\s\((.+?)\)/;
	            HtmlContent = ep.status.replace(rSearchTerm,"$1"+' <span class="quality '+ep.quality+'">'+"$2"+'</span>');
		        
			}
        	// update the status column if it exists
	        parent.siblings('.status_column').html(HtmlContent)
        	
        }
		
	});
}

$(document).ready(function () {

	check_manual_searches();

});

function enableLink(el) {
	el.on('click.disabled', false);
}

function disableLink(el) {
	el.off('click.disabled');
}

(function(){

	$.ajaxEpSearch = {
	    defaults: {
	        size:				16,
	        colorRow:         	false,
	        loadingImage:		'loading16_dddddd.gif',
	        queuedImage:		'queued.png',
	        noImage:			'no16.png',
	        yesImage:			'yes16.png'
	    }
	};

	$.fn.ajaxEpSearch = function(options){
		options = $.extend({}, $.ajaxEpSearch.defaults, options);
		
	    $('.epSearch').click(function(event){
	    	event.preventDefault();
	        var parent = $(this).parent();
	        link = $(this);
	        // put the ajax spinner (for non white bg) placeholder while we wait
	        //parent.empty();
	        //parent.append($("<img/>").attr({"src": sbRoot+"/images/"+options.loadingImage, "height": options.size, "alt": "", "title": "loading"}));
	        img=$(this).children('img');
	        img.attr('title','loading');
			img.attr('alt','');
			img.attr('src','/images/' + options.loadingImage);
			
	        
	        $.getJSON($(this).attr('href'), function(data){
	            // if they failed then just put the red X
	            if (data.result == 'failure') {
	                img_name = options.noImage;
	                img_result = 'failed';

	            // if the snatch was successful then apply the corresponding class and fill in the row appropriately
	            } else {
	                img_name = options.loadingImage;
	                img_result = 'success';
	                // color the row
	                if (options.colorRow)
	                	parent.parent().removeClass('skipped wanted qual good unaired').addClass('snatched');
	                // applying the quality class
                    var rSearchTerm = /(\w+)\s\((.+?)\)/;
	                    HtmlContent = data.result.replace(rSearchTerm,"$1"+' <span class="quality '+data.quality+'">'+"$2"+'</span>');
	                // update the status column if it exists
                    parent.siblings('.status_column').html(HtmlContent)    	                  
	            }

	            // put the corresponding image as the result for the the row
	            //parent.empty();
	            //parent.append($("<img/>").attr({"src": sbRoot+"/images/"+img_name, "height": options.size, "alt": img_result, "title": img_result}));
	            img.attr('title',img_result);
				img.attr('alt',img_result);
				img.attr('height', options.size);
				img.attr('src',sbRoot+"/images/"+img_name);
				
	        });
	        disableLink(link);
	        // fon't follow the link
	        return false;
	    });
	}
})();

