package com.txp.app.system;

import com.txp.app.contants.MallConstant;
import com.txp.app.dto.BjuiDto;
import com.txp.app.exception.BusException;
import com.txp.app.service.supplier.ApiSupplierService;
import com.txp.app.supplier.dto.MallSupplierDto;
import com.txp.app.system.dto.*;
import com.txp.app.system.service.ManageSevice;
import com.txp.app.system.service.SysDepartmentService;
import com.txp.app.system.service.SysRuleService;
import com.txp.app.system.service.SysUserService;
import com.txp.app.util.CommUtils;
import com.txp.app.util.SystemConstant;
import com.txp.app.util.TreeModel;
import com.txp.app.util.VerifyCodeUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.*;

@Slf4j
@Controller
@RequestMapping("/system/user/")
public class LoginMallController {

	@Autowired
	protected SysUserService sysUserService;
	@Autowired
	protected ManageSevice manageSevice;
	@Autowired
	private SysDepartmentService deptService;
	@Resource
	private ApiSupplierService apiSupplierService;
	@Autowired
	private SysRuleService sysRuleService;

	/**
	 * 跳转到登录页面
	 *
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "login.do")
	public String login(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) {
		String uri = request.getRequestURI();
		if (uri.indexOf("/system/user/login.do") > 0) {
			request.getSession().removeAttribute(SystemConstant.SESSION_USER);
		}
		return "login";
	}

	@RequestMapping(value = "loginTimeOut.do")
	public String loginTimeout(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) {
		HttpSession session = request.getSession();
		session.removeAttribute(SystemConstant.SESSION_USER);
		session.removeAttribute("user_uuid");
		session.removeAttribute(SystemConstant.SESSION_ORG);
		session.removeAttribute(SystemConstant.SESSION_DEPT);
		session.removeAttribute("ruleCodes");
		session.removeAttribute("rules");
		return "login_timeout";
	}

	/**
	 * 首页信息
	 *
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "index.do")
	public String index(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) {
		try {
			String username = request.getParameter("username");
			String password = request.getParameter("password");
//		String verify = request.getParameter("verify");
//		String phoneNote = request.getParameter("phoneNote");
//		String message = request.getParameter("message");
//		String phoneCode = request.getParameter("phone");
			String verifyCode = request.getParameter("verifyCode");
//		String ip= CommUtils.getIpAddr(request);//获得客户端Ip
			if (verifyCode == null) {
				modelMap.put("errorMsg","登录失败，请重新登录！");
				SysUser sysUser = (SysUser) request.getSession().getAttribute(SystemConstant.SESSION_USER);
				if (sysUser == null) {
					//判断Ip是否为白名单如果为白名单则跳转到login页面，如果不是则跳转到phoneLogin
					return "index/login";
				}
				//这里也可能是免验证码登录成功后的页面
				return "index/login";
			}
			boolean checkVc = verifyCode
					.equalsIgnoreCase((String) request.getSession().getAttribute(SystemConstant.SESSION_VC));
//		if(verify.equals("0") && phoneNote.length()>0 && message.equals("null")){
//			boolean phoneVerdict = phoneCode.equalsIgnoreCase((String) request.getSession().getAttribute("logIn"));
//			if(!phoneVerdict){
//				modelMap.put("errorMsg", "手机验证码错误！");
//				return "login";
//			}
//			request.getSession().removeAttribute("logIn");
//		}
			if (!checkVc) {
				modelMap.put("errorMsg", "验证码错误！");
				return "index/login";
			}
			SysUser user = sysUserService.findUserByLoginName(username);
			boolean checkPassword = (!CommUtils.isNull(user))
					&& user.getPassword().equals(CommUtils.getMD5(password.getBytes()));
			if (checkPassword) {
				if (!user.getStatus().equals(1)) {
					modelMap.put("errorMsg", "该用户已被禁用！");
					return "index/login";
				}
				//查询用户所属的供应商信息
				MallSupplierDto mallSupplierDto = apiSupplierService.findMallSupplierByUserId(user.getId());
				user.setMallSupplier(mallSupplierDto);

				HttpSession session = request.getSession();
				session.setAttribute(SystemConstant.SESSION_USER, user);
				String uuid = CommUtils.getUUID();
				session.setAttribute("user_uuid", uuid);
//			RedisUtils.set("user:uuid:" + user.getId(), uuid);
				manageSevice.saveSysMallLog(username, MallConstant.MODEL_SYSTEM,"用户登录", SystemConstant.SUCCESSFUL_OPERATION+",登陆的用户为:"+username, CommUtils.getIpAddr(request));
				String superadmin = sysUserService.queryOrg(username);
				log.info("------用户角色的Id为" + superadmin + "-----");
				if (superadmin == null) {
					// 根据用户编号查询用户所属部门
					SysDepartment sysDepartment = deptService.findDeptByUserId(user.getId());
					// request.setAttribute(SystemConstant.SESSION_DEPT,
					// sysDepartment.getDeptName());
					session.setAttribute(SystemConstant.SESSION_DEPT, sysDepartment);
					// 根据部门查询所属机构
					if (sysDepartment == null) {
						session.removeAttribute(SystemConstant.SESSION_ORG);
					} else {
						SysOrganization sysOrganization = manageSevice.findByDeptId(sysDepartment.getId());
						// request.setAttribute(SystemConstant.SESSION_ORG,
						// sysOrganization.getOrgName());
						session.setAttribute(SystemConstant.SESSION_ORG, sysOrganization);
					}

				} else {
					session.removeAttribute(SystemConstant.SESSION_DEPT);
					session.removeAttribute(SystemConstant.SESSION_ORG);
				}

				List<SysRule> rolesAll = null;
				if(user.getMallSupplier()!=null&&user.getMallSupplier().getRuleType()!=null) {
					rolesAll = apiSupplierService.queryRoleBySupplierId(user.getMallSupplier().getId());
				}

				List<SysRule> roles = new ArrayList<>();
				List<SysRule> rolesTemp = null;
				if(user.getMallSupplier()!=null&&user.getMallSupplier().getRuleType()!=null
						&&user.getMallSupplier().getRuleType().intValue()==1) {	//供应商的超级管理员，默认全部显示

//				rolesTemp.addAll(rolesAll);
					roles.addAll(rolesAll);
				} else if(user.getMallSupplier()!=null&&user.getMallSupplier().getRuleType()!=null
						&&user.getMallSupplier().getRuleType().intValue()==0) {
					try {
						rolesTemp = sysUserService.queryRole(user.getId());
					} catch (BusException e) {
						log.error(e.getMessage(),e);
					}
				} else {
					try {
						rolesTemp = sysUserService.queryRole(user.getId());
						roles.addAll(rolesTemp);
					} catch (BusException e) {
						log.error(e.getMessage(),e);
					}
				}

				if(user.getMallSupplier()!=null&&user.getMallSupplier().getRuleType()!=null&&user.getMallSupplier().getRuleType().intValue()==0) {	//供应商普通人员
					if(!CommUtils.isNull(rolesAll)&&!CommUtils.isNull(rolesTemp)) {
						for(SysRule sysRule : rolesTemp) {
							for(SysRule sysRule2 : rolesAll) {
								if(!CommUtils.isNull(sysRule)) {
									if(sysRule.getId().longValue()==sysRule2.getId().longValue()) {
										roles.add(sysRule2);
									}
								}
							}
						}
					}
				}

				Set<RuleDto> rules = new HashSet<RuleDto>();
				List<RuleDto> firstRules = new ArrayList<RuleDto>();
				Set<String> ruleCodes = new HashSet<String>();
				if (!CommUtils.isNull(roles)) {
					for (int i = 0; i < roles.size(); i++) {
						if (roles.get(i) != null) {
							if (roles.get(i).getRuleType() == 2) {
								ruleCodes.add(roles.get(i).getRuleCode());
							} else if (roles.get(i).getRuleType().equals(1)) {
								RuleDto ruleDto = new RuleDto();
								ruleDto.setId(roles.get(i).getId());
								ruleDto.setParentId(roles.get(i).getParentId());
								ruleDto.setName(roles.get(i).getRuleName());
								ruleDto.setIcon(roles.get(i).getRulePicture());
								ruleDto.setPriority(roles.get(i).getRuleOrder());
								ruleDto.setTabid(roles.get(i).getRuleExt());
								ruleDto.setUrl(roles.get(i).getRuleUrl());
								rules.add(ruleDto);
								if (roles.get(i).getParentId().equals(0L)) {
									firstRules.add(ruleDto);
								}
							}
						}
					}
				}
				for (Iterator<RuleDto> it = firstRules.iterator(); it.hasNext();) {
					RuleDto r = it.next();
					List<RuleDto> children = new ArrayList<RuleDto>();
					for (RuleDto rule : rules) {
						if (rule.getParentId().equals(r.getId())) {
							children.add(rule);
						}
					}
					Collections.sort(children);
					r.setChildren(children);
				}
				Collections.sort(firstRules);

				session.setAttribute("ruleCodes", ruleCodes);
				session.setAttribute("rules", firstRules);
				modelMap.addAttribute("user", user);
				modelMap.addAttribute("rules", firstRules);
				// saveSysLog(request, "登录系统");
				return "redirect:/system/user/findUserByCriteriaAndPage.do";
//			return "index";
			} else {
				modelMap.put("errorMsg", "用户名或者密码错误！");
				return "index/login";
			}
		}catch (Exception e) {
			log.error("index error:"+e,e);
			modelMap.put("errorMsg", "登录出错！");
			return "index/login";
		}
	}

	@RequestMapping(value = "income.do")
	public String income(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap)
			throws Exception {
		String path = request.getContextPath();
		log.info(path);
		modelMap.put("_cssPath",path+"/web-resource/css");
		modelMap.put("_cssPagesPath",path+"/web-resource/css/pages");
		modelMap.put("_imagesPath",path+"/web-resource/images");
		modelMap.put("_jsPath",path+"/web-resource/js");
		return "index/income";
	}
	@RequestMapping(value = "income1.do")
	public String income1(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap)
			throws Exception {
		String path = request.getContextPath();
		log.info(path);
		modelMap.put("_ctxPath",path);
		modelMap.put("_cssPath",path+"/web-resource/css");
		modelMap.put("_cssPagesPath",path+"/web-resource/css/pages");
		modelMap.put("_imagesPath",path+"/web-resource/images");
		modelMap.put("_jsPath",path+"/web-resource/js");
		return "index/income1";
	}

	@RequestMapping(value = "rule2.do")
	public String rule2(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap)
			throws Exception {
		List<TreeModel> treeListAll = sysRuleService.findRuleTree(false, null);
		List<TreeModel> treeListLv1 = new ArrayList<>();
//		TreeModel treeModelRoot = new TreeModel();
//		treeModelRoot.setId("0");
//		treeModelRoot.setName("返回权限列表首页");
//		treeListLv1.add(treeModelRoot);

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

		//权限根据父id查询
		String parentId = request.getParameter("pId")==null?"0":request.getParameter("pId");
		SysRule parent = sysRuleService.findRuleById(Long.valueOf(parentId));
		List<SysRule> ruleList = sysRuleService.findRuleListByParentId(Long.parseLong(parentId));
		for (SysRule sysRule : ruleList) {
			sysRule.setParent(parent);
		}
		modelMap.put("ruleList", ruleList);
		modelMap.put("pId", parentId);

		modelMap.put("treeList", treeListLv1);
		return "index/rule2";
	}

	/**
	 * 首页信息
	 *
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 */
//	@RequestMapping(value = "indexTimeOut.do", method = RequestMethod.POST)
//	@ResponseBody
//	public BjuiDto indexTimeOut(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) {
//		BjuiDto bjuiDto = new BjuiDto();
//		String username = request.getParameter("username");
//		String password = request.getParameter("password");
//		List<SysUser> user = sysUserService.findUserByLoginName(username);
//		boolean checkPassword = (!CommUtils.isNull(user))
//				&& user.get(0).getPassword().equals(CommUtils.getMD5(password.getBytes()));
//		if (checkPassword) {
//			if (!user.get(0).getStatus().equals(1)) {
//				bjuiDto.setStatusCode("300");
//				bjuiDto.setMessage("该用户已被禁用！");
//				return bjuiDto;
//			}
//			SysUser su = user.get(0);
//			HttpSession session = request.getSession();
//			session.setAttribute(SystemConstant.SESSION_USER, su);
//			String uuid = CommUtils.getUUID();
//			session.setAttribute("user_uuid", uuid);
//			RedisUtils.set("user:uuid:" + su.getId(), uuid);
//			manageSevice.saveSysLog("用户登录", SystemConstant.SUCCESSFUL_OPERATION + ",登陆的用户为:" + username, request);
//			String superadmin = sysUserService.queryOrg(username);
//			logger.info("------用户角色的Id为" + superadmin + "-----");
//			if (superadmin == null) {
//				// 根据用户编号查询用户所属部门
//				SysDepartment sysDepartment = deptService.findDeptByUserId(user.get(0).getId());
//				// request.setAttribute(SystemConstant.SESSION_DEPT,
//				// sysDepartment.getDeptName());
//				session.setAttribute(SystemConstant.SESSION_DEPT, sysDepartment);
//				// 根据部门查询所属机构
//				if (sysDepartment == null) {
//					session.removeAttribute(SystemConstant.SESSION_ORG);
//				} else {
//					SysOrganization sysOrganization = manageSevice.findByDeptId(sysDepartment.getId());
//					// request.setAttribute(SystemConstant.SESSION_ORG,
//					// sysOrganization.getOrgName());
//					session.setAttribute(SystemConstant.SESSION_ORG, sysOrganization);
//				}
//
//			} else {
//				session.removeAttribute(SystemConstant.SESSION_DEPT);
//				session.removeAttribute(SystemConstant.SESSION_ORG);
//			}
//			List<SysRule> roles = null;
//			try {
//				roles = sysUserService.queryRole(user.get(0).getId());
//			} catch (BusException e) {
//				logger.error(e.getMessage());
//				e.printStackTrace();
//			}
//			Set<RuleDto> rules = new HashSet<RuleDto>();
//			List<RuleDto> firstRules = new ArrayList<RuleDto>();
//			Set<String> ruleCodes = new HashSet<String>();
//			if (!CommUtils.isNull(roles)) {
//				for (int i = 0; i < roles.size(); i++) {
//					if (roles.get(i) != null) {
//						if (roles.get(i).getRuleType() == 2) {
//							ruleCodes.add(roles.get(i).getRuleCode());
//						} else if (roles.get(i).getRuleType().equals(1)) {
//							RuleDto ruleDto = new RuleDto();
//							ruleDto.setId(roles.get(i).getId());
//							ruleDto.setParentId(roles.get(i).getParentId());
//							ruleDto.setName(roles.get(i).getRuleName());
//							ruleDto.setIcon(roles.get(i).getRulePicture());
//							ruleDto.setPriority(roles.get(i).getRuleOrder());
//							ruleDto.setTabid(roles.get(i).getRuleExt());
//							ruleDto.setUrl(roles.get(i).getRuleUrl());
//							rules.add(ruleDto);
//							if (roles.get(i).getParentId().equals(0L)) {
//								firstRules.add(ruleDto);
//							}
//						}
//					}
//				}
//			}
//			for (Iterator<RuleDto> it = firstRules.iterator(); it.hasNext();) {
//				RuleDto r = it.next();
//				List<RuleDto> children = new ArrayList<RuleDto>();
//				for (RuleDto rule : rules) {
//					if (rule.getParentId().equals(r.getId())) {
//						children.add(rule);
//					}
//				}
//				Collections.sort(children);
//				r.setChildren(children);
//			}
//			Collections.sort(firstRules);
//			session.setAttribute("ruleCodes", ruleCodes);
//			session.setAttribute("rules", firstRules);
//			bjuiDto.setStatusCode("200");
//			bjuiDto.setMessage("登录成功！");
//			bjuiDto.setCloseCurrent(true);
//			// saveSysLog(request, "登录系统");
//		} else {
//			bjuiDto.setStatusCode("300");
//			bjuiDto.setMessage("用户名或者密码错误！");
//		}
//		return bjuiDto;
//	}

	/**
	 * 登陆验证码生成
	 */
	@RequestMapping(value = "getVerifyCode.do")
	public void getVerifyCode(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap)
			throws Exception {
		response.setContentType("image/jpeg");
		response.setHeader("Pragma", "No-cache");
		response.setHeader("Cache-Control", "no-cache");
		response.setDateHeader("Expires", 0);
		String verifyCode = VerifyCodeUtils.generateVerifyCode(4);
		request.getSession().setAttribute(SystemConstant.SESSION_VC, verifyCode);
		ServletOutputStream os = response.getOutputStream();
		VerifyCodeUtils.outputImage(94, 26, os, verifyCode);
		os.flush();
		os.close();
	}

	@RequestMapping(value = "forwardMainPage.do")
	public String forwardMainPage(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) {
		return "index_main";
	}

	/**
	 * 获取主菜单树
	 *
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
//	@RequestMapping(value = "getMenuTree.do")
//	@ResponseBody
//	public List<TreeModel> getMenuTree(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap)
//			throws Exception {
//		Set<Long> ruleIds = (Set<Long>) request.getSession().getAttribute("ruleIds");
//		// List<TreeModel> treeList = sysRuleService.findRuleTree(false);
//		request.getSession().removeAttribute("ruleIds");
//		return null;
//	}

	/**
	 * 修改密码
	 *
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "getChangePwdPage.do")
	public String getChangePwdPage(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) {
		return "changepwd";
	}

	/**
	 * 实现修改密码
	 *
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value = "changePwd.do")
	@ResponseBody
	public BjuiDto changePwd(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) {
		BjuiDto bjuiDto = new BjuiDto();
		SysUser user0 = (SysUser) request.getSession().getAttribute(SystemConstant.SESSION_USER);
		try {
			String id = request.getParameter("userId");
			String oldPwd = request.getParameter("oldPassword");
			SysUser user = sysUserService.findUserByKey(Long.parseLong(id));
			if (CommUtils.getMD5(oldPwd.getBytes()).equals(user.getPassword())) {
				String newPwd = request.getParameter("newPassword");
				user.setPassword(CommUtils.getMD5(newPwd.getBytes()));
				sysUserService.updateByPrimaryKeySelective(user);
				bjuiDto.setStatusCode("200");
				bjuiDto.setMessage("修改成功！");
				bjuiDto.setCloseCurrent(true);
				manageSevice.saveSysMallLog(user0.getLoginName(), MallConstant.MODEL_SYSTEM,"修改密码", SystemConstant.SUCCESSFUL_OPERATION, CommUtils.getIpAddr(request));
			} else {
				manageSevice.saveSysMallLog(user0.getLoginName(), MallConstant.MODEL_SYSTEM,"修改密码", SystemConstant.OPERATION_FAILURE+"旧密码错误", CommUtils.getIpAddr(request));
				bjuiDto.setStatusCode("300");
				bjuiDto.setMessage("旧密码错误！");
			}
		} catch (Exception e) {
			manageSevice.saveSysMallLog(user0.getLoginName(), MallConstant.MODEL_SYSTEM,"修改密码", SystemConstant.OPERATION_FAILURE+"修改失败", CommUtils.getIpAddr(request));
			bjuiDto.setStatusCode("300");
			bjuiDto.setMessage("修改失败！");
		}
		return bjuiDto;

	}

}
