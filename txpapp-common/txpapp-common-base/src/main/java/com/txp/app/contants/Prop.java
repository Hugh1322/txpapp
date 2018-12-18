package com.txp.app.contants;

import java.util.List;
import java.util.Map;


/**
 * @作者：罗典
 * @时间：2014-01-10
 * @描述：层级分类属性实体
 * */
public class Prop extends PropTbl {
	/**
	 * 
	 */
	private static final long serialVersionUID = -9220010487898694955L;
	// 原产地
	public static final int LEVEL_PLACE = 0;
	// 大区
	public static final int LEVEL_REGION = 1;
	// 省份
	public static final int LEVEL_PROVINCE = 2;
	// 城市
	public static final int LEVEL_CITY = 3;

	// 国家级别
	public static final String CODE_NATION = "1000";
	// 类目级别
	public static final String CODE_FIRST = "1002";
	// 原产编码海外
	public static final String CODE_PLACE_FOREIGH= "9999";
	// 原产编码
	public static final String CODE_PLACE = "10000";
	// 商品分类
	public static final String CODE_PRODUCT = "10001";
	// 适用人群
	public static final String CODE_PEOPLE = "10002";

	// 有效
	public static final int STATUS_NORMAL = 1;
	// 无效
	public static final int STATUS_INVALID = 2;
	// 草稿
	public static final int STATUS_DRAFT = 3;
	// 父级编码
	public String parentCode;
	// 分页查询起始页
	public Integer start ;
	// 分页查询显示条数
	public Integer limit;
	// 下一集层级集合
	public List<Prop> childrenPropList;
	
	//分类广告图片的路径和图片的目标地址
	private String imgUrl;
	private String imgTargetUrl;
	
	//分类广告品牌广告
	private List<PropKindImg> propKindBrand;
	private Map bigCategoryADList;
	private Map productADList;
	
	public Map getProductADList() {
		return productADList;
	}

	public void setProductADList(Map productADList) {
		this.productADList = productADList;
	}

	public Map getBigCategoryADList() {
		return bigCategoryADList;
	}

	public void setBigCategoryADList(Map bigCategoryADList) {
		this.bigCategoryADList = bigCategoryADList;
	}

	public int getStatusNormal() {
		return Prop.STATUS_NORMAL;
	}

	public int getStatusInvalid() {
		return Prop.STATUS_INVALID;
	}

	public int getStatusDraft(){
		return Prop.STATUS_DRAFT;
	}
	
	public int getLevel_region() {
		return LEVEL_REGION;
	}

	public int getLevel_province() {
		return LEVEL_PROVINCE;
	}

	public int getLevel_city() {
		return LEVEL_CITY;
	}
	
	public String getCode_Place(){
		return CODE_PLACE;
	}
	
	public String getCode_Product(){
		return CODE_PRODUCT;
	}
		
	public Integer getStart() {
		return start;
	}

	public void setStart(Integer start) {
		this.start = start;
	}

	public Integer getLimit() {
		return limit;
	}

	public void setLimit(Integer limit) {
		this.limit = limit;
	}

	public String getParentCode() {
		return parentCode;
	}

	public void setParentCode(String parentCode) {
		this.parentCode = parentCode;
	}

	public List<Prop> getChildrenPropList() {
		return childrenPropList;
	}

	public void setChildrenPropList(List<Prop> childrenPropList) {
		this.childrenPropList = childrenPropList;
	}

	public String getImgUrl() {
		return imgUrl;
	}

	public void setImgUrl(String imgUrl) {
		this.imgUrl = imgUrl;
	}

	public String getImgTargetUrl() {
		return imgTargetUrl;
	}

	public void setImgTargetUrl(String imgTargetUrl) {
		this.imgTargetUrl = imgTargetUrl;
	}

	public List<PropKindImg> getPropKindBrand() {
		return propKindBrand;
	}

	public void setPropKindBrand(List<PropKindImg> propKindBrand) {
		this.propKindBrand = propKindBrand;
	}

	
}
