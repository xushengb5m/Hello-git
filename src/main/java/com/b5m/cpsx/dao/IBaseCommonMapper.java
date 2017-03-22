package com.b5m.cpsx.dao;

import java.util.List;

import com.b5m.cpsx.model.Page;

public interface IBaseCommonMapper {

	/**
	 * 查询一条记录
	 * @param namespace maper命名空间
	 * @param param 查询参赛
	 * @return
	 */
	public Object selectOne(String namespace,Object param);
	
	public Object selectOne(String namespace);
	
	/**
	 * 查询多条记录
	 * @param namespace maper命名空间
	 * @param param 查询参赛
	 * @return
	 */
	public List<Object> selectList(String namespace,Object param);
	
	public<T> List<T> selectList(String namespace,Object param,Class<T> resultType);
	
	/**
	 * 分页查询
	 * @param namespace
	 * @param param
	 * @return
	 */
	public Page selectListPage(String namespace,Page param);
	
	
	/**
	 * 插入
	 * @param namespace
	 * @param param
	 * @return
	 */
	public int insert(String namespace,Object param);
	public int insert(String namespace,Object param,boolean auto);
	/**
	 * 删除
	 * @param namespace
	 * @param param
	 * @return
	 */
	public int delete(String namespace,Object param);
	public int delete(String namespace,Object param,boolean auto);

	/**
	 * 更新
	 * @param namespace
	 * @param param
	 * @return
	 */
	public int update(String namespace,Object param);
	public int update(String namespace,Object param,boolean auto);

	public List<Object> selectList(String namespace);
	
	
}
