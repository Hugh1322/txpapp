package com.txp.app.dto.test;

import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.StringUtils;


public class MarketactivityRule extends MarketactivityRuleTbl{
	
	/** 活动类型为包邮 */
	public static final Integer TYPE_POST=1;
	/** 活动类型为满减 */
	public static final Integer TYPE_MANJIAN=2;
	/** 活动类型为银行打折 */
	public static final Integer TYPE_BANK_DISCOUNT=3;
	/** 活动类型为买减 */
	public static final Integer TYPE_MAIJIAN=4;
	/** 活动类型为买送 */
	public static final Integer TYPE_MAISONG=5;
	
	
	
	public static final Integer ISDELETE_YES=1;//规则删除 
	public static final Integer ISDELETE_NO=0;//规则不删除 
	
	public static final Integer DISABLED = 0;//规则禁用
	public static final Integer RULE_OPEN = 1;//规则启用
	
	
	public static final Integer JIESUAN_RULE = 1; //结算规则
	
	public static final Integer PAY_RULE = 2; //支付规则
	private String lastConnection;//活动规则与上一个规则的链接关系
	public String getLastConnection() {
		return StringUtils.isNotBlank(lastConnection) ? lastConnection : "&&";
	}
	public void setLastConnection(String lastConnection) {
		this.lastConnection = lastConnection;
	}
	public List<String> getBankKey() {
		List<String> keys = new ArrayList<String>();
		String condition = getRuleCondition();
		if(StringUtils.isBlank(condition)){
			return keys;
		}
		String[] ruleConditions = getRuleCondition().split("@");
		String conditionName = "";// 条件名称
		String conditionObject = "";// 条件对象
		for (String rule : ruleConditions) {
			if (rule.indexOf("#") == 0) {
				rule = rule.replaceFirst("#", "");
			}
			String[] rules = rule.split("#");
			conditionName = rules[0];// 条件名称
			conditionObject = rules[2];// 条件对象
			if("bankType".endsWith(conditionName)){
				keys.add(conditionObject);
			}
		}
		return keys;
	}
}
