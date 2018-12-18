package com.txp.app.system.service;

import com.txp.app.entity.Page;
import com.txp.app.exception.BusException;
import com.txp.app.system.dto.*;
import com.txp.app.system.repository.ManageMapper;
import com.txp.app.util.CommUtils;
import com.txp.app.util.TreeModel;
import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;


@Service("manageSevice")
public class ManageSeviceImpl implements ManageSevice {

	@Resource
	private ManageMapper manageMapper;

	// 获得机构数据
	@Override
	public Page<SysOrganization> query(SysOrganization org, int pageNo, int pageSize, String pid) throws BusException {
		Page<SysOrganization> page = new Page<>();
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);
		Long startIndex = Long.valueOf(((int) pageNo - 1) * (int) pageSize);
		Long endIndex = Long.valueOf((int) pageSize);

		Map map = new HashMap<String,Object>();
		map.put("startIndex",startIndex);
		map.put("endIndex",endIndex);
		map.put("orgId",!CommUtils.isNull(org.getId())?org.getId():null);
		map.put("orgName",!CommUtils.isNull(org.getOrgName())?org.getOrgName():null);

		if (pid.equals("0")) {
			List<SysOrganization> rows = manageMapper.findSysOrganizationList1(map);
			page.setTotalCount(manageMapper.findSysOrganizationList1Count(map));
			page.setResult(rows);
		} else {
			List<SysOrganization> rows = manageMapper.findSysOrganizationList2(map);
			page.setTotalCount(manageMapper.findSysOrganizationList2Count(map));
			page.setResult(rows);
		}
//		page.setPageNo((pageNo - 1) * pageSize);
//		page.setPageSize(pageSize);
		return page;
	}

	// 判断机构名是否存在
	@Override
	public Map<String, Object> findUserByLoginName(String orgName) throws BusException {
		Map<String, Object> map = new HashMap<String, Object>();
		if (StringUtils.isBlank(orgName)) {
			throw new BusException("机构名不能为空");
		} else {
			map = manageMapper.selectOrgName(orgName);
		}
		return map;
	}

	// 添加机构信息
	@Override
	public Long save(String orgName, String pid, String orgDesc) throws BusException {
		Long id = manageMapper.selectOrgIdByOrgName(orgName);
		if (!CommUtils.isNull(id)) {
			throw new BusException("该机构名在父机构中已存在");
		}
		int lft = manageMapper.selectLft(pid,orgName,orgDesc);
		SysOrganization sysOrganization = new SysOrganization();
		sysOrganization.setOrgName(orgName);
		sysOrganization.setFatherId(Long.valueOf(pid));
		sysOrganization.setOrgDesc(orgDesc);
		sysOrganization.setOrgCode(orgName);
		sysOrganization.setLft((lft + 1));
		sysOrganization.setRgt((lft + 2));
		manageMapper.insertSysOrganization(sysOrganization);
		//"update sys_organization set org_code=pinyin('" + orgName + "') where id='"
//		+ sysOrganization.getId() + "'"
//		manageMapper.updateSysOrganizationOrgCode(sysOrganization);
		return sysOrganization.getId();
	}

	// 删除机构
	@Override
	public int delete(String ids) throws BusException {
		return manageMapper.selectDeleteOrg(ids);
	}

	// 查询索要更新的数据
	@Override
	public Map<String, Object> update(String id) throws BusException {
		if (StringUtils.isNotBlank(id)) {
			return manageMapper.selectSysOrganizationById(id);
		} else {
			throw new BusException("更新数据ID为空");
		}
	}

	// 更新数据信息
	@Override
	public void updateIns(String pid, String id, String orgName, String orgDesc) throws BusException {
		if (CommUtils.isNull(id)) {
			throw new BusException("机构ID为空");
		}
		if (CommUtils.isNull(orgName)) {
			throw new BusException("机构名字为空");
		}
		if (CommUtils.isNull(orgDesc)) {
			throw new BusException("机构描述为空");
		}
		if (CommUtils.isNull(pid)) {
			SysOrganization sysOrganization = new SysOrganization();
			sysOrganization.setId(Long.parseLong(id));
			sysOrganization.setOrgName(orgName);
			sysOrganization.setOrgDesc(orgDesc);
			manageMapper.updateSysOrganization(sysOrganization);
		} else {
			int de_org = manageMapper.selectDeleteOrg(id);
			if (de_org == 0) {
				int lft = manageMapper.selectLft(pid,orgName,orgDesc);
				SysOrganization sysOrganization = new SysOrganization();
				sysOrganization.setOrgName(orgName);
				sysOrganization.setFatherId(Long.valueOf(pid));
				sysOrganization.setOrgCode(orgName);
				sysOrganization.setOrgDesc(orgDesc);
				sysOrganization.setLft((lft + 1));
				sysOrganization.setRgt((lft + 2));
				manageMapper.insertSysOrganization(sysOrganization);
//				manageMapper.update("update sys_organization set org_code=pinyin('" + orgName + "') where id='"
//						+ sysOrganization.getId() + "'");
			}
		}
	}

	// 查询操作日志
	@Override
	public Page<SysLog> queryLogin(SysLog log, int pageNo, int pageSize, String startTime, String endTime)
			throws BusException {
		Page<SysLog> page = new Page<>();
//		page.setPageNo((pageNo - 1) * pageSize);
//		page.setPageSize(pageSize);
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);
		Long startIndex = Long.valueOf(((int) pageNo - 1) * (int) pageSize);
		Long endIndex = Long.valueOf((int) pageSize);

		Map map = new HashMap<String,Object>();
		map.put("startIndex",startIndex);
		map.put("endIndex",endIndex);
		map.put("operator",!CommUtils.isNull(log.getOperator())?log.getOperator():null);
		map.put("startTime",!CommUtils.isNull(startTime)?startTime:null);
		map.put("endTime",!CommUtils.isNull(endTime)?endTime:null);

		List<SysLog> rows = manageMapper.findSysLogList(map);
		page.setTotalCount(manageMapper.findSysLogListCount(map));
		page.setResult(rows);

		return page;
	}

	// 查询日志总行数
//	@Override
//	public int TotalLogin(SysLog log, String startTime, String endTime) {
//		String hql = "select count(id) from sys_log where 1=1";
//		if (StringUtils.isNotBlank(log.getOperator())) {
//			hql += " and operator like '%" + log.getOperator() + "%'";
//		}
//		if (StringUtils.isNotBlank(log.getDescription())) {
//			hql += " and description  like '%" + log.getDescription() + "%'";
//		}
//		if (!CommUtils.isNull(startTime)) {
//			hql += " and left(operate_time,10)>='" + startTime + "'";
//		}
//		if (!CommUtils.isNull(endTime)) {
//			hql += " and left(operate_time,10)<='" + endTime + "'";
//		}
//		return manageMapper.selectOne(hql, Integer.class);
//	}

	/**
	 * 添加操作日志
	 * 
	 * @param matter 内容
	 * @param result 状态
	 */
	@Override
	public int saveSysLog(String matter, String result, SysUser sysUser, String ip) {
		SysLog log = new SysLog();
		log.setOperateTime(new Date());
		log.setOperator(sysUser.getLoginName());
		log.setDescription(matter);
		log.setOperateResult(result);
		log.setIp(ip);
//		String hql = "insert into sys_log (operator,operate_time,description,operate_result,ip) values" + " ('"
//				+ log.getOperator() + "',NOW(),'" + log.getDescription() + "','" + log.getOperateResult() + "','"
//				+ log.getIp() + "')";
		return manageMapper.insertSysLog(log);

	}

	@Override
	public SysOrganization findByDeptId(Long dId) {
		return manageMapper.selectSysOrganization(dId);
	}

	@Override
	public List<SysCity> findByOrgIdAndCity(String orgId) {
		if (CommUtils.isNull(orgId)) {
			return manageMapper.selectAllSysCity();
		} else {
			return manageMapper.selectSysCityByOrgId(orgId);
		}
	}

	@Override
	public List<TreeModel> findRuleTree(boolean isRecursion) {
		List<TreeModel> ruleTree = null;
		if (!isRecursion) {
			List<SysOrganization> ruleList = manageMapper.selectAllSysOrganization();
			if (!CommUtils.isNull(ruleList)) {
				ruleTree = new ArrayList<TreeModel>();
				for (SysOrganization rule : ruleList) {
					TreeModel tree = new TreeModel();
					tree.setId(String.valueOf(rule.getId()));
					tree.setParentId(rule.getFatherId().toString());
					tree.setName(rule.getOrgName());
					ruleTree.add(tree);
				}
			}
		}
		return ruleTree;
	}

	@Override
	public int saveSysMallLog(String operator, String model, String description, String operateResult, String ip) {
		SysMallLog malllog = new SysMallLog();
		malllog.setOperateTime(new Date());
		malllog.setOperator(operator);
		malllog.setModel(model);
		malllog.setDescription(description);
		malllog.setOperateResult(operateResult);
		malllog.setIp(ip);
		return manageMapper.insertSysMallLog(malllog);
	}

	// 查询操作日志
	@Override
	public Page<SysMallLog> queryMallLogin(SysMallLog log, int pageNo, int pageSize, String startTime, String endTime)
			throws BusException {
		Page<SysMallLog> page = new Page<>();
//		page.setPageNo((pageNo - 1) * pageSize);
//		page.setPageSize(pageSize);
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);
		Long startIndex = Long.valueOf(((int) pageNo - 1) * (int) pageSize);
		Long endIndex = Long.valueOf((int) pageSize);

		Map map = new HashMap<String,Object>();
		map.put("startIndex",startIndex);
		map.put("endIndex",endIndex);
		map.put("operator",!CommUtils.isNull(log.getOperator())?log.getOperator():null);
		map.put("model",!CommUtils.isNull(log.getModel())?log.getModel():null);
		map.put("startTime",!CommUtils.isNull(startTime)?startTime:null);
		map.put("endTime",!CommUtils.isNull(endTime)?endTime:null);

		List<SysMallLog> rows = manageMapper.findSysMallLogList(map);
		page.setTotalCount(manageMapper.findSysMallLogListCount(map));
		page.setResult(rows);

		return page;
	}

}
