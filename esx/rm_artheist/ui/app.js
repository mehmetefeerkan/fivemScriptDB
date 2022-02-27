$(document).ready(function(){
    window.addEventListener("message", function(event){
        if(event.data.action == 'open') {
            $(".mission").css({
                "display":"block"
            });
            for(i = 0; i < event.data.list.length; i++) {
                var element = "<img src ='" + event.data.list[i] + '.png' + "' class = 'missionImage' >";
                $(".mission").append(element);
            }
            sleep(3000).then(() => {        
                $(".mission").fadeOut(2000)
                $(".mission").html("");
            });
        }
    })
});

function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}