package com.b5m.cpsx.ctrl.website;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.b5m.cpsx.ctrl.BaseController;
import com.b5m.cpsx.model.ControllerMessage;
import com.b5m.cpsx.utils.GetUserFromCookieUtils;

@Controller
@RequestMapping("/web/check")
public class WebCheckController extends BaseController{
	
	protected Logger logger = Logger.getLogger(WebCheckController.class);
	
	@RequestMapping(value = "/validateWebsite.do", method=RequestMethod.GET)
	@ResponseBody
	public ModelAndView validateWebsite(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mv) {
		List<Object> ls = baseCommonService.selectListAll("websiteMapper.selectAllWebsite");
		mv.addObject("rows", ls);
		mv.setViewName("/website/checkWebsite");
		return mv;
	}
	
	@RequestMapping(value = "/checkWebsiteView.do", method=RequestMethod.GET)
	@ResponseBody
	public ModelAndView checkWebsiteView(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mv) {
		Map<String,String> params = paramMap(request);
		Object row = baseCommonService.selectOne("websiteMapper.selectOneWebsite", params);
		mv.addObject("data", row);
		mv.setViewName("/website/checkView");
		return mv;
	}
	
	@RequestMapping(value="/checkWebsite.do", method=RequestMethod.GET)
	public String checkWebSite(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mv) {
		Map<String,String> params = paramMap(request);
		ModelAndView cm = new ModelAndView();
		try {
			int suc = baseCommonService.update("websiteMapper.checkWebsite", params);
				if(suc==0){
					cm.addObject("msg","审核失败!");
				}else{
					cm.addObject("msg","审核成功!");
				}
		} catch (Exception e) {
					cm.addObject("msg","审核失败!");
		}
		return "redirect:/web/check/validateWebsite.do";
	}
	
	
}
