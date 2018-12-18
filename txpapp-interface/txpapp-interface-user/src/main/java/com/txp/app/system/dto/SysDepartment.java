package com.txp.app.system.dto;

import java.io.Serializable;


/**
 * 部门表
 *
 * @author th
 */
public class SysDepartment implements  Serializable{


	private static final long serialVersionUID = 7369717377424101947L;
	/**
	 * 主键ID
	 */
	private Long id;
	/**
	 * 部门代码
	 */
	private String deptCode;
	/**
	 * 部门名称
	 */
	private String deptName;
	/**
	 * 部门描述
	 */
	private String deptDesc;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getDeptCode() {
		return deptCode;
	}
	public void setDeptCode(String deptCode) {
		this.deptCode = deptCode;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getDeptDesc() {
		return deptDesc;
	}
	public void setDeptDesc(String deptDesc) {
		this.deptDesc = deptDesc;
	}
}
