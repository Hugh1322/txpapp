package com.txp.app.supplier.service;

import com.txp.app.dto.AppResult;
import com.txp.app.entity.Page;
import com.txp.app.supplier.dto.MallSupplierDto;
import com.txp.app.supplier.entity.MallSupplier;
import com.txp.app.supplier.entity.MallSupplierRule;
import com.txp.app.supplier.repository.MallSupplierMapper;
import com.txp.app.system.dto.SysRule;
import com.txp.app.util.CommUtils;
import com.ytoxl.module.core.common.pagination.BasePagination;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * th
 * 供应商管理
 */
@Slf4j
@Service("supplierManageApi")
public class SupplierManageApiImpl implements SupplierManageApi {

    @Resource
    private MallSupplierMapper mallSupplierMapper;

    @Override
    public Long insertSupplier(MallSupplierDto mallSupplierDto) {
        MallSupplier mallSupplier = new MallSupplier();
        BeanUtils.copyProperties(mallSupplierDto,mallSupplier);
        mallSupplierMapper.insertSelective(mallSupplier);
        return mallSupplier.getId();
    }

    @Override
    public void updateSupplier(MallSupplierDto mallSupplierDto) {
        MallSupplier mallSupplier = new MallSupplier();
        BeanUtils.copyProperties(mallSupplierDto,mallSupplier);
        mallSupplierMapper.updateByPrimaryKeySelective(mallSupplier);
    }

    @Override
    public MallSupplierDto getSupplierEditData(Long id) {
        MallSupplier mallSupplier = mallSupplierMapper.selectByPrimaryKey(id);
        MallSupplierDto mallSupplierDto = null;
        if(mallSupplier!=null) {
            mallSupplierDto = new MallSupplierDto();
            BeanUtils.copyProperties(mallSupplier,mallSupplierDto);
        }
        return mallSupplierDto;
    }

    @Override
    public Page<MallSupplierDto> findSupplierManageByType(Map<String, Object> map, int pageNo, int pageSize) {
        Page<MallSupplierDto> page = new Page<MallSupplierDto>();
        page.setPageNo(pageNo);
        page.setPageSize(pageSize);
        Long startIndex = Long.valueOf(((int) pageNo - 1) * (int) pageSize);
        Long endIndex = Long.valueOf((int) pageSize);

        map.put("startIndex",startIndex);
        map.put("endIndex",endIndex);

        page.setTotalCount(mallSupplierMapper.selectSupplierManageListCount(map));
        page.setPageNo((pageNo - 1) * pageSize);
        page.setPageSize(pageSize);

        List<MallSupplier> rows = mallSupplierMapper.selectSupplierManageList(map);
        List<MallSupplierDto> rowsDto = new ArrayList<>();
        if(rows!=null&&rows.size()>0) {
            for(MallSupplier mallSupplier : rows) {
                MallSupplierDto mallSupplierDto = new MallSupplierDto();
                BeanUtils.copyProperties(mallSupplier,mallSupplierDto);
                rowsDto.add(mallSupplierDto);
            }
        }else {
            page.setResult(rowsDto);
        }
        page.setResult(rowsDto);
        return page;
    }

    @Override
    public MallSupplierDto findMallSupplierByUserId(Long userId) {
        MallSupplier mallSupplier = mallSupplierMapper.findMallSupplierByUserId(userId);
        MallSupplierDto mallSupplierDto = null;
        if(mallSupplier!=null) {
            mallSupplierDto = new MallSupplierDto();
            BeanUtils.copyProperties(mallSupplier,mallSupplierDto);
        }
        return mallSupplierDto;
    }

    @Override
    public void initRuleForSupplier(Long mallSupplierId) {
        List<MallSupplierRule> mallSupplierRules = mallSupplierMapper.findRuleByTemplate(0l);
        if(!CommUtils.isNull(mallSupplierRules)) {
            for(MallSupplierRule mallSupplierRule : mallSupplierRules) {
                MallSupplierRule m = new MallSupplierRule();
                m.setMallSupplierId(mallSupplierId);
                m.setSysRuleId(mallSupplierRule.getSysRuleId());
                mallSupplierMapper.insertMallSupplierRule(m);
            }
        }
    }

    @Override
    public List<SysRule> queryRoleBySupplierId(Long id) {
        return mallSupplierMapper.queryRoleBySupplierId(id);
    }

    @Override
    public void saveMallSupplierRole(Long roleId, Long supplierId) {
        MallSupplierRule mallSupplierRule = new MallSupplierRule();
        mallSupplierRule.setMallSupplierId(supplierId);
        mallSupplierRule.setSysRuleId(roleId);
        mallSupplierMapper.saveMallSupplierRole(mallSupplierRule);
    }

    @Override
    public void deleteMallSupplierRole(Long roleId) {
        mallSupplierMapper.deleteMallSupplierRole(roleId);
    }

    @Override
    public AppResult<List<MallSupplierDto>> getSuppliers(Map<String,Object> map) {
        AppResult<List<MallSupplierDto>> result = new AppResult<List<MallSupplierDto>>();

        List<MallSupplier> rows = mallSupplierMapper.selectSupplierList(map);
        List<MallSupplierDto> rowsDto = new ArrayList<>();
        if(rows!=null&&rows.size()>0) {
            for(MallSupplier mallSupplier : rows) {
                MallSupplierDto mallSupplierDto = new MallSupplierDto();
                BeanUtils.copyProperties(mallSupplier,mallSupplierDto);
                rowsDto.add(mallSupplierDto);
            }
        }else {
            result.setResult(rowsDto);
        }
        result.setResult(rowsDto);
        return result;
    }

    @Override
    public String getLoginNameBySupplierId(Long id) {
        return mallSupplierMapper.getLoginNameBySupplierId(id);
    }

    @Override
    public BasePagination<MallSupplierDto> findSupplierManageByTypeNew(BasePagination<MallSupplierDto> rolerPage) {
        Map<String, Object> searchParams = rolerPage.getSearchParamsMap();
        if (rolerPage.isNeedSetTotal()) {
            Integer total = mallSupplierMapper.findSupplierManageByTypeCountNew(searchParams);
            rolerPage.setTotal(total);
        }
        List<MallSupplierDto> result = mallSupplierMapper.findSupplierManageByTypeNew(searchParams);
        if(result==null) {
            result = new ArrayList<>();
        }
//        MallSupplierDto dto = new MallSupplierDto();
//        dto.setId(0L);
//        dto.setCompanyName("供应商基础权限");
//        result.add(0,dto);
        rolerPage.setResult(result);
        return rolerPage;
    }
}
