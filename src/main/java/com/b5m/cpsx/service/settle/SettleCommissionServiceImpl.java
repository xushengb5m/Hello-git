package com.b5m.cpsx.service.settle;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.b5m.cpsx.dao.IBaseCommonMapper;
import com.b5m.cpsx.model.ControllerMessage;

@Service("settleCommissionService")
public class SettleCommissionServiceImpl implements ISettleCommissionService{
	
	@Autowired
	protected IBaseCommonMapper baseCommonMapper;

	@Override
	public ControllerMessage updateApplyingCommission(Map<String, String> params) {
		ControllerMessage cm = new ControllerMessage();
		try {
			//提现密码验证
			int suc = (int) baseCommonMapper.selectOne("payAccountMapper.selectValidatePayPsw", params);
			if(suc>0){
				//当月是否已提取过
				int hasDone = (int) baseCommonMapper.selectOne("settleMapper.hasApplied", params);
				if(hasDone>0){
					cm.setStatue(false);
					cm.setMessage("本月已提现，请下个月再申请!");
				}else{
					//添加申请
					int isAdded = (int) baseCommonMapper.update("settleMapper.updateApplyCommission", params);
					if(isAdded>0){
						cm.setStatue(true);
						cm.setMessage("申请提现成功!");
					}else{
						cm.setStatue(false);
						cm.setMessage("申请提现失败!");
					}
				}
			}else{
					cm.setStatue(false);
					cm.setMessage("提现密码错误!");
			}
		} catch (Exception e) {
			cm.setStatue(false);
			cm.setMessage("申请提现失败!");
		}
		return cm;
	}

	
	@Override
	public ControllerMessage updateCompleteCommissionPay(Map<String, String> params) {
		ControllerMessage cm = new ControllerMessage();
		try {
			int suc = baseCommonMapper.update("settleMapper.completePayCommission",params);
			if(suc>0){
				baseCommonMapper.update("settleMapper.updateApplyingMoney", params);//支付状态改变后，改变余额
				cm.setStatue(true);
				cm.setMessage("操作成功!");
			}else{
				cm.setStatue(false);
				cm.setMessage("操作失败!");
			}
		} catch (Exception e) {
			cm.setStatue(false);
			cm.setMessage("操作失败!");
		}
		return cm;
	}

}
