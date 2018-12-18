package com.txp.app.system.service;

import com.txp.app.supplier.entity.MallSupplierRule;
import com.txp.app.supplier.repository.MallSupplierMapper;
import com.txp.app.system.dto.SysRule;
import com.txp.app.system.repository.SysRuleMapper;
import com.txp.app.util.CommUtils;
import com.txp.app.util.TreeModel;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

@Service("sysRuleService")
public class SysRuleServiceImpl implements SysRuleService {

	@Resource
	private SysRuleMapper sysRuleMapper;
	@Resource
	private MallSupplierMapper mallSupplierMapper;

	@Override
	public List<SysRule> findRuleListByParentId(Long parentId) {
		return sysRuleMapper.selectSysRuleList(parentId);
	}

	@Override
	public List<SysRule> findAllRuleList() {
		List ruleList = sysRuleMapper.findAllRuleList();
		return ruleList;
	}

	@Override
	public List findRuleByCode(String ruleCode) {
		List ruleList = sysRuleMapper.findRuleByCode(ruleCode);
		return ruleList;
	}

	@Override
	public SysRule findRuleById(Long id) {
		return sysRuleMapper.selectByPrimaryKey(id);
	}

	@Override
	public void saveRule(SysRule rule) {
		sysRuleMapper.insertSelective(rule);
	}

	@Override
	public void updateRule(SysRule rule) {
		sysRuleMapper.updateByPrimaryKeySelective(rule);
	}

	@Override
	public void saveOrUpdateRule(String idList,Long ruleId ,boolean isPid){

		//更新子权限先删除该子权限，后添加,如果是本身权限，在进行删除
		if(!isPid){
			mallSupplierMapper.deleteMallSupplierRule( ruleId);
		}

		MallSupplierRule rule =  new MallSupplierRule();

		if(idList!=null && !idList.trim().equals("")){

			String[] split = idList.split(",");

			for (String id: split) {

				rule.setSysRuleId( ruleId);
				rule.setMallSupplierId(Long.valueOf(id));

				List<String> list = mallSupplierMapper.findRule(rule);

				if( list == null || list.size()==0){
					mallSupplierMapper.insertMallSupplierRule(rule);
				}
			}

		}
	}
	@Override
	public List<String> findSuppliersByRule( String ruleId){
        MallSupplierRule rule =  new MallSupplierRule();
        rule.setSysRuleId(Long.valueOf(ruleId));
		return mallSupplierMapper.findRule(rule);

	}
	@Override
	public void deleteRule(Long id) {
		sysRuleMapper.deleteByPrimaryKey(id);
	}

	@Override
	public List<TreeModel> findRuleTree(Boolean isRecursion, Long supplierId) {
		List<TreeModel> ruleTree = null;
		if (isRecursion) {
			ruleTree = findRuleTreeByPId(0L);
		} else {
			List<SysRule> ruleList = sysRuleMapper.selectAllList(supplierId);
			if (!CommUtils.isNull(ruleList)) {
				ruleTree = new ArrayList<TreeModel>();
				for (SysRule rule : ruleList) {
					TreeModel tree = new TreeModel();
					tree.setId(String.valueOf(rule.getId()));
					tree.setParentId(rule.getParentId().toString());
					tree.setName(rule.getRuleName());
					tree.setImgPath(rule.getRulePicture());
					ruleTree.add(tree);
				}
			}
		}
		return ruleTree;
	}

	private List<TreeModel> findRuleTreeByPId(Long parentId) {
		List<SysRule> ruleList = this.findRuleListByPId(parentId);
		List<TreeModel> treeList = null;
		if (!CommUtils.isNull(ruleList)) {
			treeList = new ArrayList<TreeModel>();
			for (SysRule rule : ruleList) {
				List<TreeModel> children = findRuleTreeByPId(rule.getId());
				TreeModel tree = new TreeModel();
				tree.setId(String.valueOf(rule.getId()));
				tree.setParentId(String.valueOf(parentId));
				tree.setName(rule.getRuleName());
				tree.setImgPath(rule.getRulePicture());
				tree.setChildren(children);
				treeList.add(tree);
			}
		}
		return treeList;
	}

	private List<SysRule> findRuleListByPId(Long parentId) {
		List<SysRule> ruleList = sysRuleMapper.findRuleListByPId(parentId);
		return ruleList;
	}

	@Override
	public List<TreeModel> findRuleTree(Set<Long> ruleIdSet,Long supplierId) {
		List<TreeModel> ruleTree = null;
		List<SysRule> ruleList = sysRuleMapper.selectAllList(supplierId);
		if (!CommUtils.isNull(ruleList)) {
			ruleTree = new ArrayList<TreeModel>();
			for (SysRule rule : ruleList) {
				TreeModel tree = new TreeModel();
				tree.setId(String.valueOf(rule.getId()));
				//tree.setParentId(String.valueOf(rule.getParent().getId()));
				tree.setParentId(String.valueOf(rule.getParentId()));
				tree.setName(rule.getRuleName());
				tree.setImgPath(rule.getRulePicture());
				if (!CommUtils.isNull(ruleIdSet) && ruleIdSet.contains(rule.getId())) {
					tree.setChecked("true");
				}
				ruleTree.add(tree);
			}
		}
		return ruleTree;
	}

	@Override
	public Long getTotal() {
		// TODO Auto-generated method stub
		return null;
	}
}
