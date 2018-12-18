<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%--<script type="text/javascript" src="${_jsPath}/plugin/uploadify/swfobject.js"></script>--%>
<%--<script type="text/javascript" src="${_jsPath}/plugin/uploadify/jquery.uploadify.v2.1.4.min.js"></script>--%>
<link rel="stylesheet" type="text/css" href="${_cssPath }/pages/addBrand.css">
<!-- 上传文件-->
<link rel="stylesheet" type="text/css" href="${_cssPath }/customUpload.css">
<script type="text/javascript" src="${_jsPath }/customUpload.js"></script>


<div class="m-mt10p addBanner" style="width: 1200px;height: 1000px;">
	<form  method="post"
		id="advForm232">
		<input type="hidden" id="pId" name="pId" value="${pId}" />
	</form>
	 <jsp:include page="toUploadContent.jsp"></jsp:include>



</div>