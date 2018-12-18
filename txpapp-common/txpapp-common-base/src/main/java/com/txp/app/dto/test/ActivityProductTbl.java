package com.txp.app.dto.test;

import java.math.BigDecimal;
import java.util.Date;

public class ActivityProductTbl {
	
	private Integer id;//活动商品表主键
	private Integer status;//活动商品状态
	private BigDecimal settlementPrice;//结算价
	private Integer productSkuId;//商品sku
	private BigDecimal activityPrice;//活动价
	private Date createTime;//创建时间
	private Date updateTime;//更新时间
	private Integer isDelete;//是否删除
	private Integer version;//版本控制
	private BigDecimal actSettlePrice;//活动结算价
	private BigDecimal actSettleDiscount;//活动结算折扣
	private Integer activityId;//活动id
	private Date startTime;//商品开始参加活动时间
	private Date endTime;//商品结束参加活动时间
	private Integer activityProductInventory;//活动商品库存
	private Integer activityProductLimitBuy;//活动商品限购数量
	private Integer point;//0元试吃活动商品所消耗的积分
	private Integer productInventory;//参加活动的商品的总库存
	
	
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
	public BigDecimal getSettlementPrice() {
		return settlementPrice;
	}
	public void setSettlementPrice(BigDecimal settlementPrice) {
		this.settlementPrice = settlementPrice;
	}
	public Integer getProductSkuId() {
		return productSkuId;
	}
	public void setProductSkuId(Integer productSkuId) {
		this.productSkuId = productSkuId;
	}
	public BigDecimal getActivityPrice() {
		return activityPrice;
	}
	public void setActivityPrice(BigDecimal activityPrice) {
		this.activityPrice = activityPrice;
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
	public BigDecimal getActSettlePrice() {
		return actSettlePrice;
	}
	public void setActSettlePrice(BigDecimal actSettlePrice) {
		this.actSettlePrice = actSettlePrice;
	}
	public BigDecimal getActSettleDiscount() {
		return actSettleDiscount;
	}
	public void setActSettleDiscount(BigDecimal actSettleDiscount) {
		this.actSettleDiscount = actSettleDiscount;
	}
	public Integer getActivityId() {
		return activityId;
	}
	public void setActivityId(Integer activityId) {
		this.activityId = activityId;
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
	public Integer getActivityProductInventory() {
		return activityProductInventory;
	}
	public void setActivityProductInventory(Integer activityProductInventory) {
		this.activityProductInventory = activityProductInventory;
	}
	public Integer getActivityProductLimitBuy() {
		return activityProductLimitBuy;
	}
	public void setActivityProductLimitBuy(Integer activityProductLimitBuy) {
		this.activityProductLimitBuy = activityProductLimitBuy;
	}
	public Integer getPoint() {
		return point;
	}
	public void setPoint(Integer point) {
		this.point = point;
	}
	public Integer getProductInventory() {
		return productInventory;
	}
	public void setProductInventory(Integer productInventory) {
		this.productInventory = productInventory;
	}

	
	
	
}
