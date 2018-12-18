package com.txp.app.system.service;


import com.txp.app.system.dto.SysUserRole;

/**
 * 用户角色
 * */
public interface SysUserRoleService {
	
	int insert(SysUserRole sysUserRole);
	
	/**
	 * 删除
	 * */
	int delete(Long userId);
	
	/**
	 * 更新
	 * */
	void update(SysUserRole sysUserRole);
	
	/**
	 * 批量删除
	 * */
	int batchDeleteRole(String deptIds);
}
