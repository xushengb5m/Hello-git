package com.b5m.cpsx.ctrl.settle;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.b5m.cpsx.ctrl.BaseController;
import com.b5m.cpsx.model.ControllerMessage;
import com.b5m.cpsx.service.settle.ISettleCommissionService;
@Controller
@RequestMapping("/settle/bi")
public class SettleBICheckController extends BaseController{
	
	protected Logger logger = Logger.getLogger(SettleBICheckController.class);
	
	private static final SimpleDateFormat sm = new SimpleDateFormat("yyyy-MM");
	
	/** 
	 * 申请佣金总览页
	 */
	@RequestMapping(value = "/commission", method=RequestMethod.GET)
	public ModelAndView applyCommissionList(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mv) {
		List<Object> rows = baseCommonService.selectListAll("settleMapper.selectBICommissionApply");
		mv.addObject("rows", rows);
		mv.setViewName("/settle/biCheckCommission");
		return mv;
	}
	
	/** 
	 * 审核佣金申请详情页
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "/checkView/{id}/{y}/{m}", method=RequestMethod.GET)
	public ModelAndView getPayCommission(@PathVariable String id,@PathVariable String y,@PathVariable String m,HttpServletRequest request, HttpServletResponse response,
			ModelAndView mv) {
		Map params = new HashMap<String,String>();
		params.put("user_id", id);
		params.put("the_year", y);
		params.put("the_month", m);
		Object applying = baseCommonService.selectOne("settleMapper.selectOneCommissionApply",params);
		List<Object> rows = baseCommonService.selectList("settleMapper.selectApplyDataByUserId",params);
		mv.addObject("applying", applying);
		mv.addObject("rows", rows);
		mv.setViewName("/settle/checkView");
		return mv;
	}
	
	/** 
	 * 支付佣金
	 */
	@RequestMapping(value = "/checkApply/{id}/{y}/{m}", method=RequestMethod.POST)
	@ResponseBody
	public Object postPayCommission(@PathVariable String id,@PathVariable String y,@PathVariable String m,HttpServletRequest request, HttpServletResponse response) {
		Map<String,String> params = paramMap(request);
		ControllerMessage cm = new ControllerMessage();
		params.put("user_id", id);
		params.put("the_year", y);
		params.put("the_month", m);
		int suc = baseCommonService.update("settleMapper.updateApplyCheckState", params);
		if(suc==1){
			cm.setStatue(true);
			cm.setMessage("处理成功!");
		}else{
			cm.setStatue(false);
			cm.setMessage("处理失败!");
		}
		return cm;
	}
	
}

