$('document').ready(function() {
    alerts = {};
    

    window.addEventListener('message', function (event) {
        ShowNotif(event.data);
    });

    function ShowNotif(data) {
            var $notification = CreateNotification(data);
            $('.notif-container').append($notification);
            setTimeout(function() {
                $.when($notification.fadeOut()).done(function() {
                    $notification.remove()
                });
            }, data.length != null ? data.length : 2500);
    }



    function CreateNotification(data) {
        var $notification = $(document.createElement('div'));
        //$notification.addClass('notification').addClass(data.type);
        $notification.addClass('notification').addClass(data.style);
        //$notification.html(data.text);
        var sex = 'Erkek';
        if(data.info['sex'] == 1) sex = 'Kadın'
        var carcolor = '<div id="alert-info"><i class="fas fa-car" style="color: rgb('+data.info["inVeh"][2]+');"></i>'+data.info["inVeh"][1]+'</div>'
        if(data.info['inVeh'][1] == ""){carcolor = ""}
        $notification.html('\
        <div class="content">\
            <div class="alertinfo2">\
                <div id="code">' + data.info["code"] + '</div>\
                <div id="alert-name">' + data.info["name"] + '</div>\
            </div>\
            <div id="alert-info"><i class="fas fa-globe-europe"></i>' + data.info["loc"] + '</div>\
            <div id="alert-info"><i class="fas fa-user"></i>Cinsiyet: '+sex+'</div>\
            <div id="alert-info"><i class="fas fa-keyboard"></i>'+data.info["inVeh"][0]+'</div>\
            '+carcolor+'\
            <div id="alert-info"><i class="fas fa-keyboard"></i>[<font style="color: #f88;">M</font>] tuşuna basarak GPS üzerinde işaretleyin.</div>\
        </div>');
        $notification.fadeIn();
        if (data.style !== undefined) {
            Object.keys(data.style).forEach(function(css) {
                $notification.css(css, data.style[css])
            });
        }
        return $notification;
    }









    alerts.BaseAlert = function(style, info) {
        switch(style) {
            case 'ems':
               alerts.EMSAlert(info)
            break;
            case 'police':
                alerts.PoPo(info)
            break;
        }
    };

    alerts.PoPo = function(info) {
        
        $('.alerts-wrapper').html('\
        <div class="alerts police">\
        <div class="content">\
        <div id="code">' + info["code"] + '</div>\
        <div id="alert-name">' + info["name"] + '</div>\
        <div id="marker"><i class="fas fa-map-marker-alt" aria-hidden="true"></i></div>\
        <div id="alert-info"><i class="fas fa-globe-europe"></i>' + info["loc"] + '</div>\
        </div>').fadeIn(1000);
        
        setTimeout(HideAlert, 4500);
    };

    alerts.EMSAlert = function(info) {
        //console.log(info["code"])
        $('.alerts-wrapper').html('\
        <div class="alerts ems">\
        <div class="content">\
        <div id="code">' + info["code"] + '</div>\
        <div id="alert-name">' + info["name"] + '</div>\
        <div id="marker"><i class="fas fa-map-marker-alt" aria-hidden="true"></i></div>\
        <div id="alert-info"><i class="fas fa-skull-crossbones"></i> ' + info["loc"] + '</div>\
        </div>').fadeIn(1000);
        
        setTimeout(HideAlert, 4500);
    };


    function HideAlert() {
        $('.alerts-wrapper').fadeOut(1000);
    };

    /*window.addEventListener('message', function(event) {
        //console.log(event.data.action + " " + event.data.style)
        switch(event.data.action) {
            case 'display':
                //console.log("We've been called for this one")
                alerts.BaseAlert(event.data.style, event.data.info)
            break;
        }
    });*/
});