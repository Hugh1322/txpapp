package com.txp.app.system.service;

import java.util.*;

import com.txp.app.dto.BjuiDto;
import com.txp.app.dto.MessageDto;
import com.txp.app.entity.Page;
import com.txp.app.exception.BusException;
import com.txp.app.supplier.dto.MallSupplierSysuser;
import com.txp.app.supplier.entity.MallSupplier;
import com.txp.app.supplier.repository.MallSupplierMapper;
import com.txp.app.system.dto.SysDeptUser;
import com.txp.app.system.dto.SysRule;
import com.txp.app.system.dto.SysUser;
import com.txp.app.system.dto.SysUserRole;
import com.txp.app.system.repository.SysUserMapper;
import com.txp.app.util.CommUtils;
import com.ytoxl.module.core.common.pagination.BasePagination;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;

import javax.annotation.Resource;


@Slf4j
@Service("sysUserService")
public class SysUserServiceImpl implements SysUserService {

	@Resource
	private SysUserMapper sysUserMapper;

	@Autowired
	private SysUserRoleService sysUserRoleService;

	@Autowired
	private SysDeptUserService sysDeptUserService;

	@Resource
	private MallSupplierMapper mallSupplierMapper;


	/*
	 * 查询所有user
	 */
	@Override
	public List<SysUser> findAll() {
		return sysUserMapper.selectAllList(null);
	}

	/**
	 * 查询分页
	 */
	@Override
	public Page findSysUser(SysUser user, int pageNo, int pageSize, String beginTime, String endTime) {
		Page<SysUser> page = new Page<SysUser>();
		page.setPageNo(pageNo);
		page.setPageSize(pageSize);
		Long startIndex = Long.valueOf(((int) pageNo - 1) * (int) pageSize);
		Long endIndex = Long.valueOf((int) pageSize);

		Map map = new HashMap<String,Object>();
		map.put("startIndex",startIndex);
		map.put("endIndex",endIndex);
		map.put("realName",!CommUtils.isNull(user.getRealName())?user.getRealName():null);
		map.put("status",!CommUtils.isNull(user.getStatus())?user.getStatus():null);
		map.put("sex",!CommUtils.isNull(user.getSex())?user.getSex():null);
		map.put("beginTime",!CommUtils.isNull(beginTime)?beginTime:null);
		map.put("endTime",!CommUtils.isNull(endTime)?endTime:null);
		if(!CommUtils.isNull(user) && !CommUtils.isNull(user.getMallSupplier())) {
			map.put("mallSupplierId",user.getMallSupplier().getId());
		}

		page.setTotalCount(sysUserMapper.findSysUserListCount(map));
//		page.setPageNo((pageNo - 1) * pageSize);
//		page.setPageSize(pageSize);

		List<SysUser> rows = sysUserMapper.findSysUserList(map);

		for (int i = 0; i < rows.size(); i++) {
			try {
				String[] roleIds = rows.get(i).getPassword().split(",");
				List<String> roleIdList = Arrays.asList(roleIds);
				String roleName = sysUserMapper.selectRoleName(roleIdList);
				rows.get(i).setPassword(roleName);
			} catch (Exception e) {
				log.error("============" + rows.get(i).getId(), e);
			}
		}
		page.setResult(rows);
		return page;
	}

//	@Override
//	public Long getRowCount(SysUser user) {
//		return Integer.toUnsignedLong(super.selectCount(user));
//	}

	/**
	 * 添加用户
	 */
	@Override
	public boolean insertUser(SysUser user, String deptId, String roleId, String supplierId, String passStr, Integer ... type) {
		// String sql = "insert into sys_user"
		// + "(login_name,real_name,password,sex,email,phone,status,create_time) VALUES"
		// + "(#{loginName},#{realName},#{password},#{sex},#{email},#{phone},#{status},#{createTime})";
		// int userResult = sqlMapper.insert(sql,user);
		// 发送短信
//		MsgReqData msgReqData = new MsgReqData();
//		msgReqData.setPhone(user.getPhone());
//		msgReqData.setMsg("【水象分期】尊敬的" + user.getLoginName() + "您在水象分期后台审核系统添加用户的密码为" + passStr + "！");
//		// 短信的环境 0 真是环境 1 测试环境
//		msgReqData.setType(String.valueOf(SystemConstant.MESSAGE_CIRCUMSTANCE));
//		Response<Object> rsp = BeadWalletSendMsgService.sendMsg(msgReqData);
//		log.info("添加用户发送短信" + rsp.getRequestMsg());
		String message = "尊敬的" + user.getLoginName() + "您在水象分期后台审核系统添加用户的密码为" + passStr + "！";
//		boolean bo = sendMessageCommonService.commonSendMessage("1", user.getPhone(), message);
		MessageDto messageDto = new MessageDto();
		messageDto.setBusinessScenario("1");
		messageDto.setPhone(user.getPhone());
		messageDto.setMsg(message);
		messageDto.setType("1");
		//暂时去掉
//		RedisUtils.rpush("system:sendMessage", JSON.toJSONString(messageDto));
		boolean bo = true;
		boolean success = false;
		if (bo) {
//		if (rsp.getRequestCode().equals("200")) {
			// 添加用户
			int successNum1 = sysUserMapper.insertSelective(user);
			// 添加用户角色
			String[] splitRole = roleId.split(",");
			for (int i = 0; i < splitRole.length; i++) {
				SysUserRole role = new SysUserRole(user.getId(), Long.valueOf(splitRole[i]));
				sysUserRoleService.insert(role);
			}
			// 添加用户部门
			if (StringUtils.isNotEmpty(deptId)) {
				SysDeptUser sysDeptUser = new SysDeptUser(Long.valueOf(deptId), user.getId());
				sysDeptUserService.insert(sysDeptUser);
			} else {
				SysDeptUser sysDeptUser = new SysDeptUser(0L, user.getId());
				sysDeptUserService.insert(sysDeptUser);
			}

			// 添加用户供应商
			if (StringUtils.isNotEmpty(supplierId)) {
				MallSupplierSysuser mallSupplierSysuser = new MallSupplierSysuser();
				mallSupplierSysuser.setSysUserId(user.getId());
				mallSupplierSysuser.setMallSupplierId(Long.valueOf(supplierId));
				if(!CommUtils.isNull(type)&&type[0].intValue()==1) {
					mallSupplierSysuser.setType(1);
				}
				mallSupplierMapper.insertMallSupplierSysuser(mallSupplierSysuser);
			}

			if (successNum1 > 0) {
				success = true;
			}
		}

		return success;

	}

	@Override
	public SysUser findUserByLoginName(String loginName) {
		Map<String,Object> map = new HashMap<>();
		map.put("loginName",loginName);
		List<SysUser> userList = sysUserMapper.selectAllList(map);
		return CommUtils.isNull(userList) ? null : userList.get(0);
	}

	@Override
	public SysUser findUserByKey(Long id) {
		return sysUserMapper.selectByPrimaryKey(id);
	}

	@Override
	public boolean updateUser(SysUser user, String roleId, String deptId, String supplierId) {
		// 更新用户信息
		int userUpdate = sysUserMapper.updateByPrimaryKeySelective(user);
		// 更新用户角色信息
		sysUserMapper.deleteSysUserRole(user.getId());
		String[] splitRole = roleId.split(",");
		for (int i = 0; i < splitRole.length; i++) {
			SysUserRole sysUserRole = new SysUserRole(user.getId(), Long.valueOf(splitRole[i]));
			sysUserRoleService.update(sysUserRole);
		}

		// 更新用户部门信息
		if (StringUtils.isEmpty(deptId)) {
			deptId = "0";
		}
		SysDeptUser sysDeptUser = new SysDeptUser(Long.valueOf(deptId), user.getId());
		sysDeptUserService.update(sysDeptUser);

		// 更新用户所属供应商信息
		if (!StringUtils.isEmpty(supplierId)) {
			MallSupplier mallSupplier = mallSupplierMapper.findMallSupplierByUserId(user.getId());
			if(mallSupplier==null) {
				MallSupplierSysuser mallSupplierSysuser = new MallSupplierSysuser();
				mallSupplierSysuser.setSysUserId(user.getId());
				mallSupplierSysuser.setMallSupplierId(Long.valueOf(supplierId));
				mallSupplierMapper.insertMallSupplierSysuser(mallSupplierSysuser);
			}else {
				MallSupplierSysuser mallSupplierSysuser = new MallSupplierSysuser();
				mallSupplierSysuser.setSysUserId(user.getId());
				mallSupplierSysuser.setMallSupplierId(Long.valueOf(supplierId));
				mallSupplierMapper.updateMallSupplierSysuser(mallSupplierSysuser);
			}
		}

		if (userUpdate > 0) {
			return true;
		}
		return false;
	}

	@Override
	public BjuiDto delete(Long id) throws Exception {
		try {
			BjuiDto bjuiDto = new BjuiDto();
			// 删除用户记录
			//商城后台的管理 不用此逻辑
//			int merchantSysuserCount = sysUserMapper.selectMerchantSysuserBySysId(id);
//			if(merchantSysuserCount>0) {
//				bjuiDto.setMessage("该用户存在商户帐号，无法删除");
//				bjuiDto.setStatusCode("300");
//				return bjuiDto;
//			}
			int deleteId = sysUserMapper.deleteByPrimaryKey(id);
			// 删除用户拥有的角色
			int roleId = sysUserRoleService.delete(id);
			// 删除用户拥有的部门
			int deprId = sysDeptUserService.delete(id);
			if (deleteId > 0 && roleId > 0 && deprId > 0) {
				bjuiDto.setStatusCode("200");
				bjuiDto.setTabid("sys_user");
				return bjuiDto;
			}
			bjuiDto.setStatusCode("300");
			bjuiDto.setMessage("删除失败");
			return bjuiDto;
		}catch (Exception e) {
			log.error("删除用户出错"+e,e);
			throw new Exception("删除用户出错");
		}
	}

	/**
	 * 批量删除
	 */
	@Override
	public boolean bulkDeleteUser(String ids) {
		// 批量删除用户
		int result1 = sysUserMapper.deleteByIds(ids);
		// 批量删除用户拥有的角色
		int result2 = sysUserRoleService.batchDeleteRole(ids);
		// 批量删除用户所属的部门信息
		int result3 = sysDeptUserService.batchDeleteDept(ids);
		if (result1 > 0 && result2 > 0 && result3 > 0) {
			return true;
		}
		return false;
	}

	@Override
	public String queryOrg(String username) {
		return sysUserMapper.queryOrg(username);
	}

	@Override
	public List<SysRule> queryRole(Long id) throws BusException{
		if(StringUtils.isEmpty(String.valueOf(id))){
			throw new BusException("用户ID为空");
		}
		String split=sysUserMapper.selectRoleId(id);
		String[] roleIds = split.split(",");
		List<String> roleIdList = Arrays.asList(roleIds);
		return sysUserMapper.selectSysRule(roleIdList);
	}

	@Override
	public void updateByPrimaryKeySelective(SysUser user) {
		sysUserMapper.updateByPrimaryKeySelective(user);
	}

	@Override
	public BasePagination<SysUser> findUserByCriteriaAndPage(BasePagination<SysUser> userPage) {
		Map<String, Object> searchParams = userPage.getSearchParamsMap();
		if (userPage.isNeedSetTotal()) {
			Integer total = sysUserMapper.findSysUserListCountNew(searchParams);
			userPage.setTotal(total);
		}
		List<SysUser> result = sysUserMapper.findSysUserListNew(searchParams);
		if (result.size() > 0) {
			handleResult(result);
		}
		userPage.setResult(result);
		return userPage;
	}

	private void handleResult(List<SysUser> result) {
		for (int i = 0; i < result.size(); i++) {
			try {
				String[] roleIds = result.get(i).getPassword().split(",");
				List<String> roleIdList = Arrays.asList(roleIds);
				String roleName = sysUserMapper.selectRoleName(roleIdList);
				result.get(i).setPassword(roleName);
			} catch (Exception e) {
				log.error("============" + result.get(i).getId(), e);
			}
		}
	}

//	@Override
//	public BwBorrower getBwBorrowerByPhone(String phone) {
//		String sql = "SELECT b.id,b.phone FROM bw_borrower b WHERE b.phone = '"+phone+"' LIMIT 1";
//		BwBorrower bwBorrower = sqlMapper.selectOne(sql, BwBorrower.class);
//		return bwBorrower;
//	}

}
