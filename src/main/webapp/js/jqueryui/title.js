$(function() {
	$(".table th,.table td").mouseover(function(){
		var valth=$(this).text().trim();
		if(valth!="" && $(this).find("select").size()==0){
			$(this).attr('title',valth);
		}
	});
	$('tbody tr:first').hover(function(){
		$(this).siblings().removeClass("cur");
		$(this).addClass("cur");
		$(this).parent("tbody").siblings("thead").find("tr:last").css("borderBottom","1px solid #F28D17");
		$(this).css("borderBottom","1px solid #F28D17");
	},function(){
		$(this).removeClass("cur");
		$(this).prev("tr").css("borderBottom","1px solid #D1D1D1");
		$(this).parent("tbody").siblings("thead").find("tr:last").css("borderBottom","1px solid #D1D1D1");
	});
	$("tbody tr").hover(function(){
		if($(this).attr('borderflag')=='0'||!$(this).attr('borderflag')){
			$(this).siblings().removeClass("cur");
			$(this).addClass("cur");
			$(this).prev("tr").css("borderBottom","1px solid #F28D17");
			$(this).css("borderBottom","1px solid #F28D17");
			if($(this).find("a").attr('class')&&$(this).find("a").attr('class').indexOf('evt_childTableHold')!=-1){
				$(this).find(".dropdown_view").show();
			}
			if($(this).find("a").attr('class')&&$(this).find("a").attr('class').indexOf('pospencil')!=-1){
				$(this).find(".ticket-pencil").show();
			}
		}
	},function(){
		if($(this).attr('borderflag')=='0'||!$(this).attr('borderflag')){
			$(this).removeClass("cur");
			$(this).prev("tr").css("borderBottom","1px solid #D1D1D1");
			$(this).css("borderBottom","1px solid #D1D1D1");
			if($(this).find("a").attr('class')&&$(this).find("a").attr('class').indexOf('evt_childTableHold')!=-1){
				$(this).find(".dropdown_view").hide();
			}
			if($(this).find("a").attr('class')&&$(this).find("a").attr('class').indexOf('pospencil')!=-1){
				$(this).find(".ticket-pencil").hide();
			}
		}
	});
	$("thead th").hover(function(){
		$(this).addClass("cur").siblings().removeClass("cur");
	},function(){
		$(this).removeClass("cur");
	});
});
