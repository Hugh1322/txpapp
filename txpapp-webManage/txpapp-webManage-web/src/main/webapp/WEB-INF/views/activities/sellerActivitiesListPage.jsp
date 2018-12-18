<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>商家活动报名</title>
    <link href="${ _cssPath}/common.css" rel="stylesheet" />
    <script src="${_jsPath }/jquery/jquery.1.8.1.js"  language="javascript"></script>
	<script type="text/javascript" src="${_jsPath }/plugin/ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="${_jsPath }/plugin/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
<jsp:include page="../include/header.jsp"  flush="true" />
 <div class="body m-w980p">
 	<form class="sub-form m-clear m-mt10p" action="${_ctxPath}/seller/activities/activities-searchSellerActivitiesListPage.htm" id="search-form" method="post">
	    <div class="m-fl">
         	报名截止日期：<input type="text" name="beginApplyDate" value="${activeApply.beginDate}" class="Wdate" id="startTime"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true})" /><label>至 </label> <input type="text"
								name="endApplyDate" value="${activeApply.endDate}" class="Wdate" id="endTime"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true})" />
          <input type="submit" class="m-btn m-btn-search" value="查 询" id="search"/>
	    </div>
	</form>
         <!--start 商家管理table-->
        <div class="m-mt10p business-management">
            <table class="tab-control" id="tab">
                <thead>
                    <tr>                       
                        <th width="15%">活动主题</th>
                        <th width="15%">活动报名截止日期</th>
                        <th width="15%">活动内容及要求</th>
                        <th width="18%">活动时间</th>
                        <th width="9%">活动状态</th>
                        <th width="9%">已报名数量</th>
                        <th width="9%">活动操作</th>
                        
                    </tr>
                </thead>
                <tbody class="f14">
                <c:forEach items="${requestScope.activityListPage4Sellers.result}" var="activeApply" varStatus="status">
					<tr class="list-tr">
						<td >${activeApply.activeName}</td>
						<td ><fmt:formatDate value='${activeApply.applyDate}' pattern='yyyy-MM-dd HH:mm:ss' /></td>
						<td class="listTd">${activeApply.activeContent}</td>
						<td ><fmt:formatDate value='${activeApply.beginDate}' pattern='yyyy-MM-dd HH:mm:ss' />至
						<br >
						<fmt:formatDate value='${activeApply.endDate}' pattern='yyyy-MM-dd HH:mm:ss' /></td>
						<c:if test="${activeApply.activeStatus == 0}">
							<td >活动结束</td>
						</c:if>
						<c:if test="${activeApply.activeStatus == 1}">
							<td >活动进行中</td>
						</c:if>						
						<td >${activeApply.num}</td>
						<td class="cBtn">
						<a href="${_ctxPath}/seller/activities/activities-showActivitiesDetailsPage.htm?activityListPage4Sellers.params.type=2&activityListPage4Sellers.params.activeId=${activeApply.activeId}">报名</a>&nbsp;
						<a href="${_ctxPath}/seller/activities/activities-showActivitiesDetailsPage.htm?activityListPage4Sellers.params.type=1&activeId=${activeApply.activeId}">查看</a>
						</td>
					</tr>
				</c:forEach>
                </tbody>
            </table>
        </div>
       <!--end 商家管理table-->
       <div class="pagination pagination-right">
			<c:if test="${not empty activityListPage4Sellers.result}">
				<yp:commPage page="${activityListPage4Sellers}" beanName="activityListPage4Sellers"></yp:commPage>
			</c:if>
	   </div>
 </div>
<jsp:include page="/WEB-INF/views/include/foot.jsp"></jsp:include>
</body>
</html>