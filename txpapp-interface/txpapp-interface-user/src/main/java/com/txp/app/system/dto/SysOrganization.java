package com.txp.app.system.dto;

import java.io.Serializable;


/**
 * 机构
 *
 * @author th
 */
public class SysOrganization implements Serializable{

	private static final long serialVersionUID = -9123482657171410594L;
	/**
	 * 主键ID
	 */
	private Long id;
	/**
	 * 机构代码
	 */
	private String orgCode;
	/**
	 * 机构名称
	 */
	private String orgName;
	/**
	 * 机构描述
	 */
	private String orgDesc;
	/**
	 * 父类机构ID
	 * @return
	 */
	private Long fatherId;
	
	private Integer lft;
	
	private Integer rgt;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getOrgCode() {
		return orgCode;
	}
	public void setOrgCode(String orgCode) {
		this.orgCode = orgCode;
	}
	public String getOrgName() {
		return orgName;
	}
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	public String getOrgDesc() {
		return orgDesc;
	}
	public void setOrgDesc(String orgDesc) {
		this.orgDesc = orgDesc;
	}
	public Long getFatherId() {
		return fatherId;
	}
	public void setFatherId(Long fatherId) {
		this.fatherId = fatherId;
	}
	public Integer getLft() {
		return lft;
	}
	public void setLft(Integer lft) {
		this.lft = lft;
	}
	public Integer getRgt() {
		return rgt;
	}
	public void setRgt(Integer rgt) {
		this.rgt = rgt;
	}
	
	
}
