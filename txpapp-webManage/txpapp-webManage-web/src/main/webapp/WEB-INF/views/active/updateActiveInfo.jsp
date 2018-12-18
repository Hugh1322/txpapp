<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>活动发布修改</title>
	<link href="${_cssPath}/common.css" rel="stylesheet" />
	<link href="${_cssPath}/pages/addBrand.css" rel="stylesheet" />
	<link href="${_jsPath }/plugin/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" />
</head>
<body >
<jsp:include page="../include/header.jsp"  flush="true" />
	<div class="body m-w980p">
			<h1 class="add-title">活动发布修改</h1>
			<form action="${_ctxPath}/admin/active/active-updateActiveInfo.htm" method="post" id="form1">
			<input type="hidden" name="activeInfo.activeId"  value="${activeInfo.activeId}" />
			<input type="hidden" name="activeInfo.activeStatus"  value="${activeInfo.activeStatus}" />
					<table border="0" class="add-table">
						<tr>
							<th width="100">基本信息</th>
							<th colspan="4">&nbsp;</th>
						</tr>
						<tr>
							<td align="right"><span class="c-red">*</span>活动代码：</td>
							<td width="225">
								<input  type="text" name="activeInfo.activeNo"
								value="${activeInfo.activeNo}" class="add-text" id="activeInfo_Id"/>
							</td>
							<td colspan="3"><span id="activeInfo_IdTip"></span></td>
						</tr>
						<tr>
							<td align="right"><span class="c-red">*</span>活动名称：</td>
							<td><input type="text" name="activeInfo.activeName"
								value="${activeInfo.activeName}" class="add-text" id="activeName_id"/></td>
							<td colspan="3"><span id="activeName_idTip"></span></td>
						</tr>
						<tr>
							<td align="right"><span class="c-red">*</span>活动时间：</td>
							<td width="500"><input type="text" name="activeInfo.beginDate" value="<fmt:formatDate value='${activeInfo.beginDate}' pattern='yyyy-MM-dd HH:mm:ss'/>" class="Wdate" id="startTime"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true})" /><label>至:</label> <input type="text"
								name="activeInfo.endDate" value="<fmt:formatDate value='${activeInfo.endDate}' pattern='yyyy-MM-dd HH:mm:ss'/>" class="Wdate" id="endTime"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true})" /></td>
							<td colspan="3" id="dateTip"></td>
						</tr>
						<tr>
							<td align="right"><span class="c-red">*</span>报名截止日期：</td>
							<td><input type="text" name="activeInfo.applyDate" value="<fmt:formatDate value='${activeInfo.applyDate}' pattern='yyyy-MM-dd HH:mm:ss'/>" class="Wdate" id="applyTime"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true})" /></td>
							<td colspan="3"><span id="applyTimeTip"></span></td>
						</tr>
						<tr valign="top">
							<td align="right"><span class="c-red">*</span>活动内容：</td>
							<td colspan="4"><textarea class="edit-textarea" name="activeInfo.activeContent"
							id="activeContent_id">${activeInfo.activeContent}</textarea>
							</td>
						</tr>
						<tr>
							<td></td>
							<td colspan=""><span id="activeContent_idTip"></span></td>
						</tr>
						<tr>
							<td align="right"><span class="c-red">*</span>折扣：</td>
							<td><input data-default="数据格式：例如0.12,0.25" type="text" name="activeInfo.discount" value="${activeInfo.discount}" class="add-text" id="discount"/></td>
							<td colspan="3"><span id="discountTip"></span></td>
						</tr>
						<tr valign="top">
							<td align="right"><span class="c-red">*</span>活动图片添加：</td>
							<td colspan="3">
								<input type="file" id="imgUpload" name="file" /> 
								<input type="hidden" id="uploadImageValueId" name="activeInfo.imageUrl" value="${activeInfo.imageUrl}" />
								<div class="license">
									<c:if test="${not empty activeInfo.imageUrl}">
										<img src="${_filePath}${activeInfo.imageUrl}" width="300px" height="200"/>
									</c:if>
								</div>
							</td>
							<td><span id="uploadImageValueIdTip"></span></td>
						</tr>
						<tr>
							<td colspan="5" align="center">
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
	<script type="text/javascript" src="${_jsPath }/pages/editActiveInfo.js"></script>
	<script type="text/javascript">
    var _ctxPath = '${_ctxPath}',
    	_filePath = '${_filePath}',
    	_fileThumbPath = '${_fileThumbPath }',
    	_jsPath = '${_jsPath }';
	</script>
</body>
</html>