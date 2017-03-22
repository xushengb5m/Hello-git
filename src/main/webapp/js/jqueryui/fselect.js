function ok_select(options, ok_select, ok_s_show, ok_s_list, ok_s_text, ok_s_value){
	var options = $.extend({
		id:'',
		width:185,
		onSelect:function(){}
		},options);
	var hideFlag = true;
	$('#'+ok_select).css('width',options.width);
	$('#'+ok_s_show).css('width',options.width);
	$('#'+ok_s_list).css('width',options.width).hide();
	$('#'+ok_select).each(function(){
		$(this).click(function(e){
			var self = this;
			hideFlag = false;
			var tar = e.target||e.srcElement;
			if($(tar).parents('#'+ok_s_show).length>0){
				$(self).children('#'+ok_s_list).show();
				$(self).children('#'+ok_s_list).addClass('cur');
				$(self).children('#'+ok_s_show).addClass('cur');
			}
			if(tar.tagName.toLowerCase()==='li'){
				$(self).find('#'+ok_s_text).html($(tar).html());
				$(self).find('#'+ok_s_value).val($(tar).attr('val'));
				$(self).find('#'+ok_s_list).hide();
				$(self).children('#'+ok_s_list).removeClass('cur');
				$(self).children('#'+ok_s_show).removeClass('cur');
				
				options.onSelect($(tar).attr('val'));
			}
			
		});
		
		$(this).mouseover(function(e){
			var self = this;
			var tar = e.target||e.srcElement;
			if(tar.tagName.toLowerCase()==='li'){
				$(self).find('li').removeClass('curr');
				$(tar).addClass('curr');	
			}	
		});
		
		$(document).on('click',function(e){
			var tar = e.target||e.srcElement;
			var eles = $(tar).parents('#'+ok_select);
			if(eles.length===0){
				$('#'+ok_s_list).removeClass('cur');
				$('#'+ok_s_show).removeClass('cur');
				$('#'+ok_s_list).hide();	
			}
		});
		
	});
}