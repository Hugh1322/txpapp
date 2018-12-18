package com.txp.app.system.repository;

import com.txp.app.system.dto.SysRule;
import com.txp.app.system.dto.SysUser;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface SysUserMapper {

    /**
     *
     sys_user
     *
     * @mbggenerated Tue Jan 02 10:29:29 CST 2018
     */
    int deleteByPrimaryKey(Long id);

    /**
     *
     sys_user
     *
     * @mbggenerated Tue Jan 02 10:29:29 CST 2018
     */
    int insert(SysUser record);

    /**
     *
     sys_user
     *
     * @mbggenerated Tue Jan 02 10:29:29 CST 2018
     */
    int insertSelective(SysUser record);

    /**
     *
     sys_user
     *
     * @mbggenerated Tue Jan 02 10:29:29 CST 2018
     */
    SysUser selectByPrimaryKey(Long id);

    /**
     *
     sys_user
     *
     * @mbggenerated Tue Jan 02 10:29:29 CST 2018
     */
    int updateByPrimaryKeySelective(SysUser record);

    /**
     *
     sys_user
     *
     * @mbggenerated Tue Jan 02 10:29:29 CST 2018
     */
    int updateByPrimaryKey(SysUser record);

    List<SysUser> selectAllList(Map<String,Object> map);

    Long findSysUserListCount(Map map);

    List<SysUser> findSysUserList(Map map);

    String selectRoleName(@Param("roleIds") List<String> roleIds);

    void deleteSysUserRole(Long userId);

    int deleteByIds(String ids);

    String queryOrg(String username);

    String selectRoleId(Long id);

    List<SysRule> selectSysRule(@Param("roleIds") List<String> roleIds);

    Integer findSysUserListCountNew(Map<String, Object> searchParams);

    List<SysUser> findSysUserListNew(Map<String, Object> searchParams);

//    int selectMerchantSysuserBySysId(Long id);
}
