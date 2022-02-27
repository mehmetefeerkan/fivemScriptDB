$(function () {
	window.addEventListener('message', function (event) {
		switch (event.data.action) {
			case 'toggleCrafting':
				$('#container').fadeIn();
				break;
            case 'bb':
                var bbb = event.data.data;
                $('#b').text(bbb);
                break;
            case 'cc':
                var ccc = event.data.data;
                $('#c').text(ccc);
                break;
            case 'ee':
                var eee = event.data.data;
                $('#e').text(eee);
                break;
            case 'closeCrafting':
				$('#container').fadeOut();

				break;
			default:
				console.log('status: unknown action!');
				break;
		}
	}, false);

    $('.ib').click(function () {
        $.post('http://dd_bshot/sprunk', JSON.stringify({}));
    });
    $('.ic').click(function () {
        $.post('http://dd_bshot/bleeder', JSON.stringify({}));
    });
    $('.ie').click(function () {
        $.post('http://dd_bshot/stopper', JSON.stringify({}));
    });

    document.onkeyup = function (data) {
		if (data.which == 27) { // Escape key
			$.post('http://dd_bshot/NUIFocusOff', JSON.stringify({}));
		}
	};
});
