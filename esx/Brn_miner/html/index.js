$(function () {
    function display(bool) {
        if (bool) {
            $("#window").show();
        } else {
            $("#window").hide();
        }
    }

    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            $("#goldOres").text(event.data.goldOres);
            $("#ironOres").text(event.data.ironOres);
            $("#copperOres").text(event.data.copperOres);
            $("#diamondOres").text(event.data.diamondOres);
            $("#totalOres").text(`${event.data.totalOres} $`);
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }
    })


    

    // if the person uses the escape key, it will exit the resource
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('http://Brn_miner/exit', JSON.stringify({}));
            return
        }
    };
    $("#close").click(function () {
        $.post('http://Brn_miner/exit', JSON.stringify({}));
        return
    })

    $("#sell").click(function () {
        $.post('http://Brn_miner/sellResource', JSON.stringify({}));
        return
    })

    $("#sellcopper").click(function () {
        $.post('http://Brn_miner/sellCopper', JSON.stringify({}));
        return
    })

    $("#sellgold").click(function () {
        $.post('http://Brn_miner/sellGold', JSON.stringify({}));
        return
    })

    $("#selliron").click(function () {
        $.post('http://Brn_miner/sellIron', JSON.stringify({}));
        return
    })

    $("#selldiamond").click(function () {
        $.post('http://Brn_miner/sellDiamond', JSON.stringify({}));
        return
    })

})