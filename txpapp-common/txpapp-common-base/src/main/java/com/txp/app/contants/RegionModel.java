package com.txp.app.contants;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;


public class RegionModel implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -4173167783332604277L;
	
	private Integer id;
	private String name;
	
	//用于存储省市区的id
	private Integer countyId;    //县名称Id
	private Integer cityId;      //市名称Id
	private Integer provinceId;  //省名称Id
	private Integer nationId;  //国家名称Id
	
	private String countyName;    //县名称NAME
	private String cityName;      //市名称NAME
	private String provinceName;  //省名称NAME
	
	private Integer parentId;
	
	private List<RegionModel> childrenRegion ;
	
	private List<RegionModel> allChildrenRegion ;
	
	public Integer getParentId() {
		return parentId;
	}
	public void setParentId(Integer parentId) {
		this.parentId = parentId;
	}
	public List<RegionModel> getAllChildrenRegion() {
		return allChildrenRegion;
	}
	
	public void setAllChildrenRegion(List<RegionModel> allChildrenRegion) {
		this.allChildrenRegion = allChildrenRegion;
	}
	public List<RegionModel> getChildrenRegion() {
		return childrenRegion;
	}
	public void setChildrenRegion(List<RegionModel> childrenRegion) {
		this.childrenRegion = childrenRegion;
	}
	public void addChild(RegionModel children){
		if(childrenRegion == null){
			childrenRegion = new ArrayList<RegionModel>();
		}
		childrenRegion.add(children);
	}
	
	public void addChild(List<RegionModel> children) {
		if(childrenRegion == null){
			childrenRegion = new ArrayList<RegionModel>();
		}
		childrenRegion.addAll(children);
	}
	public void addAllChildren(RegionModel t) {
		if(allChildrenRegion == null){
			allChildrenRegion = new ArrayList<RegionModel>();
		}
		childrenRegion.add(t);
		 
		
	}
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	
	public Integer getCountyId() {
		return countyId;
	}
	public void setCountyId(Integer countyId) {
		this.countyId = countyId;
	}
	public Integer getCityId() {
		return cityId;
	}
	public void setCityId(Integer cityId) {
		this.cityId = cityId;
	}
	public Integer getProvinceId() {
		return provinceId;
	}
	public void setProvinceId(Integer provinceId) {
		this.provinceId = provinceId;
	}
	public Integer getNationId() {
		return nationId;
	}
	public void setNationId(Integer nationId) {
		this.nationId = nationId;
	}
	public String getCountyName() {
		return countyName;
	}
	public void setCountyName(String countyName) {
		this.countyName = countyName;
	}
	public String getCityName() {
		return cityName;
	}
	public void setCityName(String cityName) {
		this.cityName = cityName;
	}
	public String getProvinceName() {
		return provinceName;
	}
	public void setProvinceName(String provinceName) {
		this.provinceName = provinceName;
	}

	

}
