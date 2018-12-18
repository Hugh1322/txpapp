<%@page language="java" contentType="text/html; charset=UTF-8"pageEncoding="UTF-8"%>
<%@include file="../../include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>商品标签管理</title>
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
	 <form class="sub-form layout" id="labelForm" action="${_ctxPath}/admin/productLabel/label-labelManageList.htm" method="post">
            <div class="m-fl">
         			<input type="text"  class="txt-input input-marks input-default" data-default="输入标签名称" id="txtKeywords" name="productlabelPage.params.labelName" value="${productlabelPage.params.labelName}"/>
         			<input type="button" class="m-btn m-btn-search" value="查 询"  id="search"/>
            </div>
             <c:if test="${not empty productlabelPage.result}">
				<div class="m-fr curr-num">
					<label>当前显示：</label>
					<yp:commPageSize page="${productlabelPage}"
						beanName="productlabelPage"></yp:commPageSize>
				</div>
			</c:if>
		</form>
		<table style ="margin-top:10px;">
			<tr>
				<td>
					<div class="m-fl" style="margin-left:30px;">
						<input type="button" class="m-btn" value="新增商品标签" onclick = "return addProductLabel();"/>
					</div>
				</td>
			</tr>
		</table>
		<div class="m-mt10p business-management">
			<table class="tab-control" id="tab" style="clear: both;">
				<thead>
					<tr>
						<th width="9%">标签名称</th>
						<th width="9%">标签图标</th>
						<th width="9%">创建时间</th>
						<th width="9%">最后修改时间</th>
						<th width="9%">备注</th>
						<th width="9%">操作</th>
					</tr>
				</thead>
				<tbody>
				<s:iterator value="productlabelPage.result" var="label">
					<tr>
						<td>${label.labelName}</td>
						<td>
							<img alt="" src="${_filePath}/${label.labelImgUrl}" id="labelImgUrl" style="width:50px;height: 50px;"/>
						</td>
						<td> <fmt:formatDate value="${label.createTime}"   pattern="yyyy-MM-dd HH:mm:ss" type="date" dateStyle="long" />  </td>
						<td> <fmt:formatDate value="${label.updateTime}"   pattern="yyyy-MM-dd HH:mm:ss" type="date" dateStyle="long" />  </td>
						<td >${label.remark}</td>
						<td>
							<a href ="javascript:delProductLabel(${label.id})">[删除]</a>
							<a href ="javascript:editProductLabel(${label.id})">[编辑]</a>
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
					<c:if test="${not empty productlabelPage.result}">
						<yp:commPage page="${productlabelPage}" beanName="productlabelPage"></yp:commPage>
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
	<script type="text/javascript">
		function addProductLabel(){
			 window.location.href = "${_ctxPath}/admin/productLabel/label-addProductLabel.htm"; 
		}
		function delProductLabel(id){
			window.location.href = "${_ctxPath}/admin/productLabel/label-delProductLabel.htm?productLabel.id="+id;
		}
		function editProductLabel(id){
			window.location.href = "${_ctxPath}/admin/productLabel/label-addProductLabel.htm?productLabel.id="+id;
		}
		
		$("#search").click(function(){
			var keywords = $("#txtKeywords").val();
			if(keywords == $("#txtKeywords").attr("data-default")){
				$("#txtKeywords").val("");
				return;
			}
			$("#labelForm").submit();
		});		
	</script>
</body>
</html>