package com.txp.app.system.dto;

import java.io.Serializable;


/**
 * 角色权限
 * */
public class SysRoleRule implements Serializable{
		
		/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

		//角色id
		private Long roleId;
		
		//权限id
		private Long ruleId;

		public Long getRoleId() {
			return roleId;
		}

		public void setRoleId(Long roleId) {
			this.roleId = roleId;
		}

		public Long getRuleId() {
			return ruleId;
		}

		public void setRuleId(Long ruleId) {
			this.ruleId = ruleId;
		}

		public SysRoleRule(Long roleId, Long ruleId) {
			this.roleId = roleId;
			this.ruleId = ruleId;
		}

		public SysRoleRule() {
			
		}
		
		
		
}
