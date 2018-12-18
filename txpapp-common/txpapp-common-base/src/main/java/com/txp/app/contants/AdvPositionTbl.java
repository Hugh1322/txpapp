package com.txp.app.contants;

import java.io.Serializable;
import java.util.Date;

/**广告位表
 * @author zengzhiming
 *
 */
public class AdvPositionTbl implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -5031412136246442132L;
	/**主键	 */
	private Integer positionId;
	/**广告位名称	 */
	private String positionName;
	/**创建者	 */
	private Integer createUserId;
	/**创建时间	 */
	private Date createTime;
	/**更新时间	 */
	private Date updateTime;
	/**广告位类型的高度	 */
	private Integer height;
	/**广告位类型的寬度	 */
	private Integer width;
	/**广告位类型的唯一編碼	 */
	private String code;
	
	private int hidden;
	
	public int getHidden() {
		return hidden;
	}
	public void setHidden(int hidden) {
		this.hidden = hidden;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public Integer getHeight() {
		return height;
	}
	public void setHeight(Integer height) {
		this.height = height;
	}
	public Integer getWidth() {
		return width;
	}
	public void setWidth(Integer width) {
		this.width = width;
	}
	public Integer getPositionId() {
		return positionId;
	}
	public void setPositionId(Integer positionId) {
		this.positionId = positionId;
	}
	public String getPositionName() {
		return positionName;
	}
	public void setPositionName(String positionName) {
		this.positionName = positionName;
	}
	public Integer getCreateUserId() {
		return createUserId;
	}
	public void setCreateUserId(Integer createUserId) {
		this.createUserId = createUserId;
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
	
	
}
