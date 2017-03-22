/**   
 * @Title: ExcelUtil.java 
 * @Package com.b5m.dmp.utils 
 * @Description: TODO
 * @author feitian   
 * @date 2015年11月4日 上午10:36:38 
 * @version V1.0   
 */
package com.b5m.cpsx.utils;

import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.DVConstraint;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDataValidation;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Name;
import org.apache.poi.ss.util.CellRangeAddressList;
import org.springframework.web.servlet.view.document.AbstractExcelView;


/** 
 * @ClassName: ExcelUtil 
 * @Description: TODO
 * @author feitian
 * @date 2015年11月4日 上午10:36:38 
 *  
 */
public class ExcelUtil extends AbstractExcelView{
	/** 
     * 设置某些列的值只能输入预制的数据,显示下拉框. 
     * @param sheet 要设置的sheet. 
     * @param textlist 下拉框显示的内容 
     * @param firstRow 开始行 
     * @param endRow 结束行 
     * @param firstCol   开始列 
     * @param endCol  结束列 
     * @return 设置好的sheet. 
     */  
    public static HSSFSheet setHSSFValidation(HSSFSheet sheet,  
            String[] textlist, int firstRow, int endRow, int firstCol,  
            int endCol) {  
        // 加载下拉列表内容  
        DVConstraint constraint = DVConstraint.createExplicitListConstraint(textlist);  
        // 设置数据有效性加载在哪个单元格上,四个参数分别是：起始行、终止行、起始列、终止列  
        CellRangeAddressList regions = new  CellRangeAddressList(firstRow,endRow, firstCol, endCol);  
        // 数据有效性对象  
        HSSFDataValidation data_validation_list = new HSSFDataValidation(regions, constraint);  
        sheet.addValidationData(data_validation_list);  
        return sheet;  
    }  
  
    /** 
     * 设置单元格上提示 
     * @param sheet  要设置的sheet. 
     * @param promptTitle 标题 
     * @param promptContent 内容 
     * @param firstRow 开始行 
     * @param endRow  结束行 
     * @param firstCol  开始列 
     * @param endCol  结束列 
     * @return 设置好的sheet. 
     */  
    public static HSSFSheet setHSSFPrompt(HSSFSheet sheet, String promptTitle,  
            String promptContent, int firstRow, int endRow ,int firstCol,int endCol) {  
        // 构造constraint对象  
        DVConstraint constraint = DVConstraint.createCustomFormulaConstraint("BB1");  
        // 四个参数分别是：起始行、终止行、起始列、终止列  
        CellRangeAddressList regions = new CellRangeAddressList(firstRow,endRow,firstCol, endCol);  
        // 数据有效性对象  
        HSSFDataValidation data_validation_view = new HSSFDataValidation(regions,constraint);  
        data_validation_view.createPromptBox(promptTitle, promptContent);  
        sheet.addValidationData(data_validation_view);  
        return sheet;  
    }

	/**
	 * @param book  
	 * @Title: setHSSFValidationByHiddenSheet 
	 * @Description: TODO
	 * @param @param sheet
	 * @param @param objectListToStringArray
	 * @param @param i
	 * @param @param j
	 * @param @param k
	 * @param @param l
	 * @return void
	 * @throws 
	 */
	public static void setHSSFValidationByHiddenSheet(HSSFWorkbook book, HSSFSheet sheet,
			String[] textlist, int firstRow, int endRow ,int firstCol,int endCol) {
		String hiddenName = "hidden" + firstCol;
		HSSFSheet hidden = book.createSheet(hiddenName);
		for (int i = 0, length= textlist.length; i < length; i++) {
		   String data = textlist[i];
		   HSSFRow row = hidden.createRow(i);
		   HSSFCell cell = row.createCell(0);
		   cell.setCellValue(data);
		 }
		 Name namedCell = book.createName();
		 namedCell.setNameName(hiddenName);
		 namedCell.setRefersToFormula(hiddenName + "!$A$1:$A$" + textlist.length);
		 DVConstraint constraint = DVConstraint.createFormulaListConstraint(hiddenName);
		 CellRangeAddressList addressList = new CellRangeAddressList(firstRow, endRow, firstCol, endCol);
		 HSSFDataValidation validation = new HSSFDataValidation(addressList, constraint);
		 book.setSheetHidden(1, true);
		 sheet.addValidationData(validation);
		
	}

	/*
	 * 下载文件
	 * (non-Javadoc)
	 * @see org.springframework.web.servlet.view.document.AbstractExcelView#buildExcelDocument(java.util.Map, org.apache.poi.hssf.usermodel.HSSFWorkbook, javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@Override
	public void buildExcelDocument(Map<String,Object> model,HSSFWorkbook xwb, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String fileToRead = "";
		fileToRead = request.getParameter("fileToRead");
		if(fileToRead==null || "".equals(fileToRead)){
			fileToRead = "xx报表数据.xls";
		}
		//设置response
		response.reset();//
		response.setContentType("application/vnd.ms-excel");
		response.setCharacterEncoding("UTF-8");
        response.setHeader("content-disposition", "attachment; filename=" + URLEncoder.encode(fileToRead, "UTF-8"));     
        OutputStream ouputStream = response.getOutputStream();
        xwb.write(ouputStream);
        ouputStream.flush();     
        ouputStream.close();
	}

}
