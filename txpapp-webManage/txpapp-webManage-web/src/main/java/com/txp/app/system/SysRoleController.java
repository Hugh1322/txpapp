package com.txp.app.system;

import com.txp.app.dto.BjuiDto;
import com.txp.app.entity.Page;
import com.txp.app.service.supplier.ApiSupplierService;
import com.txp.app.system.dto.SysRole;
import com.txp.app.system.dto.SysRoleRule;
import com.txp.app.system.dto.SysRule;
import com.txp.app.system.dto.SysUser;
import com.txp.app.system.service.ManageSevice;
import com.txp.app.system.service.SysRoleService;
import com.txp.app.system.service.SysRuleService;
import com.txp.app.util.*;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;


/**
 * 角色管理
 * 
 * @author WEIHU
 */
@Controller
@RequestMapping("/system/role")
@Slf4j
public class SysRoleController {
	
	@Autowired
	private SysRoleService roleService;

	@Autowired
	private ManageSevice manageSevice;
	
	@Autowired
	private SysRuleService sysRuleService;
	@Resource
	private ApiSupplierService apiSupplierService;
	/**
	 * 添加角色
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping("/save.do")
	public String saveDepartment(HttpServletRequest request, HttpServletResponse response)throws Exception{
		String json = "{\"code\":200,\"msg\":\"start！\"}";
		SysRole sysRole = new SysRole();
		sysRole.setRoleName(request.getParameter("roleName"));
		sysRole.setRoleCode(request.getParameter("roleCode"));
		sysRole.setRoleDesc(request.getParameter("roleDesc"));
		String[] ruleIds2 = request.getParameterValues("chkbox");
//		String ruleIds = request.getParameter("ruleIds");
		String ruleIds = StringUtils.join(ruleIds2,",");
		try {
			SysUser user = (SysUser) request.getSession().getAttribute(SystemConstant.SESSION_USER);
			Long supplierId = null;
			if(user!=null&&user.getMallSupplier()!=null&&user.getMallSupplier().getId()!=null) {
				supplierId = user.getMallSupplier().getId();
			}

			if(roleService.findByName(sysRole.getRoleName()) || roleService.findByCode(sysRole.getRoleCode())) {
//				bjuiDto.setStatusCode("300");
//				bjuiDto.setMessage("添加角色失败！存在相同的角色");
				log.error("添加角色失败！存在相同的角色");
				json = "{\"code\":300,\"msg\":\"添加角色失败！存在相同的角色！\"}";
				return json;
			}
			Set<SysRule> ruleSet = new HashSet<SysRule>();
			if (!CommUtils.isNull(ruleIds)) {
				String[] ids = ruleIds.split(",");
				for (String ruleId : ids) {
					SysRule rule = new SysRule();
					rule.setId(Long.parseLong(ruleId));
					ruleSet.add(rule);
				}
				//sysRole.setRules(ruleSet);
			}
			Long roleId = roleService.insertRole(sysRole);
			roleService.insertRoleRule(roleId,ruleSet);
			if(supplierId!=null) {
				apiSupplierService.saveMallSupplierRole(roleId,supplierId);
			}
			//roleService.insertRole(sysRole);
//			bjuiDto.setStatusCode("200");
//			bjuiDto.setTabid("sys_role");
//			bjuiDto.setCloseCurrent(true);
			json = "{\"code\":200,\"msg\":\"添加成功！\"}";
			//保存到日志
//			manageSevice.saveSysLog("添加角色", SystemConstant.SUCCESSFUL_OPERATION+sysRole.getRoleName(), user,CommUtils.getIpAddr(request));
		} catch (Exception e) {
//			bjuiDto.setStatusCode("300");
//			bjuiDto.setMessage("添加失败！");
			json = "{\"code\":300,\"msg\":\"添加角色失败！\"}";
			log.error("添加角色失败！", e);
		}
		return json;
	}
	/**
	 * 删除角色
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/delete.do")
	@ResponseBody
	public BjuiDto deleteDepartment(HttpServletRequest request, HttpServletResponse response) throws Exception{
		BjuiDto bjuiDto = new BjuiDto();
		Long roleId  = Long.valueOf(request.getParameter("id"));
		//Long roleId = 3l;
		try {
			//该角色下的用户
			List<Long> sysUserIdList = roleService.findUserBySysRole(roleId);
			if(sysUserIdList!=null && sysUserIdList.size()>0) {
				bjuiDto.setStatusCode("300");
				bjuiDto.setMessage("删除角色失败！请先删除这个角色的所有用户");
				log.error("删除角色失败！请先删除这个角色的所有用户");
				return bjuiDto;
			}
			roleService.deleteRole(roleId);
			roleService.deleteRoleRule(roleId);
			roleService.deleteUserRole(roleId);
			apiSupplierService.deleteMallSupplierRole(roleId);
			bjuiDto.setStatusCode("200");
			bjuiDto.setTabid("sys_role");
			//保存到日志
			//saveSysLog(request, "删除角色，ID：" + roleId);
			SysUser user = (SysUser) request.getSession().getAttribute(SystemConstant.SESSION_USER);
			manageSevice.saveSysLog("删除角色，ID：", SystemConstant.SUCCESSFUL_OPERATION+roleId, user,CommUtils.getIpAddr(request));
		} catch (Exception e) {
			bjuiDto.setStatusCode("300");
			bjuiDto.setMessage("删除失败！");
			log.error("删除角色失败！", e);
		}
		return bjuiDto;
	}

//	@RequestMapping(value = "/deleteNew.do",produces = {"application/json;charset=UTF-8"})
	@RequestMapping(value = "/deleteNew.do")
	@ResponseBody
	public String deleteNew(HttpServletRequest request, HttpServletResponse response) throws Exception{
		response.setContentType("text/xml");
		response.setCharacterEncoding("utf-8");
		String json = "{\"code\":200,\"msg\":\"start！\"}";
		Long roleId  = Long.valueOf(request.getParameter("id"));
		//Long roleId = 3l;
		try {
			//该角色下的用户
			List<Long> sysUserIdList = roleService.findUserBySysRole(roleId);
			if(sysUserIdList!=null && sysUserIdList.size()>0) {
				json = "{\"code\":300,\"msg\":\"删除角色失败！请先删除这个角色的所有用户！\"}";
				log.error("删除角色失败！请先删除这个角色的所有用户");
//				response.getWriter().write(json);
//				return;
				return json;
			}
			roleService.deleteRole(roleId);
			roleService.deleteRoleRule(roleId);
			roleService.deleteUserRole(roleId);
			apiSupplierService.deleteMallSupplierRole(roleId);
			json = "{\"code\":200,\"msg\":\"删除角色成功！\"}";
			//保存到日志
			//saveSysLog(request, "删除角色，ID：" + roleId);
//			SysUser user = (SysUser) request.getSession().getAttribute(SystemConstant.SESSION_USER);
//			manageSevice.saveSysLog("删除角色，ID：", SystemConstant.SUCCESSFUL_OPERATION+roleId, user,CommUtils.getIpAddr(request));
		} catch (Exception e) {
			json = "{\"code\":300,\"msg\":\"删除失败！\"}";
			log.error("删除角色失败！", e);
		}
//		response.getWriter().write(json);
		return json;
//		return;
	}

	/**
	 * 修改角色
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@ResponseBody
	@RequestMapping(value = "/update.do")
	public String updateDepartment(HttpServletRequest request, HttpServletResponse response) throws Exception{
		String json = "{\"code\":200,\"msg\":\"start！\"}";
		BjuiDto bjuiDto = new BjuiDto();
		SysRole sysRole = new SysRole();
		sysRole.setRoleName(request.getParameter("roleName"));
		sysRole.setRoleCode(request.getParameter("roleCode"));
		sysRole.setRoleDesc(request.getParameter("roleDesc"));
		String roleId = request.getParameter("roleId");
		String[] ruleIds2 = request.getParameterValues("chkbox");
//		String ruleIds = request.getParameter("ruleIds");
		String ruleIds = StringUtils.join(ruleIds2,",");
		sysRole.setId(Long.parseLong(roleId));
		try {
			if(roleService.findBySysRole(sysRole)) {
//				bjuiDto.setStatusCode("300");
//				bjuiDto.setMessage("修改角色失败！存在相同的角色");
				log.error("修改角色失败！存在相同的角色");
				json = "{\"code\":300,\"msg\":\"修改角色失败！存在相同的角色！\"}";
				return json;
			}
			roleService.updateRole(sysRole);
			//先清除角色的权限
			roleService.delete(Long.valueOf(roleId));
			//添加角色
			if (!CommUtils.isNull(ruleIds)) {
				String[] ids = ruleIds.split(",");
				SysRoleRule sysRoleRule = null;
				for (String ruleId : ids) {
					sysRoleRule = new SysRoleRule(Long.valueOf(roleId),Long.valueOf(ruleId));
					roleService.insert(sysRoleRule);
				}
			}
			json = "{\"code\":200,\"msg\":\"修改成功！\"}";
//			bjuiDto.setStatusCode("200");
//			bjuiDto.setTabid("sys_role");
//			bjuiDto.setCloseCurrent(true);
//			SysUser user = (SysUser) request.getSession().getAttribute(SystemConstant.SESSION_USER);
//			manageSevice.saveSysLog("修改角色", SystemConstant.SUCCESSFUL_OPERATION+sysRole.getRoleName(),user, CommUtils.getIpAddr(request));
		} catch (Exception e) {
//			bjuiDto.setStatusCode("300");
//			bjuiDto.setMessage("修改失败！");
			log.error("修改角色失败！", e);
			json = "{\"code\":200,\"msg\":\"修改失败！\"}";
		}
		return json;
	}
	/**
	 * 获取角色信息列表
	 * 
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/findsByPage.do")
	public String getDepartment(HttpServletRequest request, HttpServletResponse response,ModelMap modelMap){
		SysUser user0 = (SysUser) request.getSession().getAttribute(SystemConstant.SESSION_USER);
		Long supplierId = null;
		if(user0!=null&&user0.getMallSupplier()!=null&&user0.getMallSupplier().getId()!=null) {
			supplierId = user0.getMallSupplier().getId();
		}
		String pageNo = request.getParameter("pageCurrent");
		String pageSize = request.getParameter("pageSize");
		Page<SysRole> page = new Page<>();
		if (pageNo == null || pageSize == null) {
			int[] pageParams = PageUtil.init(request);
			page = roleService.findsSysRole(pageParams[0],pageParams[1],supplierId);
		}else{
			page = roleService.findsSysRole(Integer.parseInt(pageNo),Integer.parseInt(pageSize),supplierId);
		}
		modelMap.put("page", page);
		//modelMap.put("ruleCodes", request.getSession().getAttribute("ruleCodes"));
		return "system/sys_role";
	}

	/**
	 * 获取角色信息列表new
	 *
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "findsByPageNew.do" , method={RequestMethod.POST, RequestMethod.GET})
	public String findsByPageNew(HttpServletRequest request, HttpServletResponse response,
											ModelMap modelMap,com.ytoxl.module.core.common.pagination.BasePagination<SysRole> rolePage) {
		try {
			SysUser user0 = (SysUser) request.getSession().getAttribute(SystemConstant.SESSION_USER);
			Long supplierId = null;
			if(user0!=null&&user0.getMallSupplier()!=null&&user0.getMallSupplier().getId()!=null) {
				supplierId = user0.getMallSupplier().getId();
			}

			Map<String, String> params = new HashMap<>();
			if(!StringUtil.isEmpty(supplierId)) {
				params.put("supplierId",supplierId.toString());
			}
			//封装返回的page
			if(rolePage.getLimit()==null || rolePage.getLimit().intValue()==0) {
				rolePage.setLimit(20);
			}
			rolePage.setParams(params);
			modelMap.put("rolePage",roleService.findsByPageNew(rolePage));
		}catch (Exception e) {
			log.error("findsByPageNew error:"+e,e);
		}
		return "system/sys_role_new";
	}
	/**
	 * 跳转到添加角色页面
	 * 
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "toAdd.do")
	public String getRoleAddPage(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap)
			throws Exception {
//		SysUser user0 = (SysUser) request.getSession().getAttribute(SystemConstant.SESSION_USER);
//		Long supplierId = null;
//		if(user0!=null&&user0.getMallSupplier()!=null&&user0.getMallSupplier().getId()!=null) {
//			supplierId = user0.getMallSupplier().getId();
//		}
//		/**
//		 * 获取权限（添加角色时使用）
//		 */
//	    List<TreeModel> treeList = sysRuleService.findRuleTree(false,supplierId);
//		modelMap.put("treeList", treeList);
		try {
			SysUser user0 = (SysUser) request.getSession().getAttribute(SystemConstant.SESSION_USER);
			Long supplierId = null;
			if(user0!=null&&user0.getMallSupplier()!=null&&user0.getMallSupplier().getId()!=null) {
				supplierId = user0.getMallSupplier().getId();
			}

			Set<Long> ruleIdSet = null;
			List<SysRule> ruleSet =  null;
			if (!CommUtils.isNull(ruleSet)) {
				ruleIdSet = new HashSet<Long>();
				for (SysRule rule : ruleSet) {
					ruleIdSet.add(rule.getId());
				}
			}
			List<TreeModel> treeListAll = sysRuleService.findRuleTree(ruleIdSet,supplierId);
//        List<TreeModel> treeListAll = sysRuleService.findRuleTree(false, null);

			List<TreeModel> treeListLv1 = new ArrayList<>();
			if(treeListAll!=null && treeListAll.size()>0) {
				for(TreeModel treeModel : treeListAll) {
					if(treeModel.getParentId().equals("0")) {	//一级权限
						treeListLv1.add(treeModel);
					}
				}
				for(TreeModel treeModel : treeListAll) {
					for(TreeModel treeModel1 : treeListLv1) {
						if(treeModel.getParentId().equals(treeModel1.getId())) {	//二级权限
							treeModel1.getChildren().add(treeModel);
						}
					}
				}
				for(TreeModel treeModel : treeListAll) {
					for(TreeModel treeModel1 : treeListLv1) {
						for(TreeModel treeModel2 : treeModel1.getChildren()) {
							if(treeModel.getParentId().equals(treeModel2.getId())) {	//三级权限
								treeModel2.getChildren().add(treeModel);
							}
						}
					}
				}
			}

			modelMap.put("treeList", treeListLv1);
		}catch (Exception e) {
			log.error("toAdderror:"+e,e);
		}
		return "index/editRole";
//		return "system/sys_role_add";
	}
	/**
	 * 跳转到编辑角色页面
	 * 
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "toUpdate.do")
	public String getRoleUpdatePage(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap)
			throws Exception {
//		String roleId = request.getParameter("id");
//		SysRole role = roleService.findById(Long.parseLong(roleId));
//		List<TreeModel> treeList = sysRuleService.findRuleTree(false);
//		//根据角色id查询该角色拥有的权限集合
//		List<SysRule> sysRules =  roleService.roleIdByRules(Long.valueOf(roleId));
//		modelMap.put("treeList", treeList);
//		modelMap.put("role", role);
//		return "system/sys_role_edit";

		SysUser user0 = (SysUser) request.getSession().getAttribute(SystemConstant.SESSION_USER);
		Long supplierId = null;
		if(user0!=null&&user0.getMallSupplier()!=null&&user0.getMallSupplier().getId()!=null) {
			supplierId = user0.getMallSupplier().getId();
		}

		String roleId = request.getParameter("id");
		SysRole role = roleService.findById(Long.parseLong(roleId));
		modelMap.put("role", role);
		Set<Long> ruleIdSet = null;
		List<SysRule> ruleSet =  roleService.roleIdByRules(Long.valueOf(roleId));
		if (!CommUtils.isNull(ruleSet)) {
			ruleIdSet = new HashSet<Long>();
			for (SysRule rule : ruleSet) {
				ruleIdSet.add(rule.getId());
			}
		}
		List<TreeModel> treeList = sysRuleService.findRuleTree(ruleIdSet,supplierId);
		modelMap.put("treeList", treeList);
		return "system/sys_role_edit";
	}

	@RequestMapping("/findAll.do")
	@ResponseBody
	public List<SysRole> getRoles(){
		return roleService.sysRoleAll();
	}	
	
	/**
	 * 跳转选择角色页面
	 * 
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "getRoleSelectPage.do")
	public String getRoleSelectPage(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap)
			throws Exception {
		SysUser user0 = (SysUser) request.getSession().getAttribute(SystemConstant.SESSION_USER);
		Long supplierId = null;
		if(user0!=null&&user0.getMallSupplier()!=null&&user0.getMallSupplier().getId()!=null) {
			supplierId = user0.getMallSupplier().getId();
		}
		String pageNo = request.getParameter("pageCurrent");
		String pageSize = request.getParameter("pageSize");
		Page<SysRole> page = new Page<>();
		if (pageNo == null || pageSize == null) {
			int[] pageParams = PageUtil.init(request);
			page = roleService.findsSysRole(pageParams[0],pageParams[1],supplierId);
		}else{
			page = roleService.findsSysRole(Integer.parseInt(pageNo),Integer.parseInt(pageSize),supplierId);
		}
		modelMap.put("page", page);
		return "system/sys_role_select";
	}
}
