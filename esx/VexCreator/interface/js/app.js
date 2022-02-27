$(document).ready(function(){
    let charDataGender = 0;

    window.addEventListener('message', function(event){

      if(event.data.showVexCreator == true){
        $(".charCreator").css("display","block");
        $(".styleCreator").css("display","block");
        $(".submit").css("display","block");
        $(".rotation").css("display","flex");
      }

      if(event.data.showLocationSelection == true){
        $(".charCreator").fadeOut(400);
        $(".styleCreator").fadeOut(400);
        $(".submit").fadeOut(400);
        $(".rotation").css("display","none");
        $(".selector").css("display","block");
      }

      if(event.data.showVexCreator == false){
        $(".charCreator").fadeOut(400);
        $(".styleCreator").fadeOut(400);
        $(".submit").fadeOut(400);
        $(".rotation").css("display","none");
        $(".selector").fadeOut(400);
      }
    });

    function UpdateSkin(finish) {
      $.post('http://VexCreator/updateSkin', JSON.stringify({
          value: finish,
          dad: $('input[name=papi]:checked').val(),
          mum: $('input[name=mami]:checked').val(),
          sex: charDataGender,
          morfpercent: $('.morfologia').val(),
          skintone: $('.piel').val(),
          lips: $('.lip-thickness').val(),
          neck: $('.neck-tickness').val(),
          jawh: $('.jawh').val(),
          jaww: $('.jaww').val(),
          chinh: $('.chinh').val(),
          chinl: $('.chinl').val(),
          chinw: $('.chinw').val(),
          chinhole: $('.chinhole').val(),
          eyesquint: $('.eyesquint').val(),
          eyesbrowh: $('.eyesbrowh').val(),
          eyesbrowd: $('.eyesbrowd').val(),
          nosewidth: $('.nosewidth').val(),
          noseh: $('.noseh').val(),
          nosepeakl: $('.nosepeakl').val(),
          noseboneh: $('.noseboneh').val(),
          nosepeakh: $('.nosepeakh').val(),
          nosetwist: $('.nosetwist').val(),
          cheekboneh: $('.cheekboneh').val(),
          cheekbonew: $('.cheekbonew').val(),
          cheekw: $('.cheekw').val(),
          eyecolor: $('input[name=eyecolor]:checked').val(),
          skinproblem: $('.ppiel').val(),
          skinproblemopacity: $('.ppielp').val(),
          freckle: $('.marcas').val(),
          freckleopacity: $('.marcasp').val(),
          cicatrices: $('.cicatrices').val(),
          cicatricesp: $('.cicatricesp').val(),
          wrinkle: $('.arrugas').val(),
          wrinkleopacity: $('.arrugasp').val(),
          hair: $('.hair').val(),
          hair2: $('.hair2').val(),
          haircolor: $('input[name=haircolor]:checked').val(),
          haircolor2: $('input[name=haircolor2]:checked').val(),
          eyebrow: $('.cejas').val(),
          eyebrowopacity: $('.cejasp').val(),
          eyebrowcolor: $('input[name=cejascolor]:checked').val(),
          beard: $('.barba').val(),
          beardopacity: $('.barbap').val(),
          beardcolor: $('input[name=colorbarba]:checked').val(),
          makeuptype: $('.makeuptype').val(),
          makeupintensidad: $('.makeupintensidad').val(),
          makeupcolor1: $('input[name=makeupcolor1]:checked').val(),
          makeupcolor2: $('input[name=makeupcolor2]:checked').val(),
          lipsticktype: $('.lipsticktype').val(),
          lipstickintensidad: $('.lipstickintensidad').val(),
          lipstickcolor1: $('input[name=lipstickcolor1]:checked').val(),
          blushtype: $('.blushtype').val(),
          blushintensidad: $('.blushintensidad').val(),
          blushcolor: $('input[name=blushcolor]:checked').val(),
          tshirt: $('.tshirt').val(),
          tshirtcolor: $('.tshirtcolor').val(),
          torso: $('.torso').val(),
          torsocolor: $('.torsocolor').val(),
          arms: $('.arms').val(),
          armscolor: $('.armscolor').val(),
          pants: $('.pants').val(),
          pantscolor: $('.pantscolor').val(),
          shoes: $('.shoes').val(),
          shoescolor: $('.shoescolor').val(),
          ears: $('.ears').val(),
          earscolor: $('.earscolor').val(),
          chain: $('.chain').val(),
          chaincolor: $('.chaincolor').val(),
          glasses: $('.glasses').val(),
          glassescolor: $('.glassescolor').val(),
          watches: $('.watches').val(),
          watchescolor: $('.watchescolor').val()
        }));
    }

    $('.color').each(function(){
      var color = $(this).attr('data-color');
      $(this).css('background-color', color);
    });

    $('body').on('click', '.changeGender', function (event) {
      if(charDataGender != $(this).attr("data-value")) {
          charDataGender = $(this).attr("data-value");
          $(this).removeClass('isnotset');

          if ($(this).attr("data-value") == '1') {
            var showelement = document.getElementById('maquillajes');
            var showelement2 = document.getElementById('pintalabios');
            var showelement3 = document.getElementById('coloretes');
            var hiddenelement = document.getElementById('barbas');
            hiddenelement.classList.remove("show");
            hiddenelement.classList.add("hide");
            showelement.classList.remove("hide");
            showelement2.classList.remove("hide");
            showelement3.classList.remove("hide");
            showelement.classList.add("show");
            showelement2.classList.add("show");
            showelement3.classList.add("show");
            
          } else {
            var showelement = document.getElementById('barbas');
            var hiddenelement = document.getElementById('pintalabios');
            var hiddenelement2 = document.getElementById('coloretes');
            var hiddenelement3 = document.getElementById('maquillajes');
            hiddenelement.classList.remove("show");
            hiddenelement.classList.add("hide");
            hiddenelement2.classList.remove("show");
            hiddenelement2.classList.add("hide");
            hiddenelement3.classList.remove("show");
            hiddenelement3.classList.add("hide");
            showelement.classList.remove("hide");
            showelement.classList.add("show");            
          }
    
          $(".changeGender").each(function() {
              if($(this).attr("data-value") != charDataGender) $(this).addClass('isnotset');
              UpdateSkin(false);
          });   
      }
      
    });

    $('body').on('click', '.changeStyle', function (event) {     
      if($(this).hasClass('isnotset')) {
        var something = $(this).attr("data-value");
        $(this).removeClass('isnotset');

        $(".changeStyle").each(function() {
          if($(this).attr("data-value") != something) $(this).addClass('isnotset');
        });

        if (something === 'style') {
          var showingelement = document.getElementById('style');
          var hidenelement = document.getElementById('clothes');
          hidenelement.classList.remove("show");
          hidenelement.classList.add("hide");
          showingelement.classList.remove("hide");
          showingelement.classList.add("show");
          $.post('http://VexCreator/cambiarplano', JSON.stringify({
            plano: 'cara'
          }));
        } else {
          var hidenelement = document.getElementById('style');
          var showingelement = document.getElementById('clothes');
          hidenelement.classList.remove("show");
          hidenelement.classList.add("hide");
          showingelement.classList.remove("hide");
          showingelement.classList.add("show");
          $.post('http://VexCreator/cambiarplano', JSON.stringify({
            plano: 'ropa'
          }));
        }        
      }
    });

    $('input').bind("input",function(){
      UpdateSkin(false)
    });



    $('.submit').on('click', function(e){
      $('.popup').fadeIn(200);
    });

    // $('.badland').on('click', function(e){
    //   $.post('http://VexCreator/selectedspawn', JSON.stringify({
    //       location: 'badland'
    //     }));
    // });

    // $('.melian').on('click', function(e){
    //   $.post('http://VexCreator/selectedspawn', JSON.stringify({
    //       location: 'melian'
    //     }));
    // }); 

    $('.Airport').on('click', function(e){
      $.post('http://VexCreator/selectedspawn', JSON.stringify({
          location: 'Airport'
        }));
    });

    $('.Train').on('click', function(e){
      $.post('http://VexCreator/selectedspawn', JSON.stringify({
          location: 'Train'
        }));
    }); 
    
    $('.popup .button').on('click', function(e){
      $('.popup').fadeOut(200);
    });

    $('.yes').on('click', function(e){
      $('.popup').fadeOut(200);
      UpdateSkin(true);
    });

    $('.inputclothes .label-value').each(function(){
      var max = $(this).parent().find('.label-value').attr('data-maxvalue'),
      val = $(this).next().find('input').val();
      $(this).parent().find('.label-value').text(val+' / '+max);
    });

    $('#clothes input[type=range]').change(function(){
      var value = parseFloat($(this).val()),
          max = $(this).parent().prev().attr('data-maxvalue');
      $(this).parent().prev().text(value+' / '+max);
    });

    // Arrows for input[type=range]
    $('#clothes .arrow-right-clothing').on('click', function(e) {
      //e.preventDefault();
      var value = parseFloat($(this).prev().val()),
        newValue = parseFloat(value + 1),
        max = $(this).parent().prev().attr('data-maxvalue');
      if (newValue > max) {
        newValue = max;
      }
      $(this).prev().val(newValue);
      $(this).parent().prev().text(newValue + '/' + max);
      UpdateSkin(false)
    });

    $('#clothes .arrow-left-clothing').on('click', function(e) {
      //e.preventDefault();
      var value = parseFloat($(this).next().val()),
        newValue = parseFloat(value - 1),
        max = $(this).parent().prev().attr('data-maxvalue');
      if (newValue < 0) {
        newValue = 0;
      }
      $(this).next().val(newValue);
      $(this).parent().prev().text(newValue + '/' + max);
      UpdateSkin(false)
    });

    // Arrows for input[type=range]
    $('.arrow-right').on('click', function(e) {
      //e.preventDefault();
      var value = parseFloat($(this).prev().val()),
        newValue = parseFloat(value + 1),
        max = $(this).prev().max;
      if (newValue > max) {
        newValue = max;
      }
      $(this).prev().val(newValue);
      UpdateSkin(false)
    });

    $('.arrow-left').on('click', function(e) {
      var value = parseFloat($(this).next().val()),
      newValue = parseFloat(value - 1);
      if (newValue < 0) {
        newValue = 0;
      }
      $(this).next().val(newValue);
      UpdateSkin(false)
    });

    $(document).keypress(function(e) {
      if(e.which == 97){
        $.post('http://VexCreator/rotar', JSON.stringify({
          value: -5
        }));
      }
      if(e.which == 100){
        $.post('http://VexCreator/rotar', JSON.stringify({
          value: 5
        }));
      }
    });

});