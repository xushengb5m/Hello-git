package com.b5m.cpsx.model;




public class Page {
	
	public static final int DEFAULT_PAGE_SIZE =20;
	
	/**每页的记录数*/
	private int pageSize = DEFAULT_PAGE_SIZE;
	
	private int pageNo=1;
	/**总记录数*/
	private long total;
	/**当前页中存放的记录,类型一般为List*/
	private Object rows;
	
	/**jquery ui 中的工具栏显示*/
	private Object footer;
	
	/**查询参赛*/
	private Object queryParam;

	private String sqlStr="";
	
	
	public String getSqlStr() {
		return sqlStr;
	}

	public void setSqlStr(String sqlStr) {
		this.sqlStr = sqlStr;
	}

	public Object getQueryParam() {
		return queryParam;
	}

	public void setQueryParam(Object queryParam) {
		this.queryParam = queryParam;
	}

	public Object getFooter() {
		return footer;
	}

	public void setFooter(Object footer) {
		this.footer = footer;
	}

	public int getPageNo() {
		return pageNo;
	}

	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}


	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	/**
	 * 构造方法，只构造空页.
	 */
	@SuppressWarnings("unchecked")
	public Page() {
	}


	/**
	 * 取总页数.
	 */
	public long getTotalPageCount() {
		if (total % pageSize == 0) {
			return total / pageSize;
		} else {
			return total / pageSize + 1;
		}
	}

	/**
	 * 取每页数据容量.
	 */
	public int getPageSize() {
		return pageSize;
	}

	/**
	 * 取当前页中的记录.
	 */
	public Object getRows() {
		return rows;
	}
	
	/**
	 * 设置当前页中的记录.
	 */
	public void setRows(Object rows){
		this.rows = rows;
	}
	

	/**
	 * 获取任一页第一条数据在数据集的位置，每页条数使用默认值.
	 *
	 * @see #getStartOfPage(int,int)
	 */

	/**
	 * 获取总记录数
	 * 
	 * @return	
	 */
	public long getTotal() {
		return total;
	}

	/**
	 * 设置总记录数
	 * 
	 * @param total
	 */
	public void setTotal(long total) {
		this.total = total;
	}

}
