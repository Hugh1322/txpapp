<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8" import="com.txp.app.contants.Product" pageEncoding="UTF-8"%>
<%@include file="../include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>商品管理</title>
	<link href="${_cssPath }/common.css" rel="stylesheet" />
	<link href="${_cssPath }/pages/cashlist.css" rel="stylesheet" />
	<script type="text/javascript" src="${_jsPath }/jquery/jquery.1.8.1.js"></script>
	<script type="text/javascript"	src="${_jsPath }/plugin/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript"	src="${_jsPath }/plugin/formvalidator/formValidatorRegex.js"></script>
	<script type="text/javascript"	src="${_jsPath }/plugin/formvalidator/formValidator-4.1.3.js"></script>
	<script type="text/javascript"	src="${_jsPath }/plugin/artdialog/jquery.artDialog.min.js"></script>
	<link rel="stylesheet" type="text/css" href="${_jsPath }/plugin/artdialog/skins/ytoxl.css" media="all">

</head>
   <c:set var="STATUS_PASS" value="<%=Product.STATUS_PASS %>"></c:set>
    <c:set var="STATUS_DRAFT" value="<%=Product.STATUS_DRAFT %>"></c:set>
    <c:set var="CHECK_PEND" value="<%=Product.STATUS_CHECK_PEND %>"></c:set>
    <c:set var="status_no_pass" value="<%=Product.STATUS_NO_PASS %>"></c:set>
<body>
	<jsp:include page="../include/header.jsp" flush="true" />
	<div class="body m-w980p">
	 <!--start form-->
        <form id="searchForm" class="sub-form m-clear m-mt10p" action="${_ctxPath}/admin/product/product-querySellerProducts.htm" method="post">
        <input type="hidden" value="${userProductPage.params.sellerId}" name = "userProductPage.params.sellerId"/>
   			 
            <div class="m-fl">
                <select name="userProductPage.params.brandId" id="brand" class="m-sel">
                   <option value="">全部品牌</option>
                           	<c:forEach items="${brands }" var="brand">
								<option value="${brand.brandId }"
								<c:if test="${userProductPage.params.brandId==brand.brandId }">
								selected = "selected"
								</c:if>
								>${brand.name }</option>
							</c:forEach>
                </select>
                <select name="userProductPage.params.status" class="m-sel">
                	<option value="">选择商品状态</option>
							<c:forEach items="${statuses }" var="obj">
							<option value="${obj }"
								<c:if test="${userProductPage.params.status==obj }">
								selected = "selected"
								</c:if>
								><spring:message code="product.status.${obj}"/></option>
							</c:forEach>
                 </select>
                  
              <input type="text" data-default="输入品牌名称，商品名称" name="userProductPage.params.name" value="${userProductPage.params.name }" class="J-keywords txt-input input-marks" />

	        </div>
	        
	         <div class="m-mt10p">
              <input type="button" class="m-btn m-btn-search" value="查 询" id="search"/>
              
              <c:if test="${not empty userProductPage.result}">
                    <span class="m-fr curr-num">
                        <label>当前显示： </label>
                        <yp:commPageSize page="${userProductPage}" beanName="userProductPage"></yp:commPageSize>
                    </span>
                </c:if>
            </div>
	        <div class="m-mt10p">
				
				统计时间： 
				<input type="input" name="userProductPage.params.beginTime" value="${userProductPage.params.beginTime}" class="Wdate" id="startTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endTime\')}',readOnly:true})"/>
				 至 <input type="input" name="userProductPage.params.endTime" value="${userProductPage.params.endTime}" class="Wdate" id="endTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startTime\')||\'%y-%M-%d\'}',readOnly:true})"/>
				
			</div>
           
          
           	
        </form>
		<!--start 商品管理table-->
		<div class="m-mt10p">
			<table width="100%" id="order-tab">
				<thead class="tab-control">
                    <tr>
                        <th width="12%">品牌</th>
                        <th width="20%">商品名称</th>
                        <th width="12%">图片</th>
                        <th width="8%">商品编码</th>
                        <th width="8%">销售方式</th>
                        <th width="16%">商品状态</th>
                        <th width="10%">库存</th>
                        <th width="14%">订单总数量</th>
                    </tr>
                </thead>
				<tbody>
					<c:if test="${fn:length(userProductPage.result)>0 }">
							<c:forEach items="${userProductPage.result}"  var="product" varStatus="status">
								<tr class="list-tr">
									<td colspan="8" class="td-nobor">
										<table class="tab-control">
											<tr class="tr-height" productId="${product.productId }">
												<td class="num-icon" width="12%"><input id="sellType_${product.productId }" type="hidden" value="${product.sellType }">
													<i></i><label><a>${product.brand.name }</a></label>
												</td>
												<td width="20%">${product.name}</td>
												
												<td width="12%">
													<img src="<yp:thumbImage originalPath='${product.coverPicture}' imageType='t84'></yp:thumbImage>" />
												</td>
												<td width="8%">${product.productId }</td>
												
												
												
												<td width="8%">
												<spring:message code="product.sellType.${product.sellType}"/>
					                    			
												</td>
												<td width="16%">
					                    			<spring:message code="product.status.${product.sellStatus}"/>
												</td>
												<td width="10%">
					                    			${product.inventory}
												</td>
					                  
												<td width="14%">
													<p>
					                     				
					                           			<a class="c-blue view" href="javascript:;">${product.orderTotalNum}</a>
					                       		 		
				                        			</p>
												</td>						
											</tr>
										</table>
									</td>
								</tr>
							</c:forEach>
					</c:if>
					<c:if test="${fn:length(userProductPage.result)==0 }">
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
					<c:if test="${not empty userProductPage.result}">
						<yp:commPage page="${userProductPage}" beanName="userProductPage"></yp:commPage>
					</c:if>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/foot.jsp"></jsp:include>
</body>
<script type="text/javascript">
	var isPost = true;
	var msg = $("#msg").val();
	if(msg!=null && msg !=""){
		$.dialog({
	        title: false,
	        content:"<font color='red'>"+msg+"</font>",
	        time : 8000
	    });
	} 
	//按钮绑定事件
	$(function(){
		//查询
		$("#search").click(function(){
    		var keywords = $(".J-keywords").val();
    		if(keywords == $(".J-keywords").attr("data-default")){
    			$(".J-keywords").val("");
    		}
    		$("#searchForm").submit();
    	});
		//查看
		$(".view").click(function(){
			var productId = $(this).closest("tr").attr("productId");
			window.location.href = _ctxPath +"/admin/order/order-searchProductOrderDetail.htm?orderPage.params.productId="+productId+"&mark=1";
		});
	});
	
	$(document).ready(function() {
		// -- 列表行单击绑定时间 beginning
		$(".tr-height").on("click", function(e) {
			var $this = $(this),
				evt = $(e.target);
			if(!evt.is('a')){
				var productId = $this.attr('productId');
				if (!$(this).next(".show-tr")[0]) {
					if( isPost == false) return;
					isPost = false;
					$.ajax({
						type : 'POST',
						url : '${_ctxPath}/admin/product/product-listProductSkuAndSaleDetail.htm',
						data : {
							"product.productId" : productId,
							"product.sellType" : $("#sellType_"+productId).val(),
							"mark" : 2
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
		//-- end
	});
</script>
</html>