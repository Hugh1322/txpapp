package com.txp.app.system.service;


import com.txp.app.dto.BjuiDto;
import com.txp.app.entity.Page;
import com.txp.app.exception.BusException;
import com.txp.app.system.dto.SysRule;
import com.txp.app.system.dto.SysUser;
import com.ytoxl.module.core.common.pagination.BasePagination;

import java.util.List;


public interface SysUserService {

	List<SysUser> findAll();

	Page findSysUser(SysUser user, int pageNo, int pageSize, String beginTime, String endTime);

//	Long getRowCount(SysUser user);

	/**
	 * 添加用户，同时插入用户所属部门和角色
	 */

	boolean insertUser(SysUser user, String deptId, String roleId, String supplierId, String passStr, Integer ... type);

	SysUser findUserByLoginName(String loginName);

	SysUser findUserByKey(Long id);

	/**
	 * 更新用户信息，以及用户的角色、部门
	 */
	boolean updateUser(SysUser user, String roleId, String deptId, String supplierId);

	BjuiDto delete(Long id) throws Exception;

	/**
	 * 批量删除
	 */
	boolean bulkDeleteUser(String ids);

	String queryOrg(String username);

	List<SysRule> queryRole(Long id) throws BusException;

	void updateByPrimaryKeySelective(SysUser user);

	BasePagination<SysUser> findUserByCriteriaAndPage(BasePagination<SysUser> userPage);

//	BwBorrower getBwBorrowerByPhone(String phone);
}
