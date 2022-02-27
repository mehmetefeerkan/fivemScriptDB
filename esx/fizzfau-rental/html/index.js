$(document).ready(function(){
    $(".container").hide();

    function print(param) { 
        console.log(param)
    }

    window.addEventListener("message", function(event){
        var k = event.data.key
        var v = event.data.value
        $(".container").fadeIn(500);
        LoadVehicles(k, v)
    });
    
    document.onkeyup = function (data) {
        if (data.which == 27) { //esc
            close()
            return
        }
    };

   $(document).on("click", "#close", function (param) { 
       close()
    })

    function close() { 
        $.post('http://fizzfau-rental/close', JSON.stringify({display: false}));
        $(".container").fadeOut(500);
    }
    function LoadVehicles(k, v) {
        document.getElementById("label").innerHTML = k 
        $(".blista").remove();
        for (i=0; i < v.Vehicles.length; i++) {
            // $(".blista").find("[data =" + i + "]").removeData()
            $(".vehicles").append('<div class="blista"><p class="label"> ' + v.Vehicles[i].label+ '</p> <p class="price"> $' + v.Vehicles[i].price + '</p> <img src="' + v.Vehicles[i].name + '.png" alt="'+v.Vehicles[i].name+'"><button class="rent-button" id="'+i+'" type="submit">Rent<hr></button>');
            $("#"+i).data("data", v.Vehicles[i]);
        }
    }

    $(document).on("click", ".rent-button", function (e) { 
        var data = $(this).data("data")
        $.post('http://fizzfau-rental/rent', JSON.stringify({data: data}));
        close()
    });
})

//