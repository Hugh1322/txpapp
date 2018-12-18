package com.txp.app.system.service;

import com.txp.app.entity.Page;
import com.txp.app.exception.BusException;
import com.txp.app.system.dto.SysRole;
import com.txp.app.system.dto.SysRoleRule;
import com.txp.app.system.dto.SysRule;
import com.txp.app.system.repository.SysRoleMapper;
import com.ytoxl.module.core.common.pagination.BasePagination;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
* 角色接口
* @author th
*/
@Slf4j
@Service("sysRoleService")
public class SysRoleServiceImpl implements SysRoleService{

	@Resource
	private SysRoleMapper sysRoleMapper;

	@Override
	public Long insertRole(SysRole sysRole) {
		sysRoleMapper.insertSelective(sysRole);
		log.info("SysRoleServiceImpl..insertRole..id:" + sysRole.getId());
		return sysRole.getId();
	}

	@Override
	public void deleteRole(Long roleId) {
		sysRoleMapper.delete(roleId);
	}

	@Override
	public void updateRole(SysRole sysRole) {
		sysRoleMapper.update(sysRole);
	}

	@Override
	public Page<SysRole> findsSysRole(int pageNo, int pageSize, Long supplierId) {
		Page<SysRole> page = new Page<>();
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);
		Long startIndex = Long.valueOf(((int) pageNo - 1) * (int) pageSize);
		Long endIndex = Long.valueOf((int) pageSize);

		Map map = new HashMap<>();
		map.put("startIndex",startIndex);
		map.put("endIndex",endIndex);
		map.put("supplierId",supplierId);

		page.setTotalCount(sysRoleMapper.selectRoleListCount(map));
		page.setPageNo((pageNo - 1) * pageSize);
		page.setPageSize(pageSize);

		List<SysRole> list = sysRoleMapper.selectRoleList(map);
		page.setResult(list);
		return page;
	}

	@Override
	public SysRole findById(Long id) {
		return sysRoleMapper.selectRoleById(id);
	}


	@Override
	public int insertRoleRule(Long roleId,Set<SysRule> rules) {
		int result = 0;
		for (SysRule sysRule : rules) {
			SysRoleRule rDto = new SysRoleRule();
			rDto.setRoleId(roleId);
			rDto.setRuleId(sysRule.getId());
			result = sysRoleMapper.insertRoleRule(rDto);
		}
		return result;
	}

	public List<SysRole> sysRoleAll() {
		return sysRoleMapper.selectAllList();
	}

	@Override
	public List<SysRole> findRoleByUserId(Long userID) throws BusException {
		if(StringUtils.isEmpty(String.valueOf(userID))){
			throw new BusException("用户Id为空");
		}
		return sysRoleMapper.selectSysRoleByUserId(userID);
//		String split=sysRoleMapper.selectOne(userID);//对数据库数据进行分割
//		return sysRoleMapper.selectListByUserId(split);
	}

	@Override
	public List<SysRule> roleIdByRules(Long id) {
		return sysRoleMapper.selectRuleList(id);
	}

	@Override
	public int delete(Long roleIds) {
		return sysRoleMapper.deleteRoleRule(roleIds);
	}

	@Override
	public int insert(SysRoleRule sysRoleRule) {
		return sysRoleMapper.insertRoleRule(sysRoleRule);
	}

	@Override
	public boolean findByName(String roleName) {
		int count = sysRoleMapper.findByName(roleName);
		return count>0?true:false;
	}

	@Override
	public boolean findByCode(String roleCode) {
		int count = sysRoleMapper.findByCode(roleCode);
		return count>0?true:false;
	}

	@Override
	public boolean findBySysRole(SysRole sysRole) {
		int count = sysRoleMapper.findBySysRole(sysRole);
		return count>0?true:false;
	}

	@Override
	public void deleteRoleRule(Long roleId) {
		sysRoleMapper.deleteRoleRule(roleId);
	}

	@Override
	public void deleteUserRole(Long roleId) {
		sysRoleMapper.deleteUserRole(roleId);
	}

	@Override
	public List<Long> findUserBySysRole(Long roleId) {
		return sysRoleMapper.findUserBySysRole(roleId);
	}

	@Override
	public BasePagination<SysRole> findsByPageNew(BasePagination<SysRole> rolerPage) {
		Map<String, Object> searchParams = rolerPage.getSearchParamsMap();
		if (rolerPage.isNeedSetTotal()) {
			Integer total = sysRoleMapper.findsByPageCountNew(searchParams);
			rolerPage.setTotal(total);
		}
		List<SysRole> result = sysRoleMapper.findsByPageNew(searchParams);
		rolerPage.setResult(result);
		return rolerPage;
	}


}
