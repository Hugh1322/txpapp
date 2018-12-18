<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="aut" uri="http://www.springsecurity.org/jsp" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>物流管理-时效管理</title>
		<link rel="stylesheet" type="text/css" href="${_jsPath }/new/css/base.css?v=${_resVerion}"/>
		
        <link rel="stylesheet" href="${_jsPath }/new/calendar/kalendae.css?v=${_resVerion}" type="text/css" charset="utf-8">
        <script type="text/javascript" src="${_jsPath }/new/js/jquery-1.11.0.min.js?v=${_resVerion}"></script>
        <script type="text/javascript" src="${_jsPath }/new/js/manage_basefun.js?v=${_resVerion}"></script>
		<script src="${_jsPath }/new/calendar/kalendae.standalone.js?v=${_resVerion}" type="text/javascript" charset="utf-8"></script>
       <script type="text/javascript" src="${_jsPath}/plugin/uploadify/jquery.uploadify.v2.1.4.min.js?v=${_resVerion}"></script>
		<script type="text/javascript" src="${_jsPath}/plugin/uploadify/swfobject.js?v=${_resVerion}"></script>
		
	</head>
	<body>
		<jsp:include page="../include/headerNew.jsp" flush="true" />
			<!--main-->
			<div class="main">
				
				<!--面包屑-->
				<div class="crumb">
					<!--<a href="" class="fr export"><i></i><input type="button" name="" id="" value="导出"/></a>-->
					<aut:authorize url="/admin/order/order-exportSaleOrders">
						<button class="fr export" id="export"><i></i>
			      				导出
						</button>
					</aut:authorize>
					<p>
						<a href="" class="home"><i></i></a>
						<span class="sep"></span>
						<a href="">物流管理</a>
						<span class="sep"></span>
						<a href="">时效管理</a>
					</p>
				</div>
				
				<!--查询条件-->
				<form class="m-mt10p m-clear" action="${_ctxPath}/admin/order/logistics-listEfficiency.htm" method="get" id="subform">
				<div class="query">
					<div class="line">
						
							
							<div id="seller" class="col">
								
								<span class="sp">下单时间：</span>
                              <input type="text" name="resultPage.params.startTime" value="${resultPage.params.startTime }" class="inputText bgcf9f calendarOne startTime"/>
								<span class="fl">至&nbsp;&nbsp;</span>
							  <input type="text" name="resultPage.params.endTime" value="${resultPage.params.endTime }" class="inputText bgcf9f calendarOne endTime"/>
							  
							  <span class="sp">签收时间：</span>
                              <input type="text" name="resultPage.params.startReceiveTime" value="${resultPage.params.startReceiveTime }" class="inputText bgcf9f calendarOne startReceiveTime"/>
								<span class="fl">至&nbsp;&nbsp;</span>
							  <input type="text" name="resultPage.params.endReceiveTime" value="${resultPage.params.endReceiveTime }" class="inputText bgcf9f calendarOne endReceiveTime"/>
							</div>
						
					</div>

					<div class="line">
						<div class="col">
						<span class="sp">订单号：</span>
								<input type="text" name="resultPage.params.orderNo" id="" value="${resultPage.params.orderNo}" class="inputText"/>	
						
						<span class="sp">整体时效：</span>
							<div class="fl">
								<div class="fl module_Select">
									<select name="resultPage.params.sign" class="trueMenu">
										<option value="0"
											<c:if test="${resultPage.params.sign==null || resultPage.params.sign==0}">
												selected = "selected"
											</c:if>>=</option>
										<option value="1" 
											<c:if test="${resultPage.params.sign==1 }">
												selected = "selected"
											</c:if>>>=</option>
										<option value="2" 
											<c:if test="${resultPage.params.sign==2 }">
												selected = "selected"
											</c:if>><=</option>
										
									</select>
									<div class="newSelectCer"></div>
								</div>
							</div>
							<input type="text" name="resultPage.params.hours" id="" value="${resultPage.params.hours }" class="inputText"/>
						</div>
						
						<input type="hidden" name="resultPage.currentPage" value="0" />
						<input type="hidden" name="exportType" value="efficiency" />
						<input id="searchBtn" class="maageBtn_1" type="button" value="查询" />
					</div>
					</div>
				</form>
				
				<!--查询结果-表格-->
				<div class="tableData">
					<div class="table">
						<table border="1px" bordercolor="#cfd7dd" cellspacing="0px">
							<tr>
								<th width="20%">
									时效管理编号
								</th>
								<th width="15%">快递单号</th>
								<th width="15%">订单号</th>
								<th width="20%">下单时间</th>
								
								<th width="20%">签收时间</th>
								<th width="10%">整体时效h</th>
							</tr>
							<c:forEach items="${resultPage.result}" var="shipper" varStatus="status">
								<tr>
									<td class="c-258" width="20%">
										<span data-cancelId='${shipper.lsNo }' data-orderNo='${shipper.orderNo }' class="getOrderCancelDetail curpointer">${shipper.lsNo }</span>
									</td>
									<td width="15%">${shipper.expressNo}</td>
									<td width="15%"><a href="${_ctxPath}/admin/order/orderMgr-getOrderDetail.htm?orderHead.orderId=${shipper.orderId}">${shipper.orderNo}</a></td>
									<td width="20%"><fmt:formatDate value='${shipper.orderPayTime}' pattern='yyyy-MM-dd HH:mm' /></td>
									
									<td width="20%"><fmt:formatDate value='${shipper.receiveTime}' pattern='yyyy-MM-dd HH:mm' /></td>
									<td width="10%">${shipper.hours}</td>
									
								</tr>
							</c:forEach>
						</table>
					</div>
					
				</div>
				
				<!--分页-->
				<div class="module_page" totNum="${resultPage.total}" >
				?&
				<c:forEach items="${resultPage.params}" var="map">
					resultPage.params.${map.key }=${map.value }&
				</c:forEach>
				   
				</div>
				
			</div>
	</body>
<script type="text/javascript">
	
//查看退款单详情
$(".getOrderCancelDetail").bind("click", function() {
	getOrderCancelDetail($(this));
});
function getOrderCancelDetail(obj){
	var _this= obj;
	var orderCancelId = _this.attr("data-cancelId");
	var orderNo= _this.attr("data-orderNo");
	var _okBtn = "保存";
	var _noBtn = "取消";
	
	var detailDialog = $.dialog({
		    lock: true,
		    title:orderCancelId+"》时效详情",
		    okValue: _okBtn,
	        ok: function(){
	        	var remark=$("#shipper_reason_area").val()+"";	
	        	var reason=$("#shipper_exception_reason option:selected").text()+"";
	        	if(remark=='' && reason==''){
	        		return;
	        	}
	        	if(remark.length>50){
	        		alert("备注不能超过50个字符");
	        		return;
	        	}
	        	$.ajax({
	    			type:'GET',
	    			url: '${_ctxPath}/admin/order/logistics-updateEfficiency.htm',
	    			data:{
	    				'logisticsEfficiency.orderNo':orderNo,
	    				'logisticsEfficiency.remark':remark
	    			},
	    			
	    			//data:{},
	    			success:function(msg){
	    				if(msg.code == "true"){
	        				$.dialog({
	        					lock: true,
	        		            title: false,
	        		            content: msg.info,
	        		            time : 1500
	        		        });
	        				setTimeout(function () { 
	        					location.reload();
	        			    }, 1000);
	        			}
	    			},
	    			error: function(xhr){
	    				showMsgDialog(xhr.responseText);
	    	        }
	    		});
			      
			      
	        },
	        cancelValue:_noBtn,
	        cancel: function(){
	
	        },
		    visible: false
	  });
		 
	  $.ajax({
			type:'POST',
			url: '${_ctxPath}/admin/order/logistics-getEfficiencyDetail.htm',
			data: {'orderNo':orderNo},
			success:function(html){
				detailDialog.visible().content(html);
				$(".popupOuter").ready(function(){
					createModule($(".popupOuter"));
				})
			},
			error: function(xhr){
				showMsgDialog(xhr.responseText);
	        }
		});
	  if(cancelStatus!=1){
			$(".d-button[value=\"保存\"]").hide();
		}
}

$("#searchBtn").bind("click", function() {
	if($(".startTime").val()&&$(".endTime").val()){
		if(compareDate($(".startTime").val(),$(".endTime").val())){
			showMsgDialog("下单时间的开始时间不能大于结束时间！");
			return;
		}
	}
	if($(".startReceiveTime").val()&&$(".endReceiveTime").val()){
		if(compareDate($(".startReceiveTime").val(),$(".endReceiveTime").val())){
			showMsgDialog("签收时间的开始时间不能大于结束时间！");
			return;
		}
	}
	$("#subform").submit();
});
$('#export').bind('click', function() {
	if($.trim($('tbody').html())==''){
		return;
	}
	if($(".startTime").val()&&$(".endTime").val()){
		if(compareDate($(".startTime").val(),$(".endTime").val())){
			showMsgDialog("下单时间的开始时间不能大于结束时间！");
			return;
		}
	}
	if($(".startReceiveTime").val()&&$(".endReceiveTime").val()){
		if(compareDate($(".startReceiveTime").val(),$(".endReceiveTime").val())){
			showMsgDialog("签收时间的开始时间不能大于结束时间！");
			return;
		}
	}

	$('#subform').attr("action","${_ctxPath}/admin/order/logistics-export.htm");
	$('#subform').submit();
	$('#subform').attr("action","${_ctxPath}/admin/order/logistics-listEfficiency.htm");
});
</script>
</html>