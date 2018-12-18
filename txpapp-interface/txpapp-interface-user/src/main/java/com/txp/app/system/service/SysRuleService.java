
package com.txp.app.system.service;


import com.txp.app.exception.BusException;
import com.txp.app.system.dto.SysRule;
import com.txp.app.util.TreeModel;

import java.util.List;
import java.util.Set;


/**
 * 权限服务接口
 *
 * @author HWang
 */
public interface SysRuleService {

	List<SysRule> findRuleListByParentId(Long parentId);

	/**
	 * 
	 * @param isRecursion 是否使用递归
	 * @return
	 */
	List<TreeModel> findRuleTree(Boolean isRecursion, Long supplierId);

	List<TreeModel> findRuleTree(Set<Long> ruleIdSet, Long supplierId);

	List<SysRule> findAllRuleList();

	List findRuleByCode(String ruleCode);

	SysRule findRuleById(Long id) throws BusException;

	void saveRule(SysRule rule);

	void updateRule(SysRule rule);

	/**
	 * 新增或更新商户权限
	 * @param mallSupplierRuleList 商户ID列表，使用“，”分割
	 *                             如果该参数为空，则删除包括权限ID的所有商户
	 *
	 * @param ruleId 权限Id
	 *
	 * */
	void saveOrUpdateRule(String mallSupplierRuleList, Long ruleId, boolean isPid);

	void deleteRule(Long id) throws BusException;

	List  findSuppliersByRule(String ruleId);
	/**
	 * 获取总页数
	 */
	Long getTotal();
}
