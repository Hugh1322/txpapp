package com.txp.app.contants;

import com.txp.app.util.excel.ExcelField;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * 用户信息
 * 
 * @author th
 * 
 */
public class UserInfo extends UserInfoTbl {
	public static final Short SUPPLIER_TYPE_DEFAULT = 0; // 请选择
	public static final Short SUPPLIER_TYPE_MANUFACTURER = 1; // 厂商
	public static final Short SUPPLIER_TYPE_AGENCY = 2; // 总代理
	public static final Short SUPPLIER_TYPE_FIRST_AGENCY = 3; // 一级代理
	public static final Short SUPPLIER_TYPE_SECOND_AGENCY = 4; // 二级代理
	
	public static final Integer USER_TEL_STATE_0 = 0; // 手机没验证
	public static final Integer USER_TEL_STATE_1 = 1; // 手机验证过
	public static final Integer USER_MAIL_STATE_0 = 0; // 邮箱没验证
	public static final Integer USER_MAIL_STATE_1 = 1; // 邮箱验证过
	
	public static final Integer USER_LOGINSTATE_0 = 0; // 用户登录
	public static final Integer USER_LOGINSTATE_1 = 1; // 用户未登录
	
	public static final Integer SOME_AREA=1;//部分包邮
	public static final Integer ALL_AREA=2;//全部包邮
	public static final Integer NO_AREA=3;//全部包邮
	
	public static final Short[] SUPPLIER_TYPES = new Short[] {
			SUPPLIER_TYPE_DEFAULT, SUPPLIER_TYPE_MANUFACTURER,
			SUPPLIER_TYPE_AGENCY, SUPPLIER_TYPE_FIRST_AGENCY,
			SUPPLIER_TYPE_SECOND_AGENCY };

	/** 品牌名称 */
//	@ExcelField(filedName="可售品牌" ,sort=7)
	private String brandNames;

	public static final Integer USER_ROLE_BUYER = 100000; // 买家
	public static final Integer USER_ROLE_SELLER = 100003; // 商家
	public static final Integer USER_ROLE_ADMIN = 100002; // 管理员

	public static final Short GENDER_MALE = 1; // 男
	public static final Short GENDER_FEMALE = 0; // 女

	/** 买家账号 */
	public static final Integer USER_TYPE_CUSTOMER = 2;
	/** 管理员账号 */
	public static final Integer USER_TYPE_MANAGER = 3;
	/** 商家账号 */
	public static final Integer USER_TYPE_SELLER = 1;
	/** 管理员子账号 */
	public static final Integer USER_TYPE_MANAGER_SON = 31;
	/** 商家子账号 */
	public static final Integer USER_TYPE_SELLER_SON = 11;
	protected String shiperRegionCodes; // 发货地址codes
	protected String receiverRegionCodes; // 退货地址codes
	protected String companyRegionCodes; // 公司地址codes
	private RegionModel companyModel; // 新的地址插件 公司地址
	private RegionModel shiperModel; // 新的地址插件 发货地址
	private RegionModel receiverModel; // 新的地址插件 退货地址
//	protected List<Product> products;
//	protected List<ProductSku> productSkus;// 卖家对应的商品
	protected List<Integer> listBrandIds; // 记录选择的品牌
	protected Integer brandId; // 记录选择的品牌id
	protected String brandIds; // 记录用户选择的ids
//	private UserAddress userAddress; // 用户的默认收货地址
//	private User user;
	private int orderCount; // 记录订单数量
	private int allSaleNum; //记录总销量
	private BigDecimal totalPostagePrice; //记录总运费
	private int productTotalNum;  //产品总数
	private int productSaleNum; //在售产品数量
	
	private Date payTime; // 记录总交易金额
	private Integer brandCityId; // 记录总交易金额
	private BigDecimal totalPrice; // 记录总交易金额
	private BigDecimal totalSellInspire; // 总激励金额
//	private Point point; // 记录用户积分
//	private Region region;
	protected String newPassword;
	protected String confirmNewPassword;
	@ExcelField(filedName="登陆名" ,sort=1)
	private String loginName;
//	private City city;
	private List<String> postageCity;//包邮城市
	private List<String> countyCity;//包邮城市
//	private List<UserRegion> regions;
	private String deliveryAddress;
	private String senderAddress;//发货地址
	
	private String userName;
	
	
	
	private String refundYichenpin;//是否退换货至一城一品
	
	
	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public List<String> getCountyCity() {
		return countyCity;
	}

	public void setCountyCity(List<String> countyCity) {
		this.countyCity = countyCity;
	}

	public List<String> getPostageCity() {
		return postageCity;
	}

	public void setPostageCity(List<String> postageCity) {
		this.postageCity = postageCity;
	}

	public String getLoginName() {
		return loginName;
	}

	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	
	public Integer getBrandCityId() {
		return brandCityId;
	}

	public void setBrandCityId(Integer brandCityId) {
		this.brandCityId = brandCityId;
	}

	public String getNewPassword() {
		return newPassword;
	}

	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}

	public String getConfirmNewPassword() {
		return confirmNewPassword;
	}

	public void setConfirmNewPassword(String confirmNewPassword) {
		this.confirmNewPassword = confirmNewPassword;
	}

	public int getOrderCount() {
		return orderCount;
	}

	public void setOrderCount(int orderCount) {
		this.orderCount = orderCount;
	}

	public BigDecimal getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(BigDecimal totalPrice) {
		this.totalPrice = totalPrice;
	}

	public Date getPayTime() {
		return payTime;
	}

	public void setPayTime(Date payTime) {
		this.payTime = payTime;
	}

	public String getBrandNames() {
		return brandNames;
	}

	public void setBrandNames(String brandNames) {
		this.brandNames = brandNames;
	}

	public RegionModel getCompanyModel() {
		return companyModel;
	}

	public void setCompanyModel(RegionModel companyModel) {
		this.companyModel = companyModel;
	}

	public RegionModel getShiperModel() {
		return shiperModel;
	}

	public void setShiperModel(RegionModel shiperModel) {
		this.shiperModel = shiperModel;
	}

	public RegionModel getReceiverModel() {
		return receiverModel;
	}

	public void setReceiverModel(RegionModel receiverModel) {
		this.receiverModel = receiverModel;
	}

	public String getShiperRegionCodes() {
		return shiperRegionCodes;
	}

	public void setShiperRegionCodes(String shiperRegionCodes) {
		this.shiperRegionCodes = shiperRegionCodes;
	}

	public String getReceiverRegionCodes() {
		return receiverRegionCodes;
	}

	public void setReceiverRegionCodes(String receiverRegionCodes) {
		this.receiverRegionCodes = receiverRegionCodes;
	}

	public String getCompanyRegionCodes() {
		return companyRegionCodes;
	}

	public void setCompanyRegionCodes(String companyRegionCodes) {
		this.companyRegionCodes = companyRegionCodes;
	}


	public List<Integer> getListBrandIds() {
		return listBrandIds;
	}

	public void setListBrandIds(List<Integer> listBrandIds) {
		this.listBrandIds = listBrandIds;
	}

	public Integer getBrandId() {
		return brandId;
	}

	public void setBrandId(Integer brandId) {
		this.brandId = brandId;
	}

	public String getBrandIds() {
		return brandIds;
	}

	public void setBrandIds(String brandIds) {
		this.brandIds = brandIds;
	}
	public static Short getSupplierTypeDefault() {
		return SUPPLIER_TYPE_DEFAULT;
	}

	public static Short getSupplierTypeManufacturer() {
		return SUPPLIER_TYPE_MANUFACTURER;
	}

	public static Short getSupplierTypeAgency() {
		return SUPPLIER_TYPE_AGENCY;
	}

	public static Short getSupplierTypeFirstAgency() {
		return SUPPLIER_TYPE_FIRST_AGENCY;
	}

	public static Short getSupplierTypeSecondAgency() {
		return SUPPLIER_TYPE_SECOND_AGENCY;
	}

	public static Short[] getSupplierTypes() {
		return SUPPLIER_TYPES;
	}

	public String getDeliveryAddress() {
		return deliveryAddress;
	}

	public void setDeliveryAddress(String deliveryAddress) {
		this.deliveryAddress = deliveryAddress;
	}
	
	public int getAllSaleNum() {
		return allSaleNum;
	}

	public void setAllSaleNum(int allSaleNum) {
		this.allSaleNum = allSaleNum;
	}

	public BigDecimal getTotalPostagePrice() {
		return totalPostagePrice;
	}

	public void setTotalPostagePrice(BigDecimal totalPostagePrice) {
		this.totalPostagePrice = totalPostagePrice;
	}

	public int getProductTotalNum() {
		return productTotalNum;
	}

	public void setProductTotalNum(int productTotalNum) {
		this.productTotalNum = productTotalNum;
	}

	public int getProductSaleNum() {
		return productSaleNum;
	}

	public void setProductSaleNum(int productSaleNum) {
		this.productSaleNum = productSaleNum;
	}

	public String getSecurityLevel() {
		Integer telState = getTelCheckState();
		Integer mailState = getMailCheckState();
		if (USER_TEL_STATE_1.equals(telState) && USER_MAIL_STATE_1.equals(mailState)) {
			return "高";
		} else if (USER_TEL_STATE_1.equals(telState) || USER_MAIL_STATE_1.equals(mailState)) {
			return "中";
		}
		return "低";
	}

	public BigDecimal getTotalSellInspire() {
		return totalSellInspire;
	}

	public void setTotalSellInspire(BigDecimal totalSellInspire) {
		this.totalSellInspire = totalSellInspire;
	}

	public void setRefundYichenpin(String refundYichenpin) {
		this.refundYichenpin = refundYichenpin;
	}

	public String getRefundYichenpin() {
		return refundYichenpin;
	}

	public String getSenderAddress() {
		return senderAddress;
	}

	public void setSenderAddress(String senderAddress) {
		this.senderAddress = senderAddress;
	}
	
}
