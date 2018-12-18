package com.txp.app.contants;

import java.io.Serializable;
import java.util.Date;


public class ProductOnlineTbl implements Serializable{
	/**
     * <p>Field serialVersionUID: serialVersionUID</p>
     */
    private static final long serialVersionUID = -6468574526423729590L; 
	protected Integer productId;// 商品id
	protected Integer brandId;// 商标id
	protected Integer userId;// 商家id
	protected String name;// 商品名称
	protected Short isShowInventory;// 前如页面是否显示库存：0=不显示，1=显示
	protected String imageUrls;
	protected String description;// 详细描述
	protected String keyWord;// 关键字
	protected Short status; // 状态：1=草稿，2=审核中，3=审核通过，4=审核不通过
	protected String remark; // 备注没有通过审核的原因
	protected Date createTime;// 创建时间
	protected Date updateTime;
	protected Short sellType;// 是否预售商品：1=非预售，2=预售
	protected Date preDeliveryTime;// 预计发货时间
	protected String recommendedReason;//推荐理由
	protected Integer hits;//点击量
	protected String productProp;//商品属性字符串
	protected String coverPicture;//商品封面图片
	protected String aliasName;// 商品别名
	protected Integer rushQuantity;// 抢购数量
	protected Date checkTime;		//审核通过时间，商品发布时间
	
	// 为商品管理而新增
	protected Integer operator;				//操作人
	protected Date operationTime;			//操作时间
	protected String manufacturer;			//生产商
	protected String manufacturerAddress;	//生产地址
	protected String manufactureLicence;	//生产许可证
	protected Date expiryDate;				//有效期
	protected String productCode;			//产品标准号
	protected String barCode;				//条码
	protected String isOrganic;				//是否有机   1:是  0:否
	protected String isAdditives;			//是否含食品添加剂  1:是  0:否 
	protected String offmarket;				//下架原因
	protected Integer applicant;			//提报人
	protected Date applicationTime;			//提报时间
	protected Integer auditor;				//审核人
	protected Date auditTime;				//审核时间
	protected Double version;				//版本
	protected Integer isDelete;				//是否删除 1:是  0:否
	protected Short settlementType;			//结算类型：1=返点，2=供货
	protected Double productRebate;			//商品返点
	protected Integer isEdit;				//是否编辑过：1编辑过
	/**海外商品直购 0:否1:是	 */
	protected Short isOverseas;
	/**税率类目所属类别	 */
	protected String taxCate;
	/**商品对应税率	 */
	protected Double taxNumber;
	/**商品货号	 */
	protected String productNumber;
	/**单位编码1	 */
	protected String unitNumber;
	/**单位编码2	 */
	protected String unitCode;
	/**运营模式 0:海外直发1：国内现货	 */
	protected Short operationMode;
	/**国内是否包邮0:否1:是	 */
	protected Short homeFree;
	/**海关备案号 */
	protected String customsRecordationNumber;
	/**国检备案号*/
	protected String countryCheckNumber;
	/**时效计算规则**/
	protected Integer timeNode;
	/**商品产地**/
	protected Integer origin;
	/**货币币种**/
	protected String currencyCode;
	
	public String getCustomsRecordationNumber() {
		return customsRecordationNumber;
	}

	public void setCustomsRecordationNumber(String customsRecordationNumber) {
		this.customsRecordationNumber = customsRecordationNumber;
	}

	public String getCountryCheckNumber() {
		return countryCheckNumber;
	}

	public void setCountryCheckNumber(String countryCheckNumber) {
		this.countryCheckNumber = countryCheckNumber;
	}

	public Short getIsOverseas() {
		return isOverseas;
	}

	public void setIsOverseas(Short isOverseas) {
		this.isOverseas = isOverseas;
	}

	public String getTaxCate() {
		return taxCate;
	}

	public void setTaxCate(String taxCate) {
		this.taxCate = taxCate;
	}

	public Double getTaxNumber() {
		return taxNumber;
	}

	public void setTaxNumber(Double taxNumber) {
		this.taxNumber = taxNumber;
	}

	public String getProductNumber() {
		return productNumber;
	}

	public void setProductNumber(String productNumber) {
		this.productNumber = productNumber;
	}

	public String getUnitNumber() {
		return unitNumber;
	}

	public void setUnitNumber(String unitNumber) {
		this.unitNumber = unitNumber;
	}

	public String getUnitCode() {
		return unitCode;
	}

	public void setUnitCode(String unitCode) {
		this.unitCode = unitCode;
	}

	public Short getOperationMode() {
		return operationMode;
	}

	public void setOperationMode(Short operationMode) {
		this.operationMode = operationMode;
	}

	public Short getHomeFree() {
		return homeFree;
	}

	public void setHomeFree(Short homeFree) {
		this.homeFree = homeFree;
	}

	public String getAliasName() {
		return aliasName;
	}

	public void setAliasName(String aliasName) {
		this.aliasName = aliasName;
	}

	public Integer getRushQuantity() {
		return rushQuantity;
	}

	public void setRushQuantity(Integer rushQuantity) {
		this.rushQuantity = rushQuantity;
	}

	public Integer getProductId() {
		return productId;
	}

	public void setProductId(Integer productId) {
		this.productId = productId;
	}

	public Integer getBrandId() {
		return brandId;
	}

	public void setBrandId(Integer brandId) {
		this.brandId = brandId;
	}

	public Integer getUserId() {
		return userId;
	}

	public void setUserId(Integer userId) {
		this.userId = userId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Date getPreDeliveryTime() {
		return preDeliveryTime;
	}

	public void setPreDeliveryTime(Date preDeliveryTime) {
		this.preDeliveryTime = preDeliveryTime;
	}

	public Short getIsShowInventory() {
		return isShowInventory;
	}

	public void setIsShowInventory(Short isShowInventory) {
		this.isShowInventory = isShowInventory;
	}

	public String getImageUrls() {
		return imageUrls;
	}

	public void setImageUrls(String imageUrls) {
		this.imageUrls = imageUrls;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getKeyWord() {
		return keyWord;
	}

	public void setKeyWord(String keyWord) {
		this.keyWord = keyWord;
	}

	public Short getStatus() {
		return status;
	}

	public void setStatus(Short status) {
		this.status = status;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
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

	public Short getSellType() {
		return sellType;
	}

	public void setSellType(Short sellType) {
		this.sellType = sellType;
	}

	public String getRecommendedReason() {
		return recommendedReason;
	}

	public void setRecommendedReason(String recommendedReason) {
		this.recommendedReason = recommendedReason;
	}

	public Integer getHits() {
		return hits==null?0:hits;
	}

	public void setHits(Integer hits) {
		this.hits = hits;
	}

	public String getProductProp() {
		return productProp;
	}

	public void setProductProp(String productProp) {
		this.productProp = productProp;
	}

	public String getCoverPicture() {
		return this.coverPicture;
	}

	public void setCoverPicture(String coverPicture) {
		this.coverPicture = coverPicture;
	}

	public Date getCheckTime() {
		return checkTime;
	}

	public void setCheckTime(Date checkTime) {
		this.checkTime = checkTime;
	}

	// 为商品管理而新增
	
	public Integer getOperator() {
		return operator;
	}

	public void setOperator(Integer operator) {
		this.operator = operator;
	}

	public Date getOperationTime() {
		return operationTime;
	}

	public void setOperationTime(Date operationTime) {
		this.operationTime = operationTime;
	}

	public String getManufacturer() {
		return manufacturer;
	}

	public void setManufacturer(String manufacturer) {
		this.manufacturer = manufacturer;
	}

	public String getManufacturerAddress() {
		return manufacturerAddress;
	}

	public void setManufacturerAddress(String manufacturerAddress) {
		this.manufacturerAddress = manufacturerAddress;
	}

	public String getManufactureLicence() {
		return manufactureLicence;
	}

	public void setManufactureLicence(String manufactureLicence) {
		this.manufactureLicence = manufactureLicence;
	}

	public Date getExpiryDate() {
		return expiryDate;
	}

	public void setExpiryDate(Date expiryDate) {
		this.expiryDate = expiryDate;
	}

	public String getProductCode() {
		return productCode;
	}

	public void setProductCode(String productCode) {
		this.productCode = productCode;
	}

	public String getBarCode() {
		return barCode;
	}

	public void setBarCode(String barCode) {
		this.barCode = barCode;
	}

	public String getIsOrganic() {
		return isOrganic;
	}

	public void setIsOrganic(String isOrganic) {
		this.isOrganic = isOrganic;
	}

	public String getIsAdditives() {
		return isAdditives;
	}

	public void setIsAdditives(String isAdditives) {
		this.isAdditives = isAdditives;
	}

	public String getOffmarket() {
		return offmarket;
	}

	public void setOffmarket(String offmarket) {
		this.offmarket = offmarket;
	}

	public Integer getApplicant() {
		return applicant;
	}

	public void setApplicant(Integer applicant) {
		this.applicant = applicant;
	}

	public Date getApplicationTime() {
		return applicationTime;
	}

	public void setApplicationTime(Date applicationTime) {
		this.applicationTime = applicationTime;
	}

	public Integer getAuditor() {
		return auditor;
	}

	public void setAuditor(Integer auditor) {
		this.auditor = auditor;
	}

	public Date getAuditTime() {
		return auditTime;
	}

	public void setAuditTime(Date auditTime) {
		this.auditTime = auditTime;
	}

	public Double getVersion() {
		return version;
	}

	public void setVersion(Double version) {
		this.version = version;
	}

	public Integer getIsDelete() {
		return isDelete;
	}

	public void setIsDelete(Integer isDelete) {
		this.isDelete = isDelete;
	}

	public Short getSettlementType() {
		return settlementType;
	}

	public void setSettlementType(Short settlementType) {
		this.settlementType = settlementType;
	}

	public Integer getIsEdit() {
		return isEdit;
	}

	public void setIsEdit(Integer isEdit) {
		this.isEdit = isEdit;
	}

	public Double getProductRebate() {
		return productRebate;
	}

	public void setProductRebate(Double productRebate) {
		this.productRebate = productRebate;
	}

	public Integer getTimeNode() {
		return timeNode;
	}

	public void setTimeNode(Integer timeNode) {
		this.timeNode = timeNode;
	}

	public Integer getOrigin() {
		return origin;
	}

	public void setOrigin(Integer origin) {
		this.origin = origin;
	}

	public String getCurrencyCode() {
		return currencyCode;
	}

	public void setCurrencyCode(String currencyCode) {
		this.currencyCode = currencyCode;
	}
	
}
