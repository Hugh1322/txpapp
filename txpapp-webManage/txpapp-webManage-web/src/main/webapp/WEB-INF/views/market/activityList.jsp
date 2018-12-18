<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	%>
<%@include file="../include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>营销活动管理</title>
<link href="${_cssPath }/common.css" rel="stylesheet" />
<link href="${_cssPath }/pages/arrangement.css" rel="stylesheet" />
<link href="${_cssPath }/pages/bannerManage.css" rel="stylesheet" />
<link href="${_jsPath }/plugin/artdialog/skins/ytoxl.css"	rel="stylesheet" />
<script src="${_jsPath }/jquery/jquery.1.8.1.js" language="javascript"></script>
<script src="${_jsPath}/pages/marketactTool.js" language="javascript"></script>
<!--[if IE]>
		<script src="${_jsPath}/pages/ieplaceholder.js"></script>
	<![endif]-->
</head>
<body>
	<!--start header-->
	<jsp:include page="../include/header.jsp"></jsp:include>
	<div class="body m-w980p">
		<!-- 当前位置 -->
		<div class="curPosition" style = "margin-top:10px;">
			当前位置：<a href="${_ctxPath}/marketactivity/marketact-listActivities.htm">营销工具</a>-> <a href="${_ctxPath}/marketactivity/marketact-listActivities.htm">活动管理</a>
		</div>
		<c:if test="${not empty marketactPage.result}">
		<div class="m-fr curr-num" style = "margin-top:15px;">
		<label>当前显示：</label>
		<yp:commPageSize page="${marketactPage}"
		beanName="marketactPage"></yp:commPageSize>
		</div>
		</c:if>
		<!--start 商家管理table-->
		<div class="m-mt10p business-management">
			<form action="${_ctxPath }/marketactivity/marketact-listActivities.htm">
			<span class="m-fl" style="margin-top: 10px;margin-bottom:8px;">
			<label>活动状态：</label>
			未发布
			<label>使用状态: </label>
			活动中
			<label>代码：</label>
			 <s:textfield name="marketactPage.params['name']"></s:textfield>
				<input type="submit" class="m-btn" value="查询" />
			<input type="button" class="m-btn" value="新增活动" onclick="addMarketivity();"/>
			</span>
			</form>
			<table class="tab-control" id="tab" style="clear: both;">
				<thead>
				<tr>
					<th width="9%">活动代码</th>
					<th width="9%">活动名称</th>
					<th width="9%">开始时间</th>
					<th width="9%">结束时间</th>
					<!-- <th width="5%">会员资格</th> -->
					<th width="6%">使用状态</th>
					<th width="9%">活动状态</th>
					<th width="6%">销售类型</th>
					<th width="10%">创建时间</th>
					<th width="10%">最后修改时间</th>
					<th width="10%">操作</th>
				</tr>
				</thead>
				<tbody>
				<tr>
					<td>111</td>
					<td>满减活动</td>
					<td> </td>
					<td> </td>
					<%-- <td> <c:if test="${act.vipLevel==1}">LV1</c:if>  </td> --%>
					<td>cccc</td>
					<td><span class="statusLabel" ></span></td>
					<td>
						普通
					</td>
					<td> </td>
					<td>  </td>
					<td>

						<a href="${_ctxPath }/test/user/market/configActivityProducts.do?activityProduct.params.marketActivityId=1">[设置活动商品] <span style="color: #bf3028"><-点我</span></a><br/>
						<a href="${_ctxPath }/test/user/market/configActivityProducts.do?activityProduct.params.marketActivityId=1&listType=1">[活动商品详情] <span style="color: #bf3028"><-点我</span></a><br/>
						<a href="javascript:delActivity(1)">[删除]</a><br/>
						<a href="${_ctxPath }/marketactivity/marketact-toAddActivity.htm?activity.id=1">[编辑]</a><br/>
						<a href="javascript:activActivity(1)">[发布]</a><br/>
						<a href="javascript:showActivityDetail(1)">[详情]</a>
						<br/>
						<a href="${_ctxPath }/marketactivity/marketact-toSetActivityPage.htm?activityProduct.params.marketActivityId=1&activityProduct.params.listType=1">[活动页面设置]</a><br/>
					</td>
				</tr>
				<c:forEach items="${marketactPage.result}" var="act">
					<tr>
						<td>${act.code}</td>
						<td>${act.name}</td>
						<td> <fmt:formatDate value="${act.startTime}"   pattern="yyyy-MM-dd HH:mm:ss" type="date" dateStyle="long" />  </td>
						<td> <fmt:formatDate value="${act.endTime}"   pattern="yyyy-MM-dd HH:mm:ss" type="date" dateStyle="long" />  </td>
							<%-- <td> <c:if test="${act.vipLevel==1}">LV1</c:if>  </td> --%>
						<td>${act.activityLabel}</td>
						<td><span class="statusLabel" ><spring:message code="act.status.${act.status}"/></span></td>
						<td>
							<c:choose>
								<c:when test="${act.sellTypes==1}">
									普通
								</c:when>
								<c:when test="${act.sellTypes==3}">
									抢购
								</c:when>
								<c:when test="${act.sellTypes==4}">
									团购
								</c:when>
								<c:when test="${act.sellTypes==5}">
									分期送
								</c:when>
								<c:when test="${act.sellTypes==8}">
									试吃
								</c:when>

							</c:choose>

						</td>
						<td> <fmt:formatDate value="${act.createTime }"   pattern="yyyy-MM-dd HH:mm:ss" type="date" dateStyle="long" />  </td>
						<td> <fmt:formatDate value="${act.updateTime }"   pattern="yyyy-MM-dd HH:mm:ss" type="date" dateStyle="long" />  </td>
						<td>

							<input type="hidden" class="hiddenStatus" value="${act.status}" />
							<input type="hidden" class="hiddenActStatus" value="${act.activityStat}" />
							<input type="hidden"  value="${act.code}"  id="code_${act.id}"/>
							<input type="hidden"  value="${act.name}"  id="name_${act.id}"/>
							<input type="hidden"   value = "<fmt:formatDate value="${act.startTime}" pattern="yyyy-MM-dd"/>" id = "startTime_${act.id}" />
							<input type="hidden" value = "<fmt:formatDate value="${act.endTime}" pattern="yyyy-MM-dd"/>" id = "endTime_${act.id}"/>
							<input type="hidden"  value="${act.activityLabel}" id = "activityLabel_${act.id}"/>


							<a href="${_ctxPath }/test/user/market/configActivityProducts.do?activityProduct.params.marketActivityId=${act.id}">[设置活动商品]</a><br/>
							<a href="${_ctxPath }/test/user/market/configActivityProducts.do?activityProduct.params.marketActivityId=${act.id}&listType=1">[活动商品详情]</a><br/>
							<a href="javascript:delActivity(${act.id})">[删除]</a><br/>
							<a href="${_ctxPath }/marketactivity/marketact-toAddActivity.htm?activity.id=${act.id}">[编辑]</a><br/>
							<a href="javascript:activActivity(${act.id})">[发布]</a><br/>
							<a href="javascript:showActivityDetail(${act.id})">[详情]</a>
							<!-- 活动状态为活动未发布 -->
							<c:if test="${act.status == 0 }">
								<a href="${_ctxPath }/marketactivity/marketact-configActivityProduct.htm?activityProduct.params.marketActivityId=${act.id}">[设置活动商品]</a><br/>
								<a href="${_ctxPath }/marketactivity/marketact-configActivityProduct.htm?activityProduct.params.marketActivityId=${act.id}&activityProduct.params.listType=1">[活动商品详情]</a><br/>
								<a href="javascript:delActivity(${act.id})">[删除]</a><br/>
								<a href="${_ctxPath }/marketactivity/marketact-toAddActivity.htm?activity.id=${act.id}">[编辑]</a><br/>
								<a href="javascript:activActivity(${act.id})">[发布]</a><br/>
								<a href="javascript:showActivityDetail(${act.id})">[详情]</a>
							</c:if>

							<!-- 活动状态为活动已发布 -->
							<c:if test="${act.status == 1 }">
								<a href="${_ctxPath }/marketactivity/marketact-configActivityProduct.htm?activityProduct.params.marketActivityId=${act.id}">[设置活动商品]</a><br/>
								<a href="${_ctxPath }/marketactivity/marketact-configActivityProduct.htm?activityProduct.params.marketActivityId=${act.id}&activityProduct.params.listType=1">[活动商品详情]</a><br/>
								<a href="javascript:forbidActivity(${act.id})">[发布中止]</a><br/>
								<a href="javascript:showActivityDetail(${act.id})">[详情]</a>
							</c:if>
							<br/>
							<a href="${_ctxPath }/marketactivity/marketact-toSetActivityPage.htm?activityProduct.params.marketActivityId=${act.id}&activityProduct.params.listType=1">[活动页面设置]</a><br/>
						</td>
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
					<c:if test="${not empty marketactPage.result}">
					<yp:commPage page="${marketactPage}" beanName="marketactPage"></yp:commPage>
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