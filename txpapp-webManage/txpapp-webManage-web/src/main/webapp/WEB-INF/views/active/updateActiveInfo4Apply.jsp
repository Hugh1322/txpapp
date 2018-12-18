<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>活动结束时间修改</title>
	<link href="${_cssPath}/common.css" rel="stylesheet" />
	<link href="${_cssPath}/pages/addBrand.css" rel="stylesheet" />
	<link href="${_jsPath }/plugin/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" />
</head>
<body >
<jsp:include page="../include/header.jsp"  flush="true" />
	<div class="body m-w980p">
			<h1 class="add-title">活动结束时间修改</h1>
			<form action="${_ctxPath}/admin/active/active-updateActiveInfoApply.htm" method="post" id="form1">
			<input type="hidden" name="activeInfo.activeId" value="${activeInfo.activeId}" />
			<input type="hidden" name="activeInfo.activeStatus"  value="${activeInfo.activeStatus}" />
					<table border="0" class="add-table">
						<tr>
							<td align="right"><span class="c-red">*</span>报名截止日期：</td>
							<td><input type="text" name="activeInfo.applyDate" value="<fmt:formatDate value='${activeInfo.applyDate}' pattern='yyyy-MM-dd HH:mm:ss'/>" class="Wdate" id="applyTime"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true})" /></td>
							<td colspan="3"><span id="applyTimeTip"></span></td>
						</tr>
						
					</table>
					<table border="0" class="add-table" style="width:250px">
					<tr>
							<td align="center" >
								<input type="button" class="m-btn" value="保存信息" id="submitForm"/>
								<input type="button" class="m-btn" value="返回" id="backList"/>
							</td>
						</tr>
					</table>
			</form>
	</div>
	<script type="text/javascript" src="${_jsPath }/jquery/jquery.1.8.1.js"></script>
	<script type="text/javascript" src="${_jsPath }/plugin/formvalidator/formValidator-4.1.3.js" language="javascript"></script>
	<script type="text/javascript" src="${_jsPath }/plugin/formvalidator/formValidatorRegex.js" language="javascript"></script>
	<script type="text/javascript" src="${_jsPath }/plugin/select/linkage_sel.js"></script>
	<script type="text/javascript" src="${_jsPath }/plugin/uploadify/swfobject.js"></script>
	<script type="text/javascript" src="${_jsPath }/plugin/uploadify/jquery.uploadify.v2.1.4.min.js"></script>
	<script type="text/javascript" src="${_jsPath }/plugin/ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="${_jsPath }/plugin/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="${_jsPath }/pages/updateActiveInfoForApply.js"></script>
	<script type="text/javascript">
    var _ctxPath = '${_ctxPath}',
    	_filePath = '${_filePath}',
    	_fileThumbPath = '${_fileThumbPath }',
    	_jsPath = '${_jsPath }';
	</script>
</body>
</html>