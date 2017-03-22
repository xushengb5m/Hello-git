package com.b5m.cpsx.utils;
/**
 * 
 * 类名称: QuerySqlVo
 * <p/>  
 * 类描述:查询条件处理基础类
 * <p/>
 */
public class QuerySqlVo {
	/**
	 * 查询条件
	 */
	private String conditionSql;
	/**
	 * 条件对应值 参数
	 */
	private Object [] paramValue;
	public String getConditionSql() {
		return conditionSql;
	}
	public void setConditionSql(String conditionSql) {
		this.conditionSql = conditionSql;
	}
	public Object[] getParamValue() {
		return paramValue;
	}
	public void setParamValue(Object[] paramValue) {
		this.paramValue = paramValue;
	}
}