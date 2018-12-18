package com.txp.app.dto.test;

import java.math.BigDecimal;


public class ActivityProduct extends ActivityProductTbl{
	
	public static final Integer ISDELETE_YES=1;//活动删除 
	public static final Integer ISDELETE_NO=0;//活动不删除
	public static final Integer TYPE_PRICE = 300;//价格排序
	public static final Integer TYPE_SALE = 200;//销售数量排序
	public static final Integer SORT_DESC = 100001;//降序
	public static final Integer SORT_ASC = 100000;//升序
	
	
	/**售卖类型：1=普通，2=预售，3=抢购，5=分期送**/
	private Integer sellType;
	/**团购**/
	private Integer sellType4;
	private String sellTypeStr;
	/**状态：1=草稿，2=待审核，3=审核通过，4=审核不通过**/
	private Integer status;
	/**sku代码**/
	private String skuCode;
	/**skuId**/
	private Integer productSkuId;
	/**商品名称**/
	private String name;
	/**商品价格**/
	private BigDecimal unitPrice;
	private BigDecimal unitPriceF;
	private BigDecimal unitPriceB;
	/**库存**/
	private Integer inventory;
	/**满减商品表里的三个字段**/
	private BigDecimal actSettlePrice;
	private BigDecimal activityPrice;
	
	/**销量**/
	private Integer salesQuantity;
	private Integer salesQuantityF;
	private Integer salesQuantityB;
	
	/**重量**/
	private String weight;
	
	/**规格**/
	private String rule;
	
	/**商户id**/
	private Integer userId;
	
	/**商户名称**/
	private String username;
	
	/**一级分类**/
	private String kind1;
	/**二级分类**/
	private String kind2;
	/**商品类型串**/
	private String propIds;
	
	/**多个sku连接**/
	private String skuCodes;

	/**活动id**/
	private Integer marketActivityId;
	
	/**结算价**/
	private BigDecimal settlementPrice;
	/**结算价sku**/
	private BigDecimal skuSettlementPrice;
	/**活动结算价sku**/
	private BigDecimal skuSettlementPriceByActivity;
	
	/**列表类型：1:已选商品**/
	private Integer listType;
	
	/**渠道id**/
	private Integer channelId;
	private Integer couponActId;
	private Activity activity;
	/*图片封面*/
	private String coverPicture;
	//市场价
	private BigDecimal marketPrice;//市场价
	
	
	private Integer activityProductSort;//活动商品排序
	
	private Integer anchorCount;//锚点数
	
	private String anchorValue;//锚点值
	
	
	private Integer productId;//产品id
	
	private ProductShowProp productProp;//统计评价
	
	
	
	
	
	public String getAnchorValue() {
		return anchorValue;
	}
	public void setAnchorValue(String anchorValue) {
		this.anchorValue = anchorValue;
	}
	public ProductShowProp getProductProp() {
		return productProp;
	}
	public void setProductProp(ProductShowProp productProp) {
		this.productProp = productProp;
	}
	public Integer getProductId() {
		return productId;
	}
	public void setProductId(Integer productId) {
		this.productId = productId;
	}
	
	public Integer getActivityProductSort() {
		return activityProductSort;
	}
	public void setActivityProductSort(Integer activityProductSort) {
		this.activityProductSort = activityProductSort;
	}
	
	public Integer getAnchorCount() {
		return anchorCount;
	}
	public void setAnchorCount(Integer anchorCount) {
		this.anchorCount = anchorCount;
	}
	public BigDecimal getMarketPrice() {
		return marketPrice;
	}
	public void setMarketPrice(BigDecimal marketPrice) {
		this.marketPrice = marketPrice;
	}
	public String getCoverPicture() {
		return coverPicture;
	}
	public void setCoverPicture(String coverPicture) {
		this.coverPicture = coverPicture;
	}
	public Activity getActivity() {
		return activity;
	}
	public void setActivity(Activity activity) {
		this.activity = activity;
	}
	public Integer getSellType() {
		return sellType;
	}
	public void setSellType(Integer sellType) {
		this.sellType = sellType;
	}
	public Integer getSellType4() {
		return sellType4;
	}
	public void setSellType4(Integer sellType4) {
		this.sellType4 = sellType4;
	}
	public String getSellTypeStr() {
		return sellTypeStr;
	}
	public void setSellTypeStr(String sellTypeStr) {
		this.sellTypeStr = sellTypeStr;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	public String getSkuCode() {
		return skuCode;
	}
	public void setSkuCode(String skuCode) {
		this.skuCode = skuCode;
	}
	public Integer getProductSkuId() {
		return productSkuId;
	}
	public void setProductSkuId(Integer productSkuId) {
		this.productSkuId = productSkuId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public BigDecimal getUnitPrice() {
		return unitPrice;
	}
	public void setUnitPrice(BigDecimal unitPrice) {
		this.unitPrice = unitPrice;
	}
	public BigDecimal getUnitPriceF() {
		return unitPriceF;
	}
	public void setUnitPriceF(BigDecimal unitPriceF) {
		this.unitPriceF = unitPriceF;
	}
	public BigDecimal getUnitPriceB() {
		return unitPriceB;
	}
	public void setUnitPriceB(BigDecimal unitPriceB) {
		this.unitPriceB = unitPriceB;
	}
	public Integer getInventory() {
		return inventory;
	}
	public void setInventory(Integer inventory) {
		this.inventory = inventory;
	}
	public BigDecimal getActSettlePrice() {
		return actSettlePrice;
	}
	public void setActSettlePrice(BigDecimal actSettlePrice) {
		this.actSettlePrice = actSettlePrice;
	}

	public BigDecimal getActivityPrice() {
		return activityPrice;
	}
	public void setActivityPrice(BigDecimal activityPrice) {
		this.activityPrice = activityPrice;
	}
	public Integer getSalesQuantity() {
		return salesQuantity;
	}
	public void setSalesQuantity(Integer salesQuantity) {
		this.salesQuantity = salesQuantity;
	}
	public Integer getSalesQuantityF() {
		return salesQuantityF;
	}
	public void setSalesQuantityF(Integer salesQuantityF) {
		this.salesQuantityF = salesQuantityF;
	}
	public Integer getSalesQuantityB() {
		return salesQuantityB;
	}
	public void setSalesQuantityB(Integer salesQuantityB) {
		this.salesQuantityB = salesQuantityB;
	}
	public String getWeight() {
		return weight;
	}
	public void setWeight(String weight) {
		this.weight = weight;
	}
	public String getRule() {
		return rule;
	}
	public void setRule(String rule) {
		this.rule = rule;
	}
	public Integer getUserId() {
		return userId;
	}
	public void setUserId(Integer userId) {
		this.userId = userId;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getKind1() {
		return kind1;
	}
	public void setKind1(String kind1) {
		this.kind1 = kind1;
	}
	public String getKind2() {
		return kind2;
	}
	public void setKind2(String kind2) {
		this.kind2 = kind2;
	}
	public String getPropIds() {
		return propIds;
	}
	public void setPropIds(String propIds) {
		this.propIds = propIds;
	}
	public String getSkuCodes() {
		return skuCodes;
	}
	public void setSkuCodes(String skuCodes) {
		this.skuCodes = skuCodes;
	}
	public Integer getMarketActivityId() {
		return marketActivityId;
	}
	public void setMarketActivityId(Integer marketActivityId) {
		this.marketActivityId = marketActivityId;
	}
	public BigDecimal getSettlementPrice() {
		return settlementPrice;
	}
	public void setSettlementPrice(BigDecimal settlementPrice) {
		this.settlementPrice = settlementPrice;
	}
	public BigDecimal getSkuSettlementPrice() {
		return skuSettlementPrice;
	}
	public void setSkuSettlementPrice(BigDecimal skuSettlementPrice) {
		this.skuSettlementPrice = skuSettlementPrice;
	}
	public BigDecimal getSkuSettlementPriceByActivity() {
		return skuSettlementPriceByActivity;
	}
	public void setSkuSettlementPriceByActivity(
			BigDecimal skuSettlementPriceByActivity) {
		this.skuSettlementPriceByActivity = skuSettlementPriceByActivity;
	}
	public Integer getListType() {
		return listType;
	}
	public void setListType(Integer listType) {
		this.listType = listType;
	}
	public Integer getChannelId() {
		return channelId;
	}
	public void setChannelId(Integer channelId) {
		this.channelId = channelId;
	}
	public Integer getCouponActId() {
		return couponActId;
	}
	public void setCouponActId(Integer couponActId) {
		this.couponActId = couponActId;
	}
	
	
	
}
