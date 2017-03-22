package com.b5m.cpsx.service.cache;

import java.util.Map;


public interface CacheMapService {
	
	public Object getCache(String key);
	
	public Object getCache(String key, Object defaultValue);
	  
	public void putCache(String key, Object value);
	  
	public void removeCache(String key);
	  
	public Map<String, Object> getCacheMap();

}
