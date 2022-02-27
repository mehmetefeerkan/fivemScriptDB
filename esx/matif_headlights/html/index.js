$(function () {
    function display(bool) {
        if (bool) {
            $("#container").show();
        } else {
            $("#container").hide();
        }
    }

    display(false)

    window.addEventListener('message', function(event) {
        var item = event.data;
        if (item.type === "ui") {
            if (item.status == true) {
                display(true)
            } else {
                display(false)
            }
        }
    })
    
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('http://matif_headlights/exit', JSON.stringify({}));
            return
        }
    };
    
    $("#b-1").click(function () {
        $.post('http://matif_headlights/setcolor', JSON.stringify({
            color: '-1'
        }));
        return
    })
    $("#b1").click(function () {
        $.post('http://matif_headlights/setcolor', JSON.stringify({
            color: '1'
        }));
        return
    })
    $("#b2").click(function () {
        $.post('http://matif_headlights/setcolor', JSON.stringify({
            color: '2'
        }));
        return
    })
    $("#b3").click(function () {
        $.post('http://matif_headlights/setcolor', JSON.stringify({
            color: '3'
        }));
        return
    })
    $("#b4").click(function () {
        $.post('http://matif_headlights/setcolor', JSON.stringify({
            color: '4'
        }));
        return
    })
    $("#b5").click(function () {
        $.post('http://matif_headlights/setcolor', JSON.stringify({
            color: '5'
        }));
        return
    })
    $("#b6").click(function () {
        $.post('http://matif_headlights/setcolor', JSON.stringify({
            color: '6'
        }));
        return
    })
    $("#b7").click(function () {
        $.post('http://matif_headlights/setcolor', JSON.stringify({
            color: '7'
        }));
        return
    })
    $("#b8").click(function () {
        $.post('http://matif_headlights/setcolor', JSON.stringify({
            color: '8'
        }));
        return
    })
    $("#b9").click(function () {
        $.post('http://matif_headlights/setcolor', JSON.stringify({
            color: '9'
        }));
        return
    })
    $("#b10").click(function () {
        $.post('http://matif_headlights/setcolor', JSON.stringify({
            color: '10'
        }));
        return
    })
    $("#b11").click(function () {
        $.post('http://matif_headlights/setcolor', JSON.stringify({
            color: '11'
        }));
        return
    })
    $("#b12").click(function () {
        $.post('http://matif_headlights/setcolor', JSON.stringify({
            color: '12'
        }));
        return
    })
})
