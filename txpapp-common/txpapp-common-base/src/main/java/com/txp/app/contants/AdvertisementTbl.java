package com.txp.app.contants;

import java.io.Serializable;
import java.util.Date;

/** 广告明细表
 * @author zengzhiming
 *
 */
public class AdvertisementTbl implements Serializable {
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 4603730158413818228L;
	/**主键	 */
	private Integer advertisementId;
	/**	广告跳转的url */
	private String url;
	/**	广告排序 */
	private Integer rank;
	/**	广告图片 */
	private String imageUrl;
	/**	广告描述 */
	private String advertisementName;
	/**	广告打开的方式  1-在本页面打开；2-另开页面 */
	private Integer target;
	/**	广告位主键  多对一 */
	private Integer positionId;
	/**	广告中 商品 所在地 所属的来源id */
	private Integer advertisementPositionId;
	/**	创建者 */
	private Integer createUserId;
	/**	创建时间 */
	private Date createTime;
	/**	更新时间 */
	private Date updateTime;
	/** 状态 */
	private Integer status;
	/**	城市名称 */
	private String cityName;
	/**	城市介绍*/
	private String cityContent;
	/**	推荐商品名称 */
	private String productName;
	/**	商品跳转的url */
	private String productUrl;
	/**	商品图片 */
	private String productImageUrl;
	/**	类型  标记热销特产图片的大小*/
	private Short type;
	/** 广告说明 */
	private String advDescription;
	/**  原价	 */
	private String originalPrice;
	/**  现价 */
	private String currentPrice;
	/**规格*/
	private String specification;
	/**标签*/
	private String labelText;
	/**轮播图背景色*/
	private String backColor;
	
	/**是否默认搜索词*/
	private Integer isDefault;
	/**	瀑布流广告显示位置*/
	private Integer advPlace;
	
	public Integer getAdvPlace() {
		return advPlace;
	}
	public void setAdvPlace(Integer advPlace) {
		this.advPlace = advPlace;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public Integer getAdvertisementId() {
		return advertisementId;
	}
	public void setAdvertisementId(Integer advertisementId) {
		this.advertisementId = advertisementId;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public Integer getRank() {
		return rank;
	}
	public void setRank(Integer rank) {
		this.rank = rank;
	}
	public String getImageUrl() {
		return imageUrl;
	}
	public void setImageUrl(String imageUrl) {
		this.imageUrl = imageUrl;
	}
	public String getAdvertisementName() {
		return advertisementName;
	}
	public void setAdvertisementName(String advertisementName) {
		this.advertisementName = advertisementName;
	}
	public Integer getTarget() {
		return target;
	}
	public void setTarget(Integer target) {
		this.target = target;
	}
	public Integer getPositionId() {
		return positionId;
	}
	public void setPositionId(Integer positionId) {
		this.positionId = positionId;
	}
	public Integer getAdvertisementPositionId() {
		return advertisementPositionId;
	}
	public void setAdvertisementPositionId(Integer advertisementPositionId) {
		this.advertisementPositionId = advertisementPositionId;
	}
	public Integer getCreateUserId() {
		return createUserId;
	}
	public void setCreateUserId(Integer createUserId) {
		this.createUserId = createUserId;
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
	public String getProductUrl() {
		return productUrl;
	}
	public void setProductUrl(String productUrl) {
		this.productUrl = productUrl;
	}
	public String getProductImageUrl() {
		return productImageUrl;
	}
	public void setProductImageUrl(String productImageUrl) {
		this.productImageUrl = productImageUrl;
	}
	public String getCityName() {
		return cityName;
	}
	public void setCityName(String cityName) {
		this.cityName = cityName;
	}
	public String getCityContent() {
		return cityContent;
	}
	public void setCityContent(String cityContent) {
		this.cityContent = cityContent;
	}
	public Short getType() {
		return type;
	}
	public void setType(Short type) {
		this.type = type;
	}
	public String getProductName() {
		return productName;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public String getAdvDescription() {
		return advDescription;
	}
	public void setAdvDescription(String advDescription) {
		this.advDescription = advDescription;
	}
	public String getOriginalPrice() {
		return originalPrice;
	}
	public void setOriginalPrice(String originalPrice) {
		this.originalPrice = originalPrice;
	}
	public String getCurrentPrice() {
		return currentPrice;
	}
	public void setCurrentPrice(String currentPrice) {
		this.currentPrice = currentPrice;
	}
	public String getSpecification() {
		return specification;
	}
	public void setSpecification(String specification) {
		this.specification = specification;
	}
	public String getLabelText() {
		return labelText;
	}
	public void setLabelText(String labelText) {
		this.labelText = labelText;
	}
	public Integer getIsDefault() {
		return isDefault;
	}
	public void setIsDefault(Integer isDefault) {
		this.isDefault = isDefault;
	}
	public String getBackColor() {
		return backColor;
	}
	public void setBackColor(String backColor) {
		this.backColor = backColor;
	}
	
}
