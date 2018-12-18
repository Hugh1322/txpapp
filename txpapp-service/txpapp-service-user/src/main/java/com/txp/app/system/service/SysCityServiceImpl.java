package com.txp.app.system.service;

import com.txp.app.entity.Page;
import com.txp.app.exception.BusException;
import com.txp.app.system.dto.SysCity;
import com.txp.app.system.dto.SysOrgCity;
import com.txp.app.system.dto.SysOrganization;
import com.txp.app.system.repository.SysCityMapper;
import com.txp.app.util.CommUtils;
import com.txp.app.util.TreeModel;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Service("sysCityService")
public class SysCityServiceImpl implements SysCityService {

	@Resource
	private SysCityMapper sysCityMapper;

	@Override
	public Page<SysCity> query(int[] pageParams, String cityName, String orgId, String lft, String rgt) {
		Page<SysCity> page = new Page<>();
		page.setPageNo(pageParams[0]);
		page.setPageSize(pageParams[1]);
		Long startIndex = Long.valueOf(((int) pageParams[0] - 1) * (int) pageParams[1]);
		Long endIndex = Long.valueOf((int) pageParams[1]);

		Map map = new HashMap<String,Object>();
		map.put("startIndex",startIndex);
		map.put("endIndex",endIndex);
		map.put("cityName",!CommUtils.isNull(cityName)?cityName:null);
		map.put("orgId",!CommUtils.isNull(orgId)?orgId:null);
		map.put("lft",!CommUtils.isNull(lft)?lft:null);
		map.put("rgt",!CommUtils.isNull(rgt)?rgt:null);

		page.setTotalCount(sysCityMapper.findSysCityListCount(map));
		List<SysCity> rows = sysCityMapper.findSysCityList(map);
		page.setResult(rows);

		return page;
	}

	@Override
	public List<TreeModel> findChannelTree() {
		List<TreeModel> channelTree = new ArrayList<TreeModel>();
		List<SysOrganization> list = sysCityMapper.selectAllSysOrganization();
		for (SysOrganization channel : list) {
			TreeModel tree = new TreeModel();
			tree.setId(String.valueOf(channel.getId()));
			tree.setParentId(String.valueOf(channel.getFatherId()));
			tree.setName(channel.getOrgName());
			tree.setImgPath(String.valueOf(channel.getLft()));
			tree.setUrl(String.valueOf(channel.getRgt()));
			channelTree.add(tree);
		}
		return channelTree;
	}

	@Override
	public void add(String cityName, String cityDesc, String orgId) throws BusException {
		if (CommUtils.isNull(orgId)) {
			throw new BusException("机构选择异常");
		}
		if (CommUtils.isNull(cityDesc)) {
			throw new BusException(" 备注为空");
		}
		if (CommUtils.isNull(cityName)) {
			throw new BusException("地域名为空");
		}
		SysCity sysCity = new SysCity();
		sysCity.setCityName(cityName);
		sysCity.setCityDesc(cityDesc);
		sysCityMapper.insertSysCity(sysCity);
		SysOrgCity sysOrgCity = new SysOrgCity();
		sysOrgCity.setOrgId(Long.parseLong(orgId));
		sysOrgCity.setCityId(sysCity.getId());
		sysCityMapper.insertSysOrgCity(sysOrgCity);
	}

	@Override
	public void deleteCity(String id) throws BusException {
		if (CommUtils.isNull(id)) {
			throw new BusException("地域ID为空");
		}
		sysCityMapper.deleteSysCity(id);
		sysCityMapper.deleteSysOrgCity(id);

	}

	@Override
	public SysCity queryCity(String id) {
		return sysCityMapper.selectByPrimaryKey(Long.parseLong(id));
	}

	@Override
	public void updateSave(String id, String orgId, String cityName, String cityDesc) {
		SysCity sysCity = new SysCity();
		sysCity.setId(Long.parseLong(id));
		sysCity.setCityName(cityName);
		sysCity.setCityDesc(cityDesc);
		sysCityMapper.updateByPrimaryKeySelective(sysCity);
		Long cou = sysCityMapper.selectSysOrgCityByCityId(Long.parseLong(id));
		if (cou == 0) {
			SysOrgCity sysOrgCity = new SysOrgCity();
			sysOrgCity.setOrgId(Long.parseLong(orgId));
			sysOrgCity.setCityId(Long.parseLong(id));
			sysCityMapper.insertSysOrgCity(sysOrgCity);
		} else {
			SysOrgCity sysOrgCity = new SysOrgCity();
			sysOrgCity.setOrgId(Long.parseLong(orgId));
			sysOrgCity.setCityId(Long.parseLong(id));
			sysCityMapper.updateSysOrgCity(sysOrgCity);
		}
	}

	@Override
	public Map<String, Object> queryOrg(String id) {
		return sysCityMapper.queryOrg(id);
	}

}
