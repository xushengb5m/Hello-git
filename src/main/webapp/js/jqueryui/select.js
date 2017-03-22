//Desprecated ? 
$(function() {
	$('.field select').change(function(){
		var tar = $("option:selected",$(this)).text();
		var tarspan=$(this).siblings('span').find('b');
		tarspan.html(tar);
	});
});