$(document).ready(function(){
  
  var documentWidth = document.documentElement.clientWidth;
  var documentHeight = document.documentElement.clientHeight;
  var curTask = 0;
  var processed = []
  var percent = 0;

  document.onkeydown = function (data) {
      if (data.which == 69) {
        closeMain()
        $.post('http://skillbar/taskEnd', JSON.stringify({taskResult: percent}));
      }
  }


  function openMain() {
    $(".divwrap").fadeIn(10);
  }

  function closeMain() {
    $(".divwrap").css("display", "none");
  }  

  window.addEventListener('message', function(event){

    var item = event.data;
    if(item.runProgress === true) {
      percent = 0;
      openMain();
      $('#progress-bar').css("width","0%");
      $('.skillprogress').css("left",item.chance + "%")
      $('.skillprogress').css("width",item.skillGap + "%");
    }

    if(item.runUpdate === true) {
      percent = item.Length
      $('#progress-bar').css("width",item.Length + "%");

      if (item.Length < (item.chance + item.skillGap) && item.Length > (item.chance)) {
        $('.skillprogress').css("background-color","rgb(255,255,255)");

      } else {
        $('.skillprogress').css("background-color","rgb(255,255,255)");
      }

    }

    if(item.closeFail === true) {
      closeMain()
      $.post('http://skillbar/taskCancel', JSON.stringify({tasknum: curTask}));
    }

    if(item.closeProgress === true) {
      closeMain();
    }

  });

});
