addEventListener("message", function(event){

    let item = event.data;
    if(item.type == "txt")
	{ document.getElementById("data").innerHTML = item.html; }
});
