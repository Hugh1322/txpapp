package com.txp.app.supplier.repository;


import com.txp.app.supplier.dto.MallSupplierDto;
import com.txp.app.supplier.dto.MallSupplierSysuser;
import com.txp.app.supplier.entity.MallSupplier;
import com.txp.app.supplier.entity.MallSupplierRule;
import com.txp.app.system.dto.SysRule;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public interface MallSupplierMapper {
    /**
     * 
    mall_supplier
     *
     * @mbggenerated Thu Apr 12 13:34:47 CST 2018
     */
    int deleteByPrimaryKey(Long id);

    /**
     * 
    mall_supplier
     *
     * @mbggenerated Thu Apr 12 13:34:47 CST 2018
     */
    int insert(MallSupplier record);

    /**
     * 
    mall_supplier
     *
     * @mbggenerated Thu Apr 12 13:34:47 CST 2018
     */
    long insertSelective(MallSupplier record);

    /**
     * 
    mall_supplier
     *
     * @mbggenerated Thu Apr 12 13:34:47 CST 2018
     */
    MallSupplier selectByPrimaryKey(Long id);

    /**
     * 
    mall_supplier
     *
     * @mbggenerated Thu Apr 12 13:34:47 CST 2018
     */
    int updateByPrimaryKeySelective(MallSupplier record);

    /**
     * 
    mall_supplier
     *
     * @mbggenerated Thu Apr 12 13:34:47 CST 2018
     */
    int updateByPrimaryKey(MallSupplier record);

    Long selectSupplierManageListCount(Map<String, Object> map);

    List<MallSupplier> selectSupplierManageList(Map<String, Object> map);

    void insertMallSupplierSysuser(MallSupplierSysuser mallSupplierSysuser);

    MallSupplier findMallSupplierByUserId(Long userId);

    void updateMallSupplierSysuser(MallSupplierSysuser mallSupplierSysuser);

    List<MallSupplierRule> findRuleByTemplate(Long mallSupplierId);

    void insertMallSupplierRule(MallSupplierRule m);

    List<SysRule> queryRoleBySupplierId(Long id);

    void saveMallSupplierRole(MallSupplierRule mallSupplierRule);

    void deleteMallSupplierRole(Long roleId);

    List<MallSupplier> selectSupplierList(Map<String, Object> map);


    /**
     *
     * 查询所有的供应商
     * @Auth anwj
     *
     * 20180503
     *
     * */
    List findMallSuppliers();

    /**
     * 删除该权限下所有供应商，然后再次添加
     * @Auth anwj
     * 20180507
     * */
    void  deleteMallSupplierRule(Long ruleid);

    /**
     *
     * 查询指定权限下所有公司名称
     *
     * @Auth anwj
     *  20180507
     * */
    List<String> findRule(MallSupplierRule rule);

    String getLoginNameBySupplierId(Long id);

    Integer findSupplierManageByTypeCountNew(Map<String, Object> searchParams);

    List<MallSupplierDto> findSupplierManageByTypeNew(Map<String, Object> searchParams);
}