package com.txp.app.dto.test;

import java.io.Serializable;
import java.util.Date;

public class ProductLabelTbl implements Serializable{
	private static final long serialVersionUID = -7030794073609772206L;
	protected Integer id;
	protected String labelName;// 标签名
	protected String labelImgUrl;//标签名图标
	protected String remark; // 备注
	protected Date createTime;// 创建时间
	protected Date updateTime;
	protected Integer version;//版本
	protected Integer isDelete;
	public Integer getIsDelete() {
		return isDelete;
	}
	public void setIsDelete(Integer isDelete) {
		this.isDelete = isDelete;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getLabelName() {
		return labelName;
	}
	public void setLabelName(String labelName) {
		this.labelName = labelName;
	}
	public String getLabelImgUrl() {
		return labelImgUrl;
	}
	public void setLabelImgUrl(String labelImgUrl) {
		this.labelImgUrl = labelImgUrl;
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
	public Integer getVersion() {
		return version;
	}
	public void setVersion(Integer version) {
		this.version = version;
	}
	
	
}
