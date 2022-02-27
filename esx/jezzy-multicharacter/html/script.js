var selectedChar = null;
var WelcomePercentage = "30vh"
qbMultiCharacters = {}
var Loaded = false;

$(document).ready(function (){
    window.addEventListener('message', function (event) {
        var data = event.data;

        if (data.action == "ui") {
            if (data.toggle) {
                $.post('https://pant-multicharacter/setupCharacters');
                $('.container').show();
                $(".welcomescreen").fadeIn(150);
                qbMultiCharacters.resetAll();

               
            } else {
                $('.container').fadeOut(250);
                qbMultiCharacters.resetAll();
            }
        }

        if (data.action == "setupCharacters") {
            var originalText = "Oyuncu Verileri Alınıyor";
            var loadingProgress = 0;
            var loadingDots = 0;
            $("#loading-text").html(originalText);
            var DotsInterval = setInterval(function() {
                $("#loading-text").append(".");
                loadingDots++;
                loadingProgress++;
                if (loadingProgress == 3) {
                    originalText = "Oyuncu Verileri Doğrulanıyor"
                    $("#loading-text").html(originalText);
                }
                if (loadingProgress == 4) {
                    originalText = "Karakter Bilgileri Alınıyor"
                    $("#loading-text").html(originalText);
                }
                if (loadingProgress == 6) {
                    originalText = "Karakter Bilgileri Doğrulanıyor"
                    $("#loading-text").html(originalText);
                }
                if(loadingDots == 4) {
                    $("#loading-text").html(originalText);
                    loadingDots = 0;
                }
            }, 500);
        
            setTimeout(function(){
                
                setTimeout(function(){
                    clearInterval(DotsInterval);
                    loadingProgress = 0;
                    originalText = "Veriler Alınıyor";
                    $(".welcomescreen").fadeOut(150);
                    qbMultiCharacters.fadeInDown('.my-characters-list', '0%', 400);
                    $.post('https://pant-multicharacter/removeBlur');
                }, 2000);
            }, 2000);

            setupCharacters(event.data.characters)
        }

        if (data.action == "setupCharInfo") {
            setupCharInfo(event.data.chardata)
        }
    });

    $('.datepicker').datepicker();
});

$('.continue-btn').click(function(e){
    e.preventDefault();

    // qbMultiCharacters.fadeOutUp('.welcomescreen', undefined, 400);
    // qbMultiCharacters.fadeOutDown('.server-log', undefined, 400);
    // setTimeout(function(){
    //     qbMultiCharacters.fadeInDown('.characters-list', '20%', 400);
    //     qbMultiCharacters.fadeInDown('.character-info', '20%', 400);
    //     $.post('https://pant-multicharacter/setupCharacters');
    // }, 400)
});

function setupCharInfo(cData) {
    if (cData == 'empty') {
        charCreateMenu()
    } else {
        $('.characters-top-menu').css("opacity", 1.0);
        var gender = "Erkek"
        if (cData.charinfo.gender == 1) { gender = "Kadın" }
        $('#name').html(cData.charinfo.firstname+' '+cData.charinfo.lastname);
        $('#dob').html(cData.charinfo.birthdate);
        $('#gender').html(gender);
        $('#job').html(cData.job.label);
        $('#nationality').html(cData.charinfo.nationality);
    }
}

function charCreateMenu() {
    $('.characters-top-menu').css({"opacity": 0.0})
    var charData = $(selectedChar).data('cid');
    if (selectedChar !== null) {
        if (charData !== "") {
            $.post('https://pant-multicharacter/selectCharacter', JSON.stringify({
                cData: $(selectedChar).data('cData')
            }));
            setTimeout(function(){
                $('.my-characters-list').hide()
                qbMultiCharacters.resetAll();
            }, 1500);
        } else {
            $('.my-characters-list').hide()
            qbMultiCharacters.fadeInDown('.character-register', '25%', 400);
        }
    }
};

function setupCharacters(characters) {
    $.each(characters, function(index, char){
        if (char) {
            $('#char-'+char.cid).html('<span class="char-name" id="cid">'+char.charinfo.firstname+' '+char.charinfo.lastname+'</span>');
            $('#char-'+char.cid).data('cData', char)
            $('#char-'+char.cid).data('cid', char.cid)
        }
    })
}

$(document).on('click', '.box', function(e) {
    var cDataPed = $(this).data('cData');
    e.preventDefault();
    if (selectedChar === null) {
        selectedChar = $(this);
        if ((selectedChar).data('cid') == "") {
            setupCharInfo('empty')
            // Yarat Butonu
            
        } else {
            setupCharInfo($(this).data('cData'))
            // Oyna, Sil Butonu
        }
    } else if ($(selectedChar).attr('id') !== $(this).attr('id')) {
        selectedChar = $(this);
        if ((selectedChar).data('cid') == "") {
            setupCharInfo('empty')
            // Yarat Butonu
           
        } else {
            setupCharInfo($(this).data('cData'))
            // Oyna, Sil Butonu
        }
    }
});

$(document).on('click', '#create', function(e){
    e.preventDefault();
    $.post('https://pant-multicharacter/createNewCharacter', JSON.stringify({
        firstname: $('#first_name').val(),
        lastname: $('#last_name').val(),
        nationality: $('#nationality').val(),
        birthdate: $('#birthdate').val(),
        gender: $('select[name=gender]').val(),
        cid: $(selectedChar).attr('id').replace('char-', ''),
    }));
    $(".container").fadeOut(150);
    qbMultiCharacters.fadeOutDown('.character-register', '125%', 400);
    refreshCharacters()
});

$(document).on('click', '#accept-delete', function(e){
    var charid =  $(selectedChar).data("cData")
    $.post('https://pant-multicharacter/removeCharacter', JSON.stringify({
        citizenid: charid.citizenid,
    }));
    $('#char-'+charid.cid).html('<div class="create-char">+</div>');
    $('#char-'+charid.cid).data('cData', "")
    $('#char-'+charid.cid).data('cid', "")
    $('.character-delete').fadeOut(150);
    $('.characters-block').css("filter", "none");
    refreshCharacters()
});

$(document).on('click', '#play', function(e) {
    e.preventDefault();
    var charData = $(selectedChar).data('cid');

    if (selectedChar !== null) {
        if (charData !== "") {
            $.post('https://pant-multicharacter/selectCharacter', JSON.stringify({
                cData: $(selectedChar).data('cData')
            }));
            qbMultiCharacters.resetAll()
        }
    }
});

function refreshCharacters() {
    setTimeout(function(){
        $(selectedChar).removeClass("char-selected");
        selectedChar = null;
        $.post('https://pant-multicharacter/setupCharacters');
        $('.characters-top-menu').css({"opacity": 0.0})
      //  qbMultiCharacters.resetAll();
    }, 100)
}

$("#close-reg").click(function (e) {
    e.preventDefault();
    qbMultiCharacters.fadeOutDown('.character-register', undefined, 400);
    setTimeout(function(){
        $(".my-characters-list").css("display", "flex");
    }, 400);
})

$("#close-del").click(function (e) {
    e.preventDefault();
    $('.characters-block').css("filter", "none");
    $('.character-delete').fadeOut(150);
})

$(document).on('click', '#delete', function(e) {
    e.preventDefault();
    var charData = $(selectedChar).data('cid');

    if (selectedChar !== null) {
        if (charData !== "") {
            $('.characters-block').css("filter", "blur(2px)")
            $('.character-delete').fadeIn(250);
        }
    }
});

qbMultiCharacters.fadeOutUp = function(element, time) {
    $(element).css({"display":"flex"}).animate({top: "-80.5%",}, time, function(){
        $(element).css({"display":"none"});
    });
}

qbMultiCharacters.fadeOutDown = function(element, percent, time) {
    if (percent !== undefined) {
        $(element).css({"display":"flex"}).animate({top: percent,}, time, function(){
            $(element).css({"display":"none"});
        });
    } else {
        $(element).css({"display":"flex"}).animate({top: "103.5%",}, time, function(){
            $(element).css({"display":"none"});
        });
    }
}

qbMultiCharacters.fadeInDown = function(element, percent, time) {
    $(element).css({"display":"flex"}).animate({top: percent,}, time);
}

qbMultiCharacters.resetAll = function() {
    $('.my-characters-list').css({"display":"none"})
    $('.characters-top-menu').css({"opacity": 0.0})
}