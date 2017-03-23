package com.b5m.cpsx.ctrl;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.b5m.cpsx.model.ControllerMessage;
import com.b5m.cpsx.model.Page;
import com.b5m.cpsx.service.IBaseCommonService;
import com.b5m.cpsx.utils.DateUtils;
import com.b5m.cpsx.utils.QuerySqlUtil;
import com.google.gson.Gson;

@Controller
@RequestMapping("/common")
public class BaseController {
	protected Logger log = Logger.getLogger(this.getClass());

	@Autowired
	protected IBaseCommonService baseCommonService;

	/**
	 * 通用查询一条记录
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/quertOne.do")
	@ResponseBody
	public Object queryOne(HttpServletRequest request) {
		Map<String, String> paramMap = paramMap(request);

		return baseCommonService.selectOne(paramMap);
	}

	/**
	 * 通用查询一条记录
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/queryOne.do")
	@ResponseBody
	public Object queryOne1(HttpServletRequest request) {
		Map<String, String> paramMap = paramMap(request);

		return baseCommonService.selectOne(paramMap);
	}

	/**
	 * 通用查询N条记录
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/queryList.do")
	@ResponseBody
	public Object queryList(HttpServletRequest request) {
		Map<String, String> paramMap = paramMap(request);
		String namespace = paramMap.get("namespace");
		// namespace="com.b5m.cpsx.dao.mapper.general.IGeneralReportMapper.testListPage";
		if (StringUtils.isEmpty(namespace)) {
			return new ControllerMessage(false, "参数不足");
		}
		return baseCommonService.selectList(namespace, paramMap);
	}

	/**
	 * 通用查询N条记录 datagrid分页数据格式
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/queryPageDataGrid.do")
	@ResponseBody
	public Object queryPageDataGrid(HttpServletRequest request) {
		Map<String, String> paramMap = paramMap(request);
		String namespace = paramMap.get("namespace");

		if (StringUtils.isEmpty(namespace)) {
			return new ControllerMessage(false, "参数不足");
		}
		if (namespace.indexOf("ListPage") < 0) {
			return new ControllerMessage(false,
					"namespace不是标志的分页方法，必须包含ListPage！");
		}

		Page p = new Page();
		try {
			p.setPageNo(Integer.parseInt(paramMap.get("page")));
		} catch (Exception e) {
			p.setPageNo(1);
		}
		try {
			p.setPageSize(Integer.parseInt(paramMap.get("rows")));
		} catch (Exception e) {
			p.setPageSize(Page.DEFAULT_PAGE_SIZE);
		}
		p.setQueryParam(paramMap);

		String sqlStr = QuerySqlUtil.makeSelectSql(paramMap);
		p.setSqlStr(sqlStr);
		baseCommonService.selectList(namespace, p);

		return p;
	}

	/**
	 * 通用查询N条记录 jqgrid分页数据格式
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/queryPageJqGrid.do")
	@ResponseBody
	public Object queryPageJqGrid(HttpServletRequest request) {
		Map<String, String> paramMap = paramMap(request);

		return baseCommonService.selectList(paramMap);
	}

	/**
	 * 通用查询N条记录 jqgrid分页数据格式
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/insert.do")
	@ResponseBody
	public Object insert(HttpServletRequest request) {
		Map<String, String> param = paramMap(request);
		String namespace = param.get("namespace");

		if (StringUtils.isEmpty(namespace)) {
			return new ControllerMessage(false, "参数不足");
		}
		baseCommonService.insert(namespace, param);
		log.error(param.get("sysuser_username")+"插入记录：引用sql:" + namespace + " ; 参数为：" + param);
		return new ControllerMessage(true, "添加成功", param);
	}

	/**
	 * 通用查询N条记录 jqgrid分页数据格式
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/delete.do")
	@ResponseBody
	public Object delete(HttpServletRequest request) {
		Map<String, String> param = paramMap(request);
		String namespace = param.get("namespace");

		if (StringUtils.isEmpty(namespace)) {
			return new ControllerMessage(false, "参数不足");
		}
		Object data = baseCommonService.delete(namespace, param);
		log.error(param.get("sysuser_username")+"删除记录：引用sql:" + namespace + " ; 参数为：" + param);
		return new ControllerMessage(true, "删除成功", data);
	}

	/**
	 * 通用查询N条记录 jqgrid分页数据格式
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(value = "/update.do")
	@ResponseBody
	public Object update(HttpServletRequest request) {
		Map<String, String> param = paramMap(request);
		String namespace = param.get("namespace");

		if (StringUtils.isEmpty(namespace)) {
			return new ControllerMessage(false, "参数不足");
		}
		Object data = baseCommonService.update(namespace, param);
		log.error(param.get("sysuser_username")+"更新记录：引用sql:" + namespace + " ; 参数为：" + param);
		return new ControllerMessage(true, "更新成功", data);
	}


	/**
	 * 参数转换
	 * 
	 * @param request
	 * @return
	 */
	protected Map<String, String> paramMap(HttpServletRequest request) {
		Map<String, String> paramMap = getParamMap(request);
		log.debug("请求参数为：-----》" + paramMap);
		return paramMap;

	}

	public static Map<String, String> getParamMap(HttpServletRequest request) {
		Map<String, String> paramMap = new HashMap<String, String>();
		Map<String, String[]> paramMaps = request.getParameterMap();
		Iterator<Entry<String, String[]>> ii = paramMaps.entrySet().iterator();

		while (ii.hasNext()) {
			Entry<String, String[]> e = ii.next();
			String key = e.getKey();
			String[] vaA = e.getValue();
			String valueS = null;
			for (String p : vaA) {
				if (null == valueS) {
					valueS = p;
				} else {
					valueS += ("," + p);
				}
			}
			paramMap.put(key, valueS);
		}
		
		
		
		/*//SysUser sysuser = (SysUser) request.getSession().getAttribute("loginUser");
        if(null !=sysuser){
        	paramMap.put("sysuser_username", sysuser.getUsername());
        	paramMap.put("sysuser_mail", sysuser.getEmail());
        }*/
       		 
		return paramMap;

	}
	
	
	/**
	 * 通用查询N条记录 jqgrid分页数据格式
	 * 
	 * @param request
	 * @return
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@RequestMapping(value = "/exportExcel.do")
	@ResponseBody
	public Object exportExcel(HttpServletRequest request,
			HttpServletResponse response) {

		response.reset();
		response.setContentType("application/vnd.ms-excel;charset=UTF-8");
		response.setHeader("Content-disposition","attachment; filename="+DateUtils.currentDate("yyyyMMddHHmmss")+".xls");
		StringBuffer html = new StringBuffer();

		String tableData = request.getParameter("export_tableData");
		String columns = request.getParameter("export_tableColumns");
		

		try {
			tableData=new String(tableData.getBytes("ISO-8859-1"),"UTF-8");
			columns = new String(columns.getBytes("ISO-8859-1"),"UTF-8");
			
			List data = new Gson().fromJson(tableData, List.class);
			// System.out.println(data);
			List columns1 = (List) new Gson().fromJson(columns, List.class);
			// System.out.println(columns1);
			List columnList = (List) columns1.get(0);
			if(columns1.size()>1){
				List columnList2 = (List) columns1.get(1);
				if (null != columnList2) {
					columnList.addAll(columnList2);
				}
			}
			
			// System.out.println(columnList);
			String[] columnsArr = new String[columnList.size()];
			for (int i = 0; i < columnList.size(); i++) {
				Map map = (Map) columnList.get(i);
				columnsArr[i] = String.valueOf(map.get("field"));
			}
			html.append("<table cellpadding='5' cellspacing='1'  align='center'  style='width: 100%;font-size: 9pt;style-align: center;background-color: #ffffff;border: 1px solid #cccccc;'>");
			html.append(" <tr> ");
			for (int i = 0; i < columnList.size(); i++) {
				Map map = (Map) columnList.get(i);

				html.append(
						" <td class=formtitle align='center' nowrap style='width:13%;font-size: 9pt;background:#EF8C08;color:#ffffff;height:30px;text-align: center;border: 1px solid #cccccc;'>")
						.append(map.get("title")).append("</td>");
			}
			html.append("</tr> ");
			for (int j = 0; j < data.size(); j++) {
				Map map = (Map) data.get(j);

				html.append(" <tr> ");

				for (int k = 0; k < columnsArr.length; k++) {
					String field = columnsArr[k];

					html.append(
							"<td class=formtitle2 align='left' nowrap style='width:13%;font-size: 9pt;background:#ffffff;color:#000000;height:30px;text-align: left;border: 1px solid #cccccc;'>")
							.append(map.get(field) == null ? "" : ""
									+ map.get(field)).append(" </td>");
				}
				html.append("</tr> ");
			}
			html.append(" </table> ");
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			
		}
		return html;
	}

	
	/**
	 * 通用查询N条记录 jqgrid分页数据格式
	 * 
	 * @param request
	 * @return
	 */
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value = "/exportCsv.do")
	public Object exportCsv(HttpServletRequest request,
			HttpServletResponse response) {
		response.reset();
		//response.setContentType("application/vnd.ms-excel;charset=UTF-8");
		response.setHeader("Content-disposition","attachment; filename="+DateUtils.currentDate("yyyy-MM-dd HHmmss")+".csv");
		StringBuffer content = new StringBuffer();

		String tableData = request.getParameter("export_tableData");
		String columns = request.getParameter("export_tableColumns");
		 
		try {
			tableData=new String(tableData.getBytes("ISO-8859-1"),"UTF-8");
			columns = new String(columns.getBytes("ISO-8859-1"),"UTF-8");
			
			List data = new Gson().fromJson(tableData, List.class);
			// System.out.println(data);
			List columns1 = (List) new Gson().fromJson(columns, List.class);
			// System.out.println(columns1);
			List columnList = (List) columns1.get(0);
			if(columns1.size()>1){
				List columnList2 = (List) columns1.get(1);
				if (null != columnList2) {
					columnList.addAll(columnList2);
				}
			}
			
			// System.out.println(columnList);
			String[] columnsArr = new String[columnList.size()];
			for (int i = 0; i < columnList.size(); i++) {
				Map map = (Map) columnList.get(i);
				columnsArr[i] = String.valueOf(map.get("field"));
				content.append("\"").append(map.get("title")).append("\"").append(",");
			}
			content.append(" \n");
			for (int j = 0; j < data.size(); j++) {
				Map map = (Map) data.get(j);

				for (int k = 0; k < columnsArr.length; k++) {
					String field = columnsArr[k];

					content.append("\"").append(map.get(field) == null ? "" : ""+ map.get(field)).append("\"").append(",");
				}
				content.append("\n");
			}
			response.setCharacterEncoding("UTF-8");
			response.getWriter().write(  content.toString() );
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			
		}
		return  null;//content.toString();
	}
	

	protected final String getIpAddr(HttpServletRequest request){
        String ip=request.getHeader("x-forwarded-for");
        if(StringUtils.isEmpty(ip) || "unknown".equalsIgnoreCase(ip))
            ip=request.getHeader("Proxy-Client-IP");
        if(StringUtils.isEmpty(ip) || "unknown".equalsIgnoreCase(ip))
            ip=request.getHeader("WL-Proxy-Client-IP");
        if(StringUtils.isEmpty(ip) || "unknown".equalsIgnoreCase(ip))
            ip=request.getRemoteAddr();
        return ip;
    }
	
	public Object encodeParam(Object params){
		Object returnVal = null;
		if (null != params) {
			try {
				returnVal = new String(params.toString().getBytes("ISO-8859-1"),"UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		} else {
			returnVal = "";
		}
		return returnVal;
	}
}
