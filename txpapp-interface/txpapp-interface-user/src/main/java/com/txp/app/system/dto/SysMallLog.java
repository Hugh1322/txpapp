/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.txp.app.system.dto;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;


/**
 * 操作日志 商城
 *
 * @author th
 */
@Data
public class SysMallLog implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 主键ID
	 */
	private Long id;
	/**
	 * 操作人
	 */
	private String operator;
	/**
	 * 操作时间
	 */
	private Date operateTime;

	/**
	 * 模块
	 */
	private String model;
	/**
	 * 操作描述
	 */
	private String description;
	/**
	 * 操作结果
	 */
	private String operateResult;
	/**
	 * 操作IP
	 */
	private String ip;



}
