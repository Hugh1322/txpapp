package com.txp.app.contants;

import java.io.Serializable;


/**广告明细
 * @author zengzhiming
 *
 */
public class Advertisement extends AdvertisementTbl implements Serializable{
	
	
	
	
	/**
	 * 
	 */
	private static final long serialVersionUID = -6942563750465428575L;
	/** 多对一 广告位	 */
	private AdvPosition position;
	/** 对应商品分类或是所在地*/
	private Prop p;
	/** 正常	 */
	public static final Integer ADV_NORMAL=0;
	/** 删除  */
	public static final Integer ADV_DELETE=1;
	
	/** 非默认	 */
	public static final Integer ISDEFAULT_0=0;
	/** 默认  */
	public static final Integer ISDEFAULT_1=1;
	
	/**	热销特产处的大图*/
	public static final Short TYPE_BIG01=1;
	/**	热销特产处的横图*/
	public static final Short TYPE_CROSS04=4;
	public static final Short TYPE_CROSS05=5;
	/**	热销特产处的小图*/
	public static final Short TYPE_SMALL02=2;
	public static final Short TYPE_SMALL03=3;
	public static final Short TYPE_SMALL06=6;
	public static final Short TYPE_SMALL07=7;
	/**领券推荐广告图**/
	public static final Short TYPE_COUPON=12;
	
	/**默认地区广告位大小*/
	public static final Short ADV_DEAULT_NUM_ADDRESS=10;
	/**默认分类广告位大小*/
	public static final Short ADV_DEAULT_NUM_CATEGORY=15;
	/**	首页伸缩折叠图*/
	public static final Short INDEX_BANNER_TYPES_1=8;
	/**	首页伸缩展开图*/
	public static final Short INDEX_BANNER_TYPES_2=9;

	/**飘红**/
	public static final Short TYPE_COLOR_RED=12;
	/**非飘红**/
	public static final Short TYPE_COLOR_NOTRED=13;
	

	/**内层**/
	public static final Short TYPE_INNER=10;
	/**外层**/
	public static final Short TYPE_OUTER=11;
	// 后台商品状态
	public static final Short[] TYPES = new Short[] { TYPE_BIG01,TYPE_SMALL02,TYPE_SMALL03,TYPE_CROSS04, TYPE_CROSS05,TYPE_SMALL06,TYPE_SMALL07 };
	
	// 后台首页伸缩广告类型
	public static final Short[] INDEX_BANNER_TYPES = new Short[] { INDEX_BANNER_TYPES_1,INDEX_BANNER_TYPES_2 };
	public Prop getP() {
		return p;
	}

	public void setP(Prop p) {
		this.p = p;
	}

	public AdvPosition getPosition() {
		return position;
	}

	public void setPosition(AdvPosition position) {
		this.position = position;
	}
	
	
	
	
	
}
