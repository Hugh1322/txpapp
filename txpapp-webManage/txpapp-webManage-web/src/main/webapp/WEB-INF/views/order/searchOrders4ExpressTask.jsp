<!DOCTYPE html>
<%@page language="java"
	import="com.ytoxl.module.yipin.base.dataobject.Product"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>
<%@page import="com.ytoxl.module.yipin.order.dataobject.OrderHead"%>
<%@page import="com.ytoxl.module.yipin.order.enums.PushErrorType"%>
<c:set var="pay_type_zhifubao" value="<%=OrderHead.PAY_TPYE_1 %>" />
<c:set var="pay_type_cod" value="<%=OrderHead.PAY_TPYE_2 %>" />
<html lang="zh">
<head>
<meta charset="utf-8" />
<title>异常订单列表</title>
<link href="${_cssPath }/common.css" rel="stylesheet" />
<link href="${_jsPath }/plugin/My97DatePicker/skin/WdatePicker.css"
	rel="stylesheet" />
<script type="text/javascript" src="${_jsPath }/jquery/jquery.1.8.1.js"></script>
<script src="${_jsPath }/plugin/My97DatePicker/WdatePicker.js"></script>
<script src="${_jsPath }/plugin/formvalidator/formValidatorRegex.js"
	language="javascript"></script>
<script src="${_jsPath }/plugin/formvalidator/formValidator-4.1.3.js"
	language="javascript"></script>
<script type="text/javascript">
    
    </script>
<body>
	<!--start header-->
	<jsp:include page="../include/header.jsp"></jsp:include>
	<!--end header-->
	<!--start body-->
	<div class="body m-w980p">
		<!--start form-->
		<form class="m-mt10p m-clear"
			action="${_ctxPath}/admin/order/order-myExpressOrder.htm"
			method="post" id="subform">
			<div class="m-clear">
				<div>
					<select name="expressnoPushTaskPage.params.failureType"
						class="m-sel">
						<option value="">全部异常类型</option>
						<option value="CREATE_ERROR"
							<c:if test="${expressnoPushTaskPage.params.failureType=='CREATE_ERROR' }"> selected = "selected" </c:if>>创建COD订单失败
						</option>
						<option value="SIGN_ERROR"
							<c:if test="${expressnoPushTaskPage.params.failureType=='SIGN_ERROR' }"> selected = "selected" </c:if>>签收COD订单失败
						</option>
						<option value="UNKNOW"
							<c:if test="${expressnoPushTaskPage.params.failureType=='UNKNOW' }"> selected = "selected" </c:if>>未知异常类型
						</option>
					</select> <input type="radio"
						name="expressnoPushTaskPage.params.handingResult" value=""
						<c:if test="${expressnoPushTaskPage.params.handingResult==null || expressnoPushTaskPage.params.handingResult=='' }"> checked="checked" </c:if> />全部处理状态(${expressTaskTotalNo})
					<input style="margin-left: 10px;" type="radio"
						name="expressnoPushTaskPage.params.handingResult" value="0"
						<c:if test="${expressnoPushTaskPage.params.handingResult==0 }"> checked="checked" </c:if> /><span style="color: red;">未处理(${expressTaskTotalNo - expressTaskDealNo})</span>
					<input style="margin-left: 10px;" type="radio"
						name="expressnoPushTaskPage.params.handingResult" value="1"
						<c:if test="${expressnoPushTaskPage.params.handingResult==1 }"> checked="checked" </c:if> /><span style="color: green;">已处理(${expressTaskDealNo})</span>
				</div>
				<span class="m-fl" style="margin-top: 10px;"> <select
					name="expressnoPushTaskPage.params.selectTimeType" class="m-sel">
						<option value="e.failure_time" <c:if test="${expressnoPushTaskPage.params.selectTimeType=='e.failure_time' }"> selected = "selected" </c:if>>异常时间</option>
						<option value="o.createTime" <c:if test="${expressnoPushTaskPage.params.selectTimeType=='o.createTime' }"> selected = "selected" </c:if>>下单时间</option>
						<option value="e.handing_time" <c:if test="${expressnoPushTaskPage.params.selectTimeType=='e.handing_time' }"> selected = "selected" </c:if>>处理时间</option>
				</select> <label>日期：</label> <input id="beginTime"
					name="expressnoPushTaskPage.params.beginTime"
					value="${expressnoPushTaskPage.params.beginTime}" class="Wdate"
					type="text" readOnly="readOnly"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" /> <label>至 </label>
					<input id="endTime" name="expressnoPushTaskPage.params.endTime"
					value="${expressnoPushTaskPage.params.endTime }" class="Wdate"
					type="text" readOnly="readOnly"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{\'%y-%M-%d\'}'})" /> </span>

				<c:if test="${not empty expressnoPushTaskPage.result}">
					<span class="m-fr curr-num"> <label>当前显示： </label> <yp:commPageSize
							page="${expressnoPushTaskPage}" beanName="expressnoPushTaskPage"></yp:commPageSize>
					</span>
				</c:if>
			</div>
			<div class="m-search" style="margin-top: 10px;">
				<aut:authorize url="/admin/order/order-search">
					<input type="button" class="m-btn m-btn-search" value="查 询"
						id="search" />
				</aut:authorize>
				<input type="hidden" id="status"
					name="expressnoPushTaskPage.params.status"
					value="${orderPage.params.status}" />

				<aut:authorize url="/admin/order/order-exportOrders">
					<input type="button" class="m-btn" value="导出" id="export" />
				</aut:authorize>
			</div>
		</form>
		<!--start 品牌管理table-->
		<div class="m-mt10p">
			<table class="tab-control">
				<thead>
					<tr>
						<th width="10%">处理状态</th>
						<th width="9%">异常类型</th>
						<th width="9%">异常原因</th>
						<th width="8%">订单号</th>
						<th width="8%">物流单号</th>
						<th width="8%">下单时间</th>
						<th width="7%">订单类型</th>
						<th width="7%">支付方式</th>
						<th width="7%">支付状态</th>
						<th width="10%">异常记录时间</th>
						<th width="9%">处理结果</th>
						<th width="8%">处理时间</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty expressnoPushTaskPage.result}">
							<tr>
								<td colspan="12">无相关数据！</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach items="${expressnoPushTaskPage.result}" var="task"
								varStatus="status">
								<tr class="list-tr">
									<td><c:if test="${task.handingResult == 1}">
									已处理
								</c:if> <c:if test="${task.handingResult != 1}">
									未处理<br>
											<a class="addSale-btn" type="${task.id}" style="color: blue;">标记为已处理</a>
										</c:if></td>
									<td>${task.failureTypeName}
									</td>
									<td>${task.failureReasonName}</td>
									<td>${task.order.orderNo}</td>
									<td>${task.expressNumber}</td>
									<td><fmt:formatDate value='${task.order.createTime}'
											pattern='yyyy-MM-dd HH:mm:ss' />
									</td>
									<td>
										<c:if test="${task.order.orderType !=null && task.order.orderType !=''}">
											<spring:message code="order.source.${task.order.orderType }" />
										</c:if></td>
									<td><c:if
											test="${task.order.payType == pay_type_zhifubao}">
										在线支付
									</c:if> <c:if test="${task.order.payType == pay_type_cod}">
										货到付款
									</c:if></td>
									<td>
											<c:if test="${task.order.payStatus ==null}">
												未付款
											</c:if> 
											<c:if test="${task.order.payStatus !=null}">
												<spring:message code="order.payment.status.${task.order.payStatus }" />
											</c:if>
									</td>
									<td><fmt:formatDate value='${task.createTime}'
											pattern='yyyy-MM-dd HH:mm:ss' />
									</td>
									<td>${task.resultDesc}</td>
									<td><fmt:formatDate value='${task.handingTime}'
											pattern='yyyy-MM-dd HH:mm:ss' />
									</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
		<!--end 品牌管理table-->
		<div class="table-bm-wrap cf">
			<div class="fn-right">
				<div class="pagination pagination-right">
					<c:if test="${not empty expressnoPushTaskPage.result}">
						<yp:commPage page="${expressnoPushTaskPage}" beanName="expressnoPushTaskPage"></yp:commPage>
					</c:if>
				</div>
			</div>
		</div>
	</div>


	<div class="add-seo-info">
		<form method="post" id="form1" name="form1"
			action="${_ctxPath}/admin/order/order-updateExpressOrder.htm">
			<input id="taskId" name="expressnoPushTaskModel.id"
				style="display: none;" /> <input
				name="expressnoPushTaskModel.handingResult" value="1"
				style="display: none;" />
			<table>
				<tr>
					<td width="40px" align="right">描述：</td>
					<td><textarea class="input-text"
							style="width: 380px; height: 80px;color:#999;"
							name="expressnoPushTaskModel.resultDesc" id="description" data-default="请输入1-100个字处理结果"></textarea>
					</td>
				</tr>
				<tr>
					<td></td>
					<td><div class="position">
							<span id="descriptionTips"></span>
						</div></td>
				</tr>
			</table>
		</form>
	</div>
	<form action="${_ctxPath}/admin/order/order-exportExpressOrder.htm"
		id="exportFrom" method="post"></form>
	<!--end body-->
</body>
<jsp:include page="/WEB-INF/pages/include/foot.jsp"></jsp:include>
<script type="text/javascript">
	$(document).ready(function() {
		$(".add-seo-info").hide();
		$("#search").bind("click", function() {
			if($("#beginTime").val() && $("#endTime").val()){
				if(compareDate($("#beginTime").val(),$("#endTime").val())){
					return;
				}
			}
			$("#subform").submit();
		});
		
		//
		$("#description").input();
		$("#export").bind("click", function() {
			 if($("tbody").html().trim()==""){
				    alert("没有相关记录，不能导出！");
					return;
			 }
			 //$("#exportFrom").submit();
			 $("#subform").attr('action','${_ctxPath}/admin/order/order-exportExpressOrder.htm');
		     $("#subform").submit();
		     $("#subform").attr('action','${_ctxPath}/admin/order/order-myExpressOrder.htm');
		});
		
		
	});
	
	//比较日前大小  如果开始大于结束，返回true
	function compareDate(checkStartDate, checkEndDate) {      
	    var arys1= new Array();      
	    var arys2= new Array();      
		if(checkStartDate != null && checkEndDate != null) {      
		    arys1=checkStartDate.split('-');      
		    var sdate=new Date(arys1[0],parseInt(arys1[1]-1),arys1[2]);      
		    arys2=checkEndDate.split('-');      
		    var edate=new Date(arys2[0],parseInt(arys2[1]-1),arys2[2]);    
		    var add3month = new Date(arys1[0],parseInt(arys1[1]-1)+3,arys1[2]);  
			if(sdate > edate) { 
				alert("开始时间不能大于结束时间！");
			    return true;         
			}else if(add3month<edate){
				alert("起止时间前后选择不超3个自然月！");
				return true;
			}else{   
			    return false;      
		    }   
	    }      
	}    

	//验证
	$.formValidator.initConfig({
	  validatorGroup: '100001',
	  formID: 'form1',
	  errorFocus:false, //错误时不聚焦到第一个控件
	  theme: 'Default'
	});
	
	$("#description").formValidator({
		validatorGroup: '100001',
	  onShow:"请输入1-100个字处理结果",
	  onFocus:"请输入1-100个字处理结果",
	  onCorrect:"",
	  tipID:'descriptionTips'
	}).inputValidator({
		min:1,
		max:200,
		empty:{leftEmpty:false,rightEmpty:false,emptyError:"两边不能有空格"},
	  onError:"请输入1-100个字处理结果"
	});
	
	//弹层 添加
	$('.addSale-btn').on("click", function () {
		 var html = $(".add-seo-info").get([0]);
		 var taskId = $(this).attr('type');
		 $("#taskId").val(taskId);
	 $.dialog({
		    lock: true,
		    padding: "10px",
		    title:"处理结果",
		    content:html,
		    fixed: true,
		    cancel: true,
		    cancelValue:"取  消",
		    ok:function(){
		    	if($("#description").val() == "请输入1-100个字处理结果"){
		    		$("#description").val('');
		    	}
		    	var result = $.formValidator.pageIsValid('100001');
		    	if(result){
		    		$('#form1').submit();
		    		return true;
		    	}else{
		    		$("#description").val('请输入1-100个字处理结果');
		    		return false;
		    	}
		    },
		    cancel:function(){
		    	 window.location.reload();
		    },
		    okValue:"保  存"
	  });
	});
	
	
</script>

</html>