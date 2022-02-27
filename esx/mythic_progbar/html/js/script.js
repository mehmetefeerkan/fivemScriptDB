$('document').ready(function() {
    MythicProgBar = {};

    MythicProgBar.Progress = function(data) {
        $(".progress-container").css({"display":"block"});
        $("#progress-label").text(data.label);
        $("#progress-bar").stop().css({"width": 0, "background-color": "#1294df"}).animate({
          width: '100%'
        }, {
          duration: parseInt(data.duration),
          complete: function() {
            $(".progress-container").css({"display":"none"});
            $("#progress-bar").css("width", 0);
            $.post('http://mythic_progbar/actionFinish', JSON.stringify({
                })
            );
          }
        });
    };

    MythicProgBar.ProgressCancel = function() {
        $(".progress-container").css({"display":"block"});
        $("#progress-label").text("İptal Edildi");
        $("#progress-bar").stop().css( {"width": "100%", "background-color": ":rgba(22,22,22,0.35);"});

        setTimeout(function () {
            $(".progress-container").css({"display":"none"});
            $("#progress-bar").css("width", 0);
            $.post('http://mythic_progbar/actionCancel', JSON.stringify({
                })
            );
        }, 1000);
    };

    MythicProgBar.CloseUI = function() {
        $('.main-container').css({"display":"none"});
        $(".character-box").removeClass('active-char');
        $(".character-box").attr("data-ischar", "false")
        $("#delete").css({"display":"none"});
    };
    
    window.addEventListener('message', function(event) {
        switch(event.data.action) {
            case 'mythic_progress':
                MythicProgBar.Progress(event.data);
                break;
            case 'mythic_progress_cancel':
                MythicProgBar.ProgressCancel();
                break;
        }
    })
});