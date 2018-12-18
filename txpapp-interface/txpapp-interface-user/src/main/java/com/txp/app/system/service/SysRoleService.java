package com.txp.app.system.service;


import com.txp.app.entity.Page;
import com.txp.app.exception.BusException;
import com.txp.app.system.dto.SysRole;
import com.txp.app.system.dto.SysRoleRule;
import com.txp.app.system.dto.SysRule;
import com.ytoxl.module.core.common.pagination.BasePagination;

import java.util.List;
import java.util.Set;


public interface SysRoleService {

	//增
	Long insertRole(SysRole sysRole);
	//删
	void deleteRole(Long roleId);
	//改
	void updateRole(SysRole sysRole);
	//查
	Page<SysRole> findsSysRole(int pageNo, int pageSize, Long supplierId);
	
	//根据ID查询角色信息
	SysRole findById(Long id);

	List<SysRole> sysRoleAll();
	
	
	/**
	 * 根据用户的id查询改用户拥有的角色
	 * @throws BusException 
	 * */
	List<SysRole> findRoleByUserId(Long userID) throws BusException;
	

	/**
	 * 新增角色权限关系记录
	 */
	int insertRoleRule(Long roleId, Set<SysRule> rules);
	
	
	/**
	 * 根据角色编号查询权限集合
	 * */
	List<SysRule> roleIdByRules(Long id);
	
	/**
	 * 根据id批量删除
	 * */
	public int delete(Long roleIds);
	
	/**
	 * 根据id批量插入权限
	 * */
	int insert(SysRoleRule sysRoleRule);

	boolean findByName(String roleName);

	boolean findByCode(String roleCode);

	boolean findBySysRole(SysRole sysRole);

	void deleteRoleRule(Long roleId);

	void deleteUserRole(Long roleId);

	List<Long> findUserBySysRole(Long roleId);

	BasePagination<SysRole> findsByPageNew(BasePagination<SysRole> rolerPage);
}
