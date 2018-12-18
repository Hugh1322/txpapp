package com.txp.app.system.dto;

import java.io.Serializable;


public class SysUserRole implements Serializable{
		
		/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

		/**
		 * 用户编号
		 * */
		private Long userId;
		
		/**
		 * 角色编号
		 * */
		private Long roleId;

		public Long getUserId() {
			return userId;
		}

		public void setUserId(Long userId) {
			this.userId = userId;
		}

		public Long getRoleId() {
			return roleId;
		}

		public void setRoleId(Long roleId) {
			this.roleId = roleId;
		}

		public SysUserRole() {
		}

		public SysUserRole(Long userId, Long roleId) {
			this.userId = userId;
			this.roleId = roleId;
		}		
		
}
