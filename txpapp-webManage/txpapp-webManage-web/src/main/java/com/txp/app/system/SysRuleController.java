package com.txp.app.system;

import com.alibaba.dts.common.fastjson.JSONObject;
import com.txp.app.dto.BjuiDto;
import com.txp.app.dto.RemoteDto;
import com.txp.app.entity.Page;
import com.txp.app.service.supplier.ApiSupplierService;
import com.txp.app.supplier.dto.MallSupplierDto;
import com.txp.app.system.dto.SysRole;
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
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.*;

/**
 * 权限管理
 *
 * @author HWang
 */
@Controller
@RequestMapping("/system/rule/")
@Slf4j
public class SysRuleController {

    @Autowired
    private SysRuleService sysRuleService;

    @Autowired
    private SysRoleService roleService;
    @Autowired
    private ManageSevice manageSevice;
    @Resource
    private ApiSupplierService apiSupplierService;


    /**
     * 权限页面
     *
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "getRulePage.do")
    public String getRulePage(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        SysUser user0 = (SysUser) request.getSession().getAttribute(SystemConstant.SESSION_USER);
        Long supplierId = null;
        if (user0 != null && user0.getMallSupplier() != null && user0.getMallSupplier().getId() != null) {
            supplierId = user0.getMallSupplier().getId();
        }
        List<TreeModel> treeList = sysRuleService.findRuleTree(false, supplierId);
        modelMap.put("treeList", treeList);
        return "system/sys_rule";
    }

    /**
     * 根据父ID查询权限列表
     *
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "findRuleListByParentId.do")
    public String findRuleListByParentId(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        String parentId = request.getParameter("pId");
        SysRule parent = sysRuleService.findRuleById(Long.valueOf(parentId));
        List<SysRule> ruleList = sysRuleService.findRuleListByParentId(Long.parseLong(parentId));
        for (SysRule sysRule : ruleList) {
            sysRule.setParent(parent);
        }
        modelMap.put("ruleList", ruleList);
        modelMap.put("pId", parentId);
        return "system/sys_rule_list";
    }

    /*
        /**
         * 跳转添加权限页面
         *
         * @param request
         * @param response
         * @param modelMap
         * @return
         * @throws Exception
         */
    @RequestMapping(value = "getRuleAddPage.do")
    public String getRuleAddPage(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        try {
            String parentId = request.getParameter("pId");
            if (parentId.equals("0")) {
                modelMap.put("parentName", "根目录");
            } else {
                SysRule rule = sysRuleService.findRuleById(Long.parseLong(parentId));
                modelMap.put("parentName", rule.getRuleName());
            }
            modelMap.put("pId", parentId);
        }catch (Exception e) {
            log.error("getRuleAddPage error:" + e,e);
        }
        return "index/toAddRule";
    }

    /**
     * 跳转编辑权限页面
     *
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "getRuleEditPage.do")
    public String getRuleEditPage(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        String path = request.getContextPath();
        log.info(path);
        modelMap.put("_ctxPath",path);
        modelMap.put("_treePath",path+"/treeview");
        modelMap.put("_cssPath",path+"/web-resource/css");
        modelMap.put("_cssPagesPath",path+"/web-resource/css/pages");
        modelMap.put("_imagesPath",path+"/web-resource/images");
        modelMap.put("_jsPath",path+"/web-resource/js");

        String id = request.getParameter("id");
        String parentId = request.getParameter("pId");
        SysRule rule = sysRuleService.findRuleById(Long.parseLong(id));
        SysRule p_rule = sysRuleService.findRuleById(Long.parseLong(parentId));
        //SysRule parent = rule.getParent();
        if (parentId.equals("0")) {
            modelMap.put("parentName", "根目录");
        } else {
            modelMap.put("parentName", p_rule.getRuleName());
        }
        modelMap.put("rule", rule);

        //返现已经配置的供应商权限
        StringBuffer name=new StringBuffer();
        Map<String, Object> map = new HashMap<>();
        int[] pageParams = PageUtil.init(request);

        Page<MallSupplierDto> page = apiSupplierService.findSupplierManageByType(map, pageParams[0], pageParams[1]);

        if (id != null && id != "") {
            List<String> supplierId = sysRuleService.findSuppliersByRule(id) ;

            for (MallSupplierDto supplier : page.getResult()) {
                if (supplierId.contains(supplier.getId().toString())) {
                    name.append(","+supplier.getCompanyName());
                }
            }
        }
        modelMap.put("supplier_name",name.length()==0?name:name.deleteCharAt(0));

        return "index/detail";
    }


    @RequestMapping(value = "showSupplier.do")
    public String showSupplier(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap,
                               com.ytoxl.module.core.common.pagination.BasePagination<MallSupplierDto> supplierPage) throws Exception {
        String path = request.getContextPath();
        log.info(path);
        modelMap.put("_ctxPath",path);
        modelMap.put("_treePath",path+"/treeview");
        modelMap.put("_cssPath",path+"/web-resource/css");
        modelMap.put("_cssPagesPath",path+"/web-resource/css/pages");
        modelMap.put("_imagesPath",path+"/web-resource/images");
        modelMap.put("_jsPath",path+"/web-resource/js");

//        String ruleId = request.getParameter("ruleId");
        //去重
//        HashSet<Integer> set = new HashSet<Integer>();
//        if (ruleId != null && ruleId != "") {
//            List<String> supplierId = sysRuleService.findSuppliersByRule(ruleId);
//
//            for (MallSupplierDto supplier : page.getResult()) {
//                if (supplierId.contains(supplier.getId().toString())) {
//                    supplier.setRmk(2);
//                    set.add(2);
//                } else {
//                    supplier.setRmk(1);
//                    set.add(1);
//                }
//            }
//        }

//        if(set.size()==1){
//            modelMap.put("checked", set.toArray()[0]);
//        }

        Map<String, String> params = new HashMap<>();
        //封装返回的page
        if(supplierPage.getLimit()==null || supplierPage.getLimit().intValue()==0) {
            supplierPage.setLimit(4);
        }
        supplierPage.setParams(params);

        modelMap.put("suppPage", apiSupplierService.findSupplierManageByTypeNew(supplierPage));

        return "index/showSupplier";
    }

    @ResponseBody
    @RequestMapping(value = "showSupplierLimit.do")
    public String showSupplierLimit(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap,
                               com.ytoxl.module.core.common.pagination.BasePagination<MallSupplierDto> supplierPage) {
        String path = request.getContextPath();
        log.info(path);
        modelMap.put("_ctxPath",path);
        modelMap.put("_treePath",path+"/treeview");
        modelMap.put("_cssPath",path+"/web-resource/css");
        modelMap.put("_cssPagesPath",path+"/web-resource/css/pages");
        modelMap.put("_imagesPath",path+"/web-resource/images");
        modelMap.put("_jsPath",path+"/web-resource/js");
        String re = null;
        try {
            String ruleId = request.getParameter("ruleId");
            //去重
//        HashSet<Integer> set = new HashSet<Integer>();
//        if (ruleId != null && ruleId != "") {
//            List<String> supplierId = sysRuleService.findSuppliersByRule(ruleId);
//
//            for (MallSupplierDto supplier : page.getResult()) {
//                if (supplierId.contains(supplier.getId().toString())) {
//                    supplier.setRmk(2);
//                    set.add(2);
//                } else {
//                    supplier.setRmk(1);
//                    set.add(1);
//                }
//            }
//        }

//        if(set.size()==1){
//            modelMap.put("checked", set.toArray()[0]);
//        }

            Map<String, String> params = new HashMap<>();
            //封装返回的page
            if(supplierPage.getLimit()==null || supplierPage.getLimit().intValue()==0) {
                supplierPage.setLimit(5);
            }
            supplierPage.setParams(params);

            Map map = new HashMap<>();
            map.put("suppPage",apiSupplierService.findSupplierManageByTypeNew(supplierPage));
            JSONObject jsonObject = new JSONObject(map);
            re = jsonObject.toJSONString();
        }catch (Exception e) {
            e.printStackTrace();
            log.error("showSupplierLimit error:"+e,e);
        }
        return re;
    }

    @RequestMapping(value = "getRoleEditPage.do")
    public String getRoleEditPage(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        String path = request.getContextPath();
        log.info(path);
        modelMap.put("_ctxPath",path);
        modelMap.put("_treePath",path+"/treeview");
        modelMap.put("_cssPath",path+"/web-resource/css");
        modelMap.put("_cssPagesPath",path+"/web-resource/css/pages");
        modelMap.put("_imagesPath",path+"/web-resource/images");
        modelMap.put("_jsPath",path+"/web-resource/js");

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

        return "index/editRole";
    }

    /**
     * 验证权限代码唯一性
     *
     * @param request
     * @param response
     * @param modelMap
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "validateRuleCode.do")
    @ResponseBody
    public RemoteDto validateRuleCode(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        String ruleCode = request.getParameter("ruleCode");
        List rule = sysRuleService.findRuleByCode(ruleCode);
        RemoteDto remoteDto = new RemoteDto();
        if (rule.size() > 0) {
            remoteDto.setOk("");
        } else {
            remoteDto.setError("该权限代码已使用");
        }
        return remoteDto;
    }

    /**
     * 新增权限
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "save.do")
    @ResponseBody
    public String saveRule(HttpServletRequest request, HttpServletResponse response) throws Exception {
//        BjuiDto bjuiDto = new BjuiDto();
        String json = "{\"code\":200,\"msg\":\"start！\"}";
        try {

            String ruleCode = request.getParameter("ruleCode");
            String ruleName = request.getParameter("ruleName");
            String ruleType = request.getParameter("ruleType");
            String parentId = request.getParameter("pId");
            String ruleDesc = request.getParameter("ruleDesc");
            String rulePicture = request.getParameter("rulePicture");
            String ruleExt = request.getParameter("ruleExt");
            String ruleUrl = request.getParameter("ruleUrl");
            String ruleOrder = request.getParameter("ruleOrder");
            String supplier = request.getParameter("supplier.id");
            //SysRule parent = sysRuleService.findRuleById(Long.parseLong(parentId));
            SysRule rule = new SysRule();
            rule.setParentId(Long.valueOf(parentId));
            rule.setRuleCode(ruleCode);
            rule.setRuleDesc(ruleDesc);
            rule.setRuleExt(ruleExt);
            rule.setRuleName(ruleName);
            rule.setRuleOrder(Integer.parseInt(ruleOrder));
            rule.setRulePicture(rulePicture);
            rule.setRuleType(StringUtils.isBlank(ruleType) ? 1 : Integer.parseInt(ruleType));
            rule.setRuleUrl(ruleUrl);
            sysRuleService.saveRule(rule);

            //  获取包含该PID的权限列表，并与该权限比对(ruleCode 及ruleName)，找出插入的权限ID
            Long pid= Long.valueOf(parentId);
            List<SysRule> ruleList = sysRuleService.findRuleListByParentId(pid);

            for (SysRule SysRule : ruleList) {
                if (SysRule.getRuleCode().equals(rule.getRuleCode()) && SysRule.getRuleName().equals(rule.getRuleName())) {

                    sysRuleService.saveOrUpdateRule(supplier, SysRule.getId(),false);

                    //根据查询父权限，并入库，更新时，原商户父权限不做更新，仅更新当前权限

                    while(true){
                        SysRule ruleById = sysRuleService.findRuleById(pid);

                        if(ruleById==null || ruleById.getParentId()==0L){
                            break;
                        }else{
                            //数据入库,父权限不删除
                            sysRuleService.saveOrUpdateRule(supplier,pid,true);
                            //继续查询父权限
                            pid=ruleById.getParentId();

                        }
                    }
                    break;
                }
            }

            json = "{\"code\":200,\"msg\":\"添加成功！\"}";
//            bjuiDto.setStatusCode("200");
//            bjuiDto.setMessage("添加成功！");
//            bjuiDto.setTabid("sys_rule");
//            bjuiDto.setCloseCurrent(true);
            //保存到日志
//            SysUser user = (SysUser) request.getSession().getAttribute(SystemConstant.SESSION_USER);
//            manageSevice.saveSysLog("添加权限及权限指定商户", SystemConstant.SUCCESSFUL_OPERATION + ",添加权限名为:" + ruleName + ",权限指定商户id为:" + supplier, user, CommUtils.getIpAddr(request));
        } catch (Exception e) {
//            bjuiDto.setStatusCode("300");
//            bjuiDto.setMessage("添加失败！");
            log.error("添加权限失败！", e);
            json = "{\"code\":300,\"msg\":\"添加权限失败！\"}";
        }
        return json;
    }

    /**
     * 编辑权限
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "update.do")
    @ResponseBody
    public String updateRule(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String json = "{\"code\":200,\"msg\":\"start！\"}";
        try {
            String ruleId = request.getParameter("ruleId");
            String ruleCode = request.getParameter("ruleCode");
            String ruleName = request.getParameter("ruleName");
            String ruleType = request.getParameter("ruleType");
            String ruleDesc = request.getParameter("ruleDesc");
            String rulePicture = request.getParameter("rulePicture");
            String ruleExt = request.getParameter("ruleExt");
            String ruleUrl = request.getParameter("ruleUrl");
            String ruleOrder = request.getParameter("ruleOrder");
            String supplier = request.getParameter("supplier.id");
            //SysRule rule = sysRuleService.findRuleById(Long.parseLong(ruleId));
            SysRule rule = new SysRule();
            rule.setParentId(Long.valueOf(request.getParameter("parentId")));
            rule.setId(Long.valueOf(ruleId));
            rule.setRuleCode(ruleCode);
            rule.setRuleDesc(ruleDesc);
            rule.setRuleExt(ruleExt);
            rule.setRuleName(ruleName);
            rule.setRuleOrder(Integer.parseInt(ruleOrder));
            rule.setRulePicture(rulePicture);
            rule.setRuleType(StringUtils.isBlank(ruleType) ? 1 : Integer.parseInt(ruleType));
            rule.setRuleUrl(ruleUrl);
            sysRuleService.updateRule(rule);

            Long pid= Long.valueOf(ruleId);
            //查询该权限下所有子权限
            List<SysRule> parentList = sysRuleService.findRuleListByParentId(pid);
            boolean ensure=true;
            if(parentList != null && parentList.size()>0){

                //遍历子权限，查询子权限下，供应商列表是否全部包含还需要修改的供应商列表中
                for (SysRule rule1 : parentList) {
                    //查询一个子权限下所有的供应商列表
                    List<String> serchSuppliers = sysRuleService.findSuppliersByRule(rule1.getId().toString());
                    //要求,查询出来的供应商都应该包括在传来的供应商范围内
                    for (String s : serchSuppliers) {
                        if(!supplier.contains(s)){
                            json = "{\"code\":300,\"msg\":\"先编辑子权限！\"}";

                            ensure=false;
                            break ;
                        }
                    }
                    if(!ensure){
                        break;
                    }
                }
            }

            if (ensure){
                //新增更新商户指定权限
                sysRuleService.saveOrUpdateRule(supplier, pid, false);

                while (true) {
                    SysRule ruleById = sysRuleService.findRuleById(pid);
                    if (ruleById==null || ruleById.getParentId() == 0L) {
                        break;
                    } else {
                        //继续查询父权限
                        pid = ruleById.getParentId();

                        //数据入库,新增更新商户指定权限
                        sysRuleService.saveOrUpdateRule(supplier, pid, true);

                    }
                }
            }
            json = "{\"code\":200,\"msg\":\"保存成功！\"}";
            //保存到日志
            SysUser user = (SysUser) request.getSession().getAttribute(SystemConstant.SESSION_USER);
//            manageSevice.saveSysLog("更新权限及权限指定商户", SystemConstant.SUCCESSFUL_OPERATION + ",权限编号为：" + ruleId + ",权限指定商户id为:" + supplier, user, CommUtils.getIpAddr(request));
        } catch (Exception e) {
            log.error("error:"+e,e);
            json = "{\"code\":300,\"msg\":\"保存编辑失败！\"}";
        }
        return json;
    }

    /**
     * 删除权限
     *
     * @param request
     * @param response
     * @return
     * @throws Exception
     */
    @RequestMapping(value = "deleteRule.do")
    @ResponseBody
    public String deleteRule(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String json = "{\"code\":200,\"msg\":\"start！\"}";
//        BjuiDto bjuiDto = new BjuiDto();
        try {
            String id = request.getParameter("id");
            List<SysRule> ruleList = sysRuleService.findRuleListByParentId(Long.parseLong(id));
            if (!CommUtils.isNull(ruleList)) {
                json = "{\"code\":300,\"msg\":\"请先删除子权限！\"}";
//                bjuiDto.setStatusCode("300");
//                bjuiDto.setMessage("请先删除子权限！");
            } else {
                sysRuleService.deleteRule(Long.parseLong(id));
                json = "{\"code\":200,\"msg\":\"成功！\"}";
//                bjuiDto.setStatusCode("200");
//                bjuiDto.setTabid("sys_rule");

                //新增同步删除该权限指定商户,仅删除本身权限
                 sysRuleService.saveOrUpdateRule(null,Long.valueOf(id),false );

                //保存到日志
//                SysUser user = (SysUser) request.getSession().getAttribute(SystemConstant.SESSION_USER);
//                manageSevice.saveSysLog("删除权限", SystemConstant.SUCCESSFUL_OPERATION + ",权限编号为：" + id, user, CommUtils.getIpAddr(request));

            }
        } catch (Exception e) {
            log.error("deleteRule:" +e,e);
            json = "{\"code\":300,\"msg\":\"删除失败！\"}";
//            bjuiDto.setStatusCode("300");
//            bjuiDto.setMessage("删除失败！");
        }
        return json;
    }

    @RequestMapping(value = "showSupplier2.do")
    public String showSupplier2(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {
        try {
            String path = request.getContextPath();
            log.info(path);
            modelMap.put("_ctxPath",path);
            modelMap.put("_treePath",path+"/treeview");
            modelMap.put("_cssPath",path+"/web-resource/css");
            modelMap.put("_cssPagesPath",path+"/web-resource/css/pages");
            modelMap.put("_imagesPath",path+"/web-resource/images");
            modelMap.put("_jsPath",path+"/web-resource/js");

            String ruleId = request.getParameter("ruleId");
            Map<String, Object> map = new HashMap<>();

            int[] pageParams = PageUtil.init(request);
            Page<MallSupplierDto> page = apiSupplierService.findSupplierManageByType(map, pageParams[0], pageParams[1]);

            MallSupplierDto dto = new MallSupplierDto();
            dto.setId(0L);
            dto.setCompanyName("供应商基础权限");
            page.setTotalCount(page.getTotalCount()+1);
            page.getResult().add(0, dto);
            //去重
            HashSet<Integer> set = new HashSet<Integer>();
            if (ruleId != null && ruleId != "") {
                List<String> supplierId = sysRuleService.findSuppliersByRule(ruleId);

                for (MallSupplierDto supplier : page.getResult()) {
                    if (supplierId.contains(supplier.getId().toString())) {
                        supplier.setRmk(2);
                        set.add(2);
                    } else {
                        supplier.setRmk(1);
                        set.add(1);
                    }
                }
            }

            if(set.size()==1){
                modelMap.put("checked", set.toArray()[0]);
            }
            modelMap.put("rulePage", page);
        }catch (Exception e) {
            log.error("showSupplier error:" + e,e);
        }

        return "index/showSupplier";
    }

    @RequestMapping(value = "supplierAdd.do")
    public String supplierAdd(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap) throws Exception {

        String ruleId = request.getParameter("ruleId");
        Map<String, Object> map = new HashMap<>();

        int[] pageParams = PageUtil.init(request);
        Page<MallSupplierDto> page = apiSupplierService.findSupplierManageByType(map, pageParams[0], pageParams[1]);

        MallSupplierDto dto = new MallSupplierDto();
        dto.setId(0L);
        dto.setCompanyName("供应商基础权限");
        page.setTotalCount(page.getTotalCount()+1);
        page.getResult().add(0, dto);
        //去重
        HashSet<Integer> set = new HashSet<Integer>();
        if (ruleId != null && ruleId != "") {
            List<String> supplierId = sysRuleService.findSuppliersByRule(ruleId);

            for (MallSupplierDto supplier : page.getResult()) {
                if (supplierId.contains(supplier.getId().toString())) {
                    supplier.setRmk(2);
                    set.add(2);
                } else {
                    supplier.setRmk(1);
                    set.add(1);
                }
            }
        }

        if(set.size()==1){
            modelMap.put("checked", set.toArray()[0]);
        }


        modelMap.put("page", page);
       // modelMap.put("companyName", companyName);
        return "system/sys_supplier_add";
    }

}
