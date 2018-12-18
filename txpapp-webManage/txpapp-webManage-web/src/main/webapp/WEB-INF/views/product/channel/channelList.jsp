<%@page language="java" contentType="text/html; charset=UTF-8"pageEncoding="UTF-8"%>
<%@include file="../../include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>商品频道管理</title>
<link href="${_cssPath }/common.css" rel="stylesheet" />
<link href="${_cssPath }/pages/arrangement.css" rel="stylesheet" />
<script src="${_jsPath }/jquery/jquery.1.8.1.js" language="javascript"></script>
<!--[if IE]>
		<script src="${_jsPath}/pages/ieplaceholder.js"></script>
	<![endif]-->
</head>
<body>
	<!--start header-->
	<jsp:include page="../../include/header.jsp"></jsp:include>
	<div class="body m-w980p">
	    <form class="sub-form layout" id="channelForm" action="${_ctxPath}/admin/productChannel/channel-channelManagerList.htm" method="post">
	            <div class="m-fl">
          			<input type="text"  class="txt-input input-marks input-default" data-default="输入频道名称" id="txtKeywords" name="productChannel.params.channelName" value="${productChannel.params.channelName}"/>
          			<input type="button" class="m-btn m-btn-search" value="查 询"  id="search"/>
	            </div>
              <c:if test="${not empty productChannel.result}">
				<div class="m-fr curr-num" >
				<label>当前显示：</label>
				<yp:commPageSize page="${productChannel}"
					beanName="productChannel"></yp:commPageSize>
				</div>
			</c:if>
		</form>
		<table style ="margin-top:10px;">
			<tr>
				<td>
					<div class="m-fl" style="margin-left:30px;">
						<input type="button" class="m-btn" value="新增商品频道" onclick = "return addProductChannel();"/>
					</div>
				</td>
			</tr>
		</table>
		<div class="m-mt10p business-management">
			<table class="tab-control" id="tab" style="clear: both;">
				<thead>
					<tr>
						<th width="9%">频道名称</th>
						<th width="9%">创建时间</th>
						<th width="9%">最后修改时间</th>
						<th width="9%">备注</th>
						<th width="9%">操作</th>
					</tr>
				</thead>
				<tbody>
				<s:iterator value="productChannel.result" var="channel">
					<tr>
						<td>${channel.channelName}</td>
						<td> <fmt:formatDate value="${channel.createTime}"   pattern="yyyy-MM-dd HH:mm:ss" type="date" dateStyle="long" />  </td>
						<td> <fmt:formatDate value="${channel.updateTime}"   pattern="yyyy-MM-dd HH:mm:ss" type="date" dateStyle="long" />  </td>
						<td >${channel.remark}</td>
						<td>
							<a href ="javascript:delProductChannel(${channel.id})">[删除]</a>
							<a href ="javascript:editProductChannel(${channel.id})">[编辑]</a>
						</td>
					</tr>
				</s:iterator>
				</tbody>
			</table>
		</div>
		<div class="table-bm-wrap cf">
			<!--S 右功能区-->
			<div class="fn-right">
				<!--S 分页-->
				<div class="pagination pagination-right">
					<c:if test="${not empty productChannel.result}">
						<yp:commPage page="${productChannel}" beanName="productChannel"></yp:commPage>
					</c:if>
				</div>
				<!--E 分页-->
			</div>
			<!--E 右功能区-->
		</div>
	</div>
	<!--end foot-->
	<jsp:include page="/WEB-INF/views/include/foot.jsp"></jsp:include>
	<script type="text/javascript">
		function addProductChannel(){
			 window.location.href = "${_ctxPath}/admin/productChannel/channel-addProductChannel.htm"; 
		}
		
		function delProductChannel(id){
			window.location.href = "${_ctxPath}/admin/productChannel/channel-delProductChannel.htm?channel.id="+id;
		}
		
		function editProductChannel(id){
			window.location.href = "${_ctxPath}/admin/productChannel/channel-addProductChannel.htm?channel.id="+id;
		}
		
		$("#search").click(function(){
			var keywords = $("#txtKeywords").val();
			if(keywords == $("#txtKeywords").attr("data-default")){
				$("#txtKeywords").val("");
				return;
			}
			$("#channelForm").submit();
		});
		
	</script>
</body>
</html>