$(function () {
	window.addEventListener('message', function (event) {
		switch (event.data.action) {
			case 'toggleCrafting':
				$('#container').fadeIn();
				break;
            case 'aa':
                var aaa = event.data.data;
                $('#a').text(aaa);
                break;
            case 'bb':
                var bbb = event.data.data;
                $('#b').text(bbb);
                break;
            case 'cc':
                var ccc = event.data.data;
                $('#c').text(ccc);
                break;
            case 'dd':
                var ddd = event.data.data;
                $('#d').text(ddd);
                break;
            case 'ee':
                var eee = event.data.data;
                $('#e').text(eee);
                break;
            case 'ff':
                var fff = event.data.data;
                $('#f').text(fff);
                break;
            case 'closeCrafting':
				$('#container').fadeOut();
                break;
                // case 'toggleCrafting2':
                //     $('#container2').fadeIn();
                //     break;
                // case 'aa':
                //     var aaa = event.data.data;
                //     $('#a').text(aaa);
                //     break;
                // case 'bb':
                //     var bbb = event.data.data;
                //     $('#b').text(bbb);
                //     break;
                // case 'cc':
                //     var ccc = event.data.data;
                //     $('#c').text(ccc);
                //     break;
                // case 'dd':
                //     var ddd = event.data.data;
                //     $('#d').text(ddd);
                //     break;
                // case 'ee':
                //     var eee = event.data.data;
                //     $('#e').text(eee);
                //     break;
                // case 'ff':
                //     var fff = event.data.data;
                //     $('#f').text(fff);
                //     break;
                // case 'closeCrafting2':
                //     $('#container2').fadeOut();
    
				// break;
			default:
				console.log('status: unknown action!');
				break;
		}
	}, false);

    $('.ia').click(function () {
        $.post('http://dd_bean/coffee_b', JSON.stringify({}));
    });
    $('.ib').click(function () {
        $.post('http://dd_bean/coffee_r', JSON.stringify({}));
    });
    $('.ic').click(function () {
        $.post('http://dd_bean/cappuccino', JSON.stringify({}));
    });
    $('.id').click(function () {
        $.post('http://dd_bean/cheesecake', JSON.stringify({}));
    });
    $('.ie').click(function () {
        $.post('http://dd_bean/sandwich', JSON.stringify({}));
    });
    $('.if').click(function () {
        $.post('http://dd_bean/donut', JSON.stringify({}));
    });
    document.onkeyup = function (data) {
		if (data.which == 27) { // Escape key
			$.post('http://dd_bean/NUIFocusOff', JSON.stringify({}));
		}
	};
});
