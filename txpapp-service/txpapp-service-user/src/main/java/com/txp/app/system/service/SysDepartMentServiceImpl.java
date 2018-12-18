package com.txp.app.system.service;

import com.txp.app.entity.Page;
import com.txp.app.system.dto.OrgDeptDto;
import com.txp.app.system.dto.SysDepartment;
import com.txp.app.system.dto.SysOrganization;
import com.txp.app.system.repository.SysDepartMentMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 部门接口
 * 
 * @author th
 */
@Service("sysDepartmentService")
public class SysDepartMentServiceImpl implements SysDepartmentService {

	@Resource
	private SysDepartMentMapper sysDepartMentMapper;

	/**
	 * 新增部门
	 */
	@Override
	public Long insertDept(SysDepartment sysDepartment) {
		sysDepartMentMapper.insertSelective(sysDepartment);
		return sysDepartment.getId();
	}

	/**
	 * 删除部门
	 */
	@Override
	public void deleteDept(Long deptId) {
		sysDepartMentMapper.deleteSysDepartment(deptId);
		sysDepartMentMapper.deleteSysOrgDept(deptId);
		sysDepartMentMapper.deleteSysDeptUser(deptId);
	}

	/**
	 * 更新部门
	 */
	@Override
	public void updateDept(SysDepartment sysDepartment) {
		sysDepartMentMapper.updateByPrimaryKeySelective(sysDepartment);
	}

	/**
	 * 获取部门信息列表
	 */
	@Override
	public Page<SysDepartment> findsByPage(int pageNo, int pageSize) {
		Page<SysDepartment> page = new Page<>();
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);
		Long startIndex = Long.valueOf(((int) pageNo - 1) * (int) pageSize);
		Long endIndex = Long.valueOf((int) pageSize);

		Map map = new HashMap<String,Object>();
		map.put("startIndex",startIndex);
		map.put("endIndex",endIndex);

		page.setTotalCount(sysDepartMentMapper.selectSysDepartmentListCount(map));
		page.setPageNo((pageNo - 1) * pageSize);
		page.setPageSize(pageSize);

		List<SysDepartment> list = sysDepartMentMapper.selectSysDepartmentList(map);
		page.setResult(list);
		return page;
	}

	@Override
	public SysDepartment findById(Long id) {
		return sysDepartMentMapper.selectByPrimaryKey(id);
	}

	/**
	 * 获取所有的机构
	 */
	@Override
	public List<SysOrganization> getAllOrgList() {
		return sysDepartMentMapper.selectAllOrg();
	}

	/**
	 * 获取所有的部门
	 */
	@Override
	public List<SysDepartment> getAllDeptList() {
		return sysDepartMentMapper.selectAllDeptment();
	}

	/**
	 * 添加机构部门关系
	 * 
	 * @param orgId 机构ID,deptId 部门ID
	 */
	@Override
	public int insertOrgDept(Long orgId, Long deptId) {
		OrgDeptDto orgDeptDto = new OrgDeptDto();
		orgDeptDto.setDeptId(deptId);
		orgDeptDto.setOrgId(orgId);
		return sysDepartMentMapper.insertSysOrgDept(orgDeptDto);
	}

	@Override
	public List<SysDepartment> departmentAll() {
		return sysDepartMentMapper.selectAllDeptment();
	}

	@Override
	public SysDepartment findDeptByUserId(Long userId) {
		String sql = "select d.* from sys_department d where d.id=(select dept_id from sys_dept_user "
				+ "where user_id=#{userId})";
		return sysDepartMentMapper.findDeptByUserId(userId);
	}

	/**
	 * 根据部门ID获取所属机构信息
	 */
	@Override
	public SysOrganization findOrgById(Long deptId) {
		return sysDepartMentMapper.selectOrgByDeptId(deptId);
	}

	/**
	 * 修改部门所属机构信息
	 */
	@Override
	public int updateOrgDept(Long deptId, Long oldOrgId, Long newOrgId) {
		OrgDeptDto orgDeptDto = new OrgDeptDto();
		orgDeptDto.setDeptId(deptId);
		orgDeptDto.setOrgId(oldOrgId);
		orgDeptDto.setNewOrgId(newOrgId);
		return sysDepartMentMapper.updateOrgDept(orgDeptDto);
	}

	/**
	 * 修改部门所属机构信息
	 */
	@Override
	public int updateOrgDept(SysDepartment sysDepartment, Long oldOrgId, Long newOrgId) {
		this.updateDept(sysDepartment);
		OrgDeptDto orgDeptDto = new OrgDeptDto();
		orgDeptDto.setDeptId(sysDepartment.getId());
		orgDeptDto.setOrgId(oldOrgId);
		orgDeptDto.setNewOrgId(newOrgId);
		return sysDepartMentMapper.updateOrgDept(orgDeptDto);
	}

	/**
	 * 
	 * 根据部门名称查询部门信息
	 */
	@Override
	public SysDepartment findSysDepartmentByDeptName(String deptName) {
		SysDepartment sysDepartment = sysDepartMentMapper.findSysDepartmentByDeptName(deptName);
		return sysDepartment;
	}
}
