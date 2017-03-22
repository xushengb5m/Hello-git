package com.b5m.cpsx.ctrl.report;
import java.text.SimpleDateFormat;
import java.util.Calendar;
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

import com.b5m.cpsx.ctrl.BaseController;
import com.b5m.cpsx.utils.ExcelUtil;
import com.b5m.cpsx.utils.GetUserFromCookieUtils;

@Controller
@RequestMapping("/report/detail")
public class ReportDetailController extends BaseController{
	
	private final static SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
	
	protected Logger logger = Logger.getLogger(ReportDetailController.class);
	
	@RequestMapping(value = "/detail.do", method=RequestMethod.GET)
	@ResponseBody
	public ModelAndView detailListPage(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mv) {
		Map<String,String> params = paramMap(request);
		int userId = GetUserFromCookieUtils.getUser(request).getId();
		params.put("userId", userId+"");
		String sd = params.get("q_start_order_date");
		String ed = params.get("q_end_order_date");
		if(StringUtils.isEmpty(sd) && StringUtils.isEmpty(ed)){
			Calendar tmpCal = Calendar.getInstance();
			tmpCal.add(Calendar.DATE, -15);
			sd = dateFormat.format(tmpCal.getTime());
			params.put("q_start_order_date", sd);
			tmpCal.add(Calendar.DATE, 14);
			ed = dateFormat.format(tmpCal.getTime());
			params.put("q_end_order_date", ed);
		}
		String flag = params.get("q_condition");
		if(flag!=null){
			if(flag.equals("1")){
				params.put("q_order_no", params.get("keyword"));
			}else if(flag.equals("2")){
				params.put("q_feed_back", params.get("keyword"));
			}else if(flag.equals("3")){
				params.put("q_prod_no", params.get("keyword"));
			}
		}
		String namespace = "reportMapper.selectReportDetail";
		mv.addObject("params", params);
		try {
			List<Object> rows = baseCommonService.selectList(namespace, params);
			mv.addObject("rows",rows);
		} catch (Exception e) {
			logger.error(e);
		}
		mv.setViewName("/report/detail");
		return mv;
	}
	
	@RequestMapping("/generateExcelData.do")
	public void generateDetailData(HttpServletRequest request,
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
				tableData[0] = tableData[0].replace("<span class=\"thsp\">", "");
				tableData[0] = tableData[0].replace("undefined", "");
				tableData[0] = tableData[0].replace("</span>", "/");
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
	