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
@RequestMapping("/web/site")
public class WebSiteController extends BaseController{
	
	protected Logger logger = Logger.getLogger(WebSiteController.class);
	
	@RequestMapping(value = "/sitelist.do", method=RequestMethod.GET)
	@ResponseBody
	public ModelAndView selectListPage(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mv) {
		Map<String,String> params = paramMap(request);
		params.put("supply_id", GetUserFromCookieUtils.getUser(request).getId()+"");
		List<Object> ls = baseCommonService.selectList("websiteMapper.selectWebsiteByUserId", params);
		mv.addObject("rows", ls);
		List<Object> cats = baseCommonService.selectListAll("websiteMapper.selectWebsiteCategory");
		mv.addObject("cats",cats);
		mv.setViewName("/website/userWebsite");
		return mv;
	}
	
	
	@RequestMapping(value = "/saveWebsite.do", method=RequestMethod.POST)
	@ResponseBody
	public Object saveWebSite(HttpServletRequest request, HttpServletResponse response) {
		Map<String,String> params = paramMap(request);
		params.put("supply_id", GetUserFromCookieUtils.getUser(request).getId()+"");
		ControllerMessage cm = new ControllerMessage();
		if(params.get("flag").equals("add")){
			try {
				//时间轴记录操作所用
				request.setAttribute("msg", "添加新站点，名称"+params.get("name")+"url"+params.get("url"));
				int suc = (int) baseCommonService.insert("websiteMapper.insertWebsite",params);
				if(suc==0){
					cm.setStatue(false);
					cm.setMessage("重复添加!");
				}else{
					cm.setStatue(true);
					cm.setMessage("添加成功!");
				}
			} catch (Exception e) {
				e.printStackTrace();
				cm.setStatue(false);
				cm.setMessage("添加失败!");
			}
		}else if(params.get("flag").equals("update")){
			try {
				//时间轴记录操作所用
				request.setAttribute("msg", "更新站点"+params.get("name")+":"+params.get("url"));
				int suc = baseCommonService.update("websiteMapper.updateWebsite", params);
				if(suc==0){
					cm.setStatue(false);
					cm.setMessage("更新失败!");
				}else{
					cm.setStatue(true);
					cm.setMessage("更新成功!");
					params.remove("flag");
				}
			} catch (Exception e) {
				e.printStackTrace();
				cm.setStatue(false);
				cm.setMessage("更新失败!");
			}
		}
		return cm;
	}
}
