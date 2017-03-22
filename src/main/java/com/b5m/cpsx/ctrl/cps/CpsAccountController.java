package com.b5m.cpsx.ctrl.cps;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.b5m.cpsx.ctrl.BaseController;
import com.b5m.cpsx.model.ControllerMessage;
import com.b5m.cpsx.service.cps.ICpsService;
import com.b5m.cpsx.utils.GetUserFromCookieUtils;

@Controller
@RequestMapping("/cps/act")
public class CpsAccountController extends BaseController{
	
	protected Logger logger = Logger.getLogger(CpsAccountController.class);
	
	private static final String tableName = "cpsx_cps_url_account";
	
	@Autowired
	private ICpsService cpsService;
	
	@RequestMapping(value = "/urlaccount.do", method=RequestMethod.GET)
	@ResponseBody
	public ModelAndView selectListPage(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mv) {
		Map<String,String> params = paramMap(request);
		List<Object> ls = baseCommonService.selectList("cpsUrlMapper.selectCpsAccount", params);
		mv.addObject("rows", ls);
		mv.setViewName("/cps/urlAccount");
		return mv;
	}
	
	@RequestMapping(value = "/urlaccountById.do", method=RequestMethod.GET)
	@ResponseBody
	public ModelAndView urlaccountById(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mv) {
		Map<String,String> params = paramMap(request);
		String str = (String) baseCommonService.selectOne("cpsUrlMapper.selectOnePatternJson", params);
		JSONObject json = JSONObject.parseObject(str);
		List<TreeMap> tms = new ArrayList<TreeMap>();
		Iterator it = json.keySet().iterator();
		while(it.hasNext()){
			String key = (String) it.next();
			String val = (String)json.get(key);
			TreeMap tm = new TreeMap<String,String>();
			tm.put("key", key);
			tm.put("val", val);
			tms.add(tm);
		}
		List<Object> ls = baseCommonService.selectList("cpsUrlMapper.selectCpsAccountById", params);
		for(int i=0;i<ls.size();i++){
			try {
				Map m = (Map)ls.get(i);
				JSONObject jb = JSONObject.parseObject((String)m.get("account_info"));
				List<Object> tds = new ArrayList<Object>();
				if(jb!=null){
					Iterator tr = jb.keySet().iterator();
					while(tr.hasNext()){
						tds.add(jb.get(tr.next()));
					}
				}else{
					for(int j=0;j<tms.size();j++){
						tds.add("");
					}
				}
				m.put("jsonList", tds);
			} catch (Exception e) {
				e.printStackTrace();
				continue;
			}
		}
		mv.addObject("patternId", params.get("id"));
		mv.addObject("tms", tms);
		mv.addObject("rows", ls);
		mv.setViewName("/cps/urlAccount");
		return mv;
	}
	
	@RequestMapping(value = "/saveUrlAccount.do", method=RequestMethod.POST)
	@ResponseBody
	public Object saveUrlAccount(HttpServletRequest request, HttpServletResponse response) {
		Map<String,String> params = paramMap(request);
		Map jsonMap = new HashMap();
		jsonMap.put("id",params.get("id"));
		jsonMap.put("flag",params.get("flag"));
		jsonMap.put("host",params.get("host"));
		jsonMap.put("user_id",params.get("user_id"));
		jsonMap.put("union_account",params.get("union_account"));
		jsonMap.put("is_enable",params.get("is_enable"));
		jsonMap.put("pattern_id",params.get("pattern_id"));
		params.remove("id");
		params.remove("flag");
		params.remove("host");
		params.remove("user_id");
		params.remove("union_account");
		params.remove("is_enable");
		params.remove("pattern_id");
		JSONObject json = new JSONObject((Map)params);
		jsonMap.put("account_info", json.toJSONString());
		String userName = GetUserFromCookieUtils.getUser(request).getUserName();
		jsonMap.put("sysuser", userName);
		ControllerMessage cm = new ControllerMessage();
		if(jsonMap.get("flag").equals("add")){
			try {
				Object obj = baseCommonService.selectOne("cpsUrlMapper.selectActLastId");
				int pid = obj==null?0:(int)obj;
				pid++;
				jsonMap.put("id", pid+"");
				int suc = cpsService.insertUrlAccount(jsonMap);
				if(suc==0){
					cm.setStatue(false);
					cm.setMessage("重复添加!");
				}else{
					cm.setStatue(true);
					cm.setMessage("添加成功!");
					jsonMap.remove("flag");
//					baseRedisService.setMap(tableName+"_"+pid, jsonMap);
				}
			} catch (Exception e) {
				e.printStackTrace();
				cm.setStatue(false);
				cm.setMessage("添加失败!");
			}
		}else if(jsonMap.get("flag").equals("update")){
			try {
				int suc = cpsService.updateUrlAccount(jsonMap);
				if(suc==0){
					cm.setStatue(false);
					cm.setMessage("更新失败!");
				}else{
					cm.setStatue(true);
					cm.setMessage("更新成功!");
					jsonMap.remove("flag");
//					baseRedisService.setMap(tableName+"_"+jsonMap.get("id"), jsonMap);
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
