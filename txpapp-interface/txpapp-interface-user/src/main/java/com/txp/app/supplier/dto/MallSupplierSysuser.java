package com.txp.app.supplier.dto;

import lombok.Data;

import java.io.Serializable;


/**
 * th
 */
@Data
public class MallSupplierSysuser implements Serializable{

	/**
	 *
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * */
	private Long id;

	/**
	 * 用户编号
	 * */
	private Long sysUserId;
	/**
	 * 供应商编号
	 */
	private Long mallSupplierId;

	/**
	 * 类型 1：超级管理员
	 */
	private Integer type;


}
