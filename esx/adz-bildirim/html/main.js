$('document').ready(function() {
    alerts = {};
    

    window.addEventListener('message', function (event) {
        if (event.data.action == "detailed") {
            ShowNotifDetailed(event.data);
        }else if (event.data.action == "Detailedrecklessdriver") {
                ShowNotifDetailedrecklessdriver(event.data);
        }else {
            ShowNotif(event.data);
        }
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

    function ShowNotifDetailed(data) {
        var $notification = CreateNotificationDetailed(data);
        $('.notif-container').append($notification);
        setTimeout(function() {
            $.when($notification.fadeOut()).done(function() {
                $notification.remove()
            });
        }, data.length != null ? data.length : 2500);    
    }
    function ShowNotifDetailedrecklessdriver(data) {
        var $notification = CreateNotificationDetailedrecklessdriver(data);
        $('.notif-container').append($notification);
        setTimeout(function() {
            $.when($notification.fadeOut()).done(function() {
                $notification.remove()
            });
    }, data.length != null ? data.length : 2500);
    }

    function CreateNotificationDetailedrecklessdriver(data) {
        var $notification = $(document.createElement('div'));
        //$notification.addClass('notification').addClass(data.type);
        $notification.addClass('notificationDetailedrecklessdriver').addClass(data.style);
        //$notification.html(data.text);
        $notification.html('\
        <div class="content">\
        <div id="code">' + data.info["code"] + '</div>\
        <div id="alert-name">' + data.info["name"] + '</div>\
        <div id="alert-info-detailedrecklessdriver"><i class="fas fa-globe-europe"></i>' + data.info["loc"] + '</div>\
        <div id="marker"><i class="fas fa-map-marker-alt" aria-hidden="true"></i></div>\
        <div id="alert-info-detailedrecklessdriver"><i class="fas fa-user"></i>' + data.info["sex"] + '</div>\
        <div id="alert-info-detailedrecklessdriver"><i class="fas fa-car"></i>' + data.info["color"] + '</div>\
        <div id="alert-info-detailedrecklessdriver"><i class="fas fa-palette"></i>' + data.info["model"] + '</div>\
        <div id="alert-info-detailedrecklessdriver"><i class="fas fa-compass"></i>' + data.info["heading"] + '</div>\
		<div id="alert-info-detailedrecklessdriver" style="background-color:#17960c; position: fixed; margin-left: -21px; width:395;"><i class="fas fa-compass"></i>[E] GPS İşaretle</div>\
        </div>');
        $notification.fadeIn();
        if (data.style !== undefined) {
            Object.keys(data.style).forEach(function(css) {
                $notification.css(css, data.style[css])
            });
        }
        return $notification;
    }

    function CreateNotificationDetailed(data) {
        var $notification = $(document.createElement('div'));
        //$notification.addClass('notification').addClass(data.type);
        $notification.addClass('notificationDetailed').addClass(data.style);
        //$notification.html(data.text);
        $notification.html('\
        <div class="content">\
        <div id="code">' + data.info["code"] + '</div>\
        <div id="alert-name">' + data.info["name"] + '</div>\
        <div id="alert-info-detailed"><i class="fas fa-globe-europe"></i>' + data.info["loc"] + '</div>\
        <div id="marker"><i class="fas fa-map-marker-alt" aria-hidden="true"></i></div>\
        <div id="alert-info-detailed"><i class="fas fa-user"></i>' + data.info["sex"] + '</div>\
        <div id="alert-info-detailed"><i class="fas fa-car"></i>' + data.info["color"] + '</div>\
		<br>\
		<div id="alert-info-detailed" style="background-color: #17960c; position: fixed; margin-left: -21px; width:395;"><i class="fas fa-compass"></i>[E] GPS İşaretle</div>\
        </div>');
        $notification.fadeIn();
        if (data.style !== undefined) {
            Object.keys(data.style).forEach(function(css) {
                $notification.css(css, data.style[css])
            });
        }
        return $notification;
    }

    function CreateNotification(data) {
        var $notification = $(document.createElement('div'));
        //$notification.addClass('notification').addClass(data.type);
        $notification.addClass('notification').addClass(data.style);
        //$notification.html(data.text);
        $notification.html('\
        <div class="content">\
        <div id="code">' + data.info["code"] + '</div>\
        <div id="alert-name">' + data.info["name"] + '</div>\
        <div id="alert-info"><i class="fas fa-globe-europe"></i>' + data.info["loc"] + '</div>\
        <div id="marker"><i class="fas fa-map-marker-alt" aria-hidden="true"></i></div>\
        <div id="alert-info"><i class="fas fa-user"></i>' + data.info["sex"] + '</div>\
		<div id="alert-info" style="background-color:#17960c; position: fixed; margin-left: -21px; width:395;"><i class="fas fa-compass"></i>[E] GPS İşaretle</div>\
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
        <div id="alert-info"><i class="fas fa-user"></i>' + info["sex"] + '</div>\
        <div id="alert-info" style="background-color:#17960c; position: fixed; margin-left: -21px; width:395;"><i class="fas fa-user"></i>[E] GPS İşaretle</div>\
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
        <div id="alert-info"><i class="fas fa-user"></i>' + info["sex"] + '</div>\
        <div id="alert-info" style="background-color:#17960c; position: fixed; margin-left: -21px; width:395;"><i class="fas fa-user"></i>[E] GPS İşaretle</div>\
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