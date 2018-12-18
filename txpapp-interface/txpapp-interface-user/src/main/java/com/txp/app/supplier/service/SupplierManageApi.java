package com.txp.app.supplier.service;


import com.txp.app.dto.AppResult;
import com.txp.app.entity.Page;
import com.txp.app.supplier.dto.MallSupplierDto;
import com.txp.app.system.dto.SysRule;
import com.ytoxl.module.core.common.pagination.BasePagination;

import java.util.List;
import java.util.Map;

/**
 * 供应商管理
 */
public interface SupplierManageApi {


    Long insertSupplier(MallSupplierDto mallSupplierDto);

    void updateSupplier(MallSupplierDto mallSupplierDto);

    MallSupplierDto getSupplierEditData(Long id);

    Page<MallSupplierDto> findSupplierManageByType(Map<String, Object> map, int pageNo, int pageSize);

    MallSupplierDto findMallSupplierByUserId(Long userId);

    void initRuleForSupplier(Long i);

    List<SysRule> queryRoleBySupplierId(Long id);

    void saveMallSupplierRole(Long roleId, Long supplierId);

    void deleteMallSupplierRole(Long roleId);

    AppResult<List<MallSupplierDto>> getSuppliers(Map<String, Object> map);

    String getLoginNameBySupplierId(Long id);

    BasePagination<MallSupplierDto> findSupplierManageByTypeNew(BasePagination<MallSupplierDto> rolerPage);
}
