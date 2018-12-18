package com.txp.app.contants;

import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * <p>
 * ClassName: Product
 * </p>
 * <p>
 * Description: 商品
 * </p>
 * <p>
 * Author: 
 * </p>
 * <p>
 * Date: Dec 12, 2013
 * </p>
 */

public class Product extends ProductTbl implements Serializable{

	/**
     * <p>Field serialVersionUID: serialVersionUID</p>
     */
    private static final long serialVersionUID = -5570185486897879878L;
    
    public static final Short ISDELETE_NO = 0; // 否
	public static final Short ISDELETE_YES = 1; // 是
	/**
	 * 是否跨境商品
	 */
	public static final Short ISOVERSEAS_NO = 0; // 否
	public static final Short ISOVERSEAS_YES = 1; // 是
	/**
	 * 运营模式
	 */
	public static final Short OPERATIONMODE_DIRECT = 0; // 海外直发
	public static final Short OPERATIONMODE_NOT_DIRECT = 1; // 国内现货
    
	public static final Short STATUS_DRAFT = 1; 	// 草稿
	public static final Short STATUS_SELL = 6; 		// 销售中
	public static final Short STATUS_SELLOUT = 7; 	// 已售磬
	public static final Short STATUS_INVALID = 8; 	// 下架
	public static final Short STATUS_DELETE = 9; // 删除
	
	public static final Short STATUS_CHECK_PEND = 2; 	 // 待审核
	public static final Short STATUS_PASS = 3; 			 // 审核通过--->已上架
	public static final Short STATUS_NO_PASS = 4; 		 // 审核不通过
	public static final Short STATUS_WAITING_SAMPLE = 10; // 样品待发
	public static final Short STATUS_WAITING_REVIEW = 11; // 待复核
	public static final Short STATUS_WAINTING_MAKING = 12; // 待制作
	public static final Short STATUS_IN_SERVICE = 13; 	  // 制作中
	public static final Short STATUS_VALID = 14; 	  	  // 已上架   这个值数据库中不会存在，待删除
	public static final Short STATUS_WAINTING_INVALID = 15;	  //在售商品下架待审核
	
	public static final Short SELLTYPE_YS = 2;// 预售类型
	public static final Short SELLTYPE_XS = 1;// 销售类型
	public static final Short SELLTYPE_QG = 3;// 抢购类型
	public static final Short SELLTYPE_TG = 4;// 团购类型
	public static final Short SELLTYPE_US = 5;// 分期送类型
	public static final Short SELLTYPE_SC = 8;// 零元试吃

	public static final Short PAYTYPE_ONLINE = 1;// 在线支付
	public static final Short PAYTYPE_ONLINE_COD= 2;// 在线支付，货到付款都支持
	
	/** 团购前**/
	public static final Short GROUP_STATUS_PEND = 6;
	/** 团购中 **/
	public static final Short GROUP_STATUS_ON = 7;
	/** 已抢光 **/
	public static final Short GROUP_STATUS_STOCKOUT = 8;
	/** 已过期 **/
	public static final Short GROUP_STATUS_EXPIRED = 9;
	
	public static final String TYPE_AREA = "area";//产地
	public static final String TYPE_CATALOG = "catalog";//分类
	public static final String TYPE_PEOPLE = "adaptPeople";

	// 后台商品状态
	public static final Short[] STATUSES = new Short[] {STATUS_DRAFT,STATUS_SELL, STATUS_SELLOUT,STATUS_INVALID};//,STATUS_DELETE };
	
	//管理员商品状态
	public static final Short[] ADMINSTATUSES = new Short[] {STATUS_DRAFT,STATUS_SELL, STATUS_SELLOUT,STATUS_INVALID ,STATUS_DELETE,STATUS_DELETE,STATUS_CHECK_PEND,STATUS_PASS,STATUS_NO_PASS };
	
	// 后台商品状态
	public static final Short[] FRONTSTATUSES = new Short[] {STATUS_DRAFT,STATUS_SELL, STATUS_SELLOUT ,STATUS_INVALID};//,STATUS_DELETE};
	// 审核状态
	public static final Short[] REVIEWSTATUSES = new Short[] {STATUS_CHECK_PEND, STATUS_WAITING_SAMPLE, STATUS_WAITING_REVIEW,STATUS_WAINTING_MAKING,STATUS_IN_SERVICE,STATUS_PASS,STATUS_NO_PASS,STATUS_WAINTING_INVALID };

	public static final Short IS_SHOW_INVENTORY_NO = 0;// 不显示库存
	public static final Short IS_SHOW_INVENTORY_YES = 1;// 显示库存
	public static final Short[] ISSHOWINVENTORYS = new Short[] {IS_SHOW_INVENTORY_NO, IS_SHOW_INVENTORY_YES };

	protected Brand brand; // 关联品牌
//	protected List<ProductSku> productSkus; // 关联商品SKU
//	protected List<SkuOption> skuOptions; // 商品SKU信息
	protected Integer salesNum; // 商品销售次数
	protected Integer productSkuColorNum;
	protected Integer productSkuSizeNum;
//	protected ProductSku productSku;
//	protected Sale sale;
	// 图片集合
	protected List<String> imageList;
	protected String defaultImage;
	protected int inventory;// 商品库存
	protected int sellStatus;
	protected Date preSellTime;// 预发售时间
	protected String skuCode;
	protected String name;// 商品名称
	protected Integer orderTotalNum;// 商品订单总数
//	protected Map<String,List<Prop>> propsMap;
//	protected Zone zone;
	protected Integer totalInventory;// 总库存
//	protected List<ProductProp> ppList;
	protected String areaStr;		//原产地信息

//	protected GroupItem groupItem;

	public  Short groupStatus;   //商品团购状态
	
	protected String zoneSaleImage;//专区销售图片
	
	protected String others;	   // 其他原因下架
	
	protected String operatorName;//操作人名字
	
	protected String applicantName; // 提报人名字

	private List<Integer> scheduleConfigIds; // 分期送计划配置id集合
	// 商品支付类型 1:在线支付 2:在线支付+货到付款
	protected Short payType;
	
//	protected List<ProductAuditLog> auditLogs; //商品审核操作日志记录

	private String channelNameStr;//商品所属频道拼接信息
	
	private String channelIdStr;//商品所属频道拼接信息
	
	private String sellerName;//商家名称
	
//	private ProductShowProp productShowProp;//商品显示相关
	
	private Integer productLabelId;// 商品标签ID
	private String labelImgUrl;// 商品标签ID
	/**
	 * 发货省
	 */
	private String deliveryP;
	/**
	 * 发货市
	 */
	private String deliveryC;
	/**
	 * 发货省regionId
	 */
	private String deliveryPId;
	
	/**国家id**/
	private String nation;
	/**类目**/
	private String firstcatalog;
	
	public String getDeliveryPId() {
		return deliveryPId;
	}

	public void setDeliveryPId(String deliveryPId) {
		this.deliveryPId = deliveryPId;
	}

	public String getDeliveryP() {
		return deliveryP;
	}

	public void setDeliveryP(String deliveryP) {
		this.deliveryP = deliveryP;
	}

	public String getDeliveryC() {
		return deliveryC;
	}

	public void setDeliveryC(String deliveryC) {
		this.deliveryC = deliveryC;
	}

	public Integer getProductLabelId() {
		return productLabelId;
	}

	public void setProductLabelId(Integer productLabelId) {
		this.productLabelId = productLabelId;
	}

	
	public String getChannelIdStr() {
		return channelIdStr;
	}

	public void setChannelIdStr(String channelIdStr) {
		this.channelIdStr = channelIdStr;
	}
	
	public String getSellerName() {
		return sellerName;
	}

	public void setSellerName(String sellerName) {
		this.sellerName = sellerName;
	}

	public String getChannelNameStr() {
		return channelNameStr;
	}

	public void setChannelNameStr(String channelNameStr) {
		this.channelNameStr = channelNameStr;
	}

	public List<Integer> getScheduleConfigIds() {
		return scheduleConfigIds;
	}

	public void setScheduleConfigIds(List<Integer> scheduleConfigIds) {
		this.scheduleConfigIds = scheduleConfigIds;
	}
	
	public String getApplicantName() {
		return applicantName;
	}

	public void setApplicantName(String applicantName) {
		this.applicantName = applicantName;
	}

	/**
	 * 产品的多个产地拼接(ex:东北|黑龙江|哈尔滨)
	 * **/
//	public String getAreaStr() {
//		StringBuffer propSb = new StringBuffer();
//		if (propsMap != null) {
//			List<Prop> props = propsMap.get("area");
//			if(props != null){
//				for (int i = 0; i < props.size(); i++) {
//					if (props.size() == i + 2) {
//						propSb.append(props.get(i).getName() + " | ");
//					} else {
//						propSb.append(props.get(i).getName());
//					}
//				}
//			}
//		}
//		String propStr=propSb.toString();
//		if(propStr!=null&&propStr.length()>=10){
//			return propStr.substring(0, 10)+"...";
//		}else{
//			return propStr;
//		}
//	}

	public Short getGroupStatus() {
		return groupStatus;
	}


	public void setGroupStatus(Short groupStatus) {
		this.groupStatus = groupStatus;
	}

	public String getSkuCode() {
		return skuCode;
	}

	public void setSkuCode(String skuCode) {
		this.skuCode = skuCode;
	}
	
	/**
	 * <p>
	 * Field productSkuId: 商品SKUID
	 * </p>
	 */
	protected Integer productSkuId;
	
	/**
	 * <p>Field skuSpecification: 商品规格</p>
	 */
	protected String skuSpecification;

	/**
	 * <p>
	 * Field rank: 商品权重
	 * </p>
	 */
	protected Integer rank;

	/**
	 * <p>
	 * Field unitPrice: 单价
	 * </p>
	 */
	protected BigDecimal unitPrice;
	protected BigDecimal marketPrice;
	
	public String getCoverPicture(){
		//return this.getDefaultImage();
		return coverPicture;
	}

	/**
	 * 获取商品第一张默认图片，添加相应前后缀可以访问缩略图
	 * 
	 * @return
	 */
//	public String getDefaultImage() {
//		String thumbnail = null;
//		if (StringUtils.isNotEmpty(imageUrls)) {
//			String[] thumbnails = imageUrls.split(",");
//			thumbnail = thumbnails != null && thumbnails.length > 0 ? thumbnails[0]
//					: "";
//		}
//		return thumbnail;
//	}
//
//	public List<String> getImageList() {
//		List<String> list = new ArrayList<String>();
//
//		String[] str = null;
//		if(StringUtils.isNotBlank(this.imageUrls)){
//			str = imageUrls.split(",");
//			list = Arrays.asList(str);
//		}
//		return list;
//	}

	public BigDecimal getMarketPrice() {
		return marketPrice;
	}

	public void setMarketPrice(BigDecimal marketPrice) {
		this.marketPrice = marketPrice;
	}

	public Brand getBrand() {
		return brand;
	}

	public void setBrand(Brand brand) {
		this.brand = brand;
	}

	public int getSellStatus() {
		return sellStatus;
	}

	public void setSellStatus(int sellStatus) {

		this.sellStatus = sellStatus;
	}

	public Date getPreSellTime() {
		return preSellTime;
	}

	public void setPreSellTime(Date preSellTime) {
		this.preSellTime = preSellTime;
	}

	public int getInventory() {
		return inventory;
	}

	public void setInventory(int inventory) {
		this.inventory = inventory;
	}

	public Integer getSalesNum() {
		return salesNum;
	}

	public void setSalesNum(Integer salesNum) {
		this.salesNum = salesNum;
	}

	public Integer getProductSkuColorNum() {
		return productSkuColorNum;
	}

	public void setProductSkuColorNum(Integer productSkuColorNum) {
		this.productSkuColorNum = productSkuColorNum;
	}

	public Integer getProductSkuSizeNum() {
		return productSkuSizeNum;
	}

	public void setProductSkuSizeNum(Integer productSkuSizeNum) {
		this.productSkuSizeNum = productSkuSizeNum;
	}

	@Override
	public String toString() {
		return productId + "-->" + name;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getTotalInventory() {
		return totalInventory;
	}

	public void setTotalInventory(Integer totalInventory) {
		this.totalInventory = totalInventory;
	}

	/**
	 * <p>
	 * Description: 商品权重
	 * </p>
	 * 
	 * @return the rank
	 */
	public Integer getRank() {
		return this.rank;
	}

	/**
	 * <p>
	 * Description: 商品权重
	 * </p>
	 * 
	 * @param rank
	 *            the rank to set
	 */
	public void setRank(Integer rank) {
		this.rank = rank;
	}

	/**
	 * <p>
	 * Description: 单价
	 * </p>
	 * 
	 * @return the unitPrice
	 */
	public BigDecimal getUnitPrice() {
		return this.unitPrice;
	}

	/**
	 * <p>
	 * Description: 单价
	 * </p>
	 * 
	 * @param unitPrice
	 *            the unitPrice to set
	 */
	public void setUnitPrice(BigDecimal unitPrice) {
		this.unitPrice = unitPrice;
	}
   
	/**
	 * <p>
	 * Description: 商品SKUID
	 * </p>
	 * 
	 * @return the productSkuId
	 */
	public Integer getProductSkuId() {
		return this.productSkuId;
	}

	/**
	 * <p>
	 * Description: 商品SKUID
	 * </p>
	 * 
	 * @param productSkuId
	 *            the productSkuId to set
	 */
	public void setProductSkuId(Integer productSkuId) {
		this.productSkuId = productSkuId;
	}
	
	/**
	 * <p>Description: 商品规格</p>
	 * @return the skuSpecification
	 */
	public String getSkuSpecification() {
		return this.skuSpecification;
	}
	/**
	 * <p>Description: 商品规格</p>
	 * @param skuSpecification the skuSpecification to set
	 */
	public void setSkuSpecification(String skuSpecification) {
		this.skuSpecification = skuSpecification;
	}
	
	public String getZoneSaleImage() {
		return zoneSaleImage;
	}

	public void setZoneSaleImage(String zoneSaleImage) {
		this.zoneSaleImage = zoneSaleImage;
	}

	public Integer getOrderTotalNum() {
		return orderTotalNum;
	}

	public void setOrderTotalNum(Integer orderTotalNum) {
		this.orderTotalNum = orderTotalNum;
	}

	public String getOthers() {
		return others;
	}

	public void setOthers(String others) {
		this.others = others;
	}

	public String getOperatorName() {
		return operatorName;
	}

	public void setOperatorName(String operatorName) {
		this.operatorName = operatorName;
	}

	public Short getPayType() {
		return payType;
	}

	public void setPayType(Short payType) {
		this.payType = payType;
	}
	
	public String getLabelImgUrl() {
		return labelImgUrl;
	}

	public void setLabelImgUrl(String labelImgUrl) {
		this.labelImgUrl = labelImgUrl;
	}

	public String getNation() {
		return nation;
	}

	public void setNation(String nation) {
		this.nation = nation;
	}

	public String getFirstcatalog() {
		return firstcatalog;
	}

	public void setFirstcatalog(String firstcatalog) {
		this.firstcatalog = firstcatalog;
	}
	
}
