/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.txp.app.system.dto;

import com.txp.app.supplier.dto.MallSupplierDto;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * 用户信息
 *
 * @author th
 */
@Data
public class SysUser implements Serializable {

	/**
	 *
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 主键ID
	 */
	private Long id;
	/**
	 * 登录用户名
	 */
	private String loginName;
	/**
	 * 姓名
	 */
	private String realName;
	/**
	 * 密码
	 */
	private String password;
	/**
	 * 性别
	 */
	private Integer sex;
	/**
	 * 状态
	 */
	private Integer status;

	/**
	 * 联系方式
	 */
	private String phone;
	/**
	 * 邮箱
	 */
	private String email;
	/**
	 * 创建时间
	 */
	private Date createTime;
	/**
	 * 更新时间
	 */
	private Date updateTime;

	/**
	 * 用户角色
	 */
	private String roleName;

	private Integer collectorStatus;

	private String inviteCode;

	private String qrCodeUrl;

	/**
	 * 所属的供应商
	 */
	private MallSupplierDto mallSupplier;



}
