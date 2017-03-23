package com.b5m.cpsx.service.cache;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.springframework.stereotype.Service;

@Service("cacheMapService")
public class CacheMapServiceImpl implements CacheMapService{

	private static Map<String, Object> cacheMap = new ConcurrentHashMap<String, Object>(1000);
	
	@Override
	public Object getCache(String key) {  
	    Object obj = getCacheMap().get(key);  
	    //Object obj = getSession().getAttribute(key);  
	    return obj;  
	}
	
	@Override
	public Object getCache(String key, Object defaultValue) {  
	    Object obj = getCacheMap().get(key);  
	    //Object obj = getSession().getAttribute(key);  
	    return obj==null?defaultValue:obj;  
	}  
	  
	@Override
	public void putCache(String key, Object value) {  
	    getCacheMap().put(key, value);  
	    //getSession().setAttribute(key, value);  
	}  
	  
	@Override
	public void removeCache(String key) {  
	    getCacheMap().remove(key);  
	    //getSession().removeAttribute(key);  
	}  
	  
	@Override
	public Map<String, Object> getCacheMap() {  
	    if (cacheMap==null){  
	        cacheMap = new HashMap<String, Object>();  
	    }  
	    return cacheMap;  
	}
}
