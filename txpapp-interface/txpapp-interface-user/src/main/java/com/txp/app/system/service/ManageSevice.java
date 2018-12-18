package com.txp.app.system.service;


import com.txp.app.entity.Page;
import com.txp.app.exception.BusException;
import com.txp.app.system.dto.*;
import com.txp.app.util.TreeModel;

import java.util.List;
import java.util.Map;

/**
 * 机构日志业务层
 * @author DOY
 *
 */
public interface ManageSevice {
	
	Page<SysOrganization> query(SysOrganization org, int i, int j, String pid) throws BusException;

	Map<String, Object> findUserByLoginName(String orgName) throws BusException;

	Long save(String orgName, String pid, String orgDesc)throws BusException;

	int delete(String ids) throws BusException;

	Map<String, Object> update(String id) throws BusException;

	void updateIns(String pid, String id, String orgName, String orgDesc) throws BusException;

	Page<SysLog> queryLogin(SysLog log, int i, int j, String startTime, String endTime) throws BusException;
	
	int saveSysLog(String string, String oPERATION_FAILURE, SysUser user, String ip);

//	int TotalLogin(SysLog log, String startTime, String endTime);

	/**
	 * 根据部门id查询所属机构
	 * */
	SysOrganization findByDeptId(Long dId);


	List<SysCity> findByOrgIdAndCity(String orgId);

	List<TreeModel> findRuleTree(boolean b);

	/**
	 * 插入商城日志
	 * @param operator
	 * @param model
	 * @param description
	 * @param operateResult
	 * @param ip
     * @return
     */
	int saveSysMallLog(String operator, String model, String description, String operateResult, String ip);

	Page<SysMallLog> queryMallLogin(SysMallLog log, int i, int j, String startTime, String endTime) throws BusException;
}
