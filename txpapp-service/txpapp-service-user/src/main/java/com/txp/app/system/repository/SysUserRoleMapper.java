package com.txp.app.system.repository;

import com.txp.app.system.dto.SysUserRole;
import org.springframework.stereotype.Repository;

@Repository
public interface SysUserRoleMapper {

    /**
     *
     sys_user_role
     *
     * @mbggenerated Tue Jan 02 11:24:37 CST 2018
     */
    int insertSelective(SysUserRole record);

    int delete(Long userId);

    int batchDelete(String deptIds);
}
