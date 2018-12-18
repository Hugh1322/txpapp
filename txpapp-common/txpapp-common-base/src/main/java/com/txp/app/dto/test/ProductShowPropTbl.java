package com.txp.app.dto.test;

import java.io.Serializable;
import java.util.Date;

public class ProductShowPropTbl implements Serializable{
	private static final long serialVersionUID = 1655739873056117868L;
	protected Integer id;
	protected Integer productId;// 商品id
	protected Integer praiseClickNum;// 点赞数
	protected Integer commentNum;// 评价数
	protected Integer saleHistoryNum;// 历史销量数
	protected Integer productLabelId;// 商品标签ID
	protected String remark;
	protected Date createTime;// 创建时间
	protected Date updateTime;
	protected Integer version;//版本
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getProductId() {
		return productId;
	}
	public void setProductId(Integer productId) {
		this.productId = productId;
	}
	public Integer getPraiseClickNum() {
		return praiseClickNum;
	}
	public void setPraiseClickNum(Integer praiseClickNum) {
		this.praiseClickNum = praiseClickNum;
	}
	public Integer getCommentNum() {
		return commentNum;
	}
	public void setCommentNum(Integer commentNum) {
		this.commentNum = commentNum;
	}
	public Integer getSaleHistoryNum() {
		return saleHistoryNum;
	}
	public void setSaleHistoryNum(Integer saleHistoryNum) {
		this.saleHistoryNum = saleHistoryNum;
	}
	public Integer getProductLabelId() {
		return productLabelId;
	}
	public void setProductLabelId(Integer productLabelId) {
		this.productLabelId = productLabelId;
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
