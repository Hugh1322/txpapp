<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../../include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript" src="${_jsPath}/plugin/uploadify/swfobject.js"></script>
<script type="text/javascript" src="${_jsPath}/plugin/uploadify/jquery.uploadify.v2.1.4.min.js"></script>
  <script src="${_jsPath}/pages/specAdv.js" language="javascript"></script>

	<div class="m-mt10p addBanner" style="width: 700px;height:350px;">
		<form action="${_ctxPath}/admin/adv/categoryAdv_saveDetail.htm" method="post"
			id="advForm">
		 <jsp:include page="detailContent.jsp"></jsp:include>
		</form>

	</div>
	 
	 
 