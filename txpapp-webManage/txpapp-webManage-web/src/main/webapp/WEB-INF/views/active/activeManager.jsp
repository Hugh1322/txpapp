<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<script type="text/javascript">
		var addActive=function(userId,status){
			window.location.href="${_ctxPath}/admin/active/active-regActiveInfo.htm";
		};
		
		function validate(){
			var startTime_val=$("#startTime").val();
			var endTime_val=$("#endTime").val();
			
			if(startTime_val != "" && endTime_val != ""){
				var startStringToDate = new Date(startTime_val.replace(/-/g,"/"));
				var endStringToDate = new Date(endTime_val.replace(/-/g,"/"));
				if (startStringToDate > endStringToDate) {
					alert('报名查询开始时间不能大于报名查询结束时间!');
					return;
				}else{
					document.getElementById('search-form').submit();
				}
			}else{
				document.getElementById('search-form').submit();
			}
	  
	}
	</script>
	<title>活动管理</title>
    <link href="${ _cssPath}/common.css" rel="stylesheet" />
    <script src="${_jsPath }/jquery/jquery.1.8.1.js"  language="javascript"></script>
	<script type="text/javascript" src="${_jsPath }/plugin/ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="${_jsPath }/plugin/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
<jsp:include page="../include/header.jsp"  flush="true" />
 <div class="body m-w980p">
 	<form class="sub-form m-clear m-mt10p" action="${_ctxPath}/admin/active/active-searchActivitiesByApplyTime.htm" id="search-form" method="post">
	    <div class="m-fl">
         	报名日期：<input type="text" name="applyDateBegin" value="<fmt:formatDate value='${applyDateBegin}' pattern='yyyy-MM-dd HH:mm:ss'/>" class="Wdate" id="startTime"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true})" /><label>至: </label> <input type="text"
								name="applyDateEnd" value="<fmt:formatDate value='${applyDateEnd}' pattern='yyyy-MM-dd HH:mm:ss'/>" class="Wdate" id="endTime"
								onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',readOnly:true})" />
          <input type="button" class="m-btn m-btn-search" value="查 询" onclick="validate()" />
	    </div>
	</form>
        <div class="m-mt10p">
			<input type="button" class="m-btn" value="添加新活动" onclick="addActive()"/>
		</div>
         <!--start 商家管理table-->
        <div class="m-mt10p business-management">
            <table class="tab-control" id="tab">
                <thead>
                    <tr>
                        <th width="11%">活动主题</th>
                        <th width="15%">活动报名截止日期</th>
                        <th width="19%">活动内容及要求</th>
                        <th width="18%">活动时间</th>
                        <th width="8%">活动折扣</th>
                        <th width="9%">活动状态</th>
                        <th width="9%">已报名数量</th>
                        <th width="8%">活动操作</th>
                    </tr>
                </thead>
                <tbody class="f14">
                <c:forEach items="${activeInfoPage.result}" var="activeInfo" varStatus="status">
					<tr class="list-tr">
						<td >${activeInfo.activeName}</td>
						<td ><fmt:formatDate value='${activeInfo.applyDate}' pattern='yyyy-MM-dd HH:mm:ss' /></td>
						<td  class="listTd">${activeInfo.activeContent}</td>
						<td ><fmt:formatDate value='${activeInfo.beginDate}' pattern='yyyy-MM-dd HH:mm:ss' />至
						<br>
						<fmt:formatDate value='${activeInfo.endDate}' pattern='yyyy-MM-dd HH:mm:ss' /></td>
						<td >${activeInfo.discount}</td>
						<td >
						<spring:message code="activeInfo.status.${activeInfo.activeStatus}"/>
						</td>
						<td >${activeInfo.num}</td>
						<td class="cBtn">
							<aut:authorize url="/admin/active/active-executeActiveApply">
							<a class="c-blue" href="${_ctxPath}/admin/active/active-executeActiveApply.htm?allActiveApplyPage.params.activeId=
													${activeInfo.activeId}">处理</a>
							</aut:authorize>
							<c:if test="${activeInfo.activeStatus == 1}">
							<aut:authorize url="/admin/active/active-completeActiveInfo">
							<a class="c-blue" href="${_ctxPath}/admin/active/active-completeActiveInfo.htm?activeInfo.activeId=
													${activeInfo.activeId}">结束</a> 
							</aut:authorize>
							</c:if>
							<aut:authorize url="/admin/active/active-delayActiveInfo">
							<a class="c-blue" href="${_ctxPath}/admin/active/active-delayActiveInfo.htm?activeInfo.activeId=
													${activeInfo.activeId}">修改</a> 
							</aut:authorize>
							<aut:authorize url="/admin/active/active-viewActiveInfo">
							<a class="c-blue" href="${_ctxPath}/admin/active/active-viewActiveInfo.htm?allActiveApplyPage.params.activeId=
													${activeInfo.activeId}&activeInfo.activeId=
													${activeInfo.activeId}">查看</a> 
							</aut:authorize>
							<!-- 目前不需要
							<aut:authorize url="/admin/active/active-regActiveInfo">
							<a class="c-blue" href="${_ctxPath}/admin/active/active-regActiveInfo.htm?activeInfo.activeId=
													${activeInfo.activeId}">编辑</a>
							</aut:authorize>
							 -->
						</td>
					</tr>
				</c:forEach>
                </tbody>
            </table>
        </div>
       <!--end 商家管理table-->
       <div class="pagination pagination-right">
			<c:if test="${not empty activeInfoPage.result}">
				<yp:commPage page="${activeInfoPage}" beanName="activeInfoPage"></yp:commPage>
			</c:if>
	   </div>
 </div>
<jsp:include page="/WEB-INF/views/include/foot.jsp"></jsp:include>
</body>
</html>