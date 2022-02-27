window.addEventListener("message", function(event) {
    let action = event.data.action;
    let data = event.data.data;

    if (action == "show") {
        $("body").fadeIn(500);
        $("#home").addClass("active").show();
        $("#withdraw").removeClass("active").show();
        $("#deposit").removeClass("active").show();
        $("#withdrawATM").css({"display":"none"}).removeClass("active");
        $(".window" + "#home").attr("style", "display: block;");
        $(".window" + "#withdrawATM").attr("style", "display: none;");
    }

    if (action == "showATM") {
        $("body").fadeIn(500);
        $("#home").css({"display":"none"}).removeClass("active");
        $("#deposit").css({"display":"none"}).removeClass("active");
        $("#withdraw").css({"display":"none"}).removeClass("active");
        $("#withdrawATM").css({"display":"block"}).addClass("active");
        $(".window" + "#home").attr("style", "display: none;");
        $(".window" + "#deposit").attr("style", "display: none;");
        $(".window" + "#withdraw").attr("style", "display: none;");
        $(".window" + "#withdrawATM").attr("style", "display: block;");
    }
    if (action == "checkWallet") {
        $("#player-name").html(event.data.player);
        $("#bank-balance").html("$" + event.data.bank);
        $("#cash-amount").html("$" + event.data.cash);
    }

    // if (action == "update") {
    //     $("#player-name").html(data.firstname + " " + data.lastname);
    //     $("#cash-amount").html("$" + data.money);
    //     $("#bank-balance").html("$" + data.bank);
    // }
})
$(document).on('click', "[data-action=deposit]", function(e) {
    var amount = $(this).attr("data-amount");
    if (amount > 0) {
        $.post("https://niso-bank/doDeposit", JSON.stringify({
            amount: parseInt(amount)
        }));
    }
})

$(document).on('click', "[data-action=withdraw]", function(e) {
    var amount = $(this).attr("data-amount");
    if (amount > 0) {
        $.post("https://niso-bank/doWithdraw", JSON.stringify({
            amount: parseInt(amount)
        }));
    }
})

$(document).on('click', "#initiateDeposit", function(e) {
    var amount = $("#depositAmount").val();

    if (amount !== undefined && amount > 0) {
        $("#depositError").css({"display":"none"});
        $("#depositErrorMsg").html('');
        $.post("https://niso-bank/doDeposit", JSON.stringify({
            amount: parseInt(amount)
        }));
        $("#depositAmount").val('')
    } else {
        $("#depositError").css({"display":"block"});
        $("#depositErrorMsg").html("You must type valid numbers to proccess a withdrawal payment!");
    }
})

$(document).on('click', "#initiateWithdraw", function(e) {
    var amount = $("#withdrawAmount").val();

    if (amount !== undefined && amount > 0) {
        $("#withdrawError").css({"display":"none"});
        $("#withdrawErrorMsg").html('');
        $.post("https://niso-bank/doWithdraw", JSON.stringify({
            amount: parseInt(amount)
        }));
        $("#withdrawAmount").val('')
    } else {
        $("#withdrawError").css({"display":"block"});
        $("#withdrawErrorMsg").html("You must type valid numbers to proccess a withdrawal payment!");
    }
})

$(document).on('click', "#initiateWithdrawATM", function(e) {
    var amount = $("#withdrawAmountATM").val();

    if (amount > 5000) {
        $("#withdrawErrorATM").css({"display":"block"});
        $("#withdrawErrorMsgATM").html("You have a cash withdrawal limit of up to 5000.");
        return
    }
    if (amount !== undefined && amount > 0) {
        $("#withdrawErrorATM").css({"display":"none"});
        $("#withdrawErrorMsgATM").html('');
        $.post("https://niso-bank/doWithdrawATM", JSON.stringify({
            amount: parseInt(amount)
        }));
        $("#withdrawAmountATM").val('')
    } else {
        $("#withdrawErrorATM").css({"display":"block"});
        $("#withdrawErrorMsgATM").html("You must type valid numbers to proccess a withdrawal payment!");
    }
})


$(document).on('click', '#log-out', function(e) {
    $("body").fadeOut(500);
    $.post('https://niso-bank/closeNUI', JSON.stringify({}));
});

$(document).on('click', '.nav-item', function(e) {
    var window = $(this).attr('id');

    $('.window').fadeOut(0);
    $('.nav-item').removeClass('active');
    $('.window#' + window).fadeIn(0);
    $('.nav-item#' + window).addClass('active');
})