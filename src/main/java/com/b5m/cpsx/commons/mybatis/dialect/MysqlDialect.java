package com.b5m.cpsx.commons.mybatis.dialect;

public class MysqlDialect extends Dialect
{

    /*
     * (non-Javadoc)
     * @see
     * org.mybatis.extend.interceptor.IDialect#getLimitString(java.lang.String,
     * int, int)
     */
    @Override
    public String getLimitString(String sql, int offset, int limit)
    {

       /* sql = sql.trim();
        StringBuffer pagingSelect = new StringBuffer(sql.length() + 100);

        pagingSelect.append(sql);

        pagingSelect.append(" limit ").append(offset - 1).append(" , ").append(limit);
        */
        
        
        sql = sql.trim();

		StringBuffer pagingSelect = new StringBuffer(sql.length() + 100);
		
		pagingSelect.append("select xxxxxxx.* from ( ");
		
		pagingSelect.append(sql);
		
		pagingSelect.append(" ) xxxxxxx limit  "+offset+"   , "+ limit );
		
		

        return pagingSelect.toString();
    }

}