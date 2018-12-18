<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>
<link href="${_cssPath }/pages/addProduct.css" rel="stylesheet" />
<script type="text/javascript">
<!--
var mark = true;
function checkSettlement(domObj){
	var regFn1 = /^[0-9]{1}\d{0,4}([\.]\d{1,2})?$/;
	var	regFn2 = /^0.(\d[1-9]|[1-9]\d?){1}$/;
	if(!regFn1.test(domObj.value) && !regFn2.test(domObj.value)){
		domObj.value = "";
		//domObj.focus();
		mark = false
		return mark;
	}
}
//-->
</script>
<form id="productSkuForm">
	<input type="hidden" name="product.productSku.productSkuId"
		value="${product.productSku.productSkuId }" />
	<table class="repertories" style="width: 400px;" class="small">
		<tr>
			<th colspan="2">结算价设置界面</th>
		</tr>
		<tr>
			<td>结算价</td>
			<td><input type="text"
				value="${product.productSku.settlementPrice }" maxlength="5"
				name="product.productSku.settlementPrice"
				onblur="checkSettlement(this)"></td>
		</tr>
		<tr>
			<td>活动结算价</td>
			<td><input type="text"
				value="${product.productSku.settlementPriceByActivity }" maxlength="5"
				name="product.productSku.settlementPriceByActivity"
				onblur="checkSettlement(this)"></td>
		</tr>
		<tr>
			<td>活动有效时间</td>
			<td><input id="startDate" name="product.productSku.startDate"
				value="<fmt:formatDate value='${product.productSku.startDate}' pattern='yyyy-MM-dd HH:mm:ss'/>" class="Wdate" type="text"
				readOnly="readOnly" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true})" />
				<label>至 </label> <input id="endDate"
				name="product.productSku.endDate" value="<fmt:formatDate value='${product.productSku.endDate }' pattern='yyyy-MM-dd HH:mm:ss'/>"
				class="Wdate" type="text" readOnly="readOnly"
				onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true})" /></td>
		</tr>
	</table>

	<input type="hidden" name="product.sellType"
		value="${product.sellType}" /> <input type="hidden"
		name="product.productId" value="${product.productId}" />
	<div id="settlementTip"></div>
</form>

