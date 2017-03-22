package com.b5m.cpsx.commons.mybatis.dialect;
public class PostgreDialect extends Dialect {
	
	public String getLimitString(String sql, int offset, int limit) {

		sql = sql.trim();

		StringBuffer pagingSelect = new StringBuffer(sql.length() + 100);
		
		pagingSelect.append("select xxxxxxx.* from ( ");
		
		pagingSelect.append(sql);
		
		pagingSelect.append(" ) xxxxxxx OFFSET  "+offset+"   LIMIT "+ limit );
		
		return pagingSelect.toString();
	}
}