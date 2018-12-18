package com.txp.app.system.repository;

import com.txp.app.system.dto.SysDeptUser;
import org.springframework.stereotype.Repository;

@Repository
public interface SysDeptUserMapper {

    /**
     *
     sys_dept_user
     *
     * @mbggenerated Tue Jan 02 11:38:19 CST 2018
     */
    int insertSelective(SysDeptUser sysDeptUser);

    int delete(Long userId);

    int update(SysDeptUser sysDeptUser);

    int batchDelete(String userIds);
}
