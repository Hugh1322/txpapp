<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>
<link href="${_cssPath }/pages/addProduct.css" rel="stylesheet" />
<script type="text/javascript">
<!--
var mark = true;
function checkSellInspire(domObj,unitPrice){
	var regFn3=/^\d{1,6}(\.\d{0,2})?$/;
	if(!regFn3.test(domObj.value)){
		alert("销售激励设置的格式不正确");
		domObj.value = "";
		//domObj.focus();
		mark = false
		return mark;
	}
	
	if(parseFloat(domObj.value)>unitPrice){
		alert("销售激励不得大于售卖价.");
		domObj.value = "";
		//domObj.focus();
		mark = false
		return mark;
	}
	mark = true;
}
//-->
</script>
<form id="productSkuForm">
	<input type="hidden" name="product.productSku.productSkuId"
		value="${product.productSku.productSkuId }" />
	<table class="repertories" style="width: 400px;" class="small">
		<tr>
			<th colspan="2">销售激励设置界面</th>
		</tr>
		<tr>
			<td>销售激励</td>
			<td>
				<input type="text"
					value="${(product.productSku.sellInspire==null)?'0.00':(product.productSku.sellInspire)}" maxlength="9"
					name="product.productSku.sellInspire"
					onblur="checkSellInspire(this,'${product.productSku.unitPrice}')" />
			
			</td>
			</tr>
		<tr>
			<td>上次更新时间</td>
			<td>
			<fmt:formatDate value='${product.productSku.sellInspireUpdateTime }' pattern='yyyy-MM-dd HH:mm:ss'/></td>
		</tr>
		<tr>
			<td>活动有效时间</td>
			<td><input id="startTime" name="product.productSku.sellInspireStartTime"
				value="<fmt:formatDate value='${product.productSku.sellInspireStartTime}' pattern='yyyy-MM-dd HH:mm:ss'/>" class="Wdate" type="text"
				readOnly="readOnly" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'endTime\')}',readOnly:true})" />
				<label>至 </label> 
				<input id="endTime"
					name="product.productSku.sellInspireEndTime" value="<fmt:formatDate value='${product.productSku.sellInspireEndTime }' pattern='yyyy-MM-dd HH:mm:ss'/>"
					class="Wdate" type="text" readOnly="readOnly"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'startTime\')||\'%y-%M-%d\'}',readOnly:true})" />
			</td>
		</tr>
		
	</table>
</form>

