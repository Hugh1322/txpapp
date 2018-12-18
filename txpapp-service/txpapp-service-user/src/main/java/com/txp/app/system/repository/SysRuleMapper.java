package com.txp.app.system.repository;

import com.txp.app.system.dto.SysRule;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SysRuleMapper {

    /**
     *
     sys_rule
     *
     * @mbggenerated Tue Jan 02 18:54:13 CST 2018
     */
    int deleteByPrimaryKey(Long id);

    /**
     *
     sys_rule
     *
     * @mbggenerated Tue Jan 02 18:54:13 CST 2018
     */
    int insert(SysRule record);

    /**
     *
     sys_rule
     *
     * @mbggenerated Tue Jan 02 18:54:13 CST 2018
     */
    int insertSelective(SysRule record);

    /**
     *
     sys_rule
     *
     * @mbggenerated Tue Jan 02 18:54:13 CST 2018
     */
    SysRule selectByPrimaryKey(Long id);

    /**
     *
     sys_rule
     *
     * @mbggenerated Tue Jan 02 18:54:13 CST 2018
     */
    int updateByPrimaryKeySelective(SysRule record);

    /**
     *
     sys_rule
     *
     * @mbggenerated Tue Jan 02 18:54:13 CST 2018
     */
    int updateByPrimaryKey(SysRule record);


    List<SysRule> selectSysRuleList(Long parentId);

    List<SysRule> findAllRuleList();

    List<SysRule> findRuleByCode(String ruleCode);

    List<SysRule> selectAllList(@Param("supplierId") Long supplierId);

    List<SysRule> findRuleListByPId(Long parentId);
}
