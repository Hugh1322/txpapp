package com.txp.app.dto.test;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang3.StringUtils;


public class ActivityTbl {
	
	private Integer id;//活动主键
	private String code;//活动代码
	private String name;//活动名称
	private Integer status;//活动激活状态
	private Date createTime;//创建时间
	private Date updateTime;//更新时间
	private Integer isDelete;//是否删除 0 否，1 是 
	private Integer version;//版本控制
	private Short sellTypes;//销售类型   1=普通 ,2=预售 ,3=抢购,4=团购 ,5.分期送,8.试吃
	private String couponRule;//优惠券规则 1,普通优惠券  2 运单优惠券
	private Date startTime;//团购活动开始时间
	private Date endTime;//团购活动结束时间
	private Integer vipLevel; //会员等级
	private String activityDesc;//广告语
	private Integer timeRule;//时间规则
	private String advertisementPics;//广告图片字段
	private Integer displayMode;//展示形式
	private String activityLink;//活动链接
	private Integer activityLinkMode;//是否自动   0:是 1:否
	
	
	
	
	public String getAdvertisementPics() {
		return advertisementPics;
	}
	public void setAdvertisementPics(String advertisementPics) {
		this.advertisementPics = advertisementPics;
	}
	public Integer getDisplayMode() {
		return displayMode;
	}
	public void setDisplayMode(Integer displayMode) {
		this.displayMode = displayMode;
	}
	public String getActivityLink() {
		return activityLink;
	}
	public void setActivityLink(String activityLink) {
		this.activityLink = activityLink;
	}
	public Integer getActivityLinkMode() {
		return activityLinkMode;
	}
	public void setActivityLinkMode(Integer activityLinkMode) {
		this.activityLinkMode = activityLinkMode;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
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
	
	public Short getSellTypes() {
		return sellTypes;
	}
	public void setSellTypes(Short sellTypes) {
		this.sellTypes = sellTypes;
	}
	public String getCouponRule() {
		return couponRule;
	}
	public void setCouponRule(String couponRule) {
		this.couponRule = couponRule;
	}

	public Date getStartTime() {
		return startTime;
	}
	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}
	public Date getEndTime() {
		return endTime;
	}
	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public Integer getVipLevel() {
		return vipLevel;
	}
	public void setVipLevel(Integer vipLevel) {
		this.vipLevel = vipLevel;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getActivityDesc() {
		return activityDesc;
	}
	public void setActivityDesc(String activityDesc) {
		this.activityDesc = activityDesc;
	}
	public Integer getTimeRule() {
		return timeRule;
	}
	public void setTimeRule(Integer timeRule) {
		this.timeRule = timeRule;
	}
	public List<Short> getCouponScope(){
		List<Short> couponScopes= new ArrayList<Short>();
		if(StringUtils.isBlank(couponRule)){
			return couponScopes;
		}
		String[] scopes = couponRule.split(",");
		for(String scope:scopes){
			if(StringUtils.isBlank(scope)){
				continue;
			}
			couponScopes.add(Short.valueOf(scope.trim()));
		}
		return couponScopes;
	}
}
