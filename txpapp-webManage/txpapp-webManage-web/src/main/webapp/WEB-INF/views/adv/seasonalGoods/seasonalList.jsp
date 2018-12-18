<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.txp.app.contants.AdvPosition"%>
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
    <script src="${_jsPath }/jquery/jquery.1.8.1.js"  language="javascript"></script>
    <script src="${_jsPath}/plugin/formvalidator/formValidatorRegex.js" language="javascript"></script>
    <script src="${_jsPath}/plugin/formvalidator/formValidator-4.1.3.js" language="javascript"></script>
    <script src="${_jsPath}/pages/specAdv.js" language="javascript"></script>
    <!--[if IE]>
		<script src="${_jsPath}/pages/ieplaceholder.js"></script>
	<![endif]-->
</head>
<body>
	<!--start header-->
	<jsp:include page="../../include/header.jsp"></jsp:include> 
	<div class="body m-w980p">
	<%--  <jsp:include page="../include/pageManageMenu.jsp"  flush="true" />  --%>
		 <form class="sub-form m-clear m-mt10p" action="${_ctxPath }/admin/adv/seasonal_toAddDetail.htm" id="addForm" method="post">
		 	<div class="m-fl"><%-- 广告类型 --%>
		          		 	<input type="submit" class="m-btn" value="新增${position.positionName }" />
	         </div>
	         
		</form>
		
        <!--start 商家管理table-->
        <div class="m-mt10p business-management">
            <table class="tab-control" id="tab">
                <thead>
                    <tr>
                        <th width="15%">广告名称 </th>
                        <th width="15%">广告类型</th>
                        <th width="15%">预览广告</th>
                        <th width="15%">展示位置</th>
                        <th width="15%">操作</th>
                    </tr>
                </thead>
                <tbody>
                 <c:forEach items="${advPage.result}" var="adv" varStatus="status">
                 	<tr>
						<td>${adv.advertisementName}
					    </td>
						<td>${adv.position.positionName}</td>
						<td>
							<div class="relative">
								<c:if test="${adv.imageUrl != '' && adv.imageUrl!= null}">
									<span style="display: none;"><yp:thumbImage originalPath='${adv.imageUrl}' imageType='t5'></yp:thumbImage></span>
									<a class="preview" style="cursor: pointer;" onclick="imgView(this)">预览</a>
									<%-- <a class="preview" style="cursor: pointer;" onclick="imgView('${adv.imageUrl}','${adv.position.width}','${adv.position.height}')">预览</a> --%>
								</c:if>
							</div>
						</td>
						<td> 
						<c:choose>
							<c:when test="${adv.rank == 1}">
							封面图片
							</c:when>
							<c:when test="${adv.rank ==5}">
							icon
							</c:when>
							<c:otherwise>
							${adv.rank -1}
							</c:otherwise>
						</c:choose>
						</td>
						<td><a onclick="clickAddOrEdit('${adv.advertisementId}','${_ctxPath}/admin/adv/seasonal_toEditDetail.htm')" style="cursor: pointer;">编辑</a>&nbsp;
						<a style="cursor: pointer;" onclick="delAdv('${adv.advertisementId}','${_ctxPath}/admin/adv/seasonal_delDetail.htm')" class="m-5">删除</a></td>
					</tr>
                 </c:forEach>
                </tbody>
            </table>
        </div>
        <div class="table-bm-wrap cf">
			<!--S 右功能区-->
			<div class="fn-right">
				<!--S 分页-->
				<div class="pagination pagination-right">
					<c:if test="${not empty advPage.result}">
						<yp:commPage page="${advPage}" beanName="advPage"></yp:commPage>
					</c:if>
				</div>
				<!--E 分页-->
			</div>
			<!--E 右功能区-->
		</div>
       <!--end 商家管理table-->
	 </div>
	<!--end foot-->
	<jsp:include page="/WEB-INF/views/include/foot.jsp"></jsp:include>
</body>
</html>