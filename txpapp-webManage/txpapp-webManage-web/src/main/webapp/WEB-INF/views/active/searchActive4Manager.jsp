<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>活动处理</title>
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
  //选中全选按钮，下面的checkbox全部选中
  var selAll = document.getElementById("selAll");
  
  function selectAll()
  {
    var obj = document.getElementsByName("checkAll");
    if(document.getElementById("selAll").checked == false){
	    for(var i=0; i<obj.length; i++)
	    {
	      obj[i].checked=false;
	    }
    }else{
	    for(var i=0; i<obj.length; i++){  
	      obj[i].checked=true;
	    }
    }
   
  };
  //当选中所有的时候，全选按钮会勾上
  function setSelectAll(){
	  var obj=document.getElementsByName("checkAll");
	  var count = obj.length;
	  var selectCount = 0;
	
	  for(var i = 0; i < count; i++) {
		  if(obj[i].checked == true){
		  	selectCount++;
		  }
	  }
	  if(count == selectCount){
	  	document.all.selAll.checked = true;
	  }else{
	  	document.all.selAll.checked = false;
	  }
	};
	  //反选按钮
	function inverse() {
	  var checkboxs=document.getElementsByName("checkAll");
	  for (var i=0;i<checkboxs.length;i++) {
	    var e=checkboxs[i];
	    e.checked=!e.checked;
	    setSelectAll();
	  }
	};
	//拒绝申请
	function refuse(){
		//通过NAME得到CHECKBOX集合
		var allObj = document.getElementsByName("checkAll");
		var ctext = "";
		var j=0;
		
		for(var i=0; i<allObj.length; i++){  
	        if(allObj[i].checked){
	            ctext += allObj[i].value+"-";
	            j++;
	        }  
	    }
	    if(j<1){
			alert("无数据或者未勾选数据，请重新选择");
			return null;
		}
		for(var i=0; i<allObj.length; i++){
			if(allObj[i].checked && $('#'+allObj[i].value).val()!=0){
				alert("拒绝操作勾选数据中有状态不为'待处理'，请重新选择！");
		      	return null;
		    }
		}
		 
		var msg = "确认拒绝该申请！";
		if(confirm(msg)){
			$.ajax({
				url:_ctxPath + "/admin/active/active-executeActiveApply.htm",
				type:"POST",
				data:{"allActiveApplyPage.params.applyIds":ctext,"allActiveApplyPage.params.type":"refuse"},
				dataType:"html",
				async: false,
				success:function(data){
					 $("#searchForm").submit();
				},
				dataType:'json'
			});
		}
	};
	
	
	//同意申请
	function agree(){
		//通过NAME得到CHECKBOX集合
		var allObj = document.getElementsByName("checkAll");
		var ctext = "";
		var j=0;
		
	    for(var i=0; i<allObj.length; i++){  
	        if(allObj[i].checked){
	            ctext += allObj[i].value+"-";
	            j++;
	        }  
	    }
	    if(j<1){
			alert("无数据或者未勾选数据，请重新选择");
			return null;
		}
		for(var i=0; i<allObj.length; i++){  
			if(allObj[i].checked && $('#'+allObj[i].value).val()!=0){
				alert("同意操作勾选数据中有状态不为'待处理'，请重新选择！");
		      	return null;
		    }
		}
		
		var msg = "确认通过该申请！";
		if(confirm(msg)){
			$.ajax({
				url:_ctxPath + "/admin/active/active-executeActiveApply.htm",
				type:"POST",
				data:{"allActiveApplyPage.params.applyIds":ctext,"allActiveApplyPage.params.type":"agree"},
				dataType:"html",
				async: false,
				success:function(data){
					 $("#searchForm").submit();
				},
				dataType:'json'
			});
		}
	};
	// 返回
	var backList=function(){
		  $('#searchForm').attr('action', '${_ctxPath}/admin/active/active-manager.htm');
		  $("#searchForm").submit();
	};
	// 导出
	var exportActiveList=function(){
		var activePageLen=$(".list-tr").length;
		if(activePageLen){
			$('#searchForm').attr('action', '${_ctxPath}/admin/active/active-listExportActives.htm');
			$("#searchForm").submit();
		}else{
			alert("没有可导出的活动信息！")
		}
	};
  </script>
</head>
<body>
	<jsp:include page="../include/header.jsp" flush="true" />
	<div class="body m-w980p">
		<!--start form-->
		<form class="m-mt10p m-clear" action="${_ctxPath}/admin/active/active-executeActiveApply.htm" method="post" id="searchForm">
		<input type="hidden" name="allActiveApplyPage.params.activeId" id="activeId" value="${allActiveApplyPage.params.activeId}" />
		<input type="hidden" name="allActiveApplyPage.params.applyIds" id="applyIds" />
        <input type="hidden" name="allActiveApplyPage.params.type" id="type" />
            <div  class="m-clear">
                <span class="m-fl">
                <select name="allActiveApplyPage.params.sellerId" class="m-sel">
                        <option value="">商家名称</option>
                        <c:forEach items="${sellers }" var="seller" varStatus="status">
							<option value="${seller.userId }"
								<c:if test="${allActiveApplyPage.params.sellerId == seller.userId }"> selected = "selected" </c:if>>
								${seller.companyName}
							</option>
						</c:forEach>
                    </select>
                    <select name="allActiveApplyPage.params.brandId" class="m-sel">
                        <option value="">品牌名称</option>
                        <c:forEach items="${brands }" var="brand">
							<option value="${brand.brandId }" <c:if test="${allActiveApplyPage.params.brandId==brand.brandId }"> selected = "selected" </c:if>>
									${brand.name}
							</option>
						</c:forEach>
                    </select>
                    <select name="allActiveApplyPage.params.status" class="m-sel">
						<option value="">处理状态</option>
						<c:forEach items="${statusList }" var="statu">
							<option value="${statu}"
								<c:if test="${allActiveApplyPage.params.status==statu }">
									selected = "selected"
								</c:if>
								><spring:message code="activity.status.${statu}"/></option>
						</c:forEach>
					</select>
                    <label>商品名称:</label><input type="text" class="J-keywords2 txt-input input-marks input-default" name="allActiveApplyPage.params.productName"
                     value="${allActiveApplyPage.params.productName}">
                </span>
            </div>
     		<div class="m-search">
	     				<input type="submit" class="m-btn" value="查 询" /> 
		      		<aut:authorize url="/admin/active/active-listExportActives">
		      			<input type="button" class="m-btn" value="导出" id="export" onclick="exportActiveList();" />
		      		</aut:authorize>
		      		<aut:authorize url="/admin/active/active-refuseActiveInfo">
	     				<input type="button" class="m-btn" value="拒绝" onclick="refuse()"/> 
					</aut:authorize>
		      		<aut:authorize url="/admin/active/active-agreeActiveInfo">
		      			<input type="button" onclick="agree()" class="m-btn" value="同意" />
		      		</aut:authorize>
		      			<input type="button" id="back" onclick="backList()" class="m-btn" value="返回" />
     		</div>
		</form>
		<div class="m-mt10p business-management">
            <table class="tab-control" id="tab">
                <thead>
                    <tr>
                    	<th width="9%"><input type="checkbox" class="selAll" name="selAll" id="selAll" onclick="selectAll()"></th>
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
						<td ><input type="checkbox" id="applyId" value="${activeApply.applyId}" name="checkAll" onclick="setSelectAll()"/></td>
					 	<td ><a href="${_ctxPath}/admin/active/active-sellerDetail.htm?userInfo.user.userId=${activeApply.userId}&allActiveApplyPage.params.productName=
					 	${allActiveApplyPage.params.productName}&allActiveApplyPage.params.activeId=${allActiveApplyPage.params.activeId}
					 	&allActiveApplyPage.params.sellerId=${allActiveApplyPage.params.sellerId}&allActiveApplyPage.params.status=${allActiveApplyPage.params.status}"
					 	 class="J_tr">${activeApply.companyName}</a></td>
						<td >${activeApply.contactName}</td>
						<td >${activeApply.userTel}</td>
						<td ><fmt:formatDate value='${activeApply.createTime}' pattern='yyyy-MM-dd HH:mm:ss' /></td>
						<td >${activeApply.productName}</td>
						<td >${activeApply.skuSpecification}</td>
						<td >${activeApply.settlementPrice}</td>
						<td >${activeApply.price}</td>
						<td >${activeApply.amount}</td>
						<td >
						<input type="hidden" id="${activeApply.applyId}" value="${activeApply.applyStatus}"/>
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
</div>
	<jsp:include page="/WEB-INF/views/include/foot.jsp"></jsp:include>
</body>
</html>