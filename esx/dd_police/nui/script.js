var visable = false;
var mirable = false;
$(function () {
	window.addEventListener('message', function (event) {
		switch (event.data.action) {
			case 'openMir':
				
				if (mirable) {
					$('#badgeMain').hide();
				} else {
					$('#badgeMain').show();
				}

				mirable = !mirable;
				break
			case 'closeMir':
				$('#badgeMain').hide();
				mirable = false;
				break

			case 'openLSPDXn1':
				$('#myXNUi1').fadeIn();
				break;

			case 'closeLSPDXn1':
				$('#myXNUi1').fadeOut();
				break;
		}
	})

	$('.ci').click(function () {
        $.post('http://dd_police/ci', JSON.stringify({}));
    });
	$('.vi').click(function () {
        $.post('http://dd_police/vi', JSON.stringify({}));
    });
	$('.fm').click(function () {
        $.post('http://dd_police/fm', JSON.stringify({}));
    });
	$('.dr').click(function () {
        $.post('http://dd_police/dr', JSON.stringify({}));
    });
	$('.piv').click(function () {
        $.post('http://dd_police/piv', JSON.stringify({}));
    });
	$('.pov').click(function () {
        $.post('http://dd_police/pov', JSON.stringify({}));
    });
	document.onkeyup = function (data) {
		if (data.which == 27) { // Escape key
			$.post('http://dd_police/escape', JSON.stringify({}));
			$.post('http://dd_police/closexn1', JSON.stringify({}));
			$('#myXNUi1').fadeOut(1000);
		}
	};
})

