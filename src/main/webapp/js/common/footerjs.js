/**
 * 完美解决iframe双滚动条显示
 * @author yangsen
 * @param frameId
 * @param topOffset
 * @param leftOffset
 */
function resizeFrame(frameId,topOffset,leftOffset) {
	document.body.style.overflow='scroll';
	document.body.style.overflowX='hidden';
	var parentDocEle = parent.document.documentElement;
	$("html").add("body").css({"overflow-x:":"hidden","overflow-y:":"scroll"});
	var newrectage ={'height':parentDocEle.clientHeight-topOffset,'width':parentDocEle.scrollWidth-leftOffset};
	var pcontent = parent.document.getElementById("content");
	var footheight = $('#footer',parentDocEle).outerHeight()||50;
	$(pcontent).css({'height':newrectage.height+'px','width':newrectage.width+'px'});
	$(parent.document.getElementById(frameId)).css({'width':newrectage.width,'height':newrectage.height-footheight+'px'}); 
}
//init .
$(parent).resize(function() {
	var parentDocEle = parent.document.documentElement;
	var leftOffset = $(".possidebar",parentDocEle).width();
	//alert(leftOffset);
	resizeFrame("ifrObj",$("#header",parentDocEle).height(),leftOffset);
});

$(parent.window).resize();


