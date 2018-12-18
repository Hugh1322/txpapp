package com.txp.app.contants;

import java.util.List;
import java.util.Map;


public class PropKindImg {
	
	//分类广告图片的路径和图片的目标地址
	private String imgUrl;
	private String imgTargetUrl;
	private Integer propId;
	
	//品牌广告
	private String name;
	private String nameUrl;

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

	public Integer getPropId() {
		return propId;
	}

	public void setPropId(Integer propId) {
		this.propId = propId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNameUrl() {
		return nameUrl;
	}

	public void setNameUrl(String nameUrl) {
		this.nameUrl = nameUrl;
	}

	
}
