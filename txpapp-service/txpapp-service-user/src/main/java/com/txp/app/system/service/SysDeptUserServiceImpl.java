package com.txp.app.system.service;

import com.txp.app.system.dto.SysDeptUser;
import com.txp.app.system.repository.SysDeptUserMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

@Service("sysDeptUserService")
public class SysDeptUserServiceImpl implements SysDeptUserService {

	@Resource
	private SysDeptUserMapper sysDeptUserMapper;

	@Override
	public int insert(SysDeptUser sysDeptUser) {
		return sysDeptUserMapper.insertSelective(sysDeptUser);
	}

	@Override
	public int delete(Long userId) {
		return sysDeptUserMapper.delete(userId);
	}

	@Override
	public int update(SysDeptUser sysDeptUser) {
		return sysDeptUserMapper.update(sysDeptUser);
	}

	@Override
	public int batchDeleteDept(String userIds) {
		return sysDeptUserMapper.batchDelete(userIds);
	}

		
}