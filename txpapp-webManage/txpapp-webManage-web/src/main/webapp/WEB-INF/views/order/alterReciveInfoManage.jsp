<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>
<link href="${_cssPath }/pages/addProduct.css" rel="stylesheet" />
<script src="${_jsPath}/plugin/select/linkage_sel.js?v=${_resVerion}"></script>



<script type="text/javascript">
	$(function(){
		 var linkage = new linkageSelect();
		 var province = '${regionModel.provinceId}';
		 var city = '${regionModel.cityId}';
		 var regionId = '${orderAddress.regionId}';
	     linkage.init({
	         "oneSel":['#receiver_province','请选择',province],
	         "twoSel":['#receiver_city', '请选择',city],
	         "threeSel":['#receiver_region', '请选择',regionId]
	     });
	})
</script>
<form id="alterReciveForm">
	<input type="hidden" name="orderHead.orderId"
		value="${orderHead.orderId }" />
	<input type="hidden" name="orderAddress.orderAddressId" value="${orderAddress.orderAddressId }" />
	<table class="repertories" style="width: 100%;" class="small">
		<tr>
			<th>修改地址</th>
		</tr>
		<tr>
			<td style="padding: 5px 5px 5px 5px;" align="left">
				<table>
					<tr align="left">
						<td>收货人:</td><td><input type="text" id="alter_receiverName" name="orderAddress.receiverName" value="${orderAddress.receiverName }" /></td>
					</tr>
					<tr align="left">
						<td>手机:</td><td> <input type="text" id="alter_mobile" name="orderAddress.mobile" value="${orderAddress.mobile }" /></td>
					</tr>
					<tr align="left">
						<td>电话:</td><td>${orderAddress.telephone } </td>
					</tr>
					<tr align="left">
						<td>邮编:</td><td> ${orderAddress.postCode }</td>
					</tr>
					<tr align="left">
						<td>收货地址: </td><td>
						<select id="receiver_province" class="receiver linkagesel m-mr5p"></select>
                    	<select id="receiver_city" class="receiver linkagesel m-mr5p"></select>
                    	<select id="receiver_region"  name="orderAddress.regionId" class="receiver linkagesel"></select>
                    	</td>
					</tr>
					<tr align="left">
						<td>详细地址: </td>
						<td>
							<input type="text" id="receiver_detailAddress" name="orderAddress.detailAddress" value="${orderAddress.detailAddress }" />
						</td>
					</tr>
					<tr align="left">
						<td>用户备注： ${orderHead.orderRemark}</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</form>

