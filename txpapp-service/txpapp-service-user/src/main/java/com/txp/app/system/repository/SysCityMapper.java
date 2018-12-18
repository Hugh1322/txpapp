package com.txp.app.system.repository;

import com.txp.app.system.dto.SysCity;
import com.txp.app.system.dto.SysOrgCity;
import com.txp.app.system.dto.SysOrganization;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface SysCityMapper {

    /**
     *
     sys_city
     *
     * @mbggenerated Tue Jan 02 19:43:00 CST 2018
     */
    int deleteByPrimaryKey(Long id);

    /**
     *
     sys_city
     *
     * @mbggenerated Tue Jan 02 19:43:00 CST 2018
     */
    int insert(SysCity record);

    /**
     *
     sys_city
     *
     * @mbggenerated Tue Jan 02 19:43:00 CST 2018
     */
    int insertSelective(SysCity record);

    /**
     *
     sys_city
     *
     * @mbggenerated Tue Jan 02 19:43:00 CST 2018
     */
    SysCity selectByPrimaryKey(Long id);

    /**
     *
     sys_city
     *
     * @mbggenerated Tue Jan 02 19:43:00 CST 2018
     */
    int updateByPrimaryKeySelective(SysCity record);

    /**
     *
     sys_city
     *
     * @mbggenerated Tue Jan 02 19:43:00 CST 2018
     */
    int updateByPrimaryKey(SysCity record);

    long findSysCityListCount(Map map);

    List<SysCity> findSysCityList(Map map);

    List<SysOrganization> selectAllSysOrganization();

    int insertSysCity(SysCity sysCity);

    void insertSysOrgCity(SysOrgCity sysOrgCity);

    void deleteSysCity(String id);

    void deleteSysOrgCity(String id);

    Long selectSysOrgCityByCityId(Long id);

    int updateSysOrgCity(SysOrgCity sysOrgCity);

    Map<String,Object> queryOrg(String id);
}
