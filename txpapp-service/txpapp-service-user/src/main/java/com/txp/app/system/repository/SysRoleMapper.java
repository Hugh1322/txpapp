package com.txp.app.system.repository;

import com.txp.app.system.dto.SysRole;
import com.txp.app.system.dto.SysRoleRule;
import com.txp.app.system.dto.SysRule;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface SysRoleMapper {

    /**
     *
     sys_dept_user
     *
     * @mbggenerated Tue Jan 02 11:38:19 CST 2018
     */
    int insertSelective(SysRole sysRole);

    void delete(Long id);

    void update(SysRole sysRole);

    long selectRoleListCount(Map map);

    List<SysRole> selectRoleList(Map map);

    Integer findsByPageCountNew(Map map);

    List<SysRole> findsByPageNew(Map map);

    SysRole selectRoleById(Long id);

    int insertRoleRule(SysRoleRule rDto);

    List<SysRole> selectAllList();

    String selectOne(Long userID);

    List<SysRole> selectListByUserId(String split);

    List<SysRule> selectRuleList(Long id);

    int deleteRoleRule(Long roleIds);

    List<SysRole> selectSysRoleByUserId(Long userID);

    int findByName(String roleName);

    int findByCode(String roleCode);

    int findBySysRole(SysRole sysRole);

    void deleteUserRole(Long roleId);

    List<Long> findUserBySysRole(Long roleId);
}
