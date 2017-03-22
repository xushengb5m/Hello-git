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
@RequestMapping("/web/cat")
public class WebCategoryController extends BaseController{
	
	protected Logger logger = Logger.getLogger(WebCategoryController.class);
	
	@RequestMapping(value = "/siteCategory.do", method=RequestMethod.GET)
	@ResponseBody
	public ModelAndView selectSiteCategory(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mv) {
		Map<String,String> params = paramMap(request);
		List<Object> ls = baseCommonService.selectList("websiteMapper.selectWebsiteCategory", params);
		mv.addObject("rows", ls);
		mv.setViewName("/website/siteCategory");
		return mv;
	}
	
	@RequestMapping(value = "/saveSiteCategory.do", method=RequestMethod.POST)
	@ResponseBody
	public Object saveSiteCategory(HttpServletRequest request, HttpServletResponse response) {
		Map<String,String> params = paramMap(request);
		params.put("supply_id", GetUserFromCookieUtils.getUser(request).getId()+"");
		ControllerMessage cm = new ControllerMessage();
		if(params.get("flag").equals("add")){
			try {
				int suc = (int) baseCommonService.insert("websiteMapper.insertWebsiteCategory",params);
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
				int suc = baseCommonService.update("websiteMapper.updateWebsiteCategory", params);
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
	
	@RequestMapping(value = "/deleteSiteCategory.do", method=RequestMethod.POST)
	@ResponseBody
	public Object deleteSiteCategory(HttpServletRequest request, HttpServletResponse response) {
		Map<String,String> params = paramMap(request);
		ControllerMessage cm = new ControllerMessage();
			try {
				int suc = baseCommonService.delete("websiteMapper.deleteWebsiteCategory",params);
				if(suc==0){
					cm.setStatue(false);
					cm.setMessage("删除失败!");
				}else{
					cm.setStatue(true);
					cm.setMessage("删除成功!");
				}
			} catch (Exception e) {
				e.printStackTrace();
				cm.setStatue(false);
				cm.setMessage("删除失败!");
			}
		return cm;
	}
	
}
