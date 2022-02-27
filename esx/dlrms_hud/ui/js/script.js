$(() => {
  Number.prototype.format = function (n, x) {
    var re = '\\d(?=(\\d{' + (x || 3) + '})+' + (n > 0 ? '\\.' : '$') + ')';
    return this.toFixed(Math.max(0, ~~n)).replace(new RegExp(re, 'g'), '$&,');
  };
  // example
  // 1234..format();           // "1,234"
  // 12345..format(2);         // "12,345.00"
  // 123456.7.format(3, 2);    // "12,34,56.700"
  // 123456.789.format(2, 4);  // "12,3456.79"
  window.addEventListener('message', (e) => {
    const data = e.data;
    if (!data.pauseMenuOn) {
      $('.hud-container').show();

      $('.health').css('width', data.health + '%');
      $('.armor').css('width', data.armor + '%');
      $('.hunger').css('height', data.hunger + '%');
      $('.hunger-top').css('width', data.hunger + '%');
      $('.thirst').css('height', data.thirst + '%');
      $('.thirst-top').css('width', data.thirst + '%');
      $('.stamina').css('height', data.stamina + '%');

      if (data.action === 'ui') {
        if (data.ui) {
          $('.hud-menu').fadeIn('fast');

          $('#close').on('click', function () {
            $.post('http://dlrms_hud/dlrms_hud:close', JSON.stringify({}));
          });

          $(document).keyup(function (e) {
            if (e.key === 'Escape') {
              $.post('http://dlrms_hud/dlrms_hud:close', JSON.stringify({}));
            }
          });

          $('#healthchk').on('change', function () {
            this.checked ? $('#health').fadeIn('fast') : $('#health').fadeOut('fast');
          });
          $('#armorchk').on('change', function () {
            this.checked ? $('#armor').fadeIn('fast') : $('#armor').fadeOut('fast');
          });
          $('#hungerchk').on('change', function () {
            this.checked ? $('#hunger').fadeIn('fast') : $('#hunger').fadeOut('fast');
          });
          $('#thirstchk').on('change', function () {
            this.checked ? $('#thirst').fadeIn('fast') : $('#thirst').fadeOut('fast');
          });
          $('#hungerinchk').on('change', function () {
            this.checked ? $('#hunger-top').fadeIn('fast') : $('#hunger-top').fadeOut('fast');
          });
          $('#thirstinchk').on('change', function () {
            this.checked ? $('#thirst-top').fadeIn('fast') : $('#thirst-top').fadeOut('fast');
          });
          $('#staminachk').on('change', function () {
            this.checked ? $('#stamina').fadeIn('fast') : $('#stamina').fadeOut('fast');
          });
          $('#jobchk').on('change', function () {
            this.checked ? $('.hud-job').fadeIn('fast') : $('.hud-job').fadeOut('fast');
          });
          $('#idchk').on('change', function () {
            this.checked ? $('.hud-playerID').fadeIn('fast') : $('.hud-playerID').fadeOut('fast');
          });
          $('#bankchk').on('change', function () {
            this.checked ? $('.hud-bank').fadeIn('fast') : $('.hud-bank').fadeOut('fast');
          });
          $('#walletchk').on('change', function () {
            this.checked ? $('.hud-cash').fadeIn('fast') : $('.hud-cash').fadeOut('fast');
          });
          $('#societychk').on('change', function () {
            this.checked ? $('.hud-society').fadeIn('fast') : $('.hud-society').fadeOut('fast');
          });
          $('#blackchk').on('change', function () {
            this.checked ? $('.hud-black').fadeIn('fast') : $('.hud-black').fadeOut('fast');
          });
          $('#clockchk').on('change', function () {
            this.checked ? $('.hud-clock').fadeIn('fast') : $('.hud-clock').fadeOut('fast');
          });
        } else {
          $('.hud-menu').fadeOut('fast');
        }
      } else if (data.action === 'hud') {
        if (data.health <= data.healthAlert) {
          $('.health-alert').addClass('blink-anim');
          $('.health-alert').css('display', 'block');
          $('.health').css('box-shadow', '0 0 0 rgba(0,0,0,1)');
        } else {
          $('.health-alert').removeClass('blink-anim');
          $('.health-alert').css('display', 'none');
          $('.health').css('box-shadow', '0px 0px 4px rgba(65, 155, 53, 1)');
        }
        if (data.armor <= data.armorAlert && !data.armor == 0) {
          $('.armor-alert').addClass('blink-anim');
          $('.armor-alert').css('display', 'block');
          $('.armor').css('box-shadow', '0 0 0 rgba(0,0,0,1)');
        } else {
          $('.armor-alert').removeClass('blink-anim');
          $('.armor-alert').css('display', 'none');
          $('.armor').css('box-shadow', '0px 0px 4px rgba(67, 109, 175, 1)');
        }
        if (data.hunger <= data.hungerAlert) {
          $('.hunger-alert').addClass('blink-anim');
          $('.hunger-alert').css('display', 'block');
          $('.hunger-top').css('box-shadow', '0 0 0 rgba(0,0,0,1)');
          $('.hunger').css('box-shadow', '0 0 0 rgba(0,0,0,1)');
        } else {
          $('.hunger-alert').removeClass('blink-anim');
          $('.hunger-alert').css('display', 'none');
          $('.hunger-top').css('box-shadow', '0px 0px 4px rgba(236, 178, 3, 1)');
          $('.hunger').css('box-shadow', '0px 0px 4px rgba(236, 178, 3, 1)');
        }
        if (data.thirst <= data.thirstAlert) {
          $('.thirst-alert').addClass('blink-anim');
          $('.thirst-alert').css('display', 'block');
          $('.thirst-top').css('box-shadow', '0 0 0 rgba(0,0,0,1)');
          $('.thirst').css('box-shadow', '0 0 0 rgba(0,0,0,1)');
        } else {
          $('.thirst-alert').removeClass('blink-anim');
          $('.thirst-alert').css('display', 'none');
          $('.thirst-top').css('box-shadow', 'rgba(101, 137, 182, 1)');
          $('.thirst').css('box-shadow', 'rgba(101, 137, 182, 1)');
        }

        if (data.vehicle) {
          $('#hts').hide('fast');
          $('#hud-top').show('fast', function () {
            $('#hud-top').css('display', 'flex');
          });
          if (data.bigMap) {
            $('.hud-wrapper').css({ width: '22.5%', opacity: 0.4 });
          } else {
            $('.hud-wrapper').css({ width: '14.2%', opacity: 1.0 });
          }
        } else {
          $('#hts').show('fast');
          $('#hud-top').hide('fast');
          $('.hud-wrapper').css({ width: '14.2%', opacity: 1.0 });

          if (data.stamina) {
            $('.stamina-icon').attr('src', 'img/stamina.svg');
          }
          if (data.swim) {
            $('.stamina-icon').attr('src', 'img/swim.svg');
          }
          if (data.breath) {
            $('.stamina-icon').attr('src', 'img/breath.svg');
          }
        }
      } else if (data.action === 'details') {
        $('.hud-job span').text(data.label + ' - ' + data.grade);
        $('.hud-playerID span').text(data.id);
        // $('.hud-bank span').text('$' + data.bank.format());
        // $('.hud-cash span').text('$' + data.cash.format());
        // $('.hud-society span').text('$' + data.society.format());
        // $('.hud-black span').text('$' + data.dirty.format());
        // $('.hud-clock span').text(data.clock);
      }
    } else {
      $('.hud-container').hide();
    }
  });
});
