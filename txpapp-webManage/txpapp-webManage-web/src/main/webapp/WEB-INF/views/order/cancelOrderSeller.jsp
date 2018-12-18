<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>
<link href="${_cssPath }/pages/addProduct.css" rel="stylesheet" />
<script type="text/javascript">
<!--

//-->
</script>
<form id="cancelReasonForm">
	<input type="hidden" name="orderHead.orderId"
		value="${orderHead.orderId }" />
	<table class="repertories" style="width: 400px;" class="small">
		<tr>
			<th colspan="2">取消订单</th>
		</tr>
		<tr>
			<td style="text-align: left; padding: 5px 5px 5px 5px;"><input
				type="radio" name="orderHead.cancelReason" value="库存不足" checked="checked"><label>库存不足</label><br />
				<input type="radio" name="orderHead.cancelReason" value="原厂商不再生产该产品"><label>原厂商不再生产该产品</label><br />
				<input type="radio" name="orderHead.cancelReason" value="订单商品规格有误"><label>订单商品规格有误</label><br />
				<input type="radio" name="orderHead.cancelReason" value=""><label>其他:</label><br />
				<textarea style="border:1px solid #ccc; margin-top:5px;"  id="others" cols="80" rows="10" name="otherReason"></textarea>
			</td>
		</tr>
	</table>

</form>

