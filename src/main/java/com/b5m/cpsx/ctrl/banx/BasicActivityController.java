/**   
 * @Title: ActivityController.java 
 * @Package com.b5m.cpsx.ctrl.banx 
 * @Description: TODO
 * @author feitian  
 * @date 2016年6月12日 下午5:09:59 
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

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.b5m.cpsx.ctrl.BaseController;

/** 
 * @ClassName: ActivityController 
 * @Description: TODO
 * @author feitian
 * @date 2016年6月12日 下午5:09:59 
 *  
 */

@Controller
@RequestMapping(value = "/banx/act")
public class BasicActivityController extends BaseController {
	
	@RequestMapping(value = "/basic-activity", method=RequestMethod.GET)
	private ModelAndView query(HttpServletRequest request,
			HttpServletResponse response, ModelAndView mav) {
		String namespace = "basicActivityMapper.select";
		try {
			List<Object> rows = baseCommonService.selectListAll(namespace);
			List<Object> merchantList = baseCommonService.selectListAll("cpsxUserMapper.selectMerchant");
			mav.addObject("rows", rows);
			mav.addObject("merchants", merchantList);
			mav.addObject("categories", baseCommonService.selectListAll("basicActivityMapper.selectCategory"));
			mav.setViewName("/banx/basic-activity");
			return mav;
		} catch (Exception e) {
			log.error(this.getClass().getName(), e);
		}
		return mav;
	}
	
	@RequestMapping(value = "/basic-activity", method = RequestMethod.POST)
	private void create(HttpServletRequest request,
			HttpServletResponse response) {
		String namespace = "basicActivityMapper.insertOne";
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
	
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/basic-activity/{id}", method=RequestMethod.GET)
	private String queryOne(@PathVariable String id, HttpServletRequest request,
			HttpServletResponse response) {
		String namespace = "basicActivityMapper.selectOne";
		Map<String, String> param = new HashMap<String, String>();
		param.put("id", id);
		try {
			Map<String, String> row = (Map<String, String>) baseCommonService.selectOne(namespace, param);
			String str = JSON.toJSONString(row, true);
			return str;
		} catch (Exception e) {
			log.error(this.getClass().getName(), e);
		}
		return null;
	}
	
	@RequestMapping(value = "/basic-activity/{id}", method=RequestMethod.POST)
	private void update(@PathVariable String id, HttpServletRequest request,
			HttpServletResponse response) {
		String namespace = "basicActivityMapper.updateOne";
		Map<String, String> param = paramMap(request);
		param.put("id", id);
		try {
			baseCommonService.update(namespace, param);
		} catch (Exception e) {
			log.error(this.getClass().getName(), e);
		}
	}
	
}
