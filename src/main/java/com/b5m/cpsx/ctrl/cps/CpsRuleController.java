package com.b5m.cpsx.ctrl.cps;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.b5m.cpsx.ctrl.BaseController;
import com.b5m.cpsx.model.ControllerMessage;
import com.b5m.cpsx.service.cps.ICpsService;
import com.b5m.cpsx.utils.GetUserFromCookieUtils;

@Controller
@RequestMapping("/cps/rule")
public class CpsRuleController extends BaseController{
	
	protected Logger logger = Logger.getLogger(CpsRuleController.class);
	
	private static final String tableName = "cpsx_cps_activity_rule";
	
	@Autowired
	private ICpsService cpsService;
	
	@RequestMapping(value = "/activityrule.do", method=RequestMethod.GET)
	@ResponseBody
	public ModelAndView selectListPage(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mv) {
		Map<String,String> params = paramMap(request);
		List<Object> ls = baseCommonService.selectList("cpsUrlMapper.selectActivityRule", params);
		List<Object> rules = baseCommonService.selectListAll("cpsUrlMapper.selectAllAccount");
		List<Object> activities = baseCommonService.selectListAll("basicActivityMapper.select");
		mv.addObject("rows", ls);
		mv.addObject("rules", rules);
		mv.addObject("activities", activities);
		mv.setViewName("/cps/activityRule");
		return mv;
	}
	
	@RequestMapping(value = "/getOneRuleById.do", method=RequestMethod.GET)
	@ResponseBody
	public Object getOneRuleById(@RequestParam String pid ,HttpServletRequest request, HttpServletResponse response,
			ModelAndView mv) {
		@SuppressWarnings("unchecked")
		Map<String, String> row = (Map<String, String>) baseCommonService.selectOne("cpsUrlMapper.selectOneRuleById", pid);
		try {
			String str = JSON.toJSONString(row, true);
			return str;
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}
	
	@RequestMapping(value = "/saveActivityrule.do", method=RequestMethod.POST)
	@ResponseBody
	public Object saveActivityrule(HttpServletRequest request, HttpServletResponse response) {
		Map<String,String> params = paramMap(request);
		params.put("sysuser", GetUserFromCookieUtils.getUser(request).getUserName());
		ControllerMessage cm = new ControllerMessage();
		if(params.get("flag").equals("add")){
			try {
				Object obj = baseCommonService.selectOne("cpsUrlMapper.selectRuleLastId");
				int pid = obj==null?0:(int)obj;
				pid++;
				params.put("id", pid+"");
				int suc = cpsService.insertActivityRule(params);
				if(suc==0){
					cm.setStatue(false);
					cm.setMessage("重复添加!");
				}else{
					cm.setStatue(true);
					cm.setMessage("添加成功!");
					params.remove("flag");
//					baseRedisService.setMap(tableName+"_"+params.get("activity_id"), params);
				}
			} catch (Exception e) {
				e.printStackTrace();
				cm.setStatue(false);
				cm.setMessage("添加失败!");
			}
		}else if(params.get("flag").equals("update")){
			try {
				int suc = cpsService.updateActivityRule(params);
				if(suc==0){
					cm.setStatue(false);
					cm.setMessage("更新失败!");
				}else{
					cm.setStatue(true);
					cm.setMessage("更新成功!");
					params.remove("flag");
//					baseRedisService.setMap(tableName+"_"+params.get("activity_id"), params);
				}
			} catch (Exception e) {
				e.printStackTrace();
				cm.setStatue(false);
				cm.setMessage("更新失败!");
			}
		}
		return cm;
		
	}
	
	@RequestMapping(value = "/deleteActivityrule.do", method=RequestMethod.POST)
	@ResponseBody
	public Object deleteActivityrule(HttpServletRequest request, HttpServletResponse response) {
		Map<String,String> params = paramMap(request);
		ControllerMessage cm = new ControllerMessage();
		try {
				int suc =(int) baseCommonService.delete("cpsUrlMapper.deleteActivityrule",params);
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
