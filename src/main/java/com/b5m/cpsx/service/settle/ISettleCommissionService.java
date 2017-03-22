package com.b5m.cpsx.service.settle;

import java.util.Map;

import com.b5m.cpsx.model.ControllerMessage;

public interface ISettleCommissionService {
	
	//申请提现事务
	public ControllerMessage updateApplyingCommission(Map<String, String> params);
	
	//完成提现事务
	public ControllerMessage updateCompleteCommissionPay(Map<String, String> params);

}
