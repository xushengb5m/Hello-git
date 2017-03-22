package com.b5m.cpsx.utils;

import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;


/**
 * 
 * 类名称: QuerySqlUtil
 * <p/>  
 * 类描述:查询条件处理类
 * <p/>
 */
public class QuerySqlUtil {
	
	
	/**
	 * 方法描述：sql条件拼接 其中表别名为t params 为条件--值的键值对， 其中条件格式为 字段名__类型__查询关键字 ； 多个字段同一个条件
	 * 字段名$字段名__类型__查询关键字 用$分割字段 ，默认是用Like or的查查询
	 * @param aliaName 别名
	 * @param params   参数
	 * @return         String
	 */
	@SuppressWarnings("unchecked")
	public static String makeSelectSql(	Map<String, String> params) {

		StringBuffer sql = new StringBuffer(" ");
		// "t.fl='' and t.zt='' and (t.bdm='' or t.bdm='' ) and t.cjdw='' and
		// t.fzbldw='' ";
		if (params != null) {
			Iterator ite = params.entrySet().iterator();
			while (ite.hasNext()) {
				Entry<String, String> entry = (Entry<String, String>) ite
						.next();
				String key = entry.getKey().toLowerCase();
				if (key.indexOf("__") == -1) {
					continue;
				}
				String zdInfo[] = key.split("__");
				if (zdInfo.length < 3) {
					continue;
				}
				String type = zdInfo[1];
				String fh = zdInfo[2];
				String zd = zdInfo[0];
				String value = entry.getValue();
				if (value != null && !"".equals(value.trim())) {
					value = value.trim().replaceAll("'", "''");
					if (zd.indexOf("$") > 0) {
						String[] zdArra = zd.split("\\$");
						int len = zdArra.length;
						for (int m = 0; m < len; m++) {
							String zdmc = zdArra[m];
							if (m == 0) {
								sql.append(" and ( " +  zdmc
										+ " like '%" + value + "%' ");
							} else if (m == len - 1) {
								sql.append(" or " +  zdmc
										+ " like '%" + value + "%' ) ");
							} else {
								sql.append(" or " +  zdmc
										+ " like '%" + value + "%' ");
							}
						}

					} else {

						if ("string".equals(zdInfo[1])) {
							if ("eq".equals(fh)) {
								sql.append(" and  " +  zd
										+ " = '" + value + "' ");
							} else if ("neq".equalsIgnoreCase(fh)) {
								sql.append(" and  " +  zd
										+ " <> '" + value + "' ");
							} else if ("null".equalsIgnoreCase(fh)) {
								sql.append(" and  " +  zd
										+ " is null");
							} else if ("like".equals(fh)) {
								sql.append(" and  " +  zd
										+ " like '%" + value + "%' ");
							}

						} else if ("date".equals(zdInfo[1])) {
							if ("gt".equals(fh)) {
								sql.append(" and  trunc(" +  zd
										+ ") >= to_date('" + value
										+ "', 'yyyy-mm-dd') ");
							} else if ("lt".equals(fh)) {
								sql.append(" and  trunc(" +  zd
										+ ") <= to_date('" + value
										+ "', 'yyyy-mm-dd') ");
							}
						} else if("datachartime".equals(zdInfo[1])){
							if("gt".equals(fh)){
								sql.append(" and "+zd+" >= '"+value+"' ");
							}else if("lt".equals(fh)){
								sql.append(" and "+zd+" <= '"+value+"'  ");
							}
							
						}else if ("number".equals(zdInfo[1])) {
							if ("gt".equals(fh)) {
								sql.append(" and  " +  zd
										+ " >= " + value
										+ " ");
							} else if ("lt".equals(fh)) {
								sql.append(" and  " +  zd
										+ " <= " + value
										+ " ");
							}else if ("eq".equals(fh)) {
								sql.append(" and  " +  zd
										+ " = " + value
										+ " ");
							}
						}else {
							sql.append(" and  " +  zd + " = '"
									+ value + "' ");
						}

					}

				}
			}
		}

		return sql.toString();
	}
	
	
	
	
	/**
	 * 方法描述：sql条件拼接 其中表别名为t params 为条件--值的键值对， 其中条件格式为 字段名__类型__查询关键字 ； 多个字段同一个条件
	 * 字段名$字段名__类型__查询关键字 用$分割字段 ，默认是用Like or的查查询
	 * @param aliaName 别名
	 * @param params   参数
	 * @return         String
	 */
	@SuppressWarnings("unchecked")
	public static String makeSelectSql(String aliaName,
			Map<String, String> params) {

		StringBuffer sql = new StringBuffer(" ");
		// "t.fl='' and t.zt='' and (t.bdm='' or t.bdm='' ) and t.cjdw='' and
		// t.fzbldw='' ";
		if (params != null) {
			Iterator ite = params.entrySet().iterator();
			while (ite.hasNext()) {
				Entry<String, String> entry = (Entry<String, String>) ite
						.next();
				String key = entry.getKey().toLowerCase();
				if (key.indexOf("__") == -1) {
					continue;
				}
				String zdInfo[] = key.split("__");
				if (zdInfo.length < 3) {
					continue;
				}
				String type = zdInfo[1];
				String fh = zdInfo[2];
				String zd = zdInfo[0];
				String value = entry.getValue();
				if (value != null && !"".equals(value.trim())) {
					value = value.trim().replaceAll("'", "''");
					if (zd.indexOf("$") > 0) {
						String[] zdArra = zd.split("\\$");
						int len = zdArra.length;
						for (int m = 0; m < len; m++) {
							String zdmc = zdArra[m];
							if (m == 0) {
								sql.append(" and ( " + aliaName + "." + zdmc
										+ " like '%" + value + "%' ");
							} else if (m == len - 1) {
								sql.append(" or " + aliaName + "." + zdmc
										+ " like '%" + value + "%' ) ");
							} else {
								sql.append(" or " + aliaName + "." + zdmc
										+ " like '%" + value + "%' ");
							}
						}

					} else {

						if ("string".equals(zdInfo[1])) {
							if ("eq".equals(fh)) {
								sql.append(" and  " + aliaName + "." + zd
										+ " = '" + value + "' ");
							} else if ("neq".equalsIgnoreCase(fh)) {
								sql.append(" and  " + aliaName + "." + zd
										+ " <> '" + value + "' ");
							} else if ("null".equalsIgnoreCase(fh)) {
								sql.append(" and  " + aliaName + "." + zd
										+ " is null");
							} else if ("like".equals(fh)) {
								sql.append(" and  " + aliaName + "." + zd
										+ " like '%" + value + "%' ");
							}

						} else if ("date".equals(zdInfo[1])) {
							if ("gt".equals(fh)) {
								sql.append(" and  trunc(" + aliaName + "." + zd
										+ ") >= to_date('" + value
										+ "', 'yyyy-mm-dd') ");
							} else if ("lt".equals(fh)) {
								sql.append(" and  trunc(" + aliaName + "." + zd
										+ ") <= to_date('" + value
										+ "', 'yyyy-mm-dd') ");
							}
						} else if("datachartime".equals(zdInfo[1])){
							if("gt".equals(fh)){
								sql.append(" and "+aliaName+"."+zd+" >= '"+value+"' ");
							}else if("lt".equals(fh)){
								sql.append(" and "+aliaName+"."+zd+" <= '"+value+"'  ");
							}
							
						}else if ("number".equals(zdInfo[1])) {
							if ("gt".equals(fh)) {
								sql.append(" and  " + aliaName + "." + zd
										+ " >= " + value
										+ " ");
							} else if ("lt".equals(fh)) {
								sql.append(" and  " + aliaName + "." + zd
										+ " <= " + value
										+ " ");
							}else if ("eq".equals(fh)) {
								sql.append(" and  " + aliaName + "." + zd
										+ " = " + value
										+ " ");
							}
						}else if ("datetime".equals(zdInfo[1])) {
							if ("gt".equals(fh)) {
								sql.append(" and  CONVERT(VARCHAR(100)," + aliaName + "." + zd
										+ ", 23) >= '" + value
										+ "' ");
							} else if ("lt".equals(fh)) {
								sql.append(" and  CONVERT(VARCHAR(100)," + aliaName + "." + zd
										+ " , 23) <=  '" + value
										+ "' ");
							}
						}else {
							sql.append(" and  " + aliaName + "." + zd + " = '"
									+ value + "' ");
						}

					}

				}
			}
		}

		return sql.toString();
	}
	
	/**
	 * 方法描述：含有预编译的sql对象 
	 * @param aliaName 别名
	 * @param params   Map参数
	 * @return      QuerySqlVo
	 */
	public static QuerySqlVo makeSelectSqlForParam(String aliaName,Map<String, String> params) {
		List<String> paramList=new LinkedList<String>();
		QuerySqlVo sqlVo=null;
		
		StringBuffer sql = new StringBuffer(" ");
		if (params != null && params.size() > 0) {
			sqlVo=new QuerySqlVo();
			
			Iterator<Entry<String, String>> ite = params.entrySet().iterator();
			while (ite.hasNext()) {
				Entry<String, String> entry =  ite
						.next();
				String key = entry.getKey().toLowerCase();
				if (key.indexOf("__") == -1) {
					continue;
				}
				String zdInfo[] = key.split("__");
				if (zdInfo.length < 3) {
					continue;
				}
				String type = zdInfo[1];
				String fh = zdInfo[2];
				String zd = zdInfo[0];
				String value = entry.getValue();
				
				if (value != null && !"".equals(value.trim())) {
					value = value.trim().replaceAll("'", "''");
					if (zd.indexOf("$") > 0) {
						String[] zdArra = zd.split("\\$");
						int len = zdArra.length;
						for (int m = 0; m < len; m++) {
							paramList.add("%"+value+"%");
							String zdmc = zdArra[m];
							if (m == 0) {
								sql.append(" and ( " + aliaName + "." + zdmc
										+ " like ? " );
							/*} else if (m == len - 1) {
								sql.append(" or " + aliaName + "." + zdmc + " like ? " );*/
							} else {
								sql.append(" or " + aliaName + "." + zdmc
										+ " like ? " );
							}
						}

					} else {
						if("like".equals(fh)){
							paramList.add("%"+value+"%");
						}else{
							paramList.add(value);
						}
						
						if ("string".equals(zdInfo[1])) {
							if ("eq".equals(fh)) {
								
								sql.append(" and  " + aliaName + "." + zd
										+ " =  ? " );
							} else if ("neq".equalsIgnoreCase(fh)) {
								sql.append(" and  " + aliaName + "." + zd
										+ " <>  ? " );
							} else if ("null".equalsIgnoreCase(fh)) {
								sql.append(" and  " + aliaName + "." + zd
										+ " is null");
							} else if ("like".equals(fh)) {
								sql.append(" and  " + aliaName + "." + zd
										+ " like  ? " );
							}

						} else if ("number".equals(zdInfo[1])) {
							if ("gt".equals(fh)) {
								sql.append(" and  " + aliaName + "." + zd
										+ " >= " + value
										+ " ");
							} else if ("lt".equals(fh)) {
								sql.append(" and  " + aliaName + "." + zd
										+ " <= " + value
										+ " ");
							}else if ("eq".equals(fh)) {
								sql.append(" and  " + aliaName + "." + zd
										+ " = " + value
										+ " ");
							}
						}else if ("date".equals(zdInfo[1])) {
							if ("gt".equals(fh)) {
								sql.append(" and  trunc(" + aliaName + "." + zd
										+ ") >= to_date( ? " 
										+ ", 'yyyy-mm-dd') ");
							} else if ("lt".equals(fh)) {
								sql.append(" and  trunc(" + aliaName + "." + zd
										+ ") <= to_date( ?" 
										+ ", 'yyyy-mm-dd') ");
							}
						} else if ("datetime".equals(zdInfo[1])) {
							if ("gt".equals(fh)) {
								sql.append(" and  CONVERT(VARCHAR(100)," + aliaName + "." + zd
										+ ", 23) >= ? ");
							} else if ("lt".equals(fh)) {
								sql.append(" and  CONVERT(VARCHAR(100)," + aliaName + "." + zd
										+ " , 23) <= ? " );
							}
						}else {
							sql.append(" and  " + aliaName + "." + zd + " = ? ");
						}

					}

				}
			}
			
			sqlVo.setConditionSql(sql.toString());
			String paramArra[]=new String[paramList.size()];
			for(int i=0;i<paramArra.length;i++){
				paramArra[i]=paramList.get(i);
			}
			sqlVo.setParamValue(paramArra);
//			///System.out.printlnln(sql.toString());
//			///System.out.printlnln(Arrays.toString(paramArra));
		}

		return sqlVo;
	}
	
	/**
	 * 方法描述：不需要预编译的sql（直接通过条件 值 拼接）
	 * @param aliaName  别名
	 * @param params    Map参数
	 * @return          String
	 */
	public static String makeSelectSqlForStr(String aliaName,Map<String, String> params) {
		StringBuffer result=new StringBuffer();
		QuerySqlVo sqlVo=makeSelectSqlForParam(aliaName, params);
		if(null!=sqlVo){
			String sql=sqlVo.getConditionSql();
			Object []param=sqlVo.getParamValue();
			
			String [] sqlArra=sql.split("\\?");
			for(int i=0;i<param.length;i++){
				result.append(sqlArra[i] +"'"+param[i]+"' ");
			}
			
		}
		
		return result.toString();
	}
	
	
}
