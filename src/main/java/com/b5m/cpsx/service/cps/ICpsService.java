package com.b5m.cpsx.service.cps;

import java.util.Map;

public interface ICpsService {
	
	public int insertUrlAccount(Map<String, String> params);
	
	public int updateUrlAccount(Map<String, String> params);
	
	public int insertActivityRule(Map<String, String> params);
	
	public int updateActivityRule(Map<String, String> params);

	public int insertExchangePattern(Map<String, String> params);

	public int updateExchangePattern(Map<String, String> params);
}
