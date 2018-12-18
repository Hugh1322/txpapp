<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/taglibs.jsp"%>
<%@page import="com.txp.app.contants.UserInfo" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>首页</title>
<link href="${ _cssPath}/common.css" rel="stylesheet" />
<link href="${ _cssPath}/pages/orderManagement.css" rel="stylesheet" />
<script src="${_jsPath }/jquery/jquery.1.8.1.js" language="javascript"></script>
<script type="text/javascript"	src="${_jsPath }/plugin/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript"	src="${_jsPath }/plugin/formvalidator/formValidatorRegex.js"></script>
	<script type="text/javascript"	src="${_jsPath }/plugin/formvalidator/formValidator-4.1.3.js"></script>
	<script type="text/javascript"	src="${_jsPath }/plugin/artdialog/jquery.artDialog.min.js"></script>
<style type="text/css">
.main {
	width: 100%;
	color: #333;
	line-height: 28px;
	font-size: 12px
}
.main:before, .main:after {
	content: "";
	display: table;
}
.pan1, .pan1:hover {
	padding: 6px 20px;
	cursor: default;
	font-weight: bold
}
.main:after {
	clear: both;
	overflow: hidden;
}
.cl1 {
	clear: both;
	font-size: 0;
	height: 8px;
	overflow: hidden;
}
.col5 {
	width: 20%;
	float: left;
	cursor:pointer;
}
.col4 {
	width: 25%;
	float: left
}
.col3 {
	width: 60%;
	float: left
}
.col2 {
	width: 40%;
	float: left
}
.col1 {
	width: 100%;
	float: left
}
.height1 {
	height: 32px;
	line-height: 32px
}
.height2 {
	height: 146px;
	overflow: hidden
}
.height4 {
	height: 90px;
	overflow: hidden
}
.height3 {
	height: 30px;
	overflow: hidden
}
.bgc1 {
	background: #000;
	color: #FFF
}
.bgcl1 {
	background: #C30
}
.pbox {
	margin: 0 8px 0 0;
	padding: 0 10px;
	display: block;
}
.pbox1 {
	margin: 0;
	padding: 0 10px;
	display: block;
}
.pbox3 {
	margin: 0 8px 0 0;
	display: block;
}
.pbox4 {
	margin: 0 2px 0 0;
	display: block;
}
.bor1 {
	border: 2px #000000 solid
}
.pbox span {
	color: #F33
}
dl {
	border: 1px #333333 solid;
	height: 320px;
	overflow: hidden;
	display: inline-block;
	float: left;
	width: 100%
}
dt {
	border-bottom: 1px #333333 solid;
	overflow: hidden;
	display: block;
	height: 28px;
	line-height: 28px;
	background: #000;
	color: #FFF;
	text-align: center
}
dd {
	padding-left: 12px;
}
</style>
	
	<c:set var="USER_TYPE_SELLER" value="<%=UserInfo.USER_TYPE_SELLER %>"></c:set>
	<c:set var="USER_TYPE_MANAGER" value="<%=UserInfo.USER_TYPE_MANAGER %>"></c:set>
</head>
    
<body>
	<jsp:include page="../include/header.jsp" flush="true" />
	<div class="body m-w980p">
	  <!--商户首页包含内容开始-->
  <div class="main" style="padding-top:12px"><span class="m-btn pan1">待办事项</span>
    <div class="cl1"></div>
    		<div class="col5">
      			<p class="pbox height1 bgc1">待处理问题件数量<span>(${orderBacklog.serverErrorWaiting })</span></p>
      			<input type="hidden" value="admin/order/orderMonitoring-searchOrders.htm?orderPage.params.status=3&orderPage.params.logisticStatus=logisticFailed" />
    		</div>
    		<div class="col5">
      			<p class="pbox height1 bgc1">待发货订单数量<span>(${orderBacklog.serverOrderShipment })</span></p>
      			<input type="hidden" value="admin/order/orderMgr-searchSaleOrders.htm?resultPage.params.status=2&resultPage.currentPage=0" />
    		</div>


    		<div class="col5">
      			<p class="pbox height1 bgc1">未通过审核商品<span>(${orderBacklog.sellerNoPassProduct })</span></p>
      			<input type="hidden" value="seller/product/product-searchSellerProducts.htm?productPage.params.reviewStatus=4" />
    		</div>
    		<div class="col5">
      			<p class="pbox height1 bgc1">商品状态查询<span>(${orderBacklog.sellerProductSearch })</span></p>
      			<input type="hidden" value="seller/product/product-searchSellerProducts.htm?productPage.params.reviewStatus=10" />
    		</div>
    		<div class="col5">
      			<p class="pbox height1 bgc1">待确认订单数量<span>(${orderBacklog.sellerOrderWaiting })</span></p>
      			<input type="hidden" value="admin/order/orderMgr-searchSaleOrders.htm" />
    		</div>
    		<div class="col5">
      			<p class="pbox height1 bgc1">待发货订单数量<span>(${orderBacklog.sellerOrderShipment })</span></p>
      			<input type="hidden" value="admin/order/orderMgr-searchSaleOrders.htm?resultPage.params.status=2&resultPage.currentPage=0" />
    		</div>


    		<div class="col5" >
    			<p class="pbox height1 bgc1">商品状态查询<span>(${orderBacklog.managerProductSearch })</span></p>
    			<input type="hidden" value="admin/product/product-searchProducts.htm" />
    		</div>
    		<div class="col5">
      			<p class="pbox height1 bgc1">待发货订单数量<span>(${orderBacklog.managerOrderShipment })</span></p>
      			<input type="hidden" value="admin/order/order-searchOrders4Manager.htm?orderPage.params.status=2" />
    		</div>
    		<div class="col5">
      			<p class="pbox height1 bgc1">待处理问题件数量<span>(${orderBacklog.managerErrorWaiting })</span></p>
      			<input type="hidden" value="admin/order/orderMonitoring-searchOrders.htm?orderPage.params.status=3&orderPage.params.logisticStatus=logisticFailed" />
    		</div>
    		<div class="col5">
      			<p class="pbox height1 bgc1">待审核活动报名数量<span>(${orderBacklog.managerActivityPending })</span></p>
      			<input type="hidden" value="admin/active/active-manager.htm" />
    		</div>
    <div class="cl1 height3"></div>
  </div>
 
  <div class="main">
    <div class="col3"> <span class="m-btn pan1">库存预警</span>
      <div class="bor1 pbox">
        <ul>
        <c:if test="${fn:length(warnProductSkuList)==0 }"> 
		  <li>您的库存情况良好。</li>
		  <li>&nbsp;</li>
          <li>&nbsp;</li>		
		</c:if>
		<c:if test="${fn:length(warnProductSkuList)>0 }">
			<c:forEach items="${warnProductSkuList}"  var="productSku" varStatus="status">
          		<li><a href="javascript:;" onclick="showOrders('${productSku.productSkuId}','${productSku.warnStartTime}','${productSku.warnEndTime}');" >
          			${productSku.product.name} SKU编码：${productSku.productSkuId } 请注意您的库存情况，请查看详情。</a>
          		</li>
           </c:forEach>
		</c:if>
		<c:if test="${fn:length(warnProductSkuList)==1 }">
			 <li>&nbsp;</li>
			 <li>&nbsp;</li>
		</c:if>
		<c:if test="${fn:length(warnProductSkuList)==2 }">
			 <li>&nbsp;</li> 
		</c:if>  
        </ul>
      </div>
    </div>
    <div class="col2"> <span class="m-btn pan1">商户收入</span>
      <div class="bor1 pbox1">
        <ul>
          <li>累计销售收入: ${userInfo.totalPrice} 元</li>
          <li>累计运费收入: ${userInfo.totalPostagePrice} 元</li>
          <li>累计激励收入: ${userInfo.totalSellInspire} 元</li>
        </ul>
      </div>
      
    </div>
    <div class="cl1 height3"></div>
    <div class="col1"> <span class="m-btn pan1">活动报名</span>
      <div class="bor1 pbox1">
        <ul>
        <c:if test="${fn:length(activeInfoList)==0 }"> 
		  <li>暂无活动，敬请期待。</li>
		  <li>&nbsp;</li>	
		</c:if>
        <c:if test="${fn:length(activeInfoList)>0 }">
          <c:forEach items="${activeInfoList}"  var="activeInfo" varStatus="status">
          <li><a href="javascript:;" onclick="applyActive('${activeInfo.activeId}');">${activeInfo.activeName}   
          	报名截止时间：<fmt:formatDate value='${activeInfo.applyDate}' pattern='yyyy-MM-dd HH:mm' /> 、
          	活动时间：<fmt:formatDate value='${activeInfo.beginDate}' pattern='yyyy-MM-dd HH:mm' /> --
          	<fmt:formatDate value='${activeInfo.endDate}' pattern='yyyy-MM-dd HH:mm' /> ,点击报名。
          	</a></li>
         </c:forEach>
		</c:if>
        </ul>
      </div> 
      <div class="cl1 height3"></div>
    </div>




    <div class="main"><span class="m-btn pan1">最新排行榜</span>
      <div class="cl1"></div>
      <div class="col4">
        <div class="pbox3">
          <dl>
            <dt>昨天销量排行</dt>            
            	<dd>11、测试</dd>
            	<dd>12、测试</dd>
            	<dd>13、测试</dd>
            	<dd>14、测试</dd>
            <c:if test="${empty salesRankMap.SALES_RANK_WEED_RISE_FAST}">
            	<%--<dd>暂无上榜商户</dd>--%>
            </c:if>
          </dl>
        </div>
      </div>
      <div class="col4">
        <div class="pbox3">
          <dl>
            <dt>上周销量排行</dt>
            <c:forEach items="${salesRankMap.SALES_RANK_LASTWEED}" var="rank" varStatus="status">
            	<dd>${status.index + 1}、${rank.companyName}</dd>            
            </c:forEach>
            <c:if test="${empty salesRankMap.SALES_RANK_WEED_RISE_FAST}">
            	<dd>暂无上榜商户</dd>
            </c:if>
          </dl>
        </div>
      </div>
      <div class="col4">
        <div class="pbox3">
          <dl>
            <dt>一周增长最快</dt>
           	<c:forEach items="${salesRankMap.SALES_RANK_WEED_RISE_FAST}" var="rank" varStatus="status">
            	<dd>${status.index + 1}、${rank.companyName}</dd>            
            </c:forEach>
            <c:if test="${empty salesRankMap.SALES_RANK_WEED_RISE_FAST}">
            	<dd>暂无上榜商户</dd>
            </c:if>
          </dl>
        </div>
      </div>
      <div class="col4">
        <div class="pbox4">
          <dl>
            <dt>一个月增长最快</dt>
            <c:forEach items="${salesRankMap.SALES_RANK_MONTH_RISE_FAST}" var="rank" varStatus="status">
            	<dd>${status.index + 1}、${rank.companyName}</dd>            
            </c:forEach>
            <c:if test="${empty salesRankMap.SALES_RANK_WEED_RISE_FAST}">
            	<dd>暂无上榜商户</dd>
            </c:if>
          </dl>
        </div>
      </div>
      <div class="cl1 height3"></div>
    </div>
  </div>
  <!--商户首页包含内容结束--> 
</div>
	
	<jsp:include page="/WEB-INF/views/include/foot.jsp"></jsp:include>
</body>
<script type="text/javascript">
	function showOrders(skuId,startTime,endTime){
		window.location.href = "${_ctxPath}/indexPage/index-showSkuOrders.htm?orderPage.params.productSkuId="+skuId+"&orderPage.params.startTime="+startTime+"&orderPage.params.stopTime="+endTime;
	}
	function applyActive(activeId){
		window.location.href = "${_ctxPath}/seller/activities/activities-showActivitiesDetailsPage.htm?activityListPage4Sellers.params.type=2&activeId="+activeId;
	}
	
	$(function(){
		// 待办事项添加点击事件
		$("div[class='col5']").each(function(){
			$(this).click(function(){
				// 获取链接需要跳转的URL
				var url = $(this).find("input[type='hidden']").val();
				window.location.href = "${_ctxPath}/" + url;
			});
		});
	});
</script>
</html>