$(function(){
	window.onload = (e) => {
		window.addEventListener('message', (event) => {
			var item = event.data;
			if (item !== undefined && item.type === "ui") {
				if (item.display === true) {
                    $("#container").show();
				} else{
                    $("#container").hide();
                }
			}
			if(item !== undefined && item.type === "updateTitle1"){
				$("#HeadlineTitle1").text(item.headlineTitle1);
			}
			if(item !== undefined && item.type === "updateTitle2"){
				$("#HeadlineTitle2").text(item.headlineTitle2);
			}
			if(item !== undefined && item.type === "updateHeadline1"){
				$("#Headline1").text(item.headline1);
			}
			if(item !== undefined && item.type === "updateHeadline2"){
				$("#Headline2").text(item.headline2);
			}
			//---------------------------------------------//
			if(item !== undefined && item.type === "updateArrest1"){
				$("#recentArrest1").text(item.arrest1);
			}
			if(item !== undefined && item.type === "updateArrest2"){
				$("#recentArrest2").text(item.arrest2);
			}
			if(item !== undefined && item.type === "updateArrest3"){
				$("#recentArrest3").text(item.arrest3);
			}
		});
	$("#container").hide();
	};
});