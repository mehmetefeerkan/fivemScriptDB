let showCadSystem = function(){
    $('#police-cad').show();
    $('#input-plate').focus();
    $("html").show();
    isCadSystemShowed = true;
}

let hideCadSystem = function(){
    $('#police-cad').hide();
    $("html").hide();
    isCadSystemShowed = false;
}

function openNav() {
    document.getElementById("mySidebar").style.display = "inline-block";
    document.getElementById("openbtn").style.display = "none";
}
  
/* Set the width of the sidebar to 0 and the left margin of the page content to 0 */
function closeNav() {
    document.getElementById("mySidebar").style.display = "none";
    document.getElementById("openbtn").style.display = "block";
}

document.addEventListener("DOMContentLoaded", () => {
    $("html").hide();
});

var coll = document.getElementsByClassName("cezabaslikicerik");
var i;

for (i = 0; i < coll.length; i++) {
  coll[i].addEventListener("click", function() {
    var cezaicerik = this.nextElementSibling;
    this.classList.toggle("cezabaslikicerik-aktif");
    if (cezaicerik.style.display === "block") {
      cezaicerik.style.display = "none";
    } else {
      cezaicerik.style.display = "block";
    }
  });
}

document.onkeydown = function (data) {
    if ((data.which == 120 || data.which == 27) && isCadSystemShowed) { // || data.which == 8
        $.post('http://esx_police_cad/escape');
    }
};

$(document).on('click','.karakter-geri-git', function (ev) {
    $('.civilian-details .inputfield').empty();
    $('.civilian-details').hide(300);
    $('.resultinner').show(300);
});

$(function() {
    window.addEventListener('message', function(event) {

        if (event.data.civilianresults){
            $('.tbody-result-users').remove();
            $('.all-found-users').append($('<tbody class="tbody-result-users">'));
            event.data.civilianresults.forEach(function(user){
                $('.tbody-result-users').append($('<tr>').on('click', function(){
                    showExtraUserData(user);
                })
                    .append($('<td>').text(user['firstname']))
                    .append($('<td>').text(user['lastname']))
                    .append($('<td>').text(user['sex']))
                    .append($('<td>').text(user['dateofbirth'])));
            })
        }

        if (event.data.crresults){
           createTableCr(event.data.crresults);
        }

        if(event.data.note_deleted){
            playerid = JSON.stringify({ playerid: $('#cr-playerid').val() });
            

            noteMessage = $('.note-message');
            noteMessage.empty();
            noteMessage.text('Note deleted');
            setTimeout(function(){
                $.post('http://esx_police_cad/get-note', playerid );
                noteMessage.empty();
            },1000);
        }

        if(event.data.note_not_deleted){
            noteMessage = $('.note-message');
            noteMessage.empty();
            noteMessage.text('Note deleted failed');
            setTimeout(function(){
                noteMessage.empty();
            },2000);
        }

        if(event.data.cr_deleted){
            playerid = JSON.stringify({ playerid: $('#cr-playerid').val() });

            crMessage = $('.cr-message');
            crMessage.empty();
            crMessage.text('Cr deleted');
            setTimeout(function(){
                $.post('http://esx_police_cad/get-cr', playerid );

                crMessage.empty();
            },1000);
        }

        if(event.data.bolo_not_deleted){
            boloMessage = $('.error-bolo');
            boloMessage.empty();
            boloMessage.text('İşlem Başarısız Oldu.');
            setTimeout(function(){
                boloMessage.empty();
            },2000);
        }

        if(event.data.bolo_deleted){
            playerid = JSON.stringify({ playerid: $('#cr-playerid').val() });
            boloMessage = $('.bolo-message');
            boloMessage.empty();
            boloMessage.text('Aranma Kaydı Sistemden Silindi. (Gitmesi zaman alabilir)');
            setTimeout(function(){
                $.post('http://esx_police_cad/get-bolos', playerid );

                boloMessage.empty();
            },2000);
        }

        if(event.data.cr_not_deleted){
            crMessage = $('.cr-message');
            crMessage.empty();
            crMessage.text('Cr deleted failed');
            setTimeout(function(){
                crMessage.empty();
            },2000);
        }

        if (event.data.noteResults){
            createNoteTable(event.data.noteResults);
        }

        if (event.data.licenseResults){
            createTableLicense(event.data.licenseResults);
        }

        if (event.data.showBolos){
            createBoloTable(event.data.showBolos);
        }

        if (event.data.plate){
            $('#plate').empty().append(event.data.plate);
            $('#model').empty().append(event.data.modelname);
            $('#firstname').empty().append(event.data.firstname);
            $('#lastname').empty().append(event.data.lastname);
        }

        if (event.data.foto) {
            document.getElementById("cr-resmi").value = event.data.foto;
        }

        if(event.data.showCadSystem === true){
            showCadSystem();
        }

        if(event.data.showCadSystem === false){
            hideCadSystem();
        }

    });

    document.onkeydown = function (data) {
        if ((data.which == 120 || data.which == 27) && isCadSystemShowed) { // || data.which == 8
            $.post('http://esx_police_cad/escape');
            hideCadSystem();
        }
    };

    $(document).on('click','#search-for-plate',function(event){
        searchPlate();
    });

    $(document).on('click','.police-cad-close',function(event){
        $.post('http://esx_police_cad/escape');
        hideCadSystem();
    });

    $(document).on('click','.civ-back', function (ev) {
        $('.resultinner').show(300);
    });

    $(document).on('click','.add-cr', function (ev) {
        $('.modal-add-record').show(300);
        $(".modal-add-note").hide(400);
    });

    $(document).on('click','.add-bolo', function (ev) {
        $('.modal-add-bolos').show(300);
    });

    $(document).on('click','#save-criminal-record', function () {
        if ($('#cr-reason').val().length > 0 && $('#cr-fine').val().length > 0 ) {
            addCR();
        } else if ($('#cr-resmi').val().length > 0) {
            userPhoto = JSON.stringify({resmi: $('#cr-resmi').val(), playerid: $('#cr-playerid').val() });
            $.post('http://esx_police_cad/save-photo', userPhoto);
            $("#save-criminal-record").notify(
                "Suçlunun resmi kaydedildi!",  "success", 
                { position: "bottom" }
            );
        } else {
            $("#save-criminal-record").notify(
                "Kişinin suçlarını ve cezasının bedelini yazmalısın!", "error", 
                { position: "bottom" }
            );
        }
    });

    $(document).on('click','#foto-cek', function (ev) {
        $.post('http://esx_police_cad/foto-cek');
    });

    $(document).on('click','.add-note', function (ev) {
        ($('#note-title').val(''));
        ($('#note-content').val(''));
    });

    $(document).on('click','.delete_note' ,function () {
        note = JSON.stringify({ id:  $(this).data('id') });
        $.post('http://esx_police_cad/delete_note', note);
    });

    $(document).on('click','.delete_cr' ,function () {
        cr = JSON.stringify({ id:  $(this).data('id') });
        $.post('http://esx_police_cad/delete_cr', cr);
    });

    $(document).on('click','#save-note', function (ev) {
        if ($('#note-title').val().length > 1 ) {
            addNote();
        } else {
            $("#save-note").notify(
                "Boş Not Kaydedemezsin",  "error", 
                { position: "bottom" }
            );
        }
    });

    $(document).on('click','#save-bolos', function (ev) {
        bolo = JSON.stringify({
            name: $('#input-bolos-gender').val(),
            lastname: $('#input-bolos-height').val(),
            cinsiyet: $('#input-bolos-age').val(),
            sebeb: $('#input-bolos-type-of-crime').val(),
        });

        $.post('http://esx_police_cad/add-bolo', bolo);
        $('.modal-add-bolos').hide(300);
    });

    $(document).on('click','.delete_bolo' ,function () {
        bolo = JSON.stringify({ id:  $(this).data('id') });
        $.post('http://esx_police_cad/delete-bolo', bolo);
    });

    $(document).on('click','#search-for-civilian',function(event){
        searchPlayer();
    });

    function searchPlate(){
        plate = JSON.stringify({ plate: $('#input-plate').val() });
        console.log(plate)
        $.post('http://esx_police_cad/search-plate', plate);
    }

    function addCR(){
        criminalRecord = JSON.stringify({ reason: $('#cr-reason').val(), fine: $('#cr-fine').val(), resmi: $('#cr-resmi').val(), time: $('#cr-time').val(), playerid: $('#cr-playerid').val() });
        $.post('http://esx_police_cad/add-cr', criminalRecord);
		$.post('http://esx_police_cad/refresh_cr', criminalRecord);
    }

    function addNote(){
        note = JSON.stringify({ content: $('#note-content').val(), title: $('#note-title').val(), playerid: $('#cr-playerid').val()});
        $.post('http://esx_police_cad/add-note', note);
		$.post('http://esx_police_cad/refresh_note', note);
    }

    $(document).on('click', '.police-cad-menu li', function () {
        var id = $(this).data('id');
        $('.active').removeClass('active');
        $(this).addClass('active');

        hidePlateChecker();

        if($(this).data('id') == 'plate-checker'){
            showPlateChecker();
        }
        
        if ( id == 'bolos'){
            $.post('http://esx_police_cad/get-bolos');
        }

        $('.page').hide();
        $('#'+id).show();
        $('input').focus();
    });
});

function showPlateChecker(){
    $('#plate-checker').show();
}
function hidePlateChecker(){
    $('#plate-checker').hide();
}

function createTableCr(crresults){
    $('.sabika-icerik-cezalar').html('');
    crresults.forEach(function(cr){
        if (cr['id'] != "-1" ) {
        $('.sabika-icerik-cezalar').append($('<div class="sabika-icerik-cezalar-js">')
            .append($('<div class="sabika-icerik-kutu">').text(cr['reason']))
            .append($('<div class="sabika-icerik-kutuceza">').text(cr['fine']))
            .append($('<div class="sabika-icerik-kutux">').append($('<span style="text-aligin: center;"class="delete_cr" data-id="'+ cr['id'] +'">').text('X'))));
        } else {
        $('.sabika-icerik-cezalar').append($('<div class="sabika-icerik-cezalar-js">')
            .append($('<div class="sabika-icerik-kutu">').text(cr['reason']))
            .append($('<div class="sabika-icerik-kutuceza">').text(cr['fine']))
            .append($('<div class="sabika-icerik-kutux">').text()))
        }
    })
}

function createNoteTable(noteResults){
    $('.not-icerik-cezalar').html('');
    noteResults.forEach(function(notes){
        if (notes['id'] != "-1" ) {
            $('.not-icerik-cezalar').append($('<div class="not-icerik-cezalar-js">')
            .append($('<div class="not-icerik-kutu">').text(notes['title']))
            .append($('<div class="not-icerik-kutux">').append($('<span style="text-aligin: center;"class="delete_note" data-id="'+ notes['id'] +'">').text('X'))));
        } else {
            $('.not-icerik-cezalar').append($('<div class="not-icerik-cezalar-js">')
            .append($('<div class="not-icerik-kutu">').text(notes['title']))
            .append($('<div class="not-icerik-kutux">').text()))
        }
    })
}

function createBoloTable(boloResults){
    $('.police-cad-bolos tbody').html('');
    boloResults.forEach(function(bolo){
        if (bolo['id'] == -1 ) {
            $('.police-cad-bolos tbody').append($('<tr>')
                .append($('<td>').text(bolo['name']))
                .append($('<td>').text(""))
                .append($('<td>').text(""))
                .append($('<td>').text(""))
                .append($('<td>').text(""))
                .append($('<td>').text(""))
            );
        } else {
            $('.police-cad-bolos tbody').append($('<tr>')
                .append($('<td>').text(bolo['name']))
                .append($('<td>').text(bolo['lastname']))
                .append($('<td>').text(bolo['cinsiyet']))
                .append($('<td>').text(bolo['sebeb']))
                .append($('<td>').text(bolo['created_at']))
                .append($('<td>').append($('<span class="delete_bolo" data-id="'+ bolo['id'] +'">').text('X')))
        );
        }
    })
}

function createTableLicense(licenseResults){
    $('.lisanslar-kutu').html('');
    licenseResults.forEach(function(license){
        var type = license['type'];
        if ( type == 'boating') {
            type = 'Bot Sürme Ehliyeti';
        } else if ( type == 'dmv' ) {
            type = 'Sürücü Yazılı Test Belgesi';
        } else if ( type == 'drive' ) {
            type = 'Araç Ehliyeti';
        } else if ( type == 'drive_bike' ) {
            type = 'Motorsiklet Ehliyeti';
        } else if ( type == 'drive_truck' ) {
            type = 'Ticari Araç/Kamyom Ehliyeti';
        } else if ( type == 'weapon' ) {
            type = 'Silah Taşıma Ruhsatı';
        } else if ( type == 'aircraft' ) {
            type = 'Pilotluk Ruhsatı';
        } else if ( type == 'weed_processing' ) {
            type = 'Silah Satın Alma Ruhsatı';
        }
        $('.lisanslar-kutu').append($('<div class="lisanslar-js">')
            .append($('<div class="lisans-turu">').text(type)));
    })
}

function showExtraUserData(user){
    $('#criminal-records tbody').html('');
    $('#licenses tbody').html('');
    $('.resultinner').hide(300);
    $('.civilian-details').show(300);

    $('#cr-playerid').val(user.identifier);
    if ( user.sex == 'm' ) {
        $('.cinsiyet').text('Erkek');
        if ( user.userimage != undefined ) {
            $('img').attr('src', user.userimage);
        } else {
            $('img').attr('src', 'images/male.png');  
        }
    } else {
        $('.cinsiyet').text('Kadın');
        if ( user.userimage != undefined ) {
            $('img').attr('src', user.userimage);   
        } else {
            $('img').attr('src', 'images/female.png');   
        }
    }
    $('.isimsoyisim').text(user.firstname + ' ' + user.lastname);
    $('.dob').text(user.dateofbirth);
    $('.vatandasno').text('#' + user.lastdigits);
    $('.height').text(user.height + ' cm');
    //$('.banka').text('$' + JSON.parse(user.bank));
    $('.numara').text(user.phone_number);

    playerid = JSON.stringify({ playerid: user.identifier });
    $.post('http://esx_police_cad/get-cr', playerid );

    $.post('http://esx_police_cad/get-note', playerid );

    $.post('http://esx_police_cad/get-license', playerid );
}

function searchPlayer(){
    search = JSON.stringify({ search: $('#search').val() });
    $.post('http://esx_police_cad/search-players', search);
}





