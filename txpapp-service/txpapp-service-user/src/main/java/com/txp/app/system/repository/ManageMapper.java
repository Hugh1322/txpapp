package com.txp.app.system.repository;

import com.txp.app.system.dto.SysCity;
import com.txp.app.system.dto.SysLog;
import com.txp.app.system.dto.SysMallLog;
import com.txp.app.system.dto.SysOrganization;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface ManageMapper {


    int insertSysLog(SysLog log);

    SysOrganization selectSysOrganization(Long dId);

    List<SysOrganization> findSysOrganizationList1(Map map);

    long findSysOrganizationList1Count(Map map);

    List<SysOrganization> findSysOrganizationList2(Map map);

    long findSysOrganizationList2Count(Map map);

    Map<String,Object> selectOrgName(String orgName);

    Long selectOrgIdByOrgName(String orgName);

    int selectLft(@Param("pid") String pid, @Param("orgName") String orgName, @Param("orgDesc") String orgDesc);

    int insertSysOrganization(SysOrganization sysOrganization);

    int updateSysOrganizationOrgCode(SysOrganization sysOrganization);

    int selectDeleteOrg(String ids);

    Map<String,Object> selectSysOrganizationById(String id);

    int updateSysOrganization(SysOrganization sysOrganization);

    List<SysLog> findSysLogList(Map map);

    long findSysLogListCount(Map map);

    List<SysCity> selectAllSysCity();

    List<SysCity> selectSysCityByOrgId(String orgId);

    List<SysOrganization> selectAllSysOrganization();

    int insertSysMallLog(SysMallLog log);

    List<SysMallLog> findSysMallLogList(Map map);

    long findSysMallLogListCount(Map map);
}
