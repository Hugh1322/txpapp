/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package com.txp.app.system.dto;

import java.io.Serializable;


/**
 * 角色
 *
 * @author th
 */
public class SysRole  implements   Serializable{

	private static final long serialVersionUID = 5372412796906257355L;
	/**
     * 主键ID
     */
    private Long id;
    /**
     * 角色代码
     */
    private String roleCode;
    /**
     * 角色名称
     */
    private String roleName;
    /**
     * 角色描述
     */
    private String roleDesc;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getRoleCode() {
        return roleCode;
    }

    public void setRoleCode(String roleCode) {
        this.roleCode = roleCode;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public String getRoleDesc() {
        return roleDesc;
    }

    public void setRoleDesc(String roleDesc) {
        this.roleDesc = roleDesc;
    }
}
