/**
 * Brand.java
 * Created at Dec 4, 2013
 * Created by kuiYang
 * Copyright (C) 2013 SHANGHAI YUANTONG XINGLONG E-Business, All rights reserved.
 */
package com.txp.app.contants;

import java.io.Serializable;
import java.util.List;


/**
 * <p>
 * ClassName: Brand
 * </p>
 * <p>
 * Description: 品牌
 * </p>
 * <p>
 * Author: Kui.Yang
 * </p>
 * <p>
 * Date: Dec 4, 2013
 * </p>
 */
public class Brand extends BrandTbl implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 6772547216535781651L;
	
	protected ProductCategory productCategory;
	protected List<Product> products;
//	private ProductSku productSku;
//	private BrandShowProp brandShowProp;
	//记录该商家是否选择了该品牌
	protected Boolean isChecked;
	protected UserInfo userInfo;
	//作为界面div的id，用于分类动态生成品牌列表
	protected String firstLetter;
	protected String productCategoryName;
	
	//品牌介绍  是否有历史的热卖记录
	protected Boolean isHistoryRecord;
	//是否显示在首页
	protected boolean isCheck = false;
//	protected City city;
	private String productTypeName;
	private String areaName;
	public static final Short ISFORBIDDEN_STATUS= 0;
	
	/**
     * <p>
     * Field ISFORBIDDEN_NO_FORBIDDEN: 启用
     * </p>
     */
    public static final Short ISFORBIDDEN_NO_FORBIDDEN = 0;
    
    public static final Short ISFORBIDDEN_DEFAULT=2;

    /**
     * <p>
     * Field ISFORBIDDEN_FORBIDDEN: 禁用
     * </p>
     */
    public static final Short ISFORBIDDEN_FORBIDDEN = 1;
    
    
    public static final Short IS_STICK_TRUE = 1;//置顶
    public static final Short IS_STICK_FALSE = 0;//不是置顶
    
    public static final Short IS_DELETE_TRUE = 1;//已经删除
    public static final Short IS_DELETE_FALSE = 0;//没有删除
    
    
    public static final Short IS_RECOMMEND_TRUE = 1;//推荐为精选
    public static final Short IS_RECOMMEND_FALSE = 0;//不是精选
    
    public static final Short IS_PUBLISH_TRUE = 1;//已公布
    public static final Short IS_PUBLISH_FALSE = 0;//未公布
    /**
     * <p>
     * Description: 品牌创建时间
     * </p>
     * 
//     * @param foundationTime the foundationTime to set
     */
//    public void setFoundationTime(String foundationTime) {
//        if(foundationTime == null || "".equals(foundationTime)){
//            this.foundationTime  = null;
//        }else{
//            this.foundationTime = DateUtil.valueof(foundationTime,"yyyy");
//        }
//    }

//    /**
//     * (non-Javadoc)
//     * <p>
//     * Title: toString
//     * </p>
//     * <p>
//     * Description: 重写toString
//     * </p>
//     * 
//     * @return 当前类toString返回值
//     * @see java.lang.Object#toString()
//     */
//    @Override
//    public String toString() {
//        return this.brandId + "-->" + this.name;
//    }
//
//    /**
//     * (non-Javadoc)
//     * <p>
//     * Title: hashCode
//     * </p>
//     * <p>
//     * Description:重写hashCode
//     * </p>
//     * 
//     * @return 当前类对象ID值
//     * @see java.lang.Object#hashCode()
//     */
//    @Override
//    public int hashCode() {
//        return brandId;
//    }
//
//    /**
//     * (non-Javadoc)
//     * <p>
//     * Title: equals
//     * </p>
//     * <p>
//     * Description:重写equals
//     * </p>
//     * 
//     * @param brand 参与比较的对象
//     * @return
//     * @see java.lang.Object#equals(java.lang.Object)
//     */
//    @Override
//    public boolean equals(Object brand) {
//        if (null == brand) {
//            return false;
//        }
//        if (brand == this) {
//            return true;
//        }
//        if (brand instanceof Brand) {
//            return this.brandId.equals(((Brand) brand).brandId);
//        }
//        return false;
//    }

	public ProductCategory getProductCategory() {
		return productCategory;
	}

	public void setProductCategory(ProductCategory productCategory) {
		this.productCategory = productCategory;
	}

	public List<Product> getProducts() {
		return products;
	}

	public void setProducts(List<Product> products) {
		this.products = products;
	}

	public Boolean getIsChecked() {
		return isChecked;
	}

	public void setIsChecked(Boolean isChecked) {
		this.isChecked = isChecked;
	}

	public UserInfo getUserInfo() {
		return userInfo;
	}

	public void setUserInfo(UserInfo userInfo) {
		this.userInfo = userInfo;
	}

	public String getFirstLetter() {
		return firstLetter;
	}

	public void setFirstLetter(String firstLetter) {
		this.firstLetter = firstLetter;
	}

	public String getProductCategoryName() {
		return productCategoryName;
	}

	public void setProductCategoryName(String productCategoryName) {
		this.productCategoryName = productCategoryName;
	}

	public Boolean getIsHistoryRecord() {
		return isHistoryRecord;
	}

	public void setIsHistoryRecord(Boolean isHistoryRecord) {
		this.isHistoryRecord = isHistoryRecord;
	}

	public boolean isCheck() {
		return isCheck;
	}

	public void setCheck(boolean isCheck) {
		this.isCheck = isCheck;
	}

	public String getProductTypeName() {
		return productTypeName;
	}

	public void setProductTypeName(String productTypeName) {
		this.productTypeName = productTypeName;
	}

	public String getAreaName() {
		return areaName;
	}

	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}

}
