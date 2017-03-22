package com.b5m.cpsx.service;

import java.util.List;
import java.util.Map;

import com.b5m.cpsx.model.Page;

public interface IBaseCommonService {
	
	
	/**
	 * 获取键值对结果集合
	 * @param param
	 * @return
	 */
	Map<String, Object> queryMapObject(String namespace ,Object param,String identity);
	
	Map<String, List<Object> > queryMapList(String namespace ,Object param,String identity);
	
	/**
	 * 查询一条记录
	 * @param namespace maper命名空间
	 * @param param 查询参数
	 * @return
	 */
	public Object selectOne(Object param);
	
	/**
	 * 查询多条记录
	 * @param namespace maper命名空间
	 * @param param 查询参数
	 * @return
	 */
	public List<Object> selectList(Object param);
	
	/**
	 * 查询一条记录
	 * @param namespace maper命名空间
	 * @param param 查询参数
	 * @return
	 */
	public Object selectOne(String namespace, Object param) ;
	
	
	/**
	 * 查询一条记录
	 * @param namespace maper命名空间
	 * @param param 查询参数
	 * @return
	 */
	public Object selectOne(String namespace);
	
	
	/**
	 * 查询多条记录
	 * @param namespace maper命名空间
	 * @param param 查询参数
	 * @return
	 */
	public List<Object> selectList(String namespace, Object param) ;
	
    /**
     * 
     * @param namespace
     * @return
     */
	public List<Object> selectListAll(String namespace);
	
	/**
	 * 分页查询
	 * @param namespace maper命名空间
	 * @param param 查询参数
	 * @return
	 */
	public Page selectList(String namespace, Page param) ;
	
	/**
	 * 分页查询
	 * @param namespace maper命名空间
	 * @param param 查询参数
	 * @return
	 */
	public List<Object> selectListPage(String namespace,Page param);
	
	
	/**
	 * 插入
	 * @param namespace
	 * @param param
	 * @return
	 */
	public Object insert(String namespace,Object param);

	/**
	 * 删除
	 * @param namespace
	 * @param param
	 * @return
	 */
	public int delete(String namespace,Object param);

	/**
	 * 更新
	 * @param namespace
	 * @param param
	 * @return
	 */
	public int update(String namespace,Object param);
}
