Hi, thank you for buying my script, I'm very grateful!

To display a notification you should call it like below:

# Client side

exports['okokNotify']:Alert("Title", "Message", Time, 'type')

# Server side

TriggerClientEvent('okokNotify:Alert', source, "Title", "Message", Time, 'type')


[Time] - 1000 = 1 second | 5000 = 5 seconds

Types: 
	- success (green)
	- info (blue)
	- warning (yellow)
	- error (red)
	- phone (orange)
	- neutral (grey)

How to add new colors:

1. Open styles.css and add the following to the last line.

/* Example Notification */

.example-icon::before {
    font-family: "Font Awesome 5 Free";
    content: "\f11c";
    color: #color_code;
}

.example {
    background-color: rgba(20, 20, 20, 0.85);
    color: #color_code;
    padding: 5px 5px 5px 5px;
}

.example-border {
    border-left: 4px solid #color_code;
}

To know the content code navigate to https://fontawesome.com/v5.15/icons?d=gallery&p=2, select an icon and copy it's code.

2. Open scripts.js and add the following to the line 76.

else if (event.data.type == 'type') {
    $(`.title-${number}`).html(event.data.title).css({
        "font-size": "16px",
        "font-weight": "600"
    })
    $(`.notification_main-${number}`).addClass('type-icon')
    $(`.wrapper-${number}`).addClass('type type-border')
    sound.play();
}

Don't forget to change the type to the same name as you choose for "example".

If you need help contact me on discord: https://discord.gg/Knw8UyqxbQ