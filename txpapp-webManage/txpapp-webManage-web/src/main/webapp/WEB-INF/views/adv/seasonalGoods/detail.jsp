<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../../include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript" src="${_jsPath}/plugin/uploadify/swfobject.js"></script>
<script type="text/javascript" src="${_jsPath}/plugin/uploadify/jquery.uploadify.v2.1.4.min.js"></script>
<%
	pageContext.setAttribute("ADRESS_PRODUCT",com.txp.app.contants.AdvPosition.ADRESS_PRODUCT);
	pageContext.setAttribute("PRODUCT_CATEGORY",com.txp.app.contants.AdvPosition.PRODUCT_CATEGORY);
	pageContext.setAttribute("SHUFFLING_FIGURE",com.txp.app.contants.AdvPosition.SHUFFLING_FIGURE);
	pageContext.setAttribute("CITY_SELECT",com.txp.app.contants.AdvPosition.CITY_SELECT);
	pageContext.setAttribute("HOT_PRODUCT",com.txp.app.contants.AdvPosition.HOT_PRODUCT);
	pageContext.setAttribute("EVERYDAY_RECOMMEND",com.txp.app.contants.AdvPosition.EVERYDAY_RECOMMEND);
	pageContext.setAttribute("HOME_RIGHT_ADV_185",com.txp.app.contants.AdvPosition.HOME_RIGHT_ADV_185);
	pageContext.setAttribute("HOME_RIGHT_ADV_180",com.txp.app.contants.AdvPosition.HOME_RIGHT_ADV_180);
%>
 
	<div class="m-mt10p addBanner">
		<form action="${_ctxPath}/admin/adv/seasonal_saveDetail.htm" method="post"
			id="advForm">
		 <jsp:include page="detailContent.jsp"></jsp:include>
		</form>

	</div>
	 
	 
 