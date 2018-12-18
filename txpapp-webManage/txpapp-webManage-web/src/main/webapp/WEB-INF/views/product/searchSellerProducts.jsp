<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8" import="com.txp.app.contants.Product" pageEncoding="UTF-8"%>
<%@include file="../include/taglibs.jsp"%>
<%@page import="com.txp.app.contants.Product" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>商品管理</title>
<link href="${ _cssPath}/common.css" rel="stylesheet" />
<link href="${ _cssPath}/pages/orderManagement.css" rel="stylesheet" />
<script src="${_jsPath }/jquery/jquery.1.8.1.js" language="javascript"></script>
<script type="text/javascript">
</script>
</head>
 	<c:set var="STATUS_DRAFT" value="<%=Product.STATUS_DRAFT %>"></c:set>
    <c:set var="STATUS_PASS" value="<%=Product.STATUS_PASS %>"></c:set>
    <c:set var="CHECK_PEND" value="<%= Product.STATUS_CHECK_PEND %>"></c:set>
    <c:set var="status_no_pass" value="<%= Product.STATUS_NO_PASS %>"></c:set>
    <c:set var="STATUS_SELL" value="<%= Product.STATUS_SELL %>"></c:set>
    <c:set var="STATUS_INVALID" value="<%= Product.STATUS_INVALID %>"></c:set>
    <c:set var="STATUS_SELLOUT" value="<%= Product.STATUS_SELLOUT %>"></c:set>
     <c:set var="SELLTYPE_US" value="<%= Product.SELLTYPE_US %>"></c:set>
    <c:set var="STATUS_WAITING_SAMPLE" value="<%= Product.STATUS_WAITING_SAMPLE %>"></c:set>
    <c:set var="STATUS_WAITING_REVIEW" value="<%= Product.STATUS_WAITING_REVIEW %>"></c:set>
    <c:set var="STATUS_WAINTING_MAKING" value="<%= Product.STATUS_WAINTING_MAKING %>"></c:set>
    <c:set var="STATUS_IN_SERVICE" value="<%= Product.STATUS_IN_SERVICE %>"></c:set>
    <c:set var="STATUS_VALID" value="<%= Product.STATUS_VALID %>"></c:set>
    <c:set var="STATUS_WAINTING_INVALID" value="<%= Product.STATUS_WAINTING_INVALID %>"></c:set>
<body>
	<jsp:include page="../include/header.jsp" flush="true" />
	<div class="body m-w980p">
	 <!--start form-->
        <form id="subform" class="sub-form m-clear m-mt10p" action="${_ctxPath}/seller/product/product-searchSellerProducts.htm" method="post">
    <aut:authorize url="/admin/product/product-search">
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
                ${s }
                <select name="productPage.params.status" class="m-sel">
                	<option value="">选择商品状态</option>
							<c:forEach items="${frontStatuses }" var="obj">
							${obj }
								<option value="${obj }"
								<c:if test="${productPage.params.status==obj }">
									selected = "selected"
								</c:if>
								><spring:message code="product.status.${obj}"/></option>
							</c:forEach>
                 </select>
                  <select name="productPage.params.reviewStatus" class="m-sel">
                       <option value="">选择审核状态</option>
							<c:forEach items="${reviewStatuses }" var="obj">
								<option value="${obj }"
								<c:if test="${productPage.params.reviewStatus==obj}">
								selected = "selected"
								</c:if>
								><spring:message code="product.check.${obj}"/></option>
							</c:forEach>
                  </select>
              <input type="text" data-default="输入品牌名称，商品名称" name="productPage.params.name" value="${productPage.params.name}" class="J-keywords txt-input input-marks" /><input type="button" class="m-btn m-btn-search" value="查 询" id="search"/>
            </div>
            </aut:authorize>
           	<c:if test="${not empty productPage.result}">
	            <div class="m-fr curr-num">
	              <label >当前显示：</label>
	              <yp:commPageSize page="${productPage}" beanName="productPage"></yp:commPageSize>
	            </div>
           	</c:if>
           	 <div class="m-mt10p">
            	<aut:authorize url="/seller/product/product-addProduct">
            		<input type="button" id="addProduct" class="m-btn" value="商品申报" />
            	</aut:authorize>
            	 <aut:authorize url="/seller/product/group/gp-toAdd">
             	 <input type="button" id="addGroup" class="m-btn" onclick="toAddGroup()" value="添加团购商品" />
              <script type="text/javascript">
               function toAddGroup(){
            	   window.location.href="${_ctxPath}/seller/product/group/gp-toAdd.htm"
               }
              </script>
              </aut:authorize>
              <aut:authorize url="/seller/product/stagingSendProduct-addProductSku">
            		<input type="button" id="addProductSku" class="m-btn" value="添加分期送商品" />
              </aut:authorize>
              <input type="button" id="exportProduct" class="m-btn" value="商品导出" />
           <%--  	<aut:authorize url="/seller/product/product-importProduct">
            		<input type="button" id="importProduct" class="m-btn" value="批量导入" />
            	</aut:authorize> --%>
            </div>
        </form>
        <div>
        	<p><span style="color: red;">亲爱的商户，请将您提报的商品素材（图片、文案）或页面原文件打包后以邮件形式发送至</span><span style="color: blue;font-weight:bold;">zhaoshang@yichengpin.com</span><br /><span style="color: red;">，并在邮件主题上标明</span><span style="color: blue;font-weight:bold;">“商家名称（或ID）+商品名称”</span><span style="color: red;">，我们会尽快处理您的申请，谢谢!</span>
        	</p>
        </div>
		<!--start 商品管理table-->
		<div class="m-mt10p goods-management">
			<table width="100%" >
				<thead class="tab-control">
                    <tr>
                        <th width="12%">品牌</th>
                        <th width="12%">商品名称</th>
                        <th width="12%">商品编码</th>
                        <th width="12%">图片</th>
                        <th width="8%">商品状态</th>
                        <th width="8%">审核状态</th>
                         <th width="8%">操作人</th>
                        <th width="12%">操作时间</th>
                        <th width="8%">操作</th>
                    </tr>
                </thead>
				<tbody>
					<c:if test="${fn:length(productPage.result)==0 }">
						<tr class="list-tr">
							<td colspan="7" class="td-nobor" align="center">
								对不起，没有找到相关商品信息，请重新选择查询条件
							</td>
						</tr>
					</c:if>
					<c:if test="${fn:length(productPage.result)>0 }">
						<c:forEach items="${productPage.result}"  var="product" varStatus="status">
						<tr class="list-tr" >
							<td colspan="10" class="td-nobor">
								<table class="tab-control">
									<tr class="tr-height" productId="${product.productId }" sellStatus="${product.sellStatus }">
										<td class="num-icon" width="12%"><input id="sellType_${product.productId }" type="hidden" value="${product.sellType }">
											<i></i><label><a>${product.brand.name }</a></label>
										</td>
										<td width="12%">${product.aliasName}</td>
										<td width="12%">${product.productId }</td>
										<td width="12%">
											 <c:choose>
												<c:when test="${product.coverPicture == null || product.coverPicture == ''}">
													<c:choose>
																<c:when test="${product.imageUrls == null}">
															-
																</c:when>
																<c:otherwise>
																	<img src="<yp:thumbImage originalPath='${fn:substring( product.imageUrls ,0,fn:indexOf(product.imageUrls, ","))}' imageType='t84'></yp:thumbImage>" />
																</c:otherwise>
															</c:choose>
												</c:when>
												<c:otherwise>
													<img src="<yp:thumbImage originalPath='${product.coverPicture}' imageType='t84'></yp:thumbImage>" />
												</c:otherwise>
											</c:choose> 
										</td>
										<td width="8%">
										
										<spring:message code="product.status.${product.sellStatus}"/>
										</td>
										<td width="8%">
											<c:choose>
												<c:when test="${product.status != STATUS_DRAFT }">
													<div class="shenhe">
				                    					<spring:message code="product.check.${product.status}"/>
				                    				</div>
				                    			</c:when>
				                    			<c:otherwise>
				                    				<div class="shenhe">-</div>
				                    			</c:otherwise>											
											</c:choose>

										</td>
										 <td width="8%">${product.operatorName}</td>
                        				 <td width="12%">
                        				 <fmt:formatDate value='${product.operationTime}' pattern='yyyy-MM-dd HH:mm' /></td>
										<td width="8%">
		                     			<%--  --%>	<aut:authorize url="/sellerproduct/product-submitReview">
												<c:if test="${(product.status == STATUS_DRAFT || product.status == STATUS_INVALID || product.status == status_no_pass) && product.status != STATUS_IN_SERVICE}">
													<p><a class="c-blue review" href="javascript:;">提交审核</a></p>
												</c:if>
	                        			<%-- --%>	 </aut:authorize> 
											<aut:authorize url="/seller/product/product-waitingForOffMarket">
												<c:if test="${(product.status == STATUS_PASS && product.sellStatus == STATUS_SELL) || product.sellStatus==STATUS_SELLOUT || product.status == STATUS_VALID}">
													<p><a class="c-blue delete" href="javascript:;">下架</a></p>
												</c:if>
	                        				</aut:authorize>
	                        				 <!-- 分期送商品 alter by 徐国飞 start  -->
	                        				 <c:choose>
	                         						<c:when test="${product.sellType eq SELLTYPE_US }">
	                         								<aut:authorize url="/seller/product/buySchedule-editProductSku">
					                         					<c:if test="${product.status != STATUS_PASS && product.sellStatus != STATUS_SELL && product.status != CHECK_PEND && product.status != STATUS_WAITING_SAMPLE && product.status != STATUS_WAITING_REVIEW && product.status != STATUS_WAINTING_MAKING && product.status != STATUS_IN_SERVICE && product.status != STATUS_WAINTING_INVALID}">
					                         						<p><a class="c-blue editBuySchedule" href="javascript:;">编辑</a></p>
					                         					</c:if>
					                         				</aut:authorize>
	                         						</c:when>
	                         						<c:otherwise>
	                         								<aut:authorize url="/seller/product/product-edit">
					                         					<c:if test="${product.status != STATUS_PASS && product.sellStatus != STATUS_SELL && product.status != CHECK_PEND && product.status != STATUS_WAITING_SAMPLE && product.status != STATUS_WAITING_REVIEW && product.status != STATUS_WAINTING_MAKING && product.status != STATUS_IN_SERVICE && product.status != STATUS_WAINTING_INVALID}">
					                         						<p><a class="c-blue edit" href="javascript:;">编辑</a></p>
					                         					</c:if>
					                         				</aut:authorize>
	                         						</c:otherwise>
	                         				  </c:choose>
	                         				  <!-- 分期送商品 alter by 徐国飞 end  -->
	                         				  <!-- 
	                         				<aut:authorize url="/seller/product/product-edit">
	                         					<c:if test="${product.status != STATUS_PASS && product.sellStatus != STATUS_SELL && product.status != CHECK_PEND && product.status != STATUS_WAITING_SAMPLE && product.status != STATUS_WAITING_REVIEW && product.status != STATUS_WAINTING_MAKING && product.status != STATUS_IN_SERVICE && product.status != STATUS_VALID && product.status != STATUS_WAINTING_INVALID}">
	                         						<p><a class="c-blue edit" href="javascript:;">编辑</a></p>
	                         					</c:if>
	                         				</aut:authorize> -->
	                         				 <!-- 分期送商品 alter by 徐国飞 start  -->
	                        				 <c:choose>
	                         						<c:when test="${product.sellType eq SELLTYPE_US }">
					                         				<aut:authorize url="/seller/product/buySchedule-previewScheduleProduct">
					                         					<p><a class="c-blue" href="${_ctxPath }/seller/product/buySchedule-previewScheduleProduct.htm?product.productId=${product.productId}" target="_blank">预览</a></p>
					                         				</aut:authorize>
	                         						</c:when>
	                         						<c:otherwise>
	                         								<aut:authorize url="/seller/product/product-preview">
					                         					<p><a class="c-blue" href="${_ctxPath }/seller/product/product-preview.htm?product.productId=${product.productId}" target="_blank">预览</a></p>
					                         				</aut:authorize>
	                         						</c:otherwise>
	                         				  </c:choose>
	                         				  <!-- 分期送商品 alter by 徐国飞 end  -->
	                         				<!-- <aut:authorize url="/seller/product/product-preview">
	                         					<p><a class="c-blue" href="${_ctxPath }/seller/product/product-preview.htm?product.productId=${product.productId}" target="_blank">预览</a></p>
	                         				</aut:authorize>-->
	                         				<aut:authorize url="/seller/product/product-confirmSampleSent">
	                         					<c:if test="${product.status == STATUS_WAITING_SAMPLE}">
	                         						<p><a class="c-blue sampleSent" href="javascript:;">样品已发送</a></p>
	                         					</c:if>
	                         				</aut:authorize>
										</td>						
									</tr>
								</table>
							</td>
						</tr>
					</c:forEach>
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
	<script type="text/javascript" src="${_jsPath }/pages/searchSellerProducts.js"></script>
</body>
<script type="text/javascript">
	var isPost = true;
	$(document).ready(function() {
		$(".tr-height").on("click", function(e) {
			var $this = $(this),
			evt = $(e.target);
			if(!evt.is('a')){
				var productId = $this.attr('productId');
				var status = $this.attr('sellStatus');
				if (!$(this).next(".show-tr")[0]) {
					if( isPost == false) return;
					isPost = false;
					$.ajax({
						type : 'POST',
						url : '${_ctxPath}/admin/product/product-listProductSkuDetailOnline.htm',
						data : {
							"product.productId" : productId,
							"product.sellStatus" : status,
							"product.sellType" : $("#sellType_"+productId).val(),
							"mark" : 1
						},
						success : function(html) {
							isPost = true;
							var content;
							if (typeof html == "object") {
								data = eval(html);
								content = data.info;
							} else {
								content = html;
							}
							$($this).after($(content));
							$this.addClass("change");
							
						},
						error:function(){
							isPost = true;
						}
					});
				}
			}
		});
	});
</script>
</html>