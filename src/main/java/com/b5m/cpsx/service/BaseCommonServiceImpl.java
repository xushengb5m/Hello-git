package com.b5m.cpsx.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Service;

import com.b5m.cpsx.dao.IBaseCommonMapper;
import com.b5m.cpsx.model.Page;
import com.b5m.cpsx.utils.SpringBeanUtil;

@Service("baseCommonService") 
public class BaseCommonServiceImpl implements IBaseCommonService{
	protected Logger log = Logger.getLogger(this.getClass());
	
	protected IBaseCommonMapper baseCommonMapper;

	public IBaseCommonMapper getBaseCommonMapper() {
		if(null ==baseCommonMapper ){
			baseCommonMapper=SpringBeanUtil.getBean("baseCommonMapper", IBaseCommonMapper.class);
		}
		return baseCommonMapper;
	}

	public void setBaseCommonMapper(IBaseCommonMapper baseCommonMapper) {
		this.baseCommonMapper = baseCommonMapper;
	}

	
	public Object selectOne(String namespace, Object param) {
		// TODO Auto-generated method stub
		return baseCommonMapper.selectOne(namespace, param);
	}

	public List<Object> selectList(String namespace, Object param) {
		// TODO Auto-generated method stub
		return  baseCommonMapper.selectList(namespace, param);
	}

	
	
	public Object selectOne(Object param) {
		String namespace= ((Map<String,String>)param).get("namespace");
		return baseCommonMapper.selectOne(namespace, param);
	}

	public Object selectOne(String namespace) {
		return baseCommonMapper.selectOne(namespace);
	}

	public List<Object> selectList(Object param) {
		String namespace= ((Map<String,String>)param).get("namespace");
		List<Object> o = baseCommonMapper.selectList(namespace, param);
		return o;
	}

	public Page selectList(String namespace, Page param) {
		// TODO Auto-generated method stub
		return baseCommonMapper.selectListPage(namespace, param);
	}
	
	public List<Object> selectListAll(String namespace) {
		List<Object> o = baseCommonMapper.selectList(namespace);
		return o;
	}
	
	
	/**
	 * 获取键值对结果集合
	 * @param param
	 * @return
	 */
	public Map<String, Object> queryMapObject(String namespace , Object param,String identity){
		
		List<Object> ol = baseCommonMapper.selectList(namespace, param);
		return queryMapObject(ol, identity);
	}
	
	protected Map<String, Object> queryMapObject(List<Object> ol ,String identity){
		Map<String, Object> result =new HashMap<String, Object>();
		
		for(Object o : ol){
			if(o instanceof Map){
				Object key = ((Map) o).get(identity);
				if(null !=key){
					result.put(key.toString(), o);
				}
			}else{
				//result.put(((Map) o).get(identity).toString(), o);
			}
			
		}
		return result;
	}
	
	public Map<String, List<Object> > queryMapList(String namespace , Object param,String identity){
		
		List<Object> ol = baseCommonMapper.selectList(namespace, param);
		
		return queryMapList(ol, identity);
	}
	protected Map<String, List<Object> > queryMapList(List<Object> ol ,String identity){
		Map<String, List<Object>> result =new HashMap<String, List<Object>>();
		
		for(Object o : ol){
			try{
				result.get(((Map) o).get(identity).toString()).add(o);
			}catch (Exception e) {
				result.put(((Map) o).get(identity).toString() , new ArrayList<Object>());
				result.get(((Map) o).get(identity).toString()).add(o);
			}
			
		}
		
		return result;
	}
	

	public Object insert(String namespace, Object param) {
		// TODO Auto-generated method stub
		return baseCommonMapper.insert(namespace, param);
	}

	public int delete(String namespace, Object param) {
		// TODO Auto-generated method stub
		return baseCommonMapper.delete(namespace, param);
	}

	public int update(String namespace, Object param) {
		// TODO Auto-generated method stub
		return baseCommonMapper.update(namespace, param);
	}

	public List<Object> selectListPage(String namespace, Page param) {
		// TODO Auto-generated method stub
		return null;
	}

}
