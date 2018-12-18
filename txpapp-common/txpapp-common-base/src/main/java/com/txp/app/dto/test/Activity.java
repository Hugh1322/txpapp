package com.txp.app.dto.test;

import java.util.List;


public class Activity extends ActivityTbl{
	
	public static final Integer PRODUCT_ALL=1;//全场 
	public static final Integer PRODUCT_NOT_ALL=0;//非全场 
	public static final Integer STATUS_PUBLISH = 1;//活动已发布
	public static final Integer STATUS_NOT_PUBLISH = 0;//活动未发布
	public static final Integer OVERRIDEFULLCOURT = 1;//覆盖全场
	public static final Integer SIMPLE_RULE = 1; //优惠券规则 -普通优惠券
	public static final Integer ORDER_RULE = 2 ; //优惠券规则 - 运单优惠券
	
	public static final Integer SELLTYPE_XS = 1;// 销售类型
	public static final Integer SELLTYPE_QG = 2;// 抢购类型
	public static final Integer SELLTYPE_TG = 3;// 团购类型
	public static final Integer SELLTYPE_SC = 8;// 试吃
	
	
	public static final Integer ISDELETE_YES=1;//活动删除 
	public static final Integer ISDELETE_NO=0;//活动不删除
	
	public static final Integer DISPLAY_FLOOR = 1;//按楼层显示
	
	public static final Integer DISPLAY_LIST = 0;//全列表显示
	
	private List<ActivityProduct> actProducts;//活动商品
	private List<MarketactivityRule> actRules;//活动规则
	
			
	private String activityLabel;
	private Integer activityStat;
	
	
	private static final String[] activityLabels = { "未开始", "活动中", "已结束" };
	
	
	public String getActivityLabel() {
		if (activityLabel == null) {
			Integer index = getActivityStat();
			if (index != null) {
				activityLabel = activityLabels[index];
			}
		}
		return activityLabel;
	}
	public Integer getActivityStat() {
		if (activityStat == null && getStartTime() != null
				&& getEndTime() != null) {
			long cur = System.currentTimeMillis();
			if (cur < getStartTime().getTime()) {
				activityStat = 0;
			} else if (cur > getEndTime().getTime()) {
				activityStat = 2;
			} else {
				activityStat = 1;
			}
		}
		return activityStat;
	}

	public List<MarketactivityRule> getActRules() {
		return actRules;
	}

	public void setActRules(List<MarketactivityRule> actRules) {
		this.actRules = actRules;
	}

	public List<ActivityProduct> getActProducts() {
		return actProducts;
	}

	public void setActProducts(List<ActivityProduct> actProducts) {
		this.actProducts = actProducts;
	}

}
