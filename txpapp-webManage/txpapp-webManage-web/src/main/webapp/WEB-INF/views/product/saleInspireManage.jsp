<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8" import="com.txp.app.contants.Product" pageEncoding="UTF-8"%>
<%@include file="../include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>商品销售激励管理</title>
<link href="${ _cssPath}/common.css" rel="stylesheet" />
<link href="${ _cssPath}/pages/orderManagement.css" rel="stylesheet" />
<script src="${_jsPath }/jquery/jquery.1.8.1.js"  type="text/javascript"></script>
<script src="${_jsPath }/plugin/My97DatePicker/WdatePicker.js"></script>
<link href="${_jsPath }/plugin/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" />
</head>
 <c:set var="STATUS_DRAFT" value="<%=Product.STATUS_DRAFT %>"></c:set>
    <c:set var="STATUS_PASS" value="<%=Product.STATUS_PASS %>"></c:set>
    <c:set var="CHECK_PEND" value="<%= Product.STATUS_CHECK_PEND %>"></c:set>
    <c:set var="status_no_pass" value="<%= Product.STATUS_NO_PASS %>"></c:set>
<body>
	<jsp:include page="../include/header.jsp" flush="true" />
	<div class="body m-w980p">
	 <!--start form-->
        <form class="sub-form m-clear m-mt10p" action="${_ctxPath}/seller/product/product-listSaleInspires.htm" method="post">
    <aut:authorize url="/seller/product/product-search">
            <div class="m-fl">
                <select name="productPage.params.brandId" id="brand" class="m-sel">
                   <option value="">全部品牌</option>
                           	<c:forEach items="${sellerBrands }" var="brand">
								<option value="${brand.brandId }"
								<c:if test="${productPage.params.brandId==brand.brandId }">
								selected = "selected"
								</c:if>
								>${brand.name }</option>
							</c:forEach>
                </select>
              <input type="text" data-default="输入品牌名称，商品名称，SKU码" name="productPage.params.name" value="${productPage.params.name }" class="J-keywords txt-input input-marks" /><input type="button" class="m-btn m-btn-search" value="查 询" id="search"/>
            </div>
            </aut:authorize>
           	<c:if test="${not empty productPage.result}">
	            <div class="m-fr curr-num">
	              <label >当前显示：</label>
	              <yp:commPageSize page="${productPage}" beanName="productPage"></yp:commPageSize>
	            </div>
           	</c:if>
        </form>
		<!--start 商品激励管理table-->
		<div class="order-management">
			<table width="100%" id="order-tab">
				<thead class="tab-control">
                    <tr>
                        <th width="20%">商品名称</th>
                        <th width="12%">销售方式</th>
                        <th width="56%">规格</th>
                        <th width="12%">操作</th>
                    </tr>
                </thead>
				<tbody>
					<c:if test="${fn:length(productPage.result)>0 }">
							<c:forEach items="${productPage.result}"  var="product" varStatus="status">
								<tr class="list-tr">
									<td colspan="8" class="td-nobor">
									  <form id="productSkuForm">
										<table class="tab-controlSaleInspire">
											<tr class="tr-height" productId="${product.productId }">
												<td width="20%">
													<img src="<yp:thumbImage originalPath='${product.coverPicture}' imageType='t84'></yp:thumbImage>" /><br/>
												   ${product.name}
												</td>
												<td width="12%">
					                    			<spring:message code="product.sellType.${product.sellType}"/>
												</td>
												<td width="56%">
													<table>
														<thead>
															<tr>
																<td width="80px;">规格</td><td width="80px;">重量</td><td width="80px;">库存</td>
																<td width="80px;">SKU编码</td><td width="80px;">售卖价</td><td width="80px;">原价</td>
																<td width="80px;">销售激励</td>
															</tr>
														</thead>
														<tbody>
															<c:forEach items="${product.productSkus }" var="productSku" varStatus="nstatus">
															<input type="hidden" name="product.productSku.productSkuId" value="${productSku.productSkuId }"/>
																<tr>
																	<td>${productSku.skuSpecification }</td>
																	<td>${productSku.skuWeight }</td>
																	<td>${productSku.inventory }</td>
																	<td>${productSku.productSkuId }</td>
																	<td><span id="unitPrice" class="unitPrice" data-item="${productSku.unitPrice}">${productSku.unitPrice }</span></td>
																	<td><span id="marketPrice" class="marketPrice" data-item="${productSku.marketPrice}">${productSku.marketPrice }</span></td>
                                                                   <td>
	                                                                   <span class="J_num" id="inspire_${status.index*1000+ nstatus.index}">
		                                                                    ${(productSku.sellInspire==null)?"0.00":(productSku.sellInspire)}
	                                                                   </span>
														               <input name="productSku.sellInspire " data-item="${productSku.productSkuId }" type="text" class="txt-input J_inputs" style="width:80px;display:none;"/>
													               </td>
													               <td><a href="javascript:" class="J_edits" onclick="changeInspire('${productSku.productSkuId }','${status.index*1000+ nstatus.index}')">编辑</a></td>
													     </tr>
															</c:forEach>
														</tbody>
													</table>
												</td>
											</tr>
										</table>
										</form>		
									</td>
								</tr>
								
							</c:forEach>
					</c:if>
					<c:if test="${fn:length(productPage.result)==0 }">
						<tr class="list-tr">
							<td colspan="7" class="td-nobor" align="center">
								对不起，没有找到相关商品信息，请重新选择查询条件
							</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
		<div class="table-bm-wrap cf">
			<!--S 右功能区-->
			<div class="fn-right">
				<!--S 分页-->
				<div class="pagination pagination-right">
					<c:if test="${not empty productPage.result}">
						<yp:commPage page="${productPage}" beanName="productPage"></yp:commPage>
					</c:if>
				</div>
				<!--E 分页-->
			</div>
			<!--E 右功能区-->
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/foot.jsp"></jsp:include>
	<script type="text/javascript" src="${_jsPath }/pages/saleInspireManage.js"></script>
</body>
<script type="text/javascript">
//编辑销售激励
function changeInspire(skuId,num){
	var dialog = $.dialog({
	    lock: true,
	    title:false,
	    okValue: "确认",
        ok: function(){
			var cc = $("#productSkuForm").serializeArray();
			var result = validInspire(cc);
			if(result == false) return;
        	$.ajax({
				type:'POST',
				url: _ctxPath + '/seller/product/product-quickSaveSaleInspire.htm',
				data: $("#productSkuForm").serialize(),
				success:function(msg){
					if(msg.code == "true"){
						$.dialog({
				            title: true,
				            content: msg.info,
				            time : 2000
				        });
						$('#inspire_'+num).text(parseFloat(cc[1].value).toFixed(2))

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
  	$.ajax({
		type:'POST',
		url: _ctxPath + '/seller/product/product-quickEditInspire.htm',
		data: "product.productSku.productSkuId=" + skuId,
		success:function(html){
			dialog.visible().content(html);
		},
		error: function(xhr){
			popupDialog(xhr.responseText);
        }
	});
  	$(".d-close").hide();
}

function validInspire(domObj){
	var inspire = domObj[1].value;
	var st = domObj[2].value;
	var et = domObj[3].value;
	if(inspire == null || inspire == ''){
		alert('你输入的销售激励不正确');
		return false;
	}
	if((st != null && st != '') &&(et == null || et == '')){
		alert('请选择活动结束时间');
		return false;
	}
	if((et != null && et != '') &&(st == null || st == '')){
		alert('请选择活动开始时间');
		return false;
	}
	return true;
}

</script>
</html>