<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%--<%@taglib prefix="aut" uri="http://www.springsecurity.org/jsp" %>--%>
<%--<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>--%>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>
<script type="text/javascript" src="${_jsPath }/plugin/artdialog/jquery.artDialog.min.js"></script>
<script type="text/javascript">
    var _ctxPath = '${_ctxPath}',
    		_filePath = '${_filePath}',
    		_fileThumbPath = '${_fileThumbPath }',
    		_jsPath = '${_jsPath }';
</script>
<link href="${_jsPath }/plugin/artdialog/skins/ytoxl.css" rel="stylesheet" />
<form id="skip_login_form" action="${_ctxPath}/j_spring_security_check" style="display:none;"  method="post">
    	 <input type="text"  id="skip_j_username" name="j_username" >
		 <input type="text"  id="skip_j_lastAdminName"  name="j_lastAdminName" >
		 <input type="checkbox" id="remberMe" name="_spring_security_remember_me">
</form>

<!--header-->
		<div id="header">
			<div class="headerIn">
				<h1 class="logo">${_webSiteNameManager}后台管理</h1>
				<div class="fl"><a href="${previewBaseUrl }" class="back">返回商城</a></div>
				<div class="fl">
					<c:if test="${!empty j_lastAdminName && session.SPRING_SECURITY_CONTEXT.authentication.principal.username != j_lastAdminName}">  
						回到<a class="topbar-psword back" onclick="skipSeller('${j_lastAdminName}')" href="javascript:void(0);">${j_lastAdminName } </a>
					</c:if> 
					<aut:authorize url="/login_yichengpinLogin.htm"> 
						 <a class="topbar-psword back" href="javascript:void(0);" onclick="loginFIO('<sec:authentication property="name" />')">一键FIO</a>
					</aut:authorize>
				</div>
				
				<div class="headInfo">
					<div class="fr">
						<dl class="hover">
							<dt><i></i><sec:authentication property="name" /><em></em></dt>
							<dd>
								<div class="userInfo">
									<i></i>
									<a href="${_ctxPath}/j_spring_security_logout">退出</a>
								</div>
							</dd>
						</dl>
						<span class="hotline">商户服务热线：${_telManager}</span>
					</div>
				</div>
			</div>
		</div>
		
		<!--con-->
		<div class="con w">
			<!--slideNav-->
			<span class="arrow slideArrow"></span>
			<div class="slideNav">
				<div class="navFrame">
				<c:forEach items="${canVisitMenu.childMenuModel }" var="m" varStatus="vs">
					<c:if test="${m.url != '/admin/user/user-editPassword'&&m.url != '/order/order-myOrders'&&m.url != '/order/order-myOrders'&&
								m.url != '/address/address-getUserAddress'&&m.url != '/order/order-myRefundManage'&&m.url != '/user/user-updatePassword'&&m.url != '/user/points'&&
								m.url != '/suggest/searchSuggest-1'&&m.url != '/suggest/searchSuggest-0'&&m.url != '/user/user-userInfo'&&m.url != '/order/order-getOrderInfo'&&
								m.url != '/order/order-submitOrder'&&m.url != '/netpay/payit'&&m.url != '/netpay/confirmOrder'&&m.url != '/order/order-panicBuying'
								&&m.url != '/order/order-showCart'&&m.url!='/order/order-myOrderCancelRecord'
								&&m.url!='/order/order-myOrderCancelManage'}">
					<c:choose>
						<c:when test="${m.url == '/admin/suggest/suggest-searchSuggests'}">
							<dl>
		                        <dt>${m.uresourceName }</dt>
		                        <dd>
					       				<aut:authorize url="/admin/suggest/suggest-searchSuggests-sub">
											<a href="${_ctxPath}/admin/suggest/suggest-searchSuggests-sub.htm?suggestPage.params.type=1"  id="suggest" >吐槽/发现</a>
										</aut:authorize>
										<aut:authorize url="/admin/help/help-listHelps">
							            	<a href="${_ctxPath}/admin/help/help-listHelps.htm" id="help" >底部信息</a>
							           	</aut:authorize>
							            <aut:authorize url="/admin/seo/seo-listSeoConfigs">
											<a href="${_ctxPath}/admin/seo/seo-listSeoConfigs.htm"  id="seo">SEO信息</a>
										</aut:authorize>
										<aut:authorize url="/admin/link/link-searchLinks">
											<a href="${_ctxPath}/admin/link/link-searchLinks.htm" id="link">友情链接</a>
										</aut:authorize>
										<aut:authorize url="/admin/notice/notice-searchNotice">
										 	<a href="${_ctxPath}/admin/notice/notice-searchNotice.htm" id="notice">最新动态</a>
										</aut:authorize>
										<aut:authorize url="/admin/adv/show">
										 	<a href="${_ctxPath}/admin/adv/show.htm" id="adv">广告位</a>
										 </aut:authorize>
										<aut:authorize url="/admin/sitemap/sitemap-sitemapManage">
										 	<a href="${_ctxPath}/admin/sitemap/sitemap-sitemapManage.htm" id="siteMapMg">siteMap管理</a>
										</aut:authorize>
		                    	</dd>
		                    </dl>
		       			</c:when>
		       			<c:when test="${m.url == '/admin/sem/manage'}">
		       				<dl>
		                        <dt>${m.uresourceName }</dt>
		                        <dd>
										<aut:authorize url="/admin/sem/sem-listAllAdvertSource">
											<a href="${_ctxPath}/admin/sem/sem-listAllAdvertSource.htm" id="sem-source">广告系列来源</a>
										</aut:authorize>
										<aut:authorize url="/admin/semsite/site-listSemSite">
							            	<a href="${_ctxPath}/admin/semsite/site-listSemSite.htm"  id="listSemSite">SEM网站构建管理</a>
							           	</aut:authorize>
							            <aut:authorize url="/admin/semsite/site-dataReport">
											<a href="${_ctxPath}/admin/semsite/site-dataReport.htm" id="sem-dataReport">SEM数据报表</a>
										</aut:authorize>
										<aut:authorize url="/medium/medium-list">
											<a href="${_ctxPath}/medium/medium-list.htm" id="sem-medium">广告系列媒介管理</a>
										</aut:authorize>
		                    	</dd>
		                    </dl>
		       			</c:when>
		       			<c:when test="${m.url == '/admin/propinfo/propinfoList'}">
		       					<dl>
			                        <dt>${m.uresourceName }</dt>
			                        <dd>
						       				<aut:authorize url="/admin/propinfo/propinfo-listTypeChildren">
												<a href="${_ctxPath}/admin/propinfo/propinfo-listTypeChildren.htm" id="listTypeChildren">商品类目</a>
											</aut:authorize>
											<aut:authorize url="/admin/propinfo/propinfo-listAreaChildren">
								            	<a href="${_ctxPath}/admin/propinfo/propinfo-listAreaChildren.htm"  id="listAreaChildren">地区维护</a>
								           	</aut:authorize>
			                    	</dd>
		                   		 </dl>
		       			</c:when>
		       			<c:when test="${m.url == '/admin/coupon/manage'}">
		       				<dl>
		                        <dt>${m.uresourceName }</dt>
		                        <dd>
					       				<aut:authorize url="/admin/coupon/coupon-searchCoupons">
											<a href="${_ctxPath}/admin/coupon/coupon-searchCoupons.htm" id=searchCoupons>优惠券明细</a>
										</aut:authorize>
										<aut:authorize url="/channelType/channelType-openChannelType">
							            	<a href="${_ctxPath}/channelType/channelType-openChannelType.htm"  id="couponChannel">渠道配置</a>
							           	</aut:authorize>
										<aut:authorize url="/admin/coupon/activity-list">
											<a href="${_ctxPath}/admin/coupon/activity-list.htm" id="couponActivity">优惠活动管理</a>
										</aut:authorize>
										<aut:authorize url="/admin/coupon/coupon-searchGetCoupons">
											<a href="${_ctxPath}/admin/coupon/coupon-searchGetCoupons.htm" id="searchGetCoupons">优惠券代领</a>
										</aut:authorize>
										<aut:authorize url="/wayBillChannel/wayBill-gotoCurrent">
							            	<a href="${_ctxPath}/wayBillChannel/wayBill-gotoCurrent.htm"  id="gotoCurrent">运单优惠劵管理</a>
							           	</aut:authorize>	
		                    	</dd>
		                    </dl>
		       			</c:when>
		       			<c:when test="${m.url == '/admin/marketActivity/manage'}">
		       				<dl>
		                        <dt>${m.uresourceName }</dt>
		                        <dd>
		                        	<aut:authorize url="/marketAct/marketactivity-listActivities">
							            	<a href="${_ctxPath}/marketactivity/marketact-listActivities.htm"  id="marketActivity">营销活动管理</a>
							        </aut:authorize>
									<aut:authorize url="/postActivity/postActivity-listPostActivity">
											<a href="${_ctxPath}/postActivity/postActivity-listPostActivity.htm" id="postageOrder">包邮订单</a>
									</aut:authorize>
									<aut:authorize url="/marketAct/marketact-listRules">
											<a href="${_ctxPath}/marketRule/marketact-listRules.htm" id="postageOrder">活动规则管理</a>
									</aut:authorize>
		                    	</dd>
		                    </dl>
		       			</c:when>
		       			<c:when test="${m.url == '/admin/online_product/productMgr'}">
		       				<dl>
		                        <dt>${m.uresourceName }</dt>
		                        <dd>
		                            <aut:authorize url="/admin/online_product/productMgr-allProducts">
											<a href="${_ctxPath}/admin/online_product/productMgr-allProducts.htm" id="onlineProduct-allProducts">所有在线商品</a>
									</aut:authorize>
									<aut:authorize url="/admin/online_product/productMgr-newRecommendProducts">
											<a href="${_ctxPath}/admin/online_product/productMgr-newRecommendProducts.htm" id="onlineProduct-newRecommendProducts">最新推荐商品</a>
									</aut:authorize>
									<aut:authorize url="/admin/online_product/productMgr-historyHotProducts">
											<a href="${_ctxPath}/admin/online_product/productMgr-historyHotProducts.htm" id="onlineProduct-historyHotProducts">人气热卖商品</a>
									</aut:authorize>
									<aut:authorize url="/admin/online_product/productMgr-tasteOfHometownProducts">
											<a href="${_ctxPath}/admin/online_product/productMgr-tasteOfHometownProducts.htm" id="onlineProduct-tasteOfHometownProducts">家乡味道商品</a>
									</aut:authorize>
		                        </dd>
		                    </dl>
		       			</c:when>
		       			<c:when test="${m.url == '/admin/order/orderMgr-orderManager'}">
		       				<dl>
		                        <dt>${m.uresourceName }</dt>
		                        <dd>
		                            <aut:authorize url="/admin/order/orderMgr-goSaleOrders">
											<a href="${_ctxPath}/admin/order/orderMgr-goSaleOrders.htm" id="orderMgr-goSaleOrders">销售单管理</a>
									</aut:authorize>
									<aut:authorize url="/admin/order/orderMgr-goRefund">
											<a href="${_ctxPath}/admin/order/orderMgr-goRefund.htm" id="orderMgr-goRefund">退款单管理</a>
									</aut:authorize>
									<aut:authorize url="/admin/order/orderMgr-goRefundGood">
											<a href="${_ctxPath}/admin/order/orderMgr-goRefundGood.htm" id="orderMgr-goRefundGood">退货单管理</a>
									</aut:authorize>
		                        </dd>
		                    </dl>
		       			</c:when>
		       			<c:when test="${m.url == '/admin/order/logistics-listShipper'}">
		       				<dl>
		                        <dt>${m.uresourceName }</dt>
		                        <dd>
		                            <aut:authorize url="/admin/order/logistics-listShipper">
											<a href="${_ctxPath}/admin/order/logistics-listShipper.htm" id="logistics-shipper">揽收管理</a>
									</aut:authorize>
									<aut:authorize url="/admin/order/logistics-listSend">
											<a href="${_ctxPath}/admin/order/logistics-listSend.htm" id="logistics-send">派送管理</a>
									</aut:authorize>
									<aut:authorize url="/admin/order/logistics-listEfficiency">
											<a href="${_ctxPath}/admin/order/logistics-listEfficiency.htm" id="logistics-efficiency">时效管理</a>
									</aut:authorize>
		                        </dd>
		                    </dl>
		       			</c:when>
		       			<c:otherwise>
		       					<dl>
			                        <dt><a id="vs${vs.index }" class="${menuFlag==m.uresourceId?'cur':'' }" href="${_ctxPath}${m.url }.htm?menuFlag=${m.uresourceId }">${m.uresourceName }</a></dt>
			                        <dd></dd>
			                    </dl>
		       			</c:otherwise>
					</c:choose>			
				</c:if>
			</c:forEach>
								<dl>
			                        <dt></dt>
			                        <dd></dd>
			                    </dl>
                </div>
			</div>
<script type="text/javascript">
function skipSeller(adminName){
	if(confirm("你确定要回到该账户吗?")){
		$("#skip_j_username").val(adminName);
		$("#skip_j_lastAdminName").val(adminName);
		$("#skip_login_form").submit();
	}
};

function loginFIO(sellerName) {
	var targetUrl = encodeURI("${_cangpei_login}?userName=" + sellerName);
	window.open(targetUrl);
}

</script>