package com.b5m.cpsx.ctrl.settle;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.xmlbeans.impl.piccolo.io.FileFormatException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.b5m.cpsx.ctrl.BaseController;
import com.b5m.cpsx.model.ControllerMessage;
import com.b5m.cpsx.utils.DigestUtils;


@Controller
@RequestMapping("/settle/data")
public class SettleUploadDataController extends BaseController{
	
	protected Logger logger = Logger.getLogger(SettleUploadDataController.class);
	
	private static final SimpleDateFormat sm = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	
	/** 
	 * 上传数据页 
	 */
	@RequestMapping(value = "/view", method=RequestMethod.GET)
	public ModelAndView selectSettleInfo(HttpServletRequest request, HttpServletResponse response,
			ModelAndView mv) {
		List<Object> rows = baseCommonService.selectListAll("confirmOrderMapper.selectAllConfirmOrders");
		mv.addObject("rows", rows);
		mv.setViewName("/settle/upload");
		return mv;
	}
	
	/** 
	 * 下载模板
	 */
	@RequestMapping(value = "/template", method=RequestMethod.GET)
	public void downloadTemplate(HttpServletRequest request, HttpServletResponse response) {
		HSSFWorkbook book = new HSSFWorkbook();
		// 一个sheet对象 对应一个工作表空间
		HSSFSheet sheet = book.createSheet("录入供应商档案信息");
		// 在当前sheet对象里面创建一行
		HSSFRow rowTitle = sheet.createRow(0);
		rowTitle.createCell(0).setCellValue("订单号");
		rowTitle.createCell(1).setCellValue("网站主ID");
		rowTitle.createCell(2).setCellValue("活动ID");
		rowTitle.createCell(3).setCellValue("下单时间");
		rowTitle.createCell(4).setCellValue("订单金额");
		rowTitle.createCell(5).setCellValue("订单状态");
		rowTitle.createCell(6).setCellValue("商品ID");
		rowTitle.createCell(7).setCellValue("商品名称");
		rowTitle.createCell(8).setCellValue("商品类型");
		rowTitle.createCell(9).setCellValue("商品数量");
		rowTitle.createCell(10).setCellValue("商品价格");
		rowTitle.createCell(11).setCellValue("预估佣金");
		rowTitle.createCell(12).setCellValue("佣金比例");
		rowTitle.createCell(13).setCellValue("反馈标签");
		rowTitle.createCell(14).setCellValue("结算金额");
		rowTitle.createCell(15).setCellValue("结算时间");
		rowTitle.createCell(16).setCellValue("结算佣金");
		rowTitle.createCell(17).setCellValue("币种");
		rowTitle.createCell(18).setCellValue("备注");
		try {
			String filename = "批量上传Excel模版.xls";
			OutputStream os = response.getOutputStream();
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(filename, "UTF-8"));
			book.write(os);
			os.flush();
			os.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/** 
	 * 上传数据
	 */
	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	@ResponseBody
	public Object uploadExcel(HttpServletRequest request, @RequestParam MultipartFile imgFile) {
		Map<String, String> param = paramMap(request);
		String ret = updateExcel(imgFile);
		return new ControllerMessage(true, ret);
	}

	private String updateExcel(MultipartFile multipartFile) {
		StringBuffer sb = new StringBuffer();
		if (multipartFile != null && !multipartFile.isEmpty()) {
				if (!multipartFile.isEmpty()) {
					try {
						String str = readExcel(multipartFile.getInputStream());
						sb.append(str);
					} catch (Exception e) {
						sb.append("检查是否支持Excel类型文件！");
						e.printStackTrace();
					}
				}
		}
		return sb.toString();
	}

	/**
	 * 读取excel文件内容
	 * 
	 * @param filePath
	 * @throws FileNotFoundException
	 * @throws FileFormatException
	 */
	public String readExcel(InputStream excelInputStream)
			throws FileNotFoundException, FileFormatException {
		HSSFWorkbook book = null;
		String ret = null;
		int errorRow = 0;
		int errorColumn = 0;
		int successNum = 0;
		int repeatNum = 0;
		try {
			POIFSFileSystem fs = new POIFSFileSystem(excelInputStream);
			book = new HSSFWorkbook(fs);
			HSSFSheet sheet = book.getSheetAt(0);
			HSSFRow row;
			Map<String, String> param = new HashMap<String, String>();
			int rowNum = sheet.getLastRowNum();
			double changed = 0.0;
			for (int i = 1; i <= rowNum; i++) {
				row = sheet.getRow(i);
				errorRow = i + 1;
				errorColumn = 0;
				param.put("order_no", getValue(row.getCell(errorColumn++)));
				param.put("website_id", (int)row.getCell(errorColumn++).getNumericCellValue()+"");
				param.put("activity_id", (int)row.getCell(errorColumn++).getNumericCellValue()+"");
				param.put("order_time", getDateValue(row.getCell(errorColumn++)));
				param.put("order_price", getValue(row.getCell(errorColumn++)));
				param.put("order_status",getOrderStatus(row.getCell(errorColumn++)));
				param.put("prod_id", getValue(row.getCell(errorColumn++)));
				param.put("prod_name", getValue(row.getCell(errorColumn++)));
				param.put("prod_type", getValue(row.getCell(errorColumn++)));
				param.put("prod_count", getValue(row.getCell(errorColumn++)));
				param.put("prod_price", getValue(row.getCell(errorColumn++)));
				param.put("commission", getValue(row.getCell(errorColumn++)));
				param.put("commission_rate", getValue(row.getCell(errorColumn++)));
				param.put("feed_back", row.getCell(errorColumn++).getStringCellValue());
				param.put("settle_money", getValue(row.getCell(errorColumn++)));
				param.put("settle_time", getDateValue(row.getCell(errorColumn++)));
				param.put("settle_commission", getValue(row.getCell(errorColumn++)));
				param.put("currency", getValue(row.getCell(errorColumn++)));
				param.put("note", getValue(row.getCell(errorColumn++)));
				float commission = Float.parseFloat(param.get("commission"));
				String str = param.get("order_no")+param.get("website_id")+param.get("activity_id")+(commission>0?"1":"0");
				String uniqueId = DigestUtils.getMD5Hex(str);
				param.put("unique_id", uniqueId);
				Object settleCommission = baseCommonService.selectOne("confirmOrderMapper.selectOneData", uniqueId);
				if (settleCommission!=null) {
					baseCommonService.update("confirmOrderMapper.updateConfirmOrder", param);
					Map map = (Map)settleCommission;
					BigDecimal com = (BigDecimal)map.get("settle_commission");
					changed+=Double.parseDouble(param.get("settle_commission"))-com.doubleValue();
					repeatNum++;
				} else {
					baseCommonService.insert("confirmOrderMapper.insertConfirmOrder", param);
					changed+=Double.parseDouble(param.get("settle_commission"));
					successNum++;
				}
			}
			ret = "导入" + successNum + "/" + rowNum + "条数据;更新" + repeatNum + "/" + "条数据";
			if(successNum>0){
				//更新余额表
				baseCommonService.update("settleMapper.updateRemainSum", changed);
			}
		} catch (Exception e) {
			e.printStackTrace();
			ret = "[" + errorRow + "行，" + errorColumn + "列]存在错误，已导入" + successNum + "条;更新" + repeatNum + "/" + "条";
		} finally {
			if (book != null) {
				try {
					excelInputStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}

		}
		return ret;
	}

	private String getOrderStatus(HSSFCell cell) {
		String stat = cell.getStringCellValue();
		if(stat.equals("A")){
			return "1";
		}else if(stat.equals("R")){
			return "2";
		}else if(stat.equals("F")){
			return "3";
		}else{
			return null;
		}
	}

	private String getDateValue(HSSFCell cell) {
		if(cell==null){
			return null;
		}
		return sm.format(cell.getDateCellValue())+"";
	}

	private String getValue(HSSFCell cell) {
		if(cell==null){
			return null;
		}
		String result = "";
		try {
			result = cell.getStringCellValue();
		} catch (Exception e) {
			try {
				result = cell.getNumericCellValue()+"";
			} catch (Exception e1) {
				result = sm.format(cell.getDateCellValue())+"";
			}
		}
		return result;
	}
	
	
}

