$(document).ready(function () {
    const buttons = []
    const submenus = []
    document.onkeyup = function (data) {
        if (data.which == 27) {
            buttons.length = 0
            submenus.length = 0
            $.post('http://dd_context/close', JSON.stringify({}));
            $(".container").fadeOut('slow')
            setTimeout(() => {
                $("button").remove()
                $(".b").remove()
                $(".a").remove();
                $("#title").html('')

            }, 500);
        } else if(data.which == 8) {
            $(".b").hide()
            $("button").remove()
            $(".b").remove()
            $(".a").remove();
    
            for (i = 0; i < buttons.length; ++i) {
                var div = buttons[i]
                var match = div.match("normalbutton")
                if(match) {
                    $(".container").prepend(div).fadeIn(400)
    
                }
            }
            $(".container").append(submenus).fadeIn(400)

        }
    }

    window.addEventListener('message', function (event) {

        var item = event.data;

        if(item.addbutton == true) {
            var title = item.title
            var description = item.description
            var server = item.server
            if(item.id == false || null) {
                var b = (`<button id="normalbutton" data-trigger="`+item.trigger+`" data-parm="`+item.par+`" class = "btn"><div class="title">`+title+`</div><div class="description" >`+description+`</div></button>`)
                $(".container").fadeIn(500)
                buttons.push(b)
                $(".container").append(b).fadeIn(400)
                return
            } else {
                var b = (`<button id="`+item.id+`"data-trigger="`+item.trigger+`" data-parm="`+item.par+`" class = "a btn"><div class="title">`+title+`</div><div class="description" >`+description+`</div></button>`)
                $(".container").fadeIn(500)
                buttons.push(b)
                $(".container").append(b).fadeIn(400)
        }
        } else if(item.SetTitle == true) {
            $("#title").html(item.title)
        } else if(item.addmenu == true) {
            var title = item.title
            var description = item.description
            $(".a").hide()
            $(".container").fadeIn(500)
            var aa = (`<button data-menu="`+item.menuid+`"class = "b btn"><div class="title">`+title+`</div><div class="description" >`+description+`</div><i class="fas fa-chevron-right" style="float:right;margin-top:-10%"></i></button>`)
            $(".container").append(aa).fadeIn(400)
            submenus.push(aa)

        }
    });

    //  FUNCTION 

    function goback() {
        var gobackbutton = (`<button style="height:10px" id="goback"class ="btn"><div class="title" style="margin-top:-3.1%">Go Back</div><i class="fas fa-chevron-left" style="float:right;margin-top:-3%"></i></button>`)
        $(".container").append(gobackbutton).fadeIn(400)
    }

    // Events
    $("body").on("click" , ".a" , function(){
        $.post('http://dd_context/clicked', JSON.stringify({trigger:$(this).attr("data-trigger") , param:$(this).attr("data-parm")}));
        $.post('http://dd_context/close', JSON.stringify({}));
        $(".container").fadeOut('slow')
        setTimeout(() => {
            $("button").remove()
            $("#title").html('')

        }, 500);
        buttons.length = 0
        submenus.length = 0


    })
    $("body").on("click" , "#normalbutton" , function(){
        $.post('http://dd_context/clicked', JSON.stringify({trigger:$(this).attr("data-trigger") , param:$(this).attr("data-parm")}));
        $.post('http://dd_context/close', JSON.stringify({}));
        $(".container").fadeOut('slow')
        setTimeout(() => {
            $("button").remove()
        }, 500);
        $("#title").html('')
        buttons.length = 0
        submenus.length = 0


    })
    
    $("body").on("click" , ".b" , function(){
      $(this).hide()
      $(".b").remove();
      $(".a").remove();
      $("#normalbutton").remove();
      $("#normalbutton").hide();
      goback()
      var menuid = $(this).attr("data-menu")
      for (i = 0; i < buttons.length; ++i) {
          var div = buttons[i]
          var match = div.match(`id="`+menuid+`"`)
         if(match) {
            $(".container").append(div)
         }
         
      }
        
    })


    $("body").on("click" , "[id=goback]" , function(){
        $(this).hide()
        $("button").remove()
        $(".b").remove()
        $(".a").remove();
        // var menuid = $(this).attr("data-menu")
        // var length = buttons.length
        // $('*:not([id = "normalbutton"])').each(function() {
        //    $(this).hide()
        // })
        $(".container").append(submenus).fadeIn(400)

        for (i = 0; i < buttons.length; ++i) {
            var div = buttons[i]
            var match = div.match("normalbutton")
            if(match) {
                $(".container").prepend(div).fadeIn(400)

            }
        }
           

        
    })

});
