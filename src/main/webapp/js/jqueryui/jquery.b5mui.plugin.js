/**
 * b5m js component event bound class.
 * author : yangsen
 */
(function(){
	window['$t']=function(arg){
		return $(arg,top.document);
	};
	jQuery.fn.extend({
		comp_select:function(){
			var ul = $(this);
			var ulviewField=ul.closest(".ok_s_list").prev(".ok_s_show").find(".ok_s_text");
			var ulval = $(this).data('selectedValue');
			var targetField = $(this).attr('data-inputfield');
			var children = $(this).find("li");
			children.each(function() {
				if(ul.attr("data-default")==$(this).attr("data-val")) {					
					ulviewField.text($(this).text());
				}
				
				$(this).on('click',function() {
					var currentVal = $(this).attr("data-val");
					var currentText = $(this).text();
					//alert(currentVal);
					if('#'+targetField==null) {
						$(document.body).append("<input type='hidden' id='"+targetField+"' name='"+targetField+"'/>");
					}
					$('#'+targetField).val(currentVal);
					ul.data('selectedValue',currentVal);
					//ulviewField.text(currentText);
				});
			});
		},
		
		"b5mPopWindow":function(options) {
			this.html('');
			var settings = $.extend({
	            // These are the defaults.
	            "height":"630",
	            "width":"667",
	            "title":"提示",
	            "src":"about:blank"
	        }, options );
			var self = this;
			var podbarh=$(window).height();
			var w=settings.width-20;
			var newah=settings.height;
			var $h=$t('body').height();
			if($t('.backGround').size()==0) {
				$("<div class='backGround'></div>").css({
					'height':$h,
					width:"100%",position:"absolute",top:0,left:0,"background-color":"#202020",filter:"alpha(opacity=50)","-webkit-opacity": 0.5,"-moz-opacity": 0.5,opacity: 0.5,display:"none","z-index":999
				}).appendTo($t("body"));
			};
			
			$t('.backGround').add(this).show();
			
			//$('.newaduser_news').css({'left':(w-posw)/2});
			//$(".newaduser_sepos").css({'left':(w-seposw)/2});
			this.css({
				'top':(podbarh-newah-78)/2,
				width:settings.width,
				position:"absolute",
				left:"25%",
				'margin':0,
				'border':'none',
				"z-index":9999,
				background:"url(/images/adserver/newad/bg-20black.png) repeat",
				"text-align":"left"
				});
			//var ifr = $("iframe").attr("src",settings.src);
			var content = $('<div class="popWinContainer_content" style="margin:10px;background:#FAFAFA;"><div class="popWinContainer_title" style="border-bottom:1px solid #C1C1C1;background:url(/images/adserver/newad/newad_bg.jpg) repeat-x;"><h5 style="margin:0px;color:#E88712;height:49px;line-height:49px;padding-left:50px;padding-right:10px;background:url(/images/adserver/newad/icon-float-box.png) no-repeat 20px -56px;"><span class="b5mpopwin_close" style="width:16px;height:16px;display:block;float:right;background:url(/images/adserver/newad/icon-float-box.png) no-repeat;margin-top:17px;cursor:pointer;"></span>'+settings.title+'</h5></div></div>');
			 content.append('<iframe style="overflow:hidden;border:none;" class="popWinContainer_iframe" width="'+w+'" height="'+newah+'" src="'+settings.src+'"></iframe>');
			this.append(content);
			$t(".b5mpopwin_close").click(function(){
				$t(self).add($t('.backGround')).hide();
			}).hover(function() {
				$(this).addClass("cur").css("background-position","left -36px");
			},function() {
				$(this).removeClass("cur").css("background-position","left top");
			});
			//$(".popWinContainer_content").append(ifr);
		}
	});
	
})();
