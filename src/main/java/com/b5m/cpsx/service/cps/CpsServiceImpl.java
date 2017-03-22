package com.b5m.cpsx.service.cps;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.b5m.cpsx.dao.IBaseCommonMapper;

@Service("cpsService")
public class CpsServiceImpl implements ICpsService{
	
	@Autowired
	protected IBaseCommonMapper baseCommonMapper;
	
	@Override
	public int insertUrlAccount(Map<String, String> params) {
		int isExsist = (int) baseCommonMapper.selectOne("cpsUrlMapper.selectOneUrlAccount",params);
		if(isExsist>0){
			return 0;
		}else{
			return baseCommonMapper.insert("cpsUrlMapper.insertCpsAccount",params);
		}
	}

	@Override
	public int updateUrlAccount(Map<String, String> params) {
		return baseCommonMapper.update("cpsUrlMapper.updateCpsAccount",params);
	}

	@Override
	public int insertActivityRule(Map<String, String> params) {
		int isExsist = (int) baseCommonMapper.selectOne("cpsUrlMapper.selectOneActivityRule",params);
		if(isExsist>0){
			return 0;
		}else{
			return baseCommonMapper.insert("cpsUrlMapper.insertActivityRule",params);
		}
	}

	@Override
	public int updateActivityRule(Map<String, String> params) {
		return baseCommonMapper.update("cpsUrlMapper.updateActivityRule",params); 
	}

	@Override
	public int insertExchangePattern(Map<String, String> params) {
		int isExsist = (int) baseCommonMapper.selectOne("cpsUrlMapper.selectOneExchangePattern",params);
		if(isExsist>0){
			return 0;
		}else{
			return baseCommonMapper.insert("cpsUrlMapper.insertExchangePattern",params);
		}
	}

	@Override
	public int updateExchangePattern(Map<String, String> params) {
		return baseCommonMapper.update("cpsUrlMapper.updateExchangePattern",params);
	}

	
	
}
