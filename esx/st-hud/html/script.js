window.addEventListener('message', function (event) {

	switch (event.data.action) {
        case 'updateStatusHud':
            $("body").css("display", event.data.show ? "block" : "none");
            $("#boxSetHealth").css("width", event.data.health + "%");
            $("#boxSetArmour").css("width", event.data.armour + "%");
            $("#boxSetHunger").css("width", event.data.hunger + "%");
			$("#boxSetThirst").css("width", event.data.thirst + "%");

            widthHeightSplit(event.data.oxygen, $("#boxSetOxygen"));
            widthHeightSplit(event.data.stress, $("#boxSetStress"));
    }
});

function widthHeightSplit(value, ele) {
    let height = 20.5;
    let eleHeight = (value / 100) * height;
    let leftOverHeight = height - eleHeight;

    ele.css("height", eleHeight + "px");
    ele.css("top", leftOverHeight + "px");
};

function Left(value, ele) {
    let height = 25.0;
    let eleHeight = (value / 100) * height;
    let leftOverHeight = height - eleHeight;

    ele.css("right", eleHeight + "px");
    ele.css("right", leftOverHeight + "px");
};