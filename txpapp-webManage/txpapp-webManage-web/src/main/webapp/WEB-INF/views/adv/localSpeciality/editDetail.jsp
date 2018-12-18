<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="com.txp.app.contants.AdvPosition"%>
<%@include file="../../include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>广告位</title>
<link href="${_cssPath }/common.css" rel="stylesheet" />
<link href="${_cssPath }/pages/arrangement.css" rel="stylesheet" />
<link href="${_cssPath }/pages/bannerManage.css" rel="stylesheet" />
<link href="${_jsPath }/plugin/artdialog/skins/ytoxl.css"	rel="stylesheet" />
<script src="${_jsPath }/jquery/jquery.1.8.1.js" language="javascript"></script>
<script src="${_jsPath }/plugin/artdialog/jquery.artDialog.min.js"></script>
<script type="text/javascript"	src="${_jsPath}/plugin/uploadify/swfobject.js"></script>
<script type="text/javascript"	src="${_jsPath}/plugin/uploadify/jquery.uploadify.v2.1.4.min.js"></script>
<script src="${_jsPath}/plugin/formvalidator/formValidator-4.1.3.js"	language="javascript"></script>
<script src="${_jsPath}/plugin/formvalidator/formValidatorRegex.js"	language="javascript"></script>
<script src="${_jsPath}/pages/specAdv.js" language="javascript"></script>
<!--[if IE]>
<script src="${_jsPath}/pages/ieplaceholder.js"></script>
<![endif]-->
</head>

<body>
	<!--start header-->
	<jsp:include page="../../include/header.jsp"></jsp:include>
	<div class="body m-w980p">
		<form action="${_ctxPath}/admin/adv/locSpec_saveDetail.htm"
			method="post" id="advForm">
			<div class="m-mt10p addBanner">
				<jsp:include page="detailContent.jsp" />
				<div class="addADV cf">
					<label>&nbsp;</label>
					<div class="infoADV">
						<input type="button" id="submitForm" onclick="addAdv('advForm')"
							value="保存" class="m-btn" /> <input type="button" id="cancelForm"
							value="取消" onclick="window.history.go(-1)" class="m-btn" />
					</div>
				</div>
			</div>
		</form>

	</div>
	<!--end foot-->
	<jsp:include page="/WEB-INF/views/include/foot.jsp"></jsp:include>

</body>
</html>