<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>商家活动报名</title>
<link href="${_cssPath}/common.css" rel="stylesheet" />
<link href="${_cssPath}/pages/arrangement.css" rel="stylesheet" />
<script type="text/javascript" src="${_jsPath }/jquery/jquery.1.8.1.js"></script>
</head>
<body>
<jsp:include page="../include/header.jsp"  flush="true" />
<div class="body m-w980p">
		<div>
       		<form class="sub-form m-clear m-mt10p" action="${_ctxPath}/seller/activities/activities-showActivitiesDetailsPage.htm?activityListPage4Sellers.params.type=2" id="search-form" method="post">
       			<input type="hidden" value="${activityListPage4Sellers.params.activeId }" name="activityListPage4Sellers.params.activeId" id="activeId"/>
       			品牌名称：<select name="activityListPage4Sellers.params.brandId" id="brand" class="m-sel">
                   <option value="">全部品牌</option>
                   	<c:forEach items="${sellerBrands }" var="brand">
						<option value="${brand.brandId }"
							<c:if test="${activityListPage4Sellers.params.brandId==brand.brandId }">
								selected = "selected"
							</c:if>
						>${brand.name }</option>
					</c:forEach>
                </select>
                                                 商品名称：
              <input type="text" data-default="输入商品名称" name="activityListPage4Sellers.params.productName" value="${activityListPage4Sellers.params.productName}" class="J-keywords txt-input input-marks" />
              <input type="button" class="m-btn m-btn-search" value="查 询" id="search"/>                                   
       		</form>
       	</div>
		<div class="body-nav m-mt10p">
			<ul class="m-clear">
				<li><a href="${_ctxPath}/seller/activities/activities-showActivitiesDetailsPage.htm?activityListPage4Sellers.params.type=1&activeId=${activityListPage4Sellers.params.activeId }">已报名商品</a></li>
				<li><a class="current-chose" href="${_ctxPath}/seller/activities/activities-showActivitiesDetailsPage.htm?activityListPage4Sellers.params.type=2&activeId=${activityListPage4Sellers.params.activeId }">未报名商品</a></li>
			</ul>
		</div>
		<div class="m-mt10p arrange-management">
			<table id="order-tab" width="100%" class="tab-control">
			<thead>
					<tr>
						<th width="15%">品牌</th>
						<th width="20%">商品名称</th>
						<th width="10%">商品规格</th>
						<th width="15%">结算价</th>
						<th width="15%">活动结算价</th>
						<th width="15%">活动库存</th>
						<th width="10%">操作</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${not empty productSkuPage.result}">
					<c:forEach items="${productSkuPage.result}" var="productSku" varStatus="status">
						<tr class="list-tr">
							<td>${productSku.product.brand.name }</td>
							<td>${productSku.product.name }</td>
							<td>${productSku.skuSpecification}</td>
							<td>${productSku.settlementPrice == null ? '0.00': productSku.settlementPrice}</td>
							<td><input type="text" value="${productSku.settlementPriceByActivity}" name="activeApply.price" id="price_${productSku.productSkuId}"/></td>
							<td><input type="text" name="activeApply.amount" id="amount_${productSku.productSkuId }"/></td>
							<td><a href="javaScript:addActiveApply('${activeId }','${productSku.productSkuId }','${productSku.product.name }','${productSku.skuSpecification}','${productSku.settlementPrice == null ? '0.00': productSku.settlementPrice}')">报名</a></td>
						</tr>
					</c:forEach>
				</c:if>
				</tbody>
			</table>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/foot.jsp"></jsp:include>
	<script language="javascript">
		$(function(){
			$("#search").click(function(){
					var keywords = $(".J-keywords").val();
					if(keywords == $(".J-keywords").attr("data-default")){
						$(".J-keywords").val("");
					}
					$(".sub-form").submit();
				});
		
		});
		function validInventory(domObj){
			var regFn = /^(0|[1-9]\d{0,4})$/ ;
			if(domObj == null || domObj == ''||!regFn.test(domObj)){
				alert('请输入正确库存');
				return false;
			}
			return true;
		}
		function addActiveApply(activeId,productSkuId,productName,skuSpecification,settlementPrice) {
			var urlPath = "${_ctxPath}/seller/activities/activities-addActiveApply.htm";
			var amount = $("#amount_"+productSkuId).val();
			var price = $("#price_"+productSkuId).val();
			if(activeId==null||activeId==''){
				activeId = $("#activeId").val();
			}
			var result = validInventory(amount);
			if(result == false) return;
			$.ajax({
				url: urlPath,
				type:"POST",
				data :  {"activeApply.activeId":activeId,"activeApply.skuId":productSkuId,"activeApply.amount":amount,"activeApply.price":price,"activeApply.productName":productName,"activeApply.skuSpecification":skuSpecification,"activeApply.settlementPrice":settlementPrice},
				dataType:"json",
				async: false,
				success:function(data){
					if(data.code == "true"){
						location.href='${_ctxPath}/seller/activities/activities-showActivitiesDetailsPage.htm?activityListPage4Sellers.params.type=1&activeId='+activeId;
					}
				},
				error:function(data){
					  alert("访问失败");
				}
			});
		}
	</script>
</body>
</html>