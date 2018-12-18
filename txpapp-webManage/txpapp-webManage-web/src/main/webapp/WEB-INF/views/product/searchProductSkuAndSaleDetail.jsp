<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>

<tr class="show-tr">
	<td colspan="7" width="100%" class="show-tab">
		<div class="order-info" style="display: block;">
			<div class="layout">
				<div><h4>商品销售详情</h4></div>			
				<table>
					<thead>
						<tr>
							<td width="70px;">规格</td>
							<td width="70px;">重量</td>
							<td width="70px;">库存</td>
							<td width="100px;">SKU编码</td>
							<td width="70px;">售卖价</td>
							<td width="70px;">原价</td>
							<td width="70px;">销售激励</td>
							<td width="60px;">销售量</td>
							<td width="70px;">销售收入</td>
							<td width="70px;">总销售激励</td>
							<td width="70px;">订单数量</td>
							
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${productSkuList }" var="productSku">
							<tr>
								<td>${productSku.skuSpecification }</td>
								<td>${productSku.skuWeight }</td>
								<td><span id="inventory${productSku.productSkuId }">${productSku.inventory }</span></td>
								<td>${productSku.productSkuId }</td>
								<td>${productSku.unitPrice }</td>
								<td>${productSku.marketPrice }</td>
								<td>${productSku.sellInspire }</td>
								<td>${productSku.saleNum }</td>
								<td>${productSku.skuTotalPrice}</td>
								<td>${productSku.sellInspire*productSku.saleNum}</td>
								<td>${productSku.orderNum }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</td>
</tr>
<script type="text/javascript">
<!--
// var requestFlag = false;
function kcedit(kc,id,sellType,pId){
	
	var dialog = $.dialog({
	    lock: true,
	    title:false,
	    okValue: "确认",
        ok: function(){
			var cc = $("#productSkuForm").serializeArray();
			var result = validInventory(cc[1].value);
			if(result == false) return;
        	$.ajax({
				type:'POST',
				url: _ctxPath + '/seller/product/product-quickSave.htm',
				data: $("#productSkuForm").serialize(),
				success:function(msg){
					if(msg.code == "true"){
						$.dialog({
				            title: false,
				            content: msg.info,
				            time : 2000
				        });	
						$('#inventory'+id).text(cc[1].value)
					}else{
						$.dialog({
				            title: false,
				            content: msg.info,
				            time : 2000
				        });
					}
				}
			});
        },
	    cancelValue:"取消",
	    cancel: function(){
// 			requestFlag = false;
	    },
	    visible: false
  });
  var productId = $(this).closest("tr").attr("productId");
  $.ajax({
		type:'POST',
		url: _ctxPath + '/seller/product/product-quickEdit.htm',
		data: "product.productSku.productSkuId="+id+"&product.productSku.inventory="+$("#"+kc).text() + "&product.sellType=" + sellType + "&product.productId=" + pId,
		success:function(html){
			dialog.visible().content(html);
		},
		error: function(xhr){
			popupDialog(xhr.responseText);
// 			requestFlag = false;
        }
	});
  $(".d-close").hide();
}
function validInventory(domObj){
	if(domObj == null || domObj == ''){
		alert('你输入的库存信息不合法');
		return false;
	}
	return true;
}
//-->
</script>

