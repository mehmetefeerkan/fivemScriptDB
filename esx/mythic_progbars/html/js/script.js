var cancelledTimer = null;

$('document').ready(function() {
    mythic_progbar = {};

    mythic_progbar.Progress = function(data) {
        clearTimeout(cancelledTimer);
        $("#progress-label").text(data.label);

        $(".progress-container").fadeIn('fast', function() {
            $("#progress-bar").stop().css({"width": 0, "background-color": "#1787e2a6"}).animate({
              width: '100%'
            }, {
              duration: parseInt(data.duration),
              complete: function() {
                $(".progress-container").fadeOut('fast', function() {
                    $('#progress-bar').removeClass('cancellable');
                    $("#progress-bar").css("width", 0);
                    $.post('http://mythic_progbar/FinishAction', JSON.stringify({
                        })
                    );
                })
              }
            });
        });
    };

    mythic_progbar.ProgressCancel = function() {
        $("#progress-label").text("Iptal Edildi");
        $("#progress-bar").stop().css( {"width": "100%", "background-color": "rgba(71, 0, 0, 0.8)"});
        $('#progress-bar').removeClass('cancellable');

        cancelledTimer = setTimeout(function () {
            $(".progress-container").fadeOut('fast', function() {
                $("#progress-bar").css("width", 0);
                $.post('http://mythic_progbar/CancelAction', JSON.stringify({
                    })
                );
            });
        }, 1000);
    };

    mythic_progbar.CloseUI = function() {
        $('.main-container').fadeOut('fast');
    };
    
    window.addEventListener('message', function(event) {
        switch(event.data.action) {
            case 'progress':
                mythic_progbar.Progress(event.data);
                break;
            case 'cancel':
                mythic_progbar.ProgressCancel();
                break;
        }
    });
});