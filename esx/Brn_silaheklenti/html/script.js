

function open(data) {

console.log("img/" + data.suppressor + ".png")
var myvar = '<div class="clearfix" id="page"><!-- group -->'+
'   <div class="clearfix grpelem" id="pu272"><!-- column -->'+
'    <div class="colelem" id="u272"><!-- simple frame --></div>'+
'    <div class="rgba-background clearfix colelem" id="u94"><!-- group -->'+
'     <div class="clearfix grpelem" id="pu251-4"><!-- column -->'+
'      <div class="clearfix colelem" id="u251-4"><!-- content -->'+
'       <p>SUPPRESSOR</p>'+
'      </div>'+
'      <div class="museBGSize colelem" id="u223" style="opacity:1.0; background:rgba(9, 9, 9, 0.5) url(img/' + data.suppressor + '.png) no-repeat center center; background-size:cover;"><!-- simple frame --></div>'+
'      <button class="clearfix colelem ripple" id="u227"><!-- group -->'+
'       <div class="clearfix grpelem" id="u230-4"><!-- content -->'+
'        <p>REMOVE</p>'+
'       </div>'+
'      </button>'+
'     </div>'+
'     <div class="clearfix grpelem" id="pu254-4"><!-- column -->'+
'      <div class="clearfix colelem" id="u254-4"><!-- content -->'+
'       <p>CLIP</p>'+
'      </div>'+
'      <div class="rgba-background colelem" id="u278" style="opacity:1.0; background:rgba(9, 9, 9, 0.5) url(img/' + data.clip + '.png) no-repeat center center; background-size:cover;"><!-- simple frame --></div>'+
'      <button class="clearfix colelem ripple" id="u234"><!-- group -->'+
'       <div class="clearfix grpelem" id="u235-4"><!-- content -->'+
'        <p>REMOVE</p>'+
'       </div>'+
'      </button>'+
'     </div>'+
'     <div class="clearfix grpelem" id="pu257-4"><!-- column -->'+
'      <div class="clearfix colelem" id="u257-4"><!-- content -->'+
'       <p>FLASHLIGHT</p>'+
'      </div>'+
'      <div class="rgba-background colelem" id="u281" style="opacity:1.0; background:rgba(9, 9, 9, 0.5) url(img/' + data.flashlight + '.png) no-repeat center center; background-size:cover;"><!-- simple frame --></div>'+
'      <button class="clearfix colelem ripple" id="u243"><!-- group -->'+
'       <div class="clearfix grpelem" id="u244-4"><!-- content -->'+
'        <p>REMOVE</p>'+
'       </div>'+
'      </button>'+
'     </div>'+
'     <div class="clearfix grpelem" id="pu263-4"><!-- column -->'+
'      <div class="clearfix colelem" id="u263-4"><!-- content -->'+
'       <p>FINISH</p>'+
'      </div>'+
'      <div class="rgba-background colelem" id="u284" style="opacity:1.0; background:rgba(9, 9, 9, 0.5) url(img/' + data.finish + '.png) no-repeat center center; background-size:cover;"><!-- simple frame --></div>'+
'      <button class="clearfix colelem ripple" id="u261"><!-- group -->'+
'       <div class="clearfix grpelem" id="u262-4"><!-- content -->'+
'        <p>REMOVE</p>'+
'       </div>'+
'      </button>'+
'     </div>'+
'    </div>'+
'   </div>'+
'   <div class="clearfix grpelem" id="pu312"><!-- column -->'+
'    <div class="colelem" id="u312"><!-- simple frame --></div>'+
'    <div class="rgba-background clearfix colelem" id="u311"><!-- column -->'+
'     <div class="clearfix colelem" id="u319-4"><!-- content -->'+
'      <p>ARMOR</p>'+
'     </div>'+
'     <div class="rgba-background colelem" id="u320" style="opacity:1.0; background:rgba(9, 9, 9, 0.5) url(img/' + data.armor + '.png) no-repeat center center; background-size:cover;"><!-- simple frame --></div>'+
'     <button class="clearfix colelem rippleBlue" id="u317"><!-- group -->'+
'      <div class="clearfix grpelem" id="u318-4"><!-- content -->'+
'       <p>REMOVE</p>'+
'      </div>'+
'     </button>'+
'    </div>'+
'   </div>'+
'   <div class="verticalspacer" data-offset-top="0" data-content-above-spacer="1078" data-content-below-spacer="1078"></div>'+
'  </div>';
    



$("#main_container").html(myvar).fadeOut(0).fadeIn(1000);



}




$(document).keyup(function(e) {
    if (e.keyCode === 27) {

         $("#main_container").html("");
    
         $.post('https://core_weapon/close', JSON.stringify({}));
    }
});

window.addEventListener('message', function(event) {

    var edata = event.data;


   
    if (edata.type == "open") {


        open(edata);

    } else if (edata.type == "close") {
        $("#main_container").html("");
        $("#main_container").css({
            display: 'none'
        });
    }

    $( "#u227" ).click(function() {
   
  $("#u223").css('background', "rgba(9,9,9,0.5)");
  $.post('https://core_weapon/getComponent', JSON.stringify({component: 'suppressor'}));
});

    $( "#u234" ).click(function() {
   
  $("#u278").css('background', "rgba(9,9,9,0.5)");
  $.post('https://core_weapon/getComponent', JSON.stringify({component: 'clip_extended'}));
});

    $( "#u243" ).click(function() {
   
  $("#u281").css('background', "rgba(9,9,9,0.5)");
  $.post('https://core_weapon/getComponent', JSON.stringify({component: 'flashlight'}));
});

     $( "#u261" ).click(function() {
   
  $("#u284").css('background', "rgba(9,9,9,0.5)");
  $.post('https://core_weapon/getComponent', JSON.stringify({component: 'luxary_finish'}));
});

      $( "#u317" ).click(function() {
   
  $("#u320").css('background', "rgba(9,9,9,0.5)");
  $.post('https://core_weapon/getArmor', JSON.stringify({}));
});




});