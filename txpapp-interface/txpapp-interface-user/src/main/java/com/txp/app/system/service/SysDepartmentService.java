package com.txp.app.system.service;


import com.txp.app.entity.Page;
import com.txp.app.system.dto.SysDepartment;
import com.txp.app.system.dto.SysOrganization;

import java.util.List;


public interface SysDepartmentService {

	/**
	 * 添加部门
	 */
	Long insertDept(SysDepartment sysDepartment);

	/**
	 * 删除部门
	 */
	void deleteDept(Long deptId);

	/**
	 * 修改部门信息
	 */
	void updateDept(SysDepartment sysDepartment);

	/**
	 * 分页查询部门信息
	 */
	Page<SysDepartment> findsByPage(int pageNo, int pageSize);

	/**
	 * 根据id获取部门信息
	 */
	SysDepartment findById(Long id);

	/**
	 * 获取所有的机构
	 */
	List<SysOrganization> getAllOrgList();

	/**
	 * 获取所有的部门
	 */
	List<SysDepartment> getAllDeptList();

	/**
	 * 添加机构部门关系
	 * 
	 * @param orgId 机构ID,deptId 部门ID
	 */
	int insertOrgDept(Long orgId, Long deptId);

	/**
	 * 获取所有的部门信息
	 */
	List<SysDepartment> departmentAll();

	/**
	 * 根据用户编号查询相应的部门
	 */
	SysDepartment findDeptByUserId(Long userId);

	/**
	 * 根据部门ID获取所属机构信息
	 */
	SysOrganization findOrgById(Long deptId);

	/**
	 * 修改部门所属机构信息
	 */
	int updateOrgDept(Long deptId, Long oldOrgId, Long newOrgId);

	/**
	 * 修改部门所属机构信息
	 */
	int updateOrgDept(SysDepartment sysDepartment, Long oldOrgId, Long newOrgId);

	/**
	 * 
	 * 根据部门名称查询部门
	 * 
	 * @return
	 */
	SysDepartment findSysDepartmentByDeptName(String deptName);

}
