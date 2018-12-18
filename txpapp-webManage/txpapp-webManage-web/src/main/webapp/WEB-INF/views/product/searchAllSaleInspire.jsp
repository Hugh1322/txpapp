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
<%-- <link rel="stylesheet" type="text/css" href="${_cssPath}/pages/productList.css" media="all" /> --%>
<script type="text/javascript">
</script>
</head>
 <c:set var="STATUS_DRAFT" value="<%=Product.STATUS_DRAFT %>"></c:set>
    <c:set var="STATUS_PASS" value="<%=Product.STATUS_PASS %>"></c:set>
    <c:set var="CHECK_PEND" value="<%= Product.STATUS_CHECK_PEND %>"></c:set>
    <c:set var="status_no_pass" value="<%= Product.STATUS_NO_PASS %>"></c:set>
<body>
	<jsp:include page="../include/header.jsp" flush="true" />
	<div class="body m-w980p">
	<!-- 排序层 start-->
		<div class="rank_wrap cf">
			<div class="rank">
				<span id="tab1" class="">
					类型：
				</span>
				<span id="tab2" class="">
				    <input type="button" onclick="listByQuality();" value="按销量" style="width:70px" class="down">
				</span>
				<span id="tab4" class="r_spri">
					<input type="button" onclick="listByPrice();" value="按价格" style="width:70px" class="down"/>
				</span>
			</div>
		</div>
	 <!--start form-->
        <form class="sub-form m-clear m-mt10p" action="${_ctxPath}/admin/product/product-searchAllSaleInspires.htm" method="post">
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
															<c:forEach items="${product.productSkus }" var="productSku">
															   <input type="hidden" name="product.productSku.productSkuId" value="${product.productSku.productSkuId }"/>
																<tr>
																	<td>${productSku.skuSpecification }</td>
																	<td>${productSku.skuWeight }</td>
																	<td>${productSku.inventory }</td>
																	<td>${productSku.productSkuId }</td>
																	<td>${productSku.unitPrice }</td>
																	<td>${productSku.marketPrice }</td>
																	<td><span id="sellInspire${productSku.productSkuId }">${productSku.sellInspire }</span></td>
<%-- 																	<td id="inspire"><span>${productSku.sellInspire }</span></td> --%>
																	<td><input type="text" data-default="${productSku.sellInspire }" name="product.productSku.sellInspire" value="${product.productSku.sellInspire }" id="hiddenText" style="width:80px;display:none;"/></td>
													     </tr>
															</c:forEach>
														</tbody>
													</table>
												</td>
												<td width="8%">
<!-- 													<p> -->
<%-- 					                     				<aut:authorize url="/admin/product/product-view"> --%>
<!-- 					                           				<a class="c-blue view" href="javascript:;">编辑</a> -->
<%-- 					                       		 		</aut:authorize> --%>
<!-- 				                        			</p> -->
<%-- 				                       				 <c:if test="${product.status == CHECK_PEND}"> --%>
<!-- 				                           				<p> -->
<%-- 					                       					<aut:authorize url="/admin/product/product-review"> --%>
<!-- 					                           					<a class="c-blue review" href="javascript:;">提交</a> -->
<%-- 					                        				</aut:authorize> --%>
<!-- 				                           				</p> -->
<%-- 				                        			</c:if> --%>
												</td>						
											</tr>
										</table>
									</td>
								</tr>
							</c:forEach>
					</c:if>
<%-- 					<c:if test="${fn:length(productPage.result)==0 }"> --%>
<!-- 						<tr class="list-tr"> -->
<!-- 							<td colspan="7" class="td-nobor" align="center"> -->
<!-- 								对不起，没有找到相关商品信息，请重新选择查询条件 -->
<!-- 							</td> -->
<!-- 						</tr> -->
<%-- 					</c:if> --%>
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
</body>
<script type="text/javascript">
/**
 ** 根据价格降序查询
 **/
 function listByPrice(){
     var dir='${url_dir_100001}';
	 var url="${_ctxPath }/seller/product/inspireProduct-${url_sort_400}-"+dir+"-${productPage.total}-0.htm";
	 document.location.href=url;
 }
 //按销售量降序排序
 function listByQuality(){
	 var url="${_ctxPath }/seller/product/inspireProduct-${url_sort_200}-${url_dir_100001}-${productPage.total}-0.htm";
	 document.location.href=url;
 }
//设置查询TAB默认选中
 var tab=${productPage.params.orderType};
 //alert("orderType:"+tab);
 if(tab==1){//按销量从高到低
	 $("#tab2").attr("class","cur");
	 $("#tab4").attr("class","");
 }else if(tab==4){//按价格从高到低
	 $("#tab2").attr("class","");
	 $("#tab4").attr("class","cur down");
 }else{//按默认
	 $("#tab2").attr("class","");
 }
</script>
</html>