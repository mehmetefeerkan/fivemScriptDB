window.addEventListener('message', function (event) {

	switch (event.data.action) {
        case 'updateStatusHud':
            $("body").css("display", event.data.show ? "block" : "none");
            $("#boxSetHealth").css("width", event.data.health + "%");
            $("#boxSetArmour").css("width", event.data.armour + "%");
            $("#boxSetStamina").css("width", event.data.stamina + "%")

            widthHeightSplit(event.data.hunger, $("#boxSetHunger"));
            widthHeightSplit(event.data.thirst, $("#boxSetThirst"));
            widthHeightSplit(event.data.oxygen, $("#boxSetOxygen"));
            // widthHeightSplit(event.data.stealth, $("#boxSetStealth"));
            // widthHeightSplit(event.data.stamina, $("#boxSetStamina"));

            
    }
});

function widthHeightSplit(value, ele) {
    let width = 25.5;
    let eleHeight = (value / 100) * width;

    ele.css("width", eleHeight + "px");
};