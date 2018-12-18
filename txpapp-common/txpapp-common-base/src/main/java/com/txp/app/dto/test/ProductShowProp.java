package com.txp.app.dto.test;

import java.io.Serializable;


public class ProductShowProp extends ProductShowPropTbl implements Serializable{

	private static final long serialVersionUID = -6839133119778704510L;
	
	private ProductLabel productLabel;
	
	//最近一次评论
	private String lastComment;
	//评论用户头像
	private String userHeadPic;
	//最近一次评论的用户
	private String lastCommentUsername;
	//缓存结束时间
	private long cacheEndTime=0l;
	//匿名标识
	private Integer anonymous;
	
	public void setProductLabel(ProductLabel productLabel) {
		this.productLabel = productLabel;
	}

	public ProductLabel getProductLabel() {
		return productLabel;
	}

	public String getLastComment() {
		return lastComment;
	}

	public void setLastComment(String lastComment) {
		this.lastComment = lastComment;
	}

	public String getUserHeadPic() {
		return userHeadPic;
	}

	public void setUserHeadPic(String userHeadPic) {
		this.userHeadPic = userHeadPic;
	}

	public String getLastCommentUsername() {
		return lastCommentUsername;
	}

	public void setLastCommentUsername(String lastCommentUsername) {
		this.lastCommentUsername = lastCommentUsername;
	}

	public long getCacheEndTime() {
		return cacheEndTime;
	}

	public void setCacheEndTime(long cacheEndTime) {
		this.cacheEndTime = cacheEndTime;
	}

	public Integer getAnonymous() {
		return anonymous;
	}

	public void setAnonymous(Integer anonymous) {
		this.anonymous = anonymous;
	}

	

	
	
	

}
