<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>
<link href="${_cssPath }/pages/addProduct.css" rel="stylesheet" />
<script type="text/javascript">
<!--
var mark = true;
function checkInventory(domObj){
	var regFn = /^(0|[1-9]\d{0,4})$/ ;
	if(!regFn.test(domObj.value)){
		domObj.value = "";
		domObj.focus();
		mark = false
		return mark;
	}
}
//-->
</script>
<form id="productSkuForm">
	
	<table class="repertories" style="width:150px;" class="small">
	<input type="hidden" name="product.productSku.productSkuId" value="${product.productSku.productSkuId }"/>
		<tr>
			<th>*库存数</th>
		</tr>
		<tr>
			<td>
				<input type="text" value="${product.productSku.inventory }" maxlength="5" name="product.productSku.inventory" onblur="checkInventory(this)">
			</td>
		</tr>
	</table>
	<span style="color: red;">修改后的库存将实时同步</span><br/>
	<span style="color: red;">至网站，请慎重操作！</span>
	<input type="hidden" name="product.sellType" value="${product.sellType}"/>
	<input type="hidden" name="product.productId" value="${product.productId}"/>
	<div id="inventoryTip"></div>
</form>

