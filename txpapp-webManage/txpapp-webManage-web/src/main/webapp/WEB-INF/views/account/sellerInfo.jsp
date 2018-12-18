<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<input type="hidden" name="faPage.params.userIds" id="userList" value="${faPage.params.userIds}"/>
<input type="hidden" name="famPage.params.userIds" id="famPageUserList" value="${famPage.params.userIds}"/>
<div class="income_up" style="display:none;">
	<div class="jebh"><span class="income_h">商家名称：</span><span class="income_close"></span></div>
	<p class="inup_p">
			<label><input type="checkbox" id="selAll" />&nbsp;全选&nbsp;</label>
	</p>
	<div class="inup_div" id="sellerInfo">
	</div> 
	<div style="margin: auto 0 ;" id="pageInfo">
	</div>
	<div class=" inup_bu" ><input type="button" class="m-btn" onclick="selectSeller()" value="确认"></div>
</div>
<script>
	function selectSeller(){
		//alert($("#account_export"));
		//判断当前页面的标示
		//根据用户选中的id进行清空
		
		
		
	}
</script>