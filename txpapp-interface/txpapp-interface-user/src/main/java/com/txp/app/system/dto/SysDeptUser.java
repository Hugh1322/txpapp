package com.txp.app.system.dto;

import java.io.Serializable;


/**
 * th
 */
public class SysDeptUser implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * 部门编号
	 * */
	private Long deptId;
	
	/**
	 * 用户编号
	 * */
	private Long userId;

	public Long getDeptId() {
		return deptId;
	}

	public void setDeptId(Long deptId) {
		this.deptId = deptId;
	}

	public Long getUserId() {
		return userId;
	}

	public void setUserId(Long userId) {
		this.userId = userId;
	}

	
	public SysDeptUser(Long deptId, Long userId) {
		this.deptId = deptId;
		this.userId = userId;
	}

	
	public SysDeptUser() {
	
	}
	
	
}
