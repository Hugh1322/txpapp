package com.txp.app.dto.test;

import java.util.Date;

import org.apache.commons.lang.StringUtils;

public class MarketactivityRuleTbl {
	
	private Integer id;//活动规则主键
	private String code;//规则代码
	private String name;//规则名称
	private Integer type;//规则类型   1.结算规则  2.支付规则
	private Integer status;//状态  0:未激活，1：激活，2：禁用
	private String  ruleCondition; //规则条件
	private String  ruleResult; //规则结果
	private String lastConnection;//活动规则与上一个规则的链接关系
	private Date createTime;//创建时间
	private Date updateTime;//更新时间
	private String activityDesc;//广告语
	private Integer isDelete;//是否删除
	private Integer version;//版本控制
	
	
	
	
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Date getCreateTime() {
		return createTime;
	}
	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}
	public Date getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}
	public Integer getIsDelete() {
		return isDelete;
	}
	public void setIsDelete(Integer isDelete) {
		this.isDelete = isDelete;
	}
	public Integer getVersion() {
		return version;
	}
	public void setVersion(Integer version) {
		this.version = version;
	}
	public String getRuleCondition() {
		return ruleCondition;
	}
	public void setRuleCondition(String ruleCondition) {
		this.ruleCondition = ruleCondition;
	}
	public String getRuleResult() {
		return ruleResult;
	}
	public void setRuleResult(String ruleResult) {
		this.ruleResult = ruleResult;
	}
	public String getLastConnection() {
		return StringUtils.isNotBlank(lastConnection) ? lastConnection : "&&";
	}
	public void setLastConnection(String lastConnection) {
		this.lastConnection = lastConnection;
	}
	public String getActivityDesc() {
		return activityDesc;
	}
	public void setActivityDesc(String activityDesc) {
		this.activityDesc = activityDesc;
	}
	
}
