package com.b5m.cpsx.ctrl.report;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.b5m.cpsx.ctrl.BaseController;
import com.b5m.cpsx.utils.ExcelUtil;
import com.b5m.cpsx.utils.GetUserFromCookieUtils;

@Controller
@RequestMapping("/report/statistic")
public class ReportStatisticController extends BaseController{
	
	private final static SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	
	private final static SimpleDateFormat mdFormat = new SimpleDateFormat("MM-dd");
	
	protected Logger logger = Logger.getLogger(ReportStatisticController.class);
	
	@RequestMapping(value = "/output.do", method=RequestMethod.GET)
	@ResponseBody
	public ModelAndView selectListPage(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mv) {
		Map<String,String> params = paramMap(request);
		int userId = GetUserFromCookieUtils.getUser(request).getId();
		params.put("userId", userId+"");
		String sd = params.get("q_start_date");
		String ed = params.get("q_end_date");
		if(StringUtils.isEmpty(sd) && StringUtils.isEmpty(ed)){
			Calendar tmpCal = Calendar.getInstance();
			tmpCal.add(Calendar.DATE, -15);
			sd = dateFormat.format(tmpCal.getTime());
			params.put("q_start_date", sd);
			tmpCal.add(Calendar.DATE, 14);
			ed = dateFormat.format(tmpCal.getTime());
			params.put("q_end_date", ed);
		}
		
		String namespace = "reportMapper.selectReportByDate";
		String sumStyle = params.get("sum_style");
		if(sumStyle==null){
			namespace = "reportMapper.selectReportByDate";
		}else if(sumStyle.equals("2")){
			namespace = "reportMapper.selectReportByAction";
		}else if(sumStyle.equals("3")){
			namespace = "reportMapper.selectReportByWebsite";
		}
		
		List<String> dateArr = new ArrayList<String>();
		try {
			Date start = dateFormat.parse(sd);
			Date end = dateFormat.parse(ed);
			Calendar cal = Calendar.getInstance();
			cal.setTime(start);
			while(cal.getTimeInMillis()<=end.getTime()){
				Date var = cal.getTime();
				dateArr.add(mdFormat.format(var));
				cal.add(Calendar.DATE, 1);
			}
		} catch (ParseException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		Map<String,Object> xMap = new HashMap<String,Object>();
		Map<String,Object> y1Map = new HashMap<String,Object>();
		Map<String,Object> y2Map = new HashMap<String,Object>();
		Map<String,Object> y3Map = new HashMap<String,Object>();
		Map<String,Object> y4Map = new HashMap<String,Object>();
		Map<String,Object> y5Map = new HashMap<String,Object>();
		Map<String,Object> y6Map = new HashMap<String,Object>();
		Map<String,Object> y7Map = new HashMap<String,Object>();
		Map<String,Object> y8Map = new HashMap<String,Object>();
		mv.addObject("params", params);
		try {
			List<Object> rows = baseCommonService.selectList(namespace, params);
			mv.addObject("rows",rows);
			List<Map> arr = new ArrayList<Map>();
			for(int i=0;i<dateArr.size();i++){
				boolean hasFind = false;
				for(int t=0;t<rows.size();t++){
					Map node = (Map) rows.get(t);
					if(mdFormat.format(node.get("history_date")).equals(dateArr.get(i))){
						arr.add(node);
						hasFind=true;
						break;
					}
				}
				if(!hasFind){
					arr.add(new HashMap());
				}
			}
			for(int i=1;i<=dateArr.size();i++){
				xMap.put(i+"", dateArr.get(i-1));
				y1Map.put(i+"", arr.get(i-1).get("click_no")==null?0:arr.get(i-1).get("click_no"));
				y2Map.put(i+"", arr.get(i-1).get("click_ip")==null?0:arr.get(i-1).get("click_ip"));
				y3Map.put(i+"", arr.get(i-1).get("pre_order_count")==null?0:arr.get(i-1).get("pre_order_count"));
				y4Map.put(i+"", arr.get(i-1).get("pre_order_money")==null?0:arr.get(i-1).get("pre_order_money"));
				y5Map.put(i+"", arr.get(i-1).get("pre_commission")==null?0:arr.get(i-1).get("pre_commission"));
				y6Map.put(i+"", arr.get(i-1).get("confirm_order_count")==null?0:arr.get(i-1).get("confirm_order_count"));
				y7Map.put(i+"", arr.get(i-1).get("confirm_order_money")==null?0:arr.get(i-1).get("confirm_order_money"));
				y8Map.put(i+"", arr.get(i-1).get("confirm_commission")==null?0:arr.get(i-1).get("confirm_commission"));
		    }
		} catch (Exception e) {
			logger.error(e);
		}
		mv.addObject("dataArr", new JSONObject(xMap));//加载X轴映射坐标
		mv.addObject("dataYrr", new JSONObject(y1Map));//加载Y轴映射坐标
		mv.addObject("dataZrr", new JSONObject(y2Map));//加载Y轴映射坐标
		mv.addObject("dataDrr", new JSONObject(y3Map));//加载Y轴映射坐标
		mv.addObject("dataErr", new JSONObject(y4Map));//加载Y轴映射坐标
		mv.addObject("dataFrr", new JSONObject(y5Map));//加载Y轴映射坐标
		mv.addObject("dataGrr", new JSONObject(y6Map));//加载Y轴映射坐标
		mv.addObject("dataHrr", new JSONObject(y7Map));//加载Y轴映射坐标
		mv.addObject("dataIrr", new JSONObject(y8Map));//加载Y轴映射坐标
		mv.setViewName("/report/statistic");
		return mv;
	}
	
	
	@RequestMapping("/generateTotalData.do")
	public void generateTotalData(HttpServletRequest request,
			HttpServletResponse response){
				// workbook 对象对应一个excel文件
				HSSFWorkbook book = new HSSFWorkbook();
				// 一个sheet对象 对应一个工作表空间
				HSSFSheet sheet = book.createSheet("报表数据");
				// 在当前sheet对象里面创建一行
				HSSFRow rowTitle = sheet.createRow(0);
				String xlsData = request.getParameter("content");
				if(xlsData==null || "".equals(xlsData)){
					return;
				}
				String[] tableData = xlsData.split("\n");
				tableData[0] = tableData[0].replace("undefined", "");
				String titles[] = tableData[0].split("\t");
				for(int i=0;i<titles.length;i++){
					rowTitle.createCell(i).setCellValue(titles[i]);
				}
				for(int j=1;j<tableData.length;j++){
					HSSFRow rowData = sheet.createRow(j);
					String records[] = tableData[j].split("\t");
					for(int i=0;i<records.length;i++){
						try{
							Double value = Double.valueOf(records[i]);
							rowData.createCell(i).setCellValue(value);
						}catch(NumberFormatException e){
							rowData.createCell(i).setCellValue(records[i]);
						}
						
					}
				}
				
				try {
					new ExcelUtil().buildExcelDocument(null,book, request, response);
				} catch (Exception e) {
					e.printStackTrace();
				}
		}

	
	 
	
}
	