package com.txp.app.contants;

import java.io.Serializable;
import java.util.List;


/** 广告位
 * @author zengzhiming
 *
 */
public class AdvPosition extends AdvPositionTbl implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 2401614763674808312L;
	/** 广告明细	 */
	private List<Advertisement> advs;
	/**所在地	 */
	public static  final String  ADRESS_PRODUCT="ADRESS_PRODUCT";
	/**轮播图	 */
	public static  final String  SHUFFLING_FIGURE="SHUFFLING_FIGURE";
	/**商品分类	 */
	public static final String PRODUCT_CATEGORY="PRODUCT_CATEGORY";
	/**城市精选	 */
	public static final String CITY_SELECT="CITY_SELECT";
	/**热销商品	 */
	public static final String HOT_PRODUCT="HOT_PRODUCT";
	/**首页每日推荐	 */
	public static final String EVERYDAY_RECOMMEND="EVERYDAY_RECOMMEND";
	/** 地方特产 */
	public static final String LOCAL_SPECIALITY="LOCAL_SPECIALITY";
	/** 分类导航广告位 */
	public static final String KIND_ADVERTISEMENT="KIND_ADVERTISEMENT";
	
	/** 当季商品 */
	public static final String SEASONAL_GOODS="SEASONAL_GOODS";
	
	public static final String HOME_RIGHT_ADV_185 = "HOME_RIGHT_ADV_185";
	public static final String HOME_RIGHT_ADV_180 = "HOME_RIGHT_ADV_180";
	/** 瀑布流廣告 */
	public static final String HOME_CENTER_ADV = "HOME_CENTER_ADV";
	
	
	/**团购	 */
	public static final String GROUP_PRODUCT="GROUP_PRODUCT";

	/**首页伸缩图	 */
	public static final String INDEX_BANNER = "INDEX_BANNER";
	/**热词 */
	public static final String HOT_WORD = "HOT_WORD";
	/**分类广告 */
	public static final String CATEGORY_ADV = "CATEGORY_ADV";
	/**优惠券广告 */
	public static final String COUPON_ADV = "COUPON_ADV";
	
	/**  隐藏 */
	public static final int FLAG_HIDDEN=1;
	/**  显示 */
	public static final int FLAG_SHOW=0;

	public List<Advertisement> getAdvs() {
		return advs;
	}

	public void setAdvs(List<Advertisement> advs) {
		this.advs = advs;
	}
	
	public boolean isShow(){
		return getHidden() != FLAG_HIDDEN;
	}
	
	
	
}
