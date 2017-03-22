/**   
 * @Title: NotificationController.java 
 * @Package com.b5m.cpsx.ctrl.banx 
 * @Description: TODO
 * @author feitian  
 * @date 2016年6月14日 上午11:09:28 
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
import com.b5m.cpsx.ctrl.BaseController;

/** 
 * @ClassName: NotificationController 
 * @Description: TODO
 * @author feitian
 * @date 2016年6月14日 上午11:09:28 
 *  
 */
@Controller
@RequestMapping(value = "/banx/noti")
public class NotificationController extends BaseController {

	@RequestMapping(value = "/notification", method=RequestMethod.GET)
	private ModelAndView query(HttpServletRequest request,
			HttpServletResponse response, ModelAndView mav) {
		String namespace = "notificationMapper.select";
		try {
			List<Object> rows = baseCommonService.selectListAll(namespace);
			mav.addObject("rows", rows);
			mav.addObject("activities", baseCommonService.selectListAll("notificationMapper.selectActivity"));
			mav.setViewName("/banx/notification");
			return mav;
		} catch (Exception e) {
			log.error(this.getClass().getName(), e);
		}
		return mav;
	}
	
	@RequestMapping(value = "/notification", method = RequestMethod.POST)
	private void create(HttpServletRequest request,
			HttpServletResponse response) {
		String namespace = "notificationMapper.insertOne";
		Map<String, String> param = paramMap(request);
		try {
			baseCommonService.insert(namespace, param);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@SuppressWarnings("unchecked")
	@ResponseBody
	@RequestMapping(value = "/notification/{id}", method=RequestMethod.GET)
	private String queryOne(@PathVariable String id, HttpServletRequest request,
			HttpServletResponse response) {
		String namespace = "notificationMapper.selectOne";
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
	
	@RequestMapping(value = "/notification/{id}", method=RequestMethod.POST)
	private void update(@PathVariable String id, HttpServletRequest request,
			HttpServletResponse response) {
		String namespace = "notificationMapper.updateOne";
		Map<String, String> param = paramMap(request);
		param.put("id", id);
		try {
			baseCommonService.update(namespace, param);
		} catch (Exception e) {
			log.error(this.getClass().getName(), e);
		}
	}
	
}
