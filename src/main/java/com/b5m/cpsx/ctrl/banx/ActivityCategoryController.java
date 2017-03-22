/**   
 * @Title: ActivityCategoryController.java 
 * @Package com.b5m.cpsx.ctrl.banx 
 * @Description: TODO
 * @author feitian  
 * @date 2016年6月7日 下午7:51:02 
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
 * @ClassName: ActivityCategoryController 
 * @Description: TODO
 * @author feitian
 * @date 2016年6月7日 下午7:51:02 
 *  
 */

@Controller
@RequestMapping(value = "/banx/cat")
public class ActivityCategoryController extends BaseController {
	
	@RequestMapping(value = "/category", method=RequestMethod.GET)
	private ModelAndView queryCategory(HttpServletRequest request,
			HttpServletResponse response, ModelAndView mav) {
		String namespace = "activityCategoryMapper.select";
		try {
			List<Object> rows = baseCommonService.selectListAll(namespace);
			mav.addObject("rows", rows);
			mav.setViewName("/banx/category");
			return mav;
		} catch (Exception e) {
			log.error(this.getClass().getName(), e);
		}
		return mav;
	}
	
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/category/{id}", method=RequestMethod.GET)
	private String queryOneCategory(@PathVariable String id, HttpServletRequest request,
			HttpServletResponse response) {
		String namespace = "activityCategoryMapper.selectOne";
		Map<String, String> param = new HashMap<String, String>();
		param.put("id", id);
		try {
			Map<String, String> row = (Map<String, String>) baseCommonService.selectOne(namespace, param);
			JSONObject jo = new JSONObject();
			jo.put("name", row.get("name"));
			jo.put("note", row.get("note"));
			return jo.toJSONString();
		} catch (Exception e) {
			log.error(this.getClass().getName(), e);
		}
		return "";
	}
	
	@RequestMapping(value = "/category", method = RequestMethod.POST)
	private void createCategory(HttpServletRequest request,
			HttpServletResponse response) {
		String namespace = "activityCategoryMapper.insertOne";
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
	
	@RequestMapping(value = "/category/{id}", method=RequestMethod.POST)
	private void updateCategory(@PathVariable String id, HttpServletRequest request,
			HttpServletResponse response) {
		String namespace = "activityCategoryMapper.updateOne";
		Map<String, String> param = paramMap(request);
		param.put("id", id);
		try {
			baseCommonService.update(namespace, param);
		} catch (Exception e) {
			log.error(this.getClass().getName(), e);
		}
	}
	
}
