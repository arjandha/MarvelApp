$(document).ready(function() {
	var ready = true;
	var current_page = 1;
	var next_page = 2;
	var base_url = window.location.href;
	base_url = base_url.split("/");
	base_url = base_url[base_url.length - 1];
	if(base_url == "") {
		base_url = "/comics?page="
	}
	else {
		base_url = "/" + base_url + "?page="
	}

	if ($("#infinite_scrolling").size() > 0) {
		$(window).scroll(function() {
		  if(ready && current_page < next_page) {
		    ready = false;
		    //var more_comics_url = $('.pagination .next_page').attr('href');
		    var more_comics_url = base_url + next_page.toString();
		    if (more_comics_url && $(window).scrollTop() > $(document).height() - $(window).height() - 50) {
		       console.log(more_comics_url);

		      $.ajax({
		        url: more_comics_url,
		        success: function(data, status, xhr) {
		          $("#scrolling-display").append(data);
		          current_page = current_page + 1;
		          next_page = next_page + 1;
		        },
		        complete: function(xhr, status) {
		          ready = true;
		        }

		      });
		    }
		    else {
		      ready = true;
		    }
		  }
		});
	}
});