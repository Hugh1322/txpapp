<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>活动详情</title>
<link href="${ _cssPath}/pages/orderManagement.css" rel="stylesheet" />
<link href="${_jsPath }/plugin/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" />
<link href="${ _cssPath}/common.css" rel="stylesheet" />
<link href="${_cssPath }/pages/message.css" rel="stylesheet" /> 
<link href="${_jsPath }/plugin/artdialog/skins/ytoxl.css" rel="stylesheet" />

<script src="${_jsPath }/plugin/My97DatePicker/WdatePicker.js"></script>
<script src="${_jsPath }/pages/searchOrderCrms.js" language="javascript"></script>
<script src="${_jsPath }/jquery/jquery.1.8.1.js" language="javascript"></script>
<script src="${_jsPath }/plugin/My97DatePicker/WdatePicker.js"></script>
<script src="${_jsPath }/plugin/formvalidator/formValidatorRegex.js" language="javascript"></script>
<script src="${_jsPath }/plugin/formvalidator/formValidator-4.1.3.js" language="javascript"></script>
<script type="text/javascript" src="${_jsPath}/plugin/uploadify/jquery.uploadify.v2.1.4.min.js"></script>
<script type="text/javascript" src="${_jsPath}/plugin/uploadify/swfobject.js"></script>
<script>
	function backList(){
		 window.location.href=_ctxPath+'/admin/active/active-manager.htm';
	}
</script>

</head>
<body>
	<jsp:include page="../include/header.jsp" flush="true" />
	<div class="body m-w980p">
		<div class="m-mt10p business-management">
			<table border="0" class="add-table">
						<tr>
							<th width="100">活动详情</th>
							<th colspan="4">&nbsp;</th>
						</tr>
						<tr>
							<td align="right">活动代码：</td>
							<td>
								${activeInfo.activeNo}
							</td>
							<td></td>
						</tr>
						<tr>
							<td align="right">活动名称：</td>
							<td>${activeInfo.activeName}</td>
							<td></td>
						</tr>
						<tr>
							<td align="right">活动时间：</td>
							<td width="500"><fmt:formatDate value='${activeInfo.beginDate}' pattern='yyyy-MM-dd HH:mm:ss'/><label>至:
							<fmt:formatDate value='${activeInfo.endDate}' pattern='yyyy-MM-dd HH:mm:ss'/></label>
							<td></td>
						</tr>
						<tr>
							<td align="right">报名截止日期：</td>
							<td><fmt:formatDate value='${activeInfo.applyDate}' pattern='yyyy-MM-dd HH:mm:ss'/></td>
						</tr>
						<tr valign="top">
							<td align="right">活动内容：</td>
							<td colspan="4">${activeInfo.activeContent}</textarea>
							</td>
						</tr>
						<tr>
							<td align="right">折扣：</td>
							<td>${activeInfo.discount}</td>
						</tr>
						<tr valign="top">
							<td align="right">活动图片添加：</td>
							<td colspan="3">
								<c:if test="${not empty activeInfo.imageUrl}">
									<img src="${_filePath}${activeInfo.imageUrl}" width="300px" height="200"/>
								</c:if>
							</td>
							<td><span id="uploadImageValueIdTip"></span></td>
						</tr>
			</table>
            <table class="tab-control" id="tab">
                <thead>
                    <tr>
                        <th width="9%">商家名称</th>
                        <th width="13%">商家联系人</th>
                        <th width="8%">电话</th>
                        <th width="13%">报名时间</th>
                         <th width="8%">商品名称</th>
                        <th width="8%">商品规格</th>
                        <th width="9%">结算价</th>
                        <th width="8%">活动结算价</th>
                        <th width="9%">活动库存</th>
                        <th width="8%">处理状态</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach items="${allActiveApplyPage.result}" var="activeApply" varStatus="status">
					<tr class="list-tr">
					 	<td >${activeApply.companyName}</td>
						<td >${activeApply.contactName}</td>
						<td >${activeApply.userTel}</td>
						<td ><fmt:formatDate value='${activeApply.createTime}' pattern='yyyy-MM-dd HH:mm:ss' /></td>
						<td >${activeApply.productName}</td>
						<td >${activeApply.skuSpecification}</td>
						<td >${activeApply.settlementPrice}</td>
						<td >${activeApply.price}</td>
						<td >${activeApply.amount}</td>
						<td >
						<spring:message code="activity.status.${activeApply.applyStatus}"/>
						</td>
					</tr>
				</c:forEach>
                </tbody>
            </table>
        </div>
       <!--end 商家管理table-->
       <div class="pagination pagination-right">
			<c:if test="${not empty allActiveApplyPage.result}">
				<yp:commPage page="${allActiveApplyPage}" beanName="allActiveApplyPage"></yp:commPage>
			</c:if>
	   </div>
	   <br/>
	   <br/>
	   <div align="center">
	   <input style="" type="button" class="m-btn" value="返回" onclick="backList()"/>
	   </div>
</div>
	<jsp:include page="/WEB-INF/views/include/foot.jsp"></jsp:include>
</body>
</html>