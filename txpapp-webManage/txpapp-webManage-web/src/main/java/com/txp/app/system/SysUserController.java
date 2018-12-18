package com.txp.app.system;

import com.txp.app.contants.MallConstant;
import com.txp.app.dto.BjuiDto;
import com.txp.app.dto.RemoteDto;
import com.txp.app.entity.Page;
import com.txp.app.service.supplier.ApiSupplierService;
import com.txp.app.supplier.dto.MallSupplierDto;
import com.txp.app.system.dto.SysDepartment;
import com.txp.app.system.dto.SysRole;
import com.txp.app.system.dto.SysUser;
import com.txp.app.system.service.ManageSevice;
import com.txp.app.system.service.SysDepartmentService;
import com.txp.app.system.service.SysRoleService;
import com.txp.app.system.service.SysUserService;
import com.txp.app.util.*;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

import java.util.Date;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/system/user")
@Slf4j
public class SysUserController {

	@Autowired
	private SysUserService sysUserService;

	@Autowired
	private SysRoleService sysRoleService;

	@Autowired
	private ManageSevice manageSevice;

	@Autowired
	private SysDepartmentService departmentService;

	@Resource
	private ApiSupplierService apiSupplierService;

	/**
	 * 分页查询用户列表
	 *
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "findUserByCriteriaAndPage.do" , method={RequestMethod.POST, RequestMethod.GET})
	public String findUserByCriteriaAndPage(HttpServletRequest request, HttpServletResponse response,
											ModelMap modelMap,com.ytoxl.module.core.common.pagination.BasePagination<SysUser> userPage) {
		try {
			Map<String, String> params = new HashMap<>();
			String realName = request.getParameter("realName");
			String status = request.getParameter("status");
			String beginTime = request.getParameter("beginTime");
			String endTime = request.getParameter("endTime");

			if(!StringUtil.isEmpty(realName)) {
				params.put("realName",realName);
			}
			if(!StringUtil.isEmpty(status)) {
				params.put("status",status);
			}

			if (!StringUtils.isBlank(beginTime)) {
				params.put("beginTime",beginTime+" 00:00:00");
			}
			if (!StringUtils.isBlank(endTime)) {
				params.put("endTime",endTime+" 23:59:59");
			}

			//封装返回的page
			if(userPage.getLimit()==null || userPage.getLimit().intValue()==0) {
				userPage.setLimit(20);
			}
			userPage.setParams(params);
			modelMap.put("userPage",sysUserService.findUserByCriteriaAndPage(userPage));
		}catch (Exception e) {
			log.error("findUserByCriteriaAndPage error:"+e,e);
		}
		return "system/sys_user_new";
	}

	/**
	 * 跳转到添加用户页面
	 *
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "getUserAddPage.do")
	public String getUserAddPage(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap)
			throws Exception {
		return "system/sys_user_add";
	}

	/**
	 * 跳转到用户编辑页面
	 *
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "getUserEditPage.do")
	public String getUserEditPage(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap)
			throws Exception {
		String id = request.getParameter("id");
		SysUser user = sysUserService.findUserByKey(Long.parseLong(id));
		//查询用户拥有的角色
		List<SysRole> roleSet = sysRoleService.findRoleByUserId(user.getId());
		//查询用户拥有的部门
		SysDepartment sysDepartment = departmentService.findDeptByUserId(user.getId());
		String deptName="";
		if(sysDepartment == null){
			deptName="上海总部";
		}else{
			deptName=sysDepartment.getDeptName();
		}
		//查询用户所属的供应商
		MallSupplierDto mallSupplierDto = apiSupplierService.findMallSupplierByUserId(user.getId());
		modelMap.put("mallSupplier", mallSupplierDto);

		StringBuilder roleIds = null;
		StringBuilder roleNames = null;
		if (!CommUtils.isNull(roleSet)) {
			roleIds = new StringBuilder();
			roleNames = new StringBuilder();
			for (SysRole role : roleSet) {
				roleIds.append(role.getId()).append(",");
				roleNames.append(role.getRoleName()).append(",");
			}
			String roleId = roleIds.toString();
			roleId = roleId.substring(0, roleId.lastIndexOf(","));
			String roleName = roleNames.toString();
			roleName = roleName.substring(0, roleName.lastIndexOf(","));
			modelMap.put("roleId", roleId);
			modelMap.put("roleName", roleName);
			modelMap.put("sysDepartment", sysDepartment);
			modelMap.put("deptName", deptName);
		}
		modelMap.put("user", user);
		return "system/sys_user_edit";
	}

	/**
	 * 批量删除用户
	 *
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "bulkDeleteUser.do")
	@ResponseBody
	public BjuiDto bulkDeleteUser(HttpServletRequest request, HttpServletResponse response) {
		BjuiDto bjuiDto = new BjuiDto();
		SysUser user0 = (SysUser) request.getSession().getAttribute(SystemConstant.SESSION_USER);
		String delids = request.getParameter("delids");
		try {
			log.info("批量删除后台系统用户");
			//批量删除
			String[] idList = delids.split(",");
			int s_count = 0;
			int f_count = 0;
			for(int i=0;i<idList.length;i++) {
				try {
					bjuiDto = sysUserService.delete(Long.valueOf(idList[i]));
				}catch (Exception e) {
					log.error("bulkDeleteUser.sysUserService.delete.error:"+e,e);
					f_count++;
					continue;
				}
				if(bjuiDto!=null&&bjuiDto.getStatusCode().equals("200")){
					s_count++;
				}else {
					f_count++;
				}
			}
//			sysUserService.bulkDeleteUser(delids);
			bjuiDto.setStatusCode("200");
			bjuiDto.setTabid("sys_user");
			bjuiDto.setMessage("批量删除：成功"+ s_count+"条，失败"+f_count+"条。");
			manageSevice.saveSysMallLog(user0.getLoginName(), MallConstant.MODEL_SYSTEM,"批量删除用户：", SystemConstant.SUCCESSFUL_OPERATION+",删除的用户id为:"+delids, CommUtils.getIpAddr(request));
		} catch (Exception e) {
			bjuiDto.setStatusCode("300");
			bjuiDto.setMessage("删除失败！");
			manageSevice.saveSysMallLog(user0.getLoginName(),MallConstant.MODEL_SYSTEM,"批量删除用户：", SystemConstant.OPERATION_FAILURE+",删除的用户id为:"+delids, CommUtils.getIpAddr(request));
			log.error("删除用户失败！", e);
		}
		return bjuiDto;
	}

	/**
	 * 删除用户
	 *
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "deleteUser.do")
	@ResponseBody
	public BjuiDto deleteUser(HttpServletRequest request, HttpServletResponse response) throws Exception {
		BjuiDto bjuiDto = new BjuiDto();
		String id = request.getParameter("id");
		SysUser user0 = (SysUser) request.getSession().getAttribute(SystemConstant.SESSION_USER);
		try {
			bjuiDto = sysUserService.delete(Long.valueOf(id));
			if(bjuiDto.getStatusCode().equals("200")){
				manageSevice.saveSysMallLog(user0.getLoginName(), MallConstant.MODEL_SYSTEM,"删除用户", SystemConstant.SUCCESSFUL_OPERATION+",删除的用户编号为:"+id, CommUtils.getIpAddr(request));
			}
		} catch (Exception e) {
			bjuiDto.setStatusCode("300");
			bjuiDto.setMessage("删除失败！");
			manageSevice.saveSysMallLog(user0.getLoginName(), MallConstant.MODEL_SYSTEM,"删除用户", SystemConstant.OPERATION_FAILURE+",删除的用户编号为:"+id, CommUtils.getIpAddr(request));
			log.error("删除用户失败！", e);
		}
		return bjuiDto;
	}

	/**
	 * 验证用户登录名唯一性
	 *
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "validateUserLoginName.do")
	@ResponseBody
	public RemoteDto validateUserLoginName(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap)
			throws Exception {
		String loginName = request.getParameter("loginName");
		SysUser user = sysUserService.findUserByLoginName(loginName);
		RemoteDto remoteDto = new RemoteDto();
		if (CommUtils.isNull(user)) {
			remoteDto.setOk("");
		} else {
			remoteDto.setError("该登录用户名已使用");
		}
		return remoteDto;
	}

	/**
	 * 验证用户登录名(手机号)唯一性
	 *
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "validateUserPhone.do")
	@ResponseBody
	public RemoteDto validateUserPhone(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap)
			throws Exception {
		String phone = request.getParameter("phone");
		RemoteDto remoteDto = new RemoteDto();
		if(StringUtil.isEmpty(StringUtil.trimStr(phone))) {
			remoteDto.setError("手机号不能为空");
		}else {
			phone = StringUtil.trimStr(phone);
			SysUser user = sysUserService.findUserByLoginName(phone);
			if (CommUtils.isNull(user)) {
				remoteDto.setOk("");
			} else {
				remoteDto.setError("手机号已使用");
			}
		}
		return remoteDto;
	}

	/**
	 * 添加用户
	 *
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "saveUser.do")
	@ResponseBody
	public BjuiDto saveUser(HttpServletRequest request, HttpServletResponse response) throws Exception {
		BjuiDto bjuiDto = new BjuiDto();
		String passStr= VerifyCodeUtils.generateVerifyCode(6);
		SysUser user0 = (SysUser) request.getSession().getAttribute(SystemConstant.SESSION_USER);
		String loginName = request.getParameter("loginName");
		try {
			String realName = request.getParameter("realName");
			String email = request.getParameter("email");
			String sex = request.getParameter("sex");
			String status = request.getParameter("status");
			String phone = request.getParameter("phone");
			//角色id
			String roleIds = request.getParameter("role.id");
			//获取部门编号
			String departmentId = request.getParameter("dept.id");
			//供应商id
			String supplierId = request.getParameter("supplier.id");
			SysUser user = new SysUser();
			user.setLoginName(loginName);
			user.setRealName(realName);
//			user.setPassword(CommUtils.getMD5(passStr.getBytes()));
			user.setPassword(CommUtils.getMD5("123456".getBytes()));
			user.setEmail(email);
			user.setPhone(phone);
			user.setSex(StringUtils.isBlank(sex) ? 1 : Integer.parseInt(sex));
			user.setStatus(StringUtils.isBlank(status) ? 1 : Integer.parseInt(status));
			Date curDate = new Date();
			user.setCreateTime(curDate);
			user.setUpdateTime(curDate);
			user0.getMallSupplier();
			boolean ch = false;
			if(user0!=null&&user0.getMallSupplier()!=null) {
				//添加用户操作
				ch = sysUserService.insertUser(user,"0", roleIds,user0.getMallSupplier().getId().toString(),passStr);
			}else {
				//添加用户操作
				ch = sysUserService.insertUser(user,departmentId, roleIds,supplierId,passStr);
			}

			if(ch){
				//添加用户角色记录
				bjuiDto.setStatusCode("200");
				bjuiDto.setTabid("sys_user");
				bjuiDto.setCloseCurrent(true);

				manageSevice.saveSysMallLog(user0.getLoginName(), MallConstant.MODEL_SYSTEM,"添加用户", SystemConstant.SUCCESSFUL_OPERATION+",用户登录名为:"+loginName, CommUtils.getIpAddr(request));
			}else{
				manageSevice.saveSysMallLog(user0.getLoginName(), MallConstant.MODEL_SYSTEM,"添加用户", SystemConstant.OPERATION_FAILURE+",用户登录名为:"+loginName+"添加失败,发送短信SDK异常！", CommUtils.getIpAddr(request));
				bjuiDto.setStatusCode("300");
				bjuiDto.setMessage("添加失败,发送短信SDK异常！");
			}
		} catch (Exception e) {
			bjuiDto.setStatusCode("300");
			bjuiDto.setMessage("添加失败！");
			manageSevice.saveSysMallLog(user0.getLoginName(), MallConstant.MODEL_SYSTEM,"添加用户", SystemConstant.OPERATION_FAILURE+",用户登录名为:"+loginName, CommUtils.getIpAddr(request));
			log.error("添加用户失败！"+e,e);
		}
		return bjuiDto;
	}

	/**
	 * 编辑用户
	 *
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "updateUser.do")
	@ResponseBody
	public BjuiDto updateUser(HttpServletRequest request, HttpServletResponse response) throws Exception {
		BjuiDto bjuiDto = new BjuiDto();
		String loginName = request.getParameter("loginName");
		SysUser user0 = (SysUser) request.getSession().getAttribute(SystemConstant.SESSION_USER);
		try {
			String id = request.getParameter("id");
			String realName = request.getParameter("realName");
			String email = request.getParameter("email");
			String phone = request.getParameter("phone");
			String sex = request.getParameter("sex");
			String status = request.getParameter("status");
			//用户所属角色编号
			String roleIds = request.getParameter("role.id");
			//用户所属部门
			String departmentId = request.getParameter("dept.id");
			//供应商id
			String supplierId = request.getParameter("supplier.id");
			SysUser user = new SysUser();
			user.setId(Long.valueOf(id));
			user.setLoginName(loginName);
			user.setRealName(realName);
			user.setEmail(email);
			user.setPhone(phone);
			user.setSex(StringUtils.isBlank(sex) ? 1 : Integer.parseInt(sex));
			user.setStatus(StringUtils.isBlank(status) ? 1 : Integer.parseInt(status));
			user.setUpdateTime(new Date());
			//更新用户信息以及用户的所属部门
			log.info("updateUser:"+roleIds);

			if(user0!=null&&user0.getMallSupplier()!=null) {
				sysUserService.updateUser(user , roleIds.toString() ,null, user0.getMallSupplier().getId().toString());
			}else {
				sysUserService.updateUser(user , roleIds.toString() ,departmentId, supplierId);
			}
			bjuiDto.setStatusCode("200");
			bjuiDto.setTabid("sys_user");
			bjuiDto.setCloseCurrent(true);
			manageSevice.saveSysMallLog(user0.getLoginName(), MallConstant.MODEL_SYSTEM,"编辑用户", SystemConstant.SUCCESSFUL_OPERATION+",编辑的用户名为:"+loginName, CommUtils.getIpAddr(request));
		} catch (Exception e) {
			bjuiDto.setStatusCode("300");
			bjuiDto.setMessage("编辑失败！");
			manageSevice.saveSysMallLog(user0.getLoginName(), MallConstant.MODEL_SYSTEM,"编辑用户", SystemConstant.OPERATION_FAILURE+",编辑的用户名为:"+loginName, CommUtils.getIpAddr(request));
			log.error("编辑用户信息失败！", e);
		}
		return bjuiDto;
	}

	/**
	 * 添加操作日志
	 *
	 * @param request
	 * @param description
	 */
//	private void saveSysLog(HttpServletRequest request, String description) {
//		SysUser user = (SysUser) request.getSession().getAttribute(SystemConstant.SESSION_USER);
//		SysLog log = new SysLog();
//		log.setOperateTime(new Date());
//		log.setOperator(user.getLoginName());
//		log.setDescription(description);
//		log.setOperateResult("操作成功");
//		log.setIp(CommUtils.getIpAddr(request));
//		sysLogService.saveLog(log);
//	}

}
