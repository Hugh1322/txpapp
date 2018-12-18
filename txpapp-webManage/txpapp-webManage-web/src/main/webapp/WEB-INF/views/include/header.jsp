<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%--<%@taglib prefix="aut" uri="http://www.springsecurity.org/jsp" %>--%>
<%--<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>--%>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>
<%--<%@ include file="taglibs.jsp"%>--%>
<form id="skip_login_form" action="${_ctxPath}/j_spring_security_check" style="display:none;"  method="post">
    	 <input type="text"  id="skip_j_username" name="j_username" >
		 <input type="text"  id="skip_j_lastAdminName"  name="j_lastAdminName" >
		 <input type="checkbox" id="remberMe" name="_spring_security_remember_me">
</form>
<%
	String path_ = request.getContextPath();
	String basePath_ = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path_+"/";
%>

<div class="header">
	<div class="m-w980p m-clear">
		<div class="topbar-fl m-fl">
				<span><sec:authentication property="name" /></span>，感谢您光临${_webSiteNameManager}！
						<a href="${_ctxPath}/j_spring_security_logout" class="topbar-logout">退出</a>
<%-- 					<aut:authorize url="/admin/user/user-editPassword"> --%>
					 <a class="topbar-psword" href="${_ctxPath}/admin/user/user-editPassword.htm">修改密码    </a>
<%-- 				    </aut:authorize> --%>
						<c:if test="${!empty j_lastAdminName && session.SPRING_SECURITY_CONTEXT.authentication.principal.username != j_lastAdminName}">  
						回到<a class="topbar-psword" onclick="skipSeller('${j_lastAdminName}')" href="javascript:void(0);">${j_lastAdminName } </a>
						</c:if> 
						<aut:authorize url="/login_yichengpinLogin.htm"> 
						 	<a class="topbar-psword" href="javascript:void(0);" onclick="loginFIO('<sec:authentication property="name" />')">一键FIO</a>
						</aut:authorize>
				    	<!-- 存储卖家id -->
				<span style="margin-left: 100px;background-color: #388511;cursor: pointer;">
					消息（14）
				</span>
				<span style="padding-left: 10px;color: inherit">
					|
				</span>
				<span style="padding-left: 10px;background-color: #068581;cursor: pointer;">
					私信（23）
				</span>

				    <input type="hidden" name="userId" id="userId" value="${session.SPRING_SECURITY_CONTEXT.authentication.principal.userId }"/>
		</div>
		<div class="topbar-fr m-fr">商户服务热线：${_telManager}</div>
	</div>
</div>
<div class="nav">
		<div class="m-w980p m-clear">
			<h1><img src="${_imagesPath}/logo.png" /></h1>
			<span style="padding:18px 0px 0px 0px;float: left;font-size: 14px;">V2.0<span style="color:red;">&nbsp;&nbsp;&nbsp;&nbsp;"订单"功能已转至"订单管理"下的"销售单管理"，如有疑问请联系客服与招商部，谢谢！</span></span>

			<%-- 
		    <ul id="headerMenuUl">
				<c:forEach items="${canVisitMenu.childMenuModel }" var="m" varStatus="vs">
					<c:if test="${m.url != '/admin/user/user-editPassword'}">
						<li class="${menuFlag==m.uresourceId?'active':'' }"><a id="vs${vs.index }" href="${_ctxPath}${m.url }.htm?menuFlag=${m.uresourceId }">${m.uresourceName }</a></li>
					</c:if>
				</c:forEach>
			</ul> 
			--%>
			<div class="nav-enter">
				<a href="${toShopping}" target="_blank">进入商城&gt;&gt;</a>
			</div>
		</div>
	</div>
	<div class="leftNav">
		<div class="leftNav_list" id="page">
			<p class="subList" >Demo</p>
			<ul id="pageTabs" >
				<%--<li ><a href="http://localhost:8209/txpapp/system/user/income1.do"  id="suggest" >吐槽/发现1</a></li>--%>
				<li><a href="${_ctxPath}/system/user/findUserByCriteriaAndPage.do" id="help" >用户管理</a></li>
				<li><a href="${_ctxPath}/system/user/rule2.do" id="rule" >权限管理</a></li>
				<li><a href="${_ctxPath}/system/role/findsByPageNew.do"  id="role">角色管理</a></li>
				<li><a href="${_ctxPath}/test/user/market/activityList.do"  id="activityList">营业活动管理</a></li>
				<li><a href="${_ctxPath}/test/user/edit/indexPage.do"  id="indexPage">数据分析</a></li>
			</ul>
		</div>
		<c:forEach items="${rules}" var="rule" varStatus="vs">
			<div class="leftNav_list" id="page_${rule.id}">
				<p class="subList" >${rule.name}</p>
				<ul id="pageTabs_${rule.id}" >
				<c:if test="${not empty rule.children}">
					<c:forEach items="${rule.children}" var="ruleChild">
						<li><a href="${_ctxPath}/${ruleChild.url}" id="ruleItem_${ruleChild.id}" >${ruleChild.name}</a></li>
					</c:forEach>
				</c:if>
				</ul>
			</div>
		</c:forEach>
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

var url = location.href;
$(function(){

//		alert(url);
//		if(url.indexOf('/index.do')>0){
//			if($(".leftNav_list").eq(0).attr("id")=="page"){
//				$("#pageTabs").show();
//				location.href= $("#page li").eq(0).find("a").attr("href");
//			}else if($(".leftNav_list").eq(0).attr("id")=="semPage"){
//				$("#semPageTabs").show();
//				location.href= $("#semPage li").eq(0).find("a").attr("href");
//			}else if($(".leftNav_list").eq(0).attr("id")=="couponPage"){
//				$("#couponPageTabs").show();
//				location.href= $("#couponPage li").eq(0).find("a").attr("href");
//			}else if($(".leftNav_list").eq(0).attr("id")=="marketPage"){
//				$("#marketPageTabs").show();
//				location.href= $("#marketPage li").eq(0).find("a").attr("href");
//			}else{
//				location.href = $(".leftNav_list").eq(0).find("a").attr("href");
//			}
//		}
//
// 	 	if(url.indexOf("/admin/suggest/suggest-searchSuggests") > 0){
// 	 		$("#pageTabs").show();
// 	 		$("#suggest").addClass("cur").siblings().removeClass("cur");
// 	 	}else if(url.indexOf("/admin/help/help-listHelps.htm") > 0){
// 	 		$("#pageTabs").show();
// 	 		$("#help").addClass("cur").siblings().removeClass("cur");
// 	 		return false;
// 	 	}else if(url.indexOf('/admin/seo/seo-listSeoConfigs.htm')>0){
// 	 		$("#pageTabs").show();
// 	 		$("#seo").addClass("cur").siblings().removeClass("cur");
// 	 		return false;
// 	 	}else if(url.indexOf('/admin/link/link-searchLinks.htm')>0){
// 	 		$("#pageTabs").show();
// 	 		$("#link").addClass("cur").siblings().removeClass("cur");
// 	 		return false;
// 	 	}else if(url.indexOf('/admin/adv/show.htm')>0||url.indexOf('adv_goToAdd')>0){
// 	 		$("#pageTabs").show();
// 	 		$("#adv").addClass("cur").siblings().removeClass("cur");
// 	 		return false;
// 	 	}else if(url.indexOf('/admin/notice/notice-searchNotice.htm')>0){
// 	 		$("#pageTabs").show();
// 	 		$("#notice").addClass("cur").siblings().removeClass("cur");
// 	 		return false;
// 	 	}else{
// 	 		$("#pageTabs").hide();
// 	 	}
//
//
// 	 	if(url.indexOf("/admin/sem/sem-listAllAdvertSource") > 0){
// 	 		$("#semPageTabs").show();
// 	 		$("#sem-source").addClass("cur").siblings().removeClass("cur");
// 	 		return false;
// 	 	}else if(url.indexOf("/admin/semsite/site-listSemSite") > 0){
// 	 		$("#semPageTabs").show();
// 	 		$("#listSemSite").addClass("cur").siblings().removeClass("cur");
// 	 		return false;
// 	 	}else if(url.indexOf("/admin/semsite/site-dataReport") > 0){
// 	 		$("#semPageTabs").show();
// 	 		$("#sem-dataReport").addClass("cur").siblings().removeClass("cur");
// 	 		return false;
// 	 	}else if(url.indexOf("/medium/medium-list") > 0){
// 	 		$("#semPageTabs").show();
// 	 		$("#sem-medium").addClass("cur").siblings().removeClass("cur");
// 	 		return false;
// 	 	}else{
// 	 		$("#pageTabs").hide();
// 	 	}
//
// 	 	if(url.indexOf("/admin/online_product/productMgr-allProducts") > 0){
// 	 		$("#onlineProductPageTabs").show();
// 	 		$("#onlineProduct-allProducts").addClass("cur").siblings().removeClass("cur");
// 	 		return false;
// 	 	}else if(url.indexOf("/admin/online_product/productMgr-newRecommendProducts") > 0){
// 	 		$("#onlineProductPageTabs").show();
// 	 		$("#onlineProduct-newRecommendProducts").addClass("cur").siblings().removeClass("cur");
// 	 		return false;
// 	 	}else if(url.indexOf("/admin/online_product/productMgr-historyHotProducts") > 0){
// 	 		$("#onlineProductPageTabs").show();
// 	 		$("#onlineProduct-historyHotProducts").addClass("cur").siblings().removeClass("cur");
// 	 		return false;
// 	 	}else if(url.indexOf("/admin/online_product/productMgr-tasteOfHometownProducts") > 0){
// 	 		$("#onlineProductPageTabs").show();
// 	 		$("#onlineProduct-tasteOfHometownProducts").addClass("cur").siblings().removeClass("cur");
// 	 		return false;
// 	 	}else{
// 	 		$("#pageTabs").hide();
// 	 	}
//
// 	 	if(url.indexOf("/admin/order/orderMgr-goSaleOrders") > 0){
// 	 		$("#orderManagePageTabs").show();
// 	 		$("#orderMgr-goSaleOrders").addClass("cur").siblings().removeClass("cur");
// 	 		return false;
// 	 	}else if(url.indexOf("/admin/order/orderMgr-goRefund") > 0){
// 	 		$("#orderManagePageTabs").show();
// 	 		$("#orderMgr-goRefund").addClass("cur").siblings().removeClass("cur");
// 	 		return false;
// 	 	}else if(url.indexOf("/admin/order/orderMgr-goRefundGood") > 0){
// 	 		$("#orderManagePageTabs").show();
// 	 		$("#orderMgr-goRefundGood").addClass("cur").siblings().removeClass("cur");
// 	 		return false;
// 	 	}else{
// 	 		$("#pageTabs").hide();
// 	 	}
//
// 	 	if(url.indexOf("/channelType/channelType-openChannelType") > 0){
// 	 		$("#couponPageTabs").show();
// 	 		$("#couponChannel").addClass("cur").siblings().removeClass("cur");
// 	 		return false;
// 	 	}else if(url.indexOf("/admin/coupon/activity-list") > 0){
// 	 		$("#couponPageTabs").show();
// 	 		$("#couponActivity").addClass("cur").siblings().removeClass("cur");
// 	 		return false;
// 	 	}else if(url.indexOf("/admin/coupon/coupon-searchCoupons") > 0){
// 	 		$("#couponPageTabs").show();
// 	 		$("#searchCoupons").addClass("cur").siblings().removeClass("cur");
// 	 		return false;
// 	 	}else if(url.indexOf("/admin/coupon/coupon-searchGetCoupons") > 0){
// 	 		$("#couponPageTabs").show();
// 	 		$("#searchGetCoupons").addClass("cur").siblings().removeClass("cur");
// 	 		return false;
// 	 	}else if(url.indexOf("/wayBillChannel/wayBill-gotoCurrent") > 0){
// 	 		$("#couponPageTabs").show();
// 	 		$("#gotoCurrent").addClass("cur").siblings().removeClass("cur");
// 	 		return false;
// 	 	}else if(url.indexOf("/userRegistChannel/userRegist-showList") > 0){
// 	 		$("#couponPageTabs").show();
// 	 		$("#showList").addClass("cur").siblings().removeClass("cur");
// 	 		return false;
// 	 	}else{
// 	 		$("#couponPageTabs").hide();
// 	 	}
//
// 	 	if(url.indexOf("/marketAct/marketact-listActivities") > 0){
// 	 		$("#marketPageTabs").show();
// 	 		$("#marketActivity").addClass("cur").siblings().removeClass("cur");
// 	 		return false;
// 	 	}else if(url.indexOf("/postActivity/postActivity-listPostActivity") > 0){
// 	 		$("#marketPageTabs").show();
// 	 		$("#postageOrder").addClass("cur").siblings().removeClass("cur");
// 	 		return false;
// 	 	}else{
// 	 		$("#marketPageTabs").hide();
// 	 	}
//
// 	 	if(url.indexOf("/admin/propinfo/propinfoList") > 0){
// 	 		$("#propinfoPageTabs").show();
// 	 		$("#listTypeChildren").addClass("cur").siblings().removeClass("cur");
// 	 	}else if(url.indexOf("/admin/propinfo/propinfo-listTypeChildren.htm") > 0){
// 	 		$("#propinfoPageTabs").show();
// 	 		$("#listTypeChildren").addClass("cur").siblings().removeClass("cur");
// 	 		return false;
// 	 	}else if(url.indexOf('/admin/propinfo/propinfo-listAreaChildren.htm')>0||url.indexOf('/admin/propArea/propArea-list.htm')>0){
// 	 		$("#propinfoPageTabs").show();
// 	 		$("#listAreaChildren").addClass("cur").siblings().removeClass("cur");
// 	 		return false;
// 	 	}else{
// 	 		$("#pageTabs").hide();
// 	 	}
//
// 	 	if(url.indexOf("/admin/stat/statDot-searchDotList") > 0){
// 	 		$("#statDateTabs").show();
// 	 		$("#stat_dadain_parse").addClass("cur").siblings().removeClass("cur");
// 	 		return false;
// 	 	}else if(url.indexOf("/admin/stat/schKeywords-index") > 0){
// 	 		$("#statDateTabs").show();
// 	 		$("#stat_search_parse").addClass("cur").siblings().removeClass("cur");
// 	 		return false;
// 	 	}else if(url.indexOf("/admin/stat/statProduct-searchList") > 0){
// 	 		$("#statDateTabs").show();
// 	 		$("#stat_product_parse").addClass("cur").siblings().removeClass("cur");
// 	 		return false;
// 	 	}else if(url.indexOf("/admin/stat/statTrench-searchList.htm") > 0){
// 	 		$("#statDateTabs").show();
// 	 		$("#stat_trench_parse").addClass("cur").siblings().removeClass("cur");
// 	 		return false;
// 	 	}else{
// 	 		$("#statDateTabs").hide();
// 	 	}
// 	 	if(url.indexOf("/admin/propinfo/propinfoList") > 0){
// 	 		$("#propinfoPageTabs").show();
// 	 		$("#listTypeChildren").addClass("cur").siblings().removeClass("cur");
// 	 	}else if(url.indexOf("/admin/propinfo/propinfo-listTypeChildren.htm") > 0){
// 	 		$("#propinfoPageTabs").show();
// 	 		$("#listTypeChildren").addClass("cur").siblings().removeClass("cur");
// 	 		return false;
// 	 	}else if(url.indexOf('/admin/propinfo/propinfo-listAreaChildren.htm')>0||url.indexOf('/admin/propArea/propArea-list.htm')>0){
// 	 		$("#propinfoPageTabs").show();
// 	 		$("#listAreaChildren").addClass("cur").siblings().removeClass("cur");
// 	 		return false;
// 	 	}else{
// 	 		$("#pageTabs").hide();
// 	 	}
//
// 	 	if(url.indexOf("/admin/order/logistics-listShipper") > 0){
// 	 		$("#logisticsPageTabs").show();
// 	 		$("#logistics-shipper").addClass("cur").siblings().removeClass("cur");
// 	 	}else if(url.indexOf("/admin/order/logistics-listSend.htm") > 0){
// 	 		$("#logisticsPageTabs").show();
// 	 		$("#logistics-send").addClass("cur").siblings().removeClass("cur");
// 	 		return false;
// 	 	}else if(url.indexOf('/admin/order/logistics-listEfficiency.htm')>0){
// 	 		$("#logisticsPageTabs").show();
// 	 		$("#logistics-efficiency").addClass("cur").siblings().removeClass("cur");
// 	 		return false;
// 	 	}else{
// 	 		$("#pageTabs").hide();
// 	 	}

//		if(url.indexOf("/system/user/rule2.do") > 0){
//			$("#pageTabs").show();
//			$("#rule").addClass("cur").siblings().removeClass("cur");
//		}else if(url.indexOf("/system/role/findsByPageNew.do") > 0){
//			$("#pageTabs").show();
//			$("#role").addClass("cur").siblings().removeClass("cur");
//			return false;
//		}else if(url.indexOf('/admin/order/logistics-listEfficiency.htm')>0){
//			$("#logisticsPageTabs").show();
//			$("#logistics-efficiency").addClass("cur").siblings().removeClass("cur");
//			return false;
//		}else{
//			$("#pageTabs").hide();
//		}

 });

//以下代码用于 菜单回显
var url_ = location.href;
var bpath_ = '<%=basePath_%>';
var u_ = url_.replace(bpath_,'');
var path_;
if(u_.indexOf('?')>=0) {
	path_ = u_.substring(0,u_.indexOf('?'))
}else {
	path_ = u_;
}
//alert(path_);
$('a').each(function(){
	var href = $(this).attr('href');
	if(href.indexOf(path_) >= 0){
		var itemId_ = $(this).attr("id");
		$(this).parent('li').parent('ul').show();
		$("#"+itemId_).addClass("cur").siblings().removeClass("cur");
		$(this).parent('li').parent('ul').parent('div').find('p').addClass("on");;
		return false;
	}else{
		$(this).parent('li').parent('ul').hide();
	}
});
</script>

