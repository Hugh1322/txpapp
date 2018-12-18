package com.txp.app.system.service;
import com.txp.app.system.dto.SysUserRole;
import com.txp.app.system.repository.SysUserRoleMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * 
 * */
@Service("sysUserRoleService")
public class SysUserRoleServiceImpl implements SysUserRoleService {

	@Resource
	private SysUserRoleMapper sysUserRoleMapper;

	@Override
	public int insert(SysUserRole sysUserRole) {
		return sysUserRoleMapper.insertSelective(sysUserRole);
	}

	@Override
	public int delete(Long userId) {
		return sysUserRoleMapper.delete(userId);
	}

	@Override
	public void update(SysUserRole sysUserRole) {
		sysUserRoleMapper.insertSelective(sysUserRole);
	}

	@Override
	public int batchDeleteRole(String deptIds) {
		return sysUserRoleMapper.batchDelete(deptIds);
	}	
}
