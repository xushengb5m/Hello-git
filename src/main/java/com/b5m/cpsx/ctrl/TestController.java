/**   
 * @Title: TestController.java 
 * @Package com.b5m.cpsx.ctrl 
 * @Description: TODO
 * @author feitian  
 * @date 2016年5月31日 下午2:22:01 
 * @version V1.0   
 */
package com.b5m.cpsx.ctrl;

import java.lang.ref.WeakReference;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

/** 
 * @ClassName: TestController 
 * @Description: TODO
 * @author feitian
 * @date 2016年5月31日 下午2:22:01 
 *  
 */
@Controller
@RequestMapping(value = "/test")
public class TestController extends BaseController {
	
	@RequestMapping(value = "/testController/{id}", method=RequestMethod.DELETE)
	public String insert(@PathVariable long id, HttpServletRequest request, HttpServletResponse response) {
		System.out.println(id);
		System.out.println("IM Coming");
		List<Object> list = baseCommonService.selectListAll("testMapper.selectTest");
		System.out.println(list);
		return "/test/testJsp";
	}
	
	@RequestMapping(value = "/testController/{id}", method=RequestMethod.PUT)
	public String update(@PathVariable long id, HttpServletRequest request, HttpServletResponse response) {
		System.out.println(id);
		System.out.println("IM Coming");
		List<Object> list = baseCommonService.selectListAll("testMapper.selectTest");
		System.out.println(list);
		return "/test/testJsp";
	}
	
	@RequestMapping(value = "/testController", method=RequestMethod.POST)
	public ModelAndView seletct(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("IM Coming");
		return  new ModelAndView("/common/top");
	}
	
	public static void main(String[] args) {
			String  str =  "test";  
			WeakReference<String> weakReference = new WeakReference<String>(str);  
			str=null;  
			System.gc();  
			System.out.println(weakReference.get());  
	}
	
}
