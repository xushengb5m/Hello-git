/**   
 * @Title: ClearingCycleController.java 
 * @Package com.b5m.cpsx.ctrl.banx 
 * @Description: TODO
 * @author feitian  
 * @date 2016年6月12日 下午3:18:18 
 * @version V1.0   
 */
package com.b5m.cpsx.ctrl.banx;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.b5m.cpsx.ctrl.BaseController;

/** 
 * @ClassName: ClearingCycleController 
 * @Description: TODO
 * @author feitian
 * @date 2016年6月12日 下午3:18:18 
 *  
 */
@Controller
@RequestMapping(value = "/banx/clearing")
public class ClearingCycleController extends BaseController {
	
	@RequestMapping(value = "/cycle", method=RequestMethod.GET)
	private ModelAndView query(HttpServletRequest request,
			HttpServletResponse response, ModelAndView mav) {
		String namespace = "clearingCycleMapper.select";
		try {
			List<Object> rows = baseCommonService.selectListAll(namespace);
			mav.addObject("rows", rows);
			mav.setViewName("/banx/clearing-cycle");
			return mav;
		} catch (Exception e) {
			log.error(this.getClass().getName(), e);
		}
		return mav;
	}
	
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/cycle/{id}", method=RequestMethod.GET)
	private String queryOne(@PathVariable String id, HttpServletRequest request,
			HttpServletResponse response) {
		String namespace = "clearingCycleMapper.selectOne";
		Map<String, String> param = new HashMap<String, String>();
		param.put("id", id);
		try {
			Map<String, String> row = (Map<String, String>) baseCommonService.selectOne(namespace, param);
			JSONObject jo = new JSONObject();
			jo.put("clearing_cycle", row.get("clearing_cycle"));
			jo.put("note", row.get("note"));
			return jo.toJSONString();
		} catch (Exception e) {
			log.error(this.getClass().getName(), e);
		}
		return null;
	}
	
	@RequestMapping(value = "/cycle", method = RequestMethod.POST)
	private void create(HttpServletRequest request,
			HttpServletResponse response) {
		String namespace = "clearingCycleMapper.insertOne";
		Map<String, String> param = paramMap(request);
		/*User user = GetUserFromCookieUtils.getUser(request, baseRedisService);
		Integer userId = user.getId();
		param.put("user_id", String.valueOf(userId));*/
		try {
			baseCommonService.insert(namespace, param);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@RequestMapping(value = "/cycle/{id}", method=RequestMethod.POST)
	private void update(@PathVariable String id, HttpServletRequest request,
			HttpServletResponse response) {
		String namespace = "clearingCycleMapper.updateOne";
		Map<String, String> param = paramMap(request);
		param.put("id", id);
		try {
			baseCommonService.update(namespace, param);
		} catch (Exception e) {
			log.error(this.getClass().getName(), e);
		}
	}

}
