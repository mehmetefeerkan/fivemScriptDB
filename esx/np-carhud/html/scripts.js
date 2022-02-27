$(document).ready(function(){
   // Listen for NUI Events
  window.addEventListener('message', function(event){
    var item = event.data;
    // Trigger adding a new message to the log and create its display
    if (item.open === 2) {
     // console.log(3)
     // update(item.info);

      if (item.direction) {
        $(".direction").find(".image").attr('style', 'transform: translate3d(' + item.direction + 'px, 0px, 0px)');
        return;
      }

      if (item.atl === false) {
        $(".atlamount").attr("style", "display: none");
        $(".atlamounttxt").attr("style", "display: none");
      }
      else {
        $(".atlamount").attr("style", "display: block");
        $(".atlamounttxt").attr("style", "display: block");
        $(".atlamount").empty();
        $(".atlamount").append(item.atl);
      }
      
      $(".vehicle").removeClass("hide");
      $(".wrap").removeClass("lower");
      $(".time").removeClass("timelower");

      $(".fuelamount").empty();
      $(".fuelamount").append(item.fuel);

      $(".speedamount").empty();
      $(".speedamount").append(item.mph);

      $(".street-txt").empty();
      $(".street-txt").append(item.street);
      
      $(".time").empty();
      $(".time").append(item.time); 

      $(".belt").empty();
      if (item.belt === false) {
        let colorOn = (item.colorblind) ? 'yellow' : 'red';
        $(".belt").append(`<div class='${colorOn}'><img width="15" height="15" src="/html/belt.png"></div>`).fadeIn(500).fadeOut(500);
      }

      if (item.engine === true) {
        $(".ENGINE").fadeIn(1000);
      } else {
        $(".ENGINE").fadeOut(1000);
      }
    }

    if (item.open === 4) {
      $(".vehicle").addClass("hide");
      $(".wrap").addClass("lower");
      $(".time").addClass("timelower");
      $(".fuelamount").empty();
      $(".speedamount").empty();
      $(".street-txt").empty();
      $(".belt-txt").empty();

      $(".time").empty();
      $(".time").append(item.time); 
      $(".direction").find(".image").attr('style', 'transform: translate3d(' + item.direction + 'px, 0px, 0px)');
    }

    if (item.open === 3) {
      $(".full-screen").fadeOut(100);    
    }    
    if (item.open === 1) {
      //console.log(1)
      $(".full-screen").fadeIn(1000);    
    }    
  });
});