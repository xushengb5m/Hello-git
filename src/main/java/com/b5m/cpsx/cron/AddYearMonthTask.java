package com.b5m.cpsx.cron;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.b5m.cpsx.ctrl.cps.CpsAccountController;
import com.b5m.cpsx.service.IBaseCommonService;

@Component
public class AddYearMonthTask{
	
	protected Logger logger = Logger.getLogger(CpsAccountController.class);
	
	@Autowired
	protected IBaseCommonService baseCommonService;
	
	/*
	 * 每个月在结算申请表上为每个网站主插入新月份的记录，以便于结算数据的更新
	 * 每个月1号凌晨1点触发
	 */
	@Scheduled(cron = "0 0 1 1 * ?")
	public void excutePerMonth() throws Exception {
		Calendar cal = Calendar.getInstance();
		cal.add(Calendar.MONTH, -1);
		Map param = new HashMap<String,String>();
		param.put("mon", cal.get(cal.MONTH));
		param.put("year", cal.get(cal.YEAR));
		List<Object> userList = baseCommonService.selectList("cpsxUserMapper.selectSiteMasterList",param);
		cal.add(Calendar.MONTH, 1);
		for(Object obj:userList){
			Map m = (Map)obj;
			m.put("the_month", cal.get(cal.MONTH));
			m.put("the_year", cal.get(cal.YEAR));
		}
		int suc = (int)baseCommonService.insert("settleMapper.insertBatchApply", userList);
		if(suc>0){
			logger.info("插入所有网站主年份月份余额到佣金申请表中!");
		}else{
			logger.info("插入所有网站主年份月份余额失败!");
		}
	}
	
}
