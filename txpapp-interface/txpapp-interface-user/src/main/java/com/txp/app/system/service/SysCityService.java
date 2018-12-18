package com.txp.app.system.service;


import com.txp.app.entity.Page;
import com.txp.app.exception.BusException;
import com.txp.app.system.dto.SysCity;
import com.txp.app.util.TreeModel;

import java.util.List;
import java.util.Map;


public interface SysCityService {

	Page<SysCity> query(int[] pageParams, String cityName, String orgId, String lft, String rgt);

	List<TreeModel> findChannelTree();

	void add(String cityName, String cityDesc, String orgId) throws BusException;

	void deleteCity(String id) throws BusException;

	SysCity queryCity(String id);

	void updateSave(String id, String orgId, String cityName, String cityDesc);

	Map<String, Object> queryOrg(String id);

}
