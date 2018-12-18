package com.txp.app.service.supplier;

import com.alibaba.dts.common.util.StringUtil;
import com.txp.app.dto.AppResult;
import com.txp.app.dto.BjuiDto;
import com.txp.app.entity.Page;
import com.txp.app.supplier.dto.MallSupplierDto;
import com.txp.app.supplier.service.SupplierManageApi;
import com.txp.app.system.dto.SysRule;
import com.txp.app.system.dto.SysUser;
import com.txp.app.system.service.SysUserService;
import com.txp.app.util.CommUtils;
import com.ytoxl.module.core.common.pagination.BasePagination;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service
@Slf4j
public class ApiSupplierService {

	@Resource
	private SupplierManageApi supplierManageApi;
	@Autowired
	private SysUserService sysUserService;

	public BjuiDto saveOrUpdateContent(MallSupplierDto mallSupplierDto) {
		BjuiDto bjuiDto = new BjuiDto();
		try {
			Date curDate = new Date();

			if (CommUtils.isNull(mallSupplierDto.getId())) {
				log.info("saveOrUpdateContent add ...");
				mallSupplierDto.setCreateTime(curDate);
				//保存供应商信息
				long i = supplierManageApi.insertSupplier(mallSupplierDto);
				log.info("insertSupplier result:" + i);
				//初始化超级管理员
				SysUser user = new SysUser();
				user.setLoginName(mallSupplierDto.getPhone());
				user.setRealName(mallSupplierDto.getPhone());
				user.setPassword(CommUtils.getMD5("123456".getBytes()));
				user.setEmail(StringUtil.isEmpty(mallSupplierDto.getEmail())?"":mallSupplierDto.getEmail());
				user.setPhone(mallSupplierDto.getPhone());
				user.setSex(1);
				user.setStatus(1);
				user.setCreateTime(curDate);
				user.setUpdateTime(curDate);
				//添加用户操作
				boolean ch = sysUserService.insertUser(user,"0", "0",i+"",null,1);
				log.info("ApiSupplierService.saveOrUpdateContent.insertUser:return:{}",ch);
				//为供应商初始化权限
				supplierManageApi.initRuleForSupplier(i);
			} else {
				log.info("saveOrUpdateContent update ...");
				mallSupplierDto.setUpdateTime(curDate);
				supplierManageApi.updateSupplier(mallSupplierDto);
			}
			bjuiDto.setMessage("操作成功");
			bjuiDto.setStatusCode("200");
			bjuiDto.setCloseCurrent(true);
			bjuiDto.setTabid("mall_supplier_supplierManage");
		} catch (Exception e) {
			log.error("saveOrUpdateContent:"+e,e);
			bjuiDto.setStatusCode("300");
			bjuiDto.setMessage("操作失败！");
		}
		return bjuiDto;
	}

	public Page<MallSupplierDto> findSupplierManageByType(Map<String,Object> map, int pageNo, int pageSize) {
		return supplierManageApi.findSupplierManageByType(map,pageNo,pageSize);
	}

	public BasePagination<MallSupplierDto> findSupplierManageByTypeNew(BasePagination<MallSupplierDto> rolerPage) {
		return supplierManageApi.findSupplierManageByTypeNew(rolerPage);
	}

	public MallSupplierDto getSupplierEditData(Long id) {
		return supplierManageApi.getSupplierEditData(id);
	}

	public MallSupplierDto findMallSupplierByUserId(Long userId) {
		return supplierManageApi.findMallSupplierByUserId(userId);
	}

	public List<SysRule> queryRoleBySupplierId(Long id) {
		return supplierManageApi.queryRoleBySupplierId(id);
	}

	public void saveMallSupplierRole(Long roleId, Long supplierId) {
		supplierManageApi.saveMallSupplierRole(roleId,supplierId);
	}

	public void deleteMallSupplierRole(Long roleId) {
		supplierManageApi.deleteMallSupplierRole(roleId);
	}

	public List<MallSupplierDto> findMallSuppliers(){
		AppResult suppliers = supplierManageApi.getSuppliers(new HashMap());
		return  (List<MallSupplierDto>)suppliers.getResult();
	}

	public String getLoginNameBySupplierId(Long id) {
		return supplierManageApi.getLoginNameBySupplierId(id);
	}
}
