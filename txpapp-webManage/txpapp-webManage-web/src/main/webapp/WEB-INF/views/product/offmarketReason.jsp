<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>
<link href="${_cssPath }/pages/addProduct.css" rel="stylesheet" />
<script type="text/javascript">
<!--

//-->
</script>
<form id="cancelReasonForm">
	<input type="hidden" name="product.productId"
		value="${product.productId}" />
	<table class="repertories" style="width: 400px;" class="small">
		<tr>
			<th colspan="2">下架原因</th>
		</tr>
		<tr>
			<td style="text-align: left; padding: 5px 5px 5px 5px;"><input
				type="radio" name="product.offmarket" value="库存不足" checked="checked"><label>库存不足</label><br />
				<input type="radio" name="product.offmarket" value="原厂商不再生产该产品"><label>原厂商不再生产该产品</label><br/>
				<input type="radio" name="product.offmarket" value="更新新商品"><label>更新新商品</label><br/>
				<input type="radio" name="product.offmarket" value="others"><label>其他:</label><br/>
				<textarea id="others" cols="80" rows="10" name="product.others"></textarea>
			</td>
		</tr>
	</table>
</form>

