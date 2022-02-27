var visable = false;

$(function () {
	window.addEventListener('message', function (event) {
		switch (event.data.action) {
			case 'connect':
				// $('#main').fadeIn();
				$('#connecttt').fadeIn();
	
				break;

			case 'disconnect':
				// $('#main').fadeOut();
				$('#connecttt').fadeOut();

				break;

			case 'sms':
				// $('#main').fadeIn();
				$('#newsms').fadeIn();
	
				break;

			case 'twt':
				// $('#main').fadeIn();
				$('#newtwt').fadeIn();
	
				break;

			case 'Xsms':
				// $('#main').fadeOut();
				$('#newsms').fadeOut();
	
				break;

			case 'Xtwt':
				// $('#main').fadeOut();
				$('#newtwt').fadeOut();

				break;
			// on hack
			case 'imHacking':
				$('#myHackingUI').fadeIn(100);
				break;
			// off hack
			case 'imNotHacking':
				$('#myHackingUI').fadeOut(1000);
				break;
			// success
			case 'onSuccess':
				$('#mySuccessUI').fadeIn(100);
				break;
			case 'offSuccess':
				$('#mySuccessUI').fadeOut(1000);
				break;
			// failed
			case 'onFailed':
				$('#myFailedUI').fadeIn(100);
				break;
			case 'offFailed':
				$('#myFailedUI').fadeOut(1000);
				break;
			// copy
			case 'onCopy':
				$('#myCopyUI').fadeIn(100);
				break;
			case 'offCopy':
				$('#myCopyUI').fadeOut(1000);
				break;
			// loading
			case 'onLoading':
				$('#myLoadingUI').fadeIn(1000);
				break;
			case 'offLoading':
				$('#myLoadingUI').fadeOut(1000);
				break;
			// activate
			case '1file':
				$('#info1').fadeIn(1000);
				break;
			case '2file':
				$('#info2').fadeIn(1000);
				break;
			case '3file':
				$('#info3').fadeIn(1000);
				break;
			case '4file':
				$('#info4').fadeIn(1000);
				break;
			case '5file':
				$('#info5').fadeIn(1000);
				break;
			case '6file':
				$('#info6').fadeIn(1000);
				break;
			case '7file':
				$('#info7').fadeIn(1000);
				break;
			case '8file':
				$('#info8').fadeIn(1000);
				break;
			case '9file':
				$('#info9').fadeIn(1000);
				break;
			case '10file':
				$('#info10').fadeIn(1000);
				break;
			case '11file':
				$('#info11').fadeIn(1000);
				break;
			case '12file':
				$('#info12').fadeIn(1000);
				break;
			case 'offActivate':
				$('#info').fadeOut(1000);
				break;
		}
	})
	document.onkeyup = function (data) {
		if (data.which == 27) { // Escape key
			$.post('http://dd_cyberheist/escape', JSON.stringify({}));
			$('#info1').fadeOut(1000);
			$('#info2').fadeOut(1000);
			$('#info3').fadeOut(1000);
			$('#info4').fadeOut(1000);
			$('#info5').fadeOut(1000);
			$('#info6').fadeOut(1000);
			$('#info7').fadeOut(1000);
			$('#info8').fadeOut(1000);
			$('#info9').fadeOut(1000);
			$('#info10').fadeOut(1000);
			$('#info11').fadeOut(1000);
			$('#info12').fadeOut(1000);
		}
	};
})

