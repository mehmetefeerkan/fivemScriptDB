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
            $("#cooperOres").text(event.data.copperOres);
            $("#diamondOres").text(event.data.diamondOres);
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

   
})