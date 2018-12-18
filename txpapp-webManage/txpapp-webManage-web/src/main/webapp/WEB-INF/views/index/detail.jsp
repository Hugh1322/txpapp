<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript" src="${_jsPath}/plugin/uploadify/swfobject.js"></script>
<script type="text/javascript" src="${_jsPath}/plugin/uploadify/jquery.uploadify.v2.1.4.min.js"></script>

<div class="m-mt10p addBanner">
	<form action="${_ctxPath}/test/user/save/locSpecList.do" method="post"
		id="advForm">
		<input type="hidden" id="ruleId" name="ruleId" value="${rule.id}" />
	 <jsp:include page="detailContent.jsp"></jsp:include>

	</form>

</div>