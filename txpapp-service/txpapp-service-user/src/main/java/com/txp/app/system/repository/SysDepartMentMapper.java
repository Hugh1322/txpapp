package com.txp.app.system.repository;

import com.txp.app.system.dto.OrgDeptDto;
import com.txp.app.system.dto.SysDepartment;
import com.txp.app.system.dto.SysOrganization;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface SysDepartMentMapper {

    /**
     *
     sys_department
     *
     * @mbggenerated Tue Jan 02 15:01:34 CST 2018
     */
    int deleteByPrimaryKey(Long id);

    /**
     *
     sys_department
     *
     * @mbggenerated Tue Jan 02 15:01:34 CST 2018
     */
    int insert(SysDepartment record);

    /**
     *
     sys_department
     *
     * @mbggenerated Tue Jan 02 15:01:34 CST 2018
     */
    int insertSelective(SysDepartment record);

    /**
     *
     sys_department
     *
     * @mbggenerated Tue Jan 02 15:01:34 CST 2018
     */
    SysDepartment selectByPrimaryKey(Long id);

    /**
     *
     sys_department
     *
     * @mbggenerated Tue Jan 02 15:01:34 CST 2018
     */
    int updateByPrimaryKeySelective(SysDepartment record);

    /**
     *
     sys_department
     *
     * @mbggenerated Tue Jan 02 15:01:34 CST 2018
     */
    int updateByPrimaryKey(SysDepartment record);

    void deleteSysDepartment(Long deptId);

    void deleteSysOrgDept(Long deptId);

    void deleteSysDeptUser(Long id);

    long selectSysDepartmentListCount(Map map);

    List<SysDepartment> selectSysDepartmentList(Map map);

    List<SysOrganization> selectAllOrg();

    List<SysDepartment> selectAllDeptment();

    int insertSysOrgDept(OrgDeptDto orgDeptDto);

    SysDepartment findDeptByUserId(Long userId);

    SysOrganization selectOrgByDeptId(Long deptId);

    int updateOrgDept(OrgDeptDto orgDeptDto);

    SysDepartment findSysDepartmentByDeptName(String deptName);
}
