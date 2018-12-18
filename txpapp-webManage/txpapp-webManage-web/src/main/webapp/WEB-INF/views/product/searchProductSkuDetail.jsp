<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>

<tr class="show-tr">
	<td colspan="10" width="100%" class="show-tab">
		<div class="order-info" style="display: block;">
			<div class="layout">
				<div><h4>商品详情</h4></div>			
				<table>
					<thead>
						<tr>
							<td width="100px;">SKU编码</td>
							<td width="50px;">规格</td>
							<td width="50px;">重量</td>
							<td width="50px;">库存</td>
							<td width="110px;">商品标识</td>
							<td width="70px;">售卖价</td>
							<td width="70px;">原价</td>
							<td width="70px;">销售激励</td>
							<td width="70px;">结算价</td>
							<c:if test="${mark != 1 }">
								<td width="200px;">平台码</td>
							</c:if>
							<c:if test="${mark != 1 }">
							<td width="200px;">商家名称</td>
							</c:if>
							<c:if test="${mark == 2 }">
								<td width="200px;"></td>
							</c:if>
						</tr>
					</thead>
					<tbody>
					<tr>
						<td>10001</td>
						<td>100k/袋</td>
						<td>100k</td>
						<td><span id="inventory${productSku.productSkuId }">111</span></td>
						<td>aeeee</td>
						<td>89.5</td>
						<td>90</td>
						<td>78</td>
						<td><span id="settlement${productSku.productSkuId }">100</span></td>
						<td>好吃的</td>
						<td><p><a class="c-blue quickEdit" href="javascript:kcedit('inventory100',100,1,1)">库存编辑</a></p></td>
						<!-- 非分期送商品 -->
						<td><p><a class="c-blue quickEdit" href="javascript:settlementedit('settlement100',100,1,1);">结算价设置</a></p></td>
					</tr>
						<c:forEach items="${productSkuList }" var="productSku">
							<tr>
								<td>${productSku.productSkuId }</td>
								<td>${productSku.skuSpecification }</td>
								<td>${productSku.skuWeight }</td>
								<td><span id="inventory${productSku.productSkuId }">${productSku.inventory }</span></td>
								<td>${productSku.sellerSkuCode }</td>
								<td>${productSku.unitPrice }</td>
								<td>${productSku.marketPrice }</td>
								<td>${productSku.sellInspire }</td>
								<td><span id="settlement${productSku.productSkuId }">${productSku.settlementPrice }</span></td>
								<c:if test="${mark != 1 }">
									<td>${productSku.skuCode }</td>
								</c:if>
								<c:if test="${mark != 1 }">
									<td>${productSku.sellerName }</td>
								</c:if>
								<c:if test="${mark == 1 && productSku.product.sellStatus != 1 }">
									<td><p><a class="c-blue quickEdit" href="javascript:kcedit('inventory${productSku.productSkuId  }',${productSku.productSkuId },${productSku.product.sellType },${productSku.product.productId})">库存编辑</a></p></td>
								</c:if>
								<c:if test="${ productSku.product.sellType ne 5 }">
								<!-- 非分期送商品 -->
									<c:if test="${mark == 2 && productSku.product.sellStatus != 1 }">
										<td><p><a class="c-blue quickEdit" href="javascript:settlementedit('settlement${productSku.productSkuId  }',${productSku.productSkuId },${productSku.product.sellType },${productSku.product.productId});">结算价设置</a></p></td>
									</c:if>
								</c:if>
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
				url: _ctxPath + '/test/user/product2/quickSave.do',
				data: $("#productSkuForm").serialize(),
				dataType:"json",
				success:function(msg){
					if(msg.info){
						console.log(msg.msg);
						$('#inventory'+id).text(cc[1].value);
						$.dialog({
				            title: false,
//				            content: msg.infoValues[0],
				            content: msg.msg,
				            time : 2000
				        });	
					
					}else{
						$.dialog({
				            title: false,
				            content: msg.info,
				            time : 2000
				        });
					}
				},
				fail:function(msg) {
					alert("出错！");
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
		url: _ctxPath + '/test/user/product2/quickEditProduct.do',
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

function settlementedit(kc,id,sellType,pId,spa,sd,ed){
	var dialog = $.dialog({
	    lock: true,
	    title:false,
	    okValue: "确认",
        ok: function(){
			var cc = $("#productSkuForm").serializeArray();
			var result = validSettlement(cc);
			if(result == false) return;
        	$.ajax({
				type:'POST',
				url: _ctxPath + '/seller/product/product-quickSaveSettlement.htm',
				data: $("#productSkuForm").serialize(),
				success:function(msg){
					if(msg.code == "true"){
						$.dialog({
				            title: false,
				            content: msg.info,
				            time : 2000
				        });
						$('#settlement'+id).text(parseFloat(cc[1].value).toFixed(2))
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
	    },
	    visible: false
  });
  var productId = $(this).closest("tr").attr("productId");
  $.ajax({
		type:'POST',
		url: _ctxPath + '/test/user//product/quickEditSettlement.do',
		data: "product.productSku.productSkuId=" + id 
		+ "&product.productSku.settlementPrice=" + $("#"+kc).text() 
		+ "&product.sellType=" + sellType 
		+ "&product.productId=" + pId,
		success:function(html){
			dialog.visible().content(html);
		},
		error: function(xhr){
			popupDialog(xhr.responseText);
        }
	});
  $(".d-close").hide();
}

function validSettlement(domObj){
	var sp = domObj[1].value;
	var spa = domObj[2].value;
	var sd = domObj[3].value;
	var ed = domObj[4].value;
	//alert(sp + '-' + spa + '-' + sd + '-' + ed);
	if(sp == null || sp == ''){
		alert('你输入的结算价不合法');
		return false;
	}
	
	if(spa != null && spa != '') {
		if (sd == null || sd == '' || ed == null || ed == ''){
			alert('活动结算价截止时间不能为空');
			return false;
		} else {
			if(compareDate(sd, ed)){
				alert("开始时间不能大于结束时间！");
				return false;
			}
		}
	}
	return true;
}

//比较日前大小  如果开始大于结束，返回true
function compareDate(checkStartDate, checkEndDate) {      
    var arys1= new Array();      
    var arys2= new Array();      
	if(checkStartDate != null && checkEndDate != null) {      
	    var sdate=new Date(checkStartDate).getTime();      
	    var edate=new Date(checkEndDate).getTime();
	    //alert(sdate + '-' + edate);      
		if(sdate >= edate) {      
		    return true;         
		}else{   
		    return false;      
	    }   
    }      
}    

//-->
</script>

