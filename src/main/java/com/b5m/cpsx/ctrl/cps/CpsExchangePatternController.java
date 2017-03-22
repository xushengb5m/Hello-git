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

@Controller
@RequestMapping("/cps/pattern")
public class CpsExchangePatternController extends BaseController{
	
	protected Logger logger = Logger.getLogger(CpsExchangePatternController.class);
	
	private static final String tableName = "cpsx_cps_exchange_pattern";
	
	@Autowired
	private ICpsService cpsService;
	
	@RequestMapping(value = "/exchangePattern.do", method=RequestMethod.GET)
	@ResponseBody
	public ModelAndView selectListPage(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mv) {
		Map<String,String> params = paramMap(request);
		List<Object> ls = baseCommonService.selectList("cpsUrlMapper.selectExchangePattern", params);
		mv.addObject("rows", ls);
		mv.setViewName("/cps/exchangePattern");
		return mv;
	}
	
	@RequestMapping(value = "/exchangePatternById.do", method=RequestMethod.GET)
	@ResponseBody
	public ModelAndView selectExchangePattern(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mv) {
		Map<String,String> params = paramMap(request);
		List<Object> ls = baseCommonService.selectList("cpsUrlMapper.selectExchangePatternById", params);
		mv.addObject("rows", ls);
		mv.setViewName("/cps/exchangePattern");
		return mv;
	}
	
	@RequestMapping(value = "/getOnePatternById.do", method=RequestMethod.GET)
	@ResponseBody
	public Object getOnePatternById(HttpServletRequest request, @RequestParam String pid,HttpServletResponse response,
			ModelAndView mv) {
		@SuppressWarnings("unchecked")
		Map<String, String> row = (Map<String, String>) baseCommonService.selectOne("cpsUrlMapper.selectOnePatternById", pid);
		try {
			String str = JSON.toJSONString(row, true);
			return str;
		} catch (Exception e) {
			log.error(e);
		}
		return null;
	}
	
	@RequestMapping(value = "/saveExchangePattern.do", method=RequestMethod.POST)
	@ResponseBody
	public Object saveUrlAccount(HttpServletRequest request, HttpServletResponse response) {
		Map<String,String> params = paramMap(request);
		/*String userName = GetUserFromCookieUtils.getUser(request, baseRedisService).getUserName();
		params.put("sysuser", userName);*/
		ControllerMessage cm = new ControllerMessage();
		if(params.get("flag").equals("add")){
			try {
				Object obj = baseCommonService.selectOne("cpsUrlMapper.selectPatLastId");
				int pid = obj==null?0:(int)obj;
				pid++;
				params.put("id", pid+"");
				int suc = cpsService.insertExchangePattern(params);
				if(suc==0){
					cm.setStatue(false);
					cm.setMessage("重复添加!");
				}else{
					cm.setStatue(true);
					cm.setMessage("添加成功!");
					params.remove("flag");
//					baseRedisService.setMap(tableName+"_"+pid, params);
				}
			} catch (Exception e) {
				e.printStackTrace();
				cm.setStatue(false);
				cm.setMessage("添加失败!");
			}
		}else if(params.get("flag").equals("update")){
			try {
				int suc = cpsService.updateExchangePattern(params);
				if(suc==0){
					cm.setStatue(false);
					cm.setMessage("更新失败!");
				}else{
					cm.setStatue(true);
					cm.setMessage("更新成功!");
					params.remove("flag");
//					baseRedisService.setMap(tableName+"_"+params.get("id"), params);
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
