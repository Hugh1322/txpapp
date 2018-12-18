<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>订单管理</title>
<link href="${ _cssPath}/pages/orderManagement.css" rel="stylesheet" />
<link href="${_jsPath }/plugin/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" />
<link href="${ _cssPath}/common.css" rel="stylesheet" />
<link href="${_cssPath }/pages/message.css" rel="stylesheet" /> 
<link href="${_jsPath }/plugin/artdialog/skins/ytoxl.css" rel="stylesheet" />

<script src="${_jsPath }/plugin/My97DatePicker/WdatePicker.js"></script>
<script src="${_jsPath }/pages/searchOrderCrms.js" language="javascript"></script>
<script src="${_jsPath }/jquery/jquery.1.8.1.js" language="javascript"></script>
<script src="${_jsPath }/pages/manageModule.js" language="javascript"></script>
<script src="${_jsPath }/plugin/My97DatePicker/WdatePicker.js"></script>
<script src="${_jsPath }/plugin/formvalidator/formValidatorRegex.js" language="javascript"></script>
<script src="${_jsPath }/plugin/formvalidator/formValidator-4.1.3.js" language="javascript"></script>
<script type="text/javascript" src="${_jsPath}/plugin/uploadify/jquery.uploadify.v2.1.4.min.js"></script>
<script type="text/javascript" src="${_jsPath}/plugin/uploadify/swfobject.js"></script>
<style>
.msgContentDiv{border:1px solid #ccc; width:auto; display:none; position:absolute; padding:0 5px;background-color:#FDFFFF;z-index: 999;}
</style>
</head>
<body>
	<jsp:include page="../include/header.jsp" flush="true" />
	<div class="body m-w980p">
		<!--start form-->
		<form class="m-mt10p m-clear" action="${_ctxPath}/admin/order/order-searchOrders4Manager.htm" method="post" id="subform">
            <input type="hidden" name="orderPage.params.adminFlag" value="true" />
            <input type="hidden" id="returnStatus" name="orderPage.params.returnStatus" value="${orderPage.params.returnStatus}" /><%--退货订单状态 --%>
			<input type="hidden" id="waitStatus" name="orderPage.params.waitStatus" value="${orderPage.params.waitStatus}" /><%--待退货订单状态 --%>
            <div  class="m-clear" style="position:relative;">
                <span class="m-fl">
                	<span style="float:left; margin-right:5px;">商家</span>	
                <div  id="seller" class="searchInput" style="float:left; width:130px;margin-right: 15px;">
					<input type="text" name="orderPage.params.sellerName" id="" value="${orderPage.params.sellerName}" class="inputType"/>
					<input type="hidden" name="orderPage.params.sellerId" class="valueId" value="${orderPage.params.sellerId}"/>
					<textarea name="" rows="" cols="" class="textData"></textarea>
					<div><ul></ul></div>
				</div>
<%--                 <select name="orderPage.params.sellerId" class="m-sel">     
                        <option value="">全部商家</option>
                        <c:forEach items="${sellers }" var="seller" varStatus="status">
							<option value="${seller.userId }"
								<c:if test="${orderPage.params.sellerId == seller.userId }"> selected = "selected" </c:if>>
								${seller.companyName}
							</option>
						</c:forEach>
                    </select> --%>
                    <span style="float:left; margin-right:5px;">品牌</span>	
                <div  id="brand" class="searchInput" style="float:left; width:130px;margin-right: 15px;">
					<input type="text" name="orderPage.params.brandName" id="" value="${orderPage.params.brandName}" class="inputType"/>
					<input type="hidden" name="orderPage.params.brandId" class="valueId" value="${orderPage.params.brandId}"/>
					<textarea name="" rows="" cols="" class="textData"></textarea>
					<div><ul></ul></div>
				</div>
                   <%--  <select name="orderPage.params.brandId" class="m-sel">
                        <option value="">全部品牌</option>
                        <c:forEach items="${brands }" var="brand">
							<option value="${brand.brandId }" <c:if test="${orderPage.params.brandId==brand.brandId }"> selected = "selected" </c:if>>
									${brand.name}
							</option>
						</c:forEach>
                    </select> --%>
					<select name="orderPage.params.payType" class="m-sel">
						<option value="">全部支付方式</option>
						<c:forEach items="${payList }" var="pay">
							<option value="${pay }"
								<c:if test="${orderPage.params.payType==pay }">
									selected = "selected"
								</c:if>
								><spring:message code="order.payment.type.${pay}"/></option>
						</c:forEach>
					</select>
					
					<select name="orderPage.params.timeType" class="m-sel">
						<c:forEach items="${timeList }" var="time">
							<option value="${time }"
							<c:if test="${orderPage.params.timeType==time }">
									selected = "selected"
								</c:if>
								><spring:message code="order.timement.type.${time}"/></option>
						</c:forEach>
					</select>
                    <input id="beginTime" name="orderPage.params.beginTime" value="${orderPage.params.beginTime}" class="Wdate" type="text" readOnly="readOnly" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
                    <label>至 </label>
                    <input id="endTime" name="orderPage.params.endTime" value="${orderPage.params.endTime }" class="Wdate" type="text" readOnly="readOnly" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
                    <select name="orderPage.params.orderType" class="m-sel">
							<option value=""
								<c:if test="${orderPage.params.orderType=='' || orderPage.params.orderType==null}">
									selected = "selected"
								</c:if>>全部订单</option>
							<option value="1" 
								<c:if test="${orderPage.params.orderType==1 }">
									selected = "selected"
								</c:if>>普通订单</option>
							<option value="4"
								<c:if test="${orderPage.params.orderType==4 }">
									selected = "selected"
								</c:if>>团购订单</option>
							<option value="3"
								<c:if test="${orderPage.params.orderType==3 }">
									selected = "selected"
								</c:if>>抢购订单</option>
							<option value="6"
								<c:if test="${orderPage.params.orderType==6 }">
									selected = "selected"
								</c:if>>兑换订单</option>
					</select>
         			
                    
                    <c:if test="${not empty orderPage.params.orderId}">
		                   <aut:authorize url="/admin/order/order-search">
		     				<input type="button" class="m-btn m-btn-search" value="查 询" id="search" /> 
						</aut:authorize>
					</c:if> 
                </span>

                <c:if test="${not empty orderPage.result}">
                    <span class="m-fr curr-num" style="position:absolute; right:-10px; top:135px; width:175px;">
                        <label>当前显示： </label>
                        <yp:commPageSize page="${orderPage}" beanName="orderPage"></yp:commPageSize>
                    </span>
                </c:if>
            </div>
     		<div class="m-search" style="margin-top:40px;">
	     		<c:if test="${empty orderPage.params.orderId}">	
	     			订单金额<input type="text"  class="txt-input input-marks" name="orderPage.params.paymentAmount" value="${orderPage.params.paymentAmount}" />	     			
	     			<input type="text" class="J-keywords txt-input input-marks" data-default="输入收货人、订单号" name="orderPage.params.keywords" value="${orderPage.params.keywords }" />
	     			<input type="text" class="J-keywords2 txt-input input-marks" data-default="输入交易号" name="orderPage.params.dealCode" value="${orderPage.params.dealCode}" />
	     			<input type="text" class="J-keywords_packageNo txt-input input-marks" data-default="输入包裹号" name="orderPage.params.packageNo" value="${orderPage.params.packageNo}" />
	     			<aut:authorize url="/admin/order/order-search">
	     				<input type="button" class="m-btn m-btn-search" value="查 询" id="search" /> 
					</aut:authorize>
					<input type="hidden" id="status" name="orderPage.params.status" value="${orderPage.params.status}" /> 
					
		      		<aut:authorize url="/admin/order/order-exportOrders">
		      			<input type="button" class="m-btn" value="导出" id="export" />
		      		</aut:authorize>	
		      	</c:if> 
     		</div>
		</form>
		<div style="position: absolute;top: 150px;width: 600px;">温馨提示：所有货到付款方式订单，录入金刚系统时候代收金额填写“<font color="red">订单总金额</font>”。</div>
		
		<div class="body-nav subnav m-mt10p" id="status_con">
			<c:if test="${empty orderPage.params.orderId}">	
				<ul class="m-clear">
					<li>
						<a
							<c:if test="${orderPage.params.status==null || orderPage.params.status=='' }"> class="current-chose"</c:if>>
							 全部订单
						</a>
					</li>
					
					<c:forEach items="${statuses }" var="statuse" varStatus="status">
						<c:if test="${statuse < 6}">
							<li value="${statuse}">
							<a
								<c:if test="${orderPage.params.status==status.index+1 }"> class="current-chose" </c:if>>
									<spring:message code="order.status.${status.index+1}" /> 
							</a>
							</li>
						</c:if>
						<!-- 部分退货 和 全部退货  显示退货 -->
						<c:if test="${statuse == 6}">	
							<li value="${statuse}">
								<a 
									<c:if test="${orderPage.params.status==status.index+1 }"> class="current-chose" </c:if>>
									退货 
								</a>
							</li>
						</c:if>
					</c:forEach>
				</ul>
			</c:if>
		</div>
		<%--当选择查询状态是待发货时 --%>
		<c:if test="${orderPage.params.status == orderStatusWaitSend}">	
			<div class="child-menu"><%--1=退款审核中，2=退款未通过，3=审核通过，4=已退款 --%>
				<ul>
					<c:forEach items="${cancelStatuses}" var="wait" varStatus="status">
						<li 
							<c:if test="${status.index==0 && (orderPage.params.waitStatus==''||orderPage.params.waitStatus==0)}"> class="on" </c:if>
							<c:if test="${status.index!=0 && orderPage.params.waitStatus!=null && orderPage.params.waitStatus==status.index }"> class="on" </c:if> 
							>
							<a class="waitStatus" id="${wait}">
								<spring:message code="order.wait.status.${status.index}" /> 
							</a>
						</li>
					</c:forEach>
				</ul>
			</div>
		</c:if>
		
		<%--当选择查询状态是退货时 --%>
		<c:if test="${orderPage.params.status == orderStatusReturn}">	
			<div class="child-menu"><%--1=未审核，2=审核通过，3=审核不通过，4=已到货 --%>
				<ul>
					<c:forEach items="${itemStatuses}" var="statuse" varStatus="status">
						<li 
							<c:if test="${status.index==0 && (orderPage.params.returnStatus==''||orderPage.params.returnStatus==0)}"> class="on" </c:if>
							<c:if test="${status.index!=0 && orderPage.params.returnStatus==status.index }"> class="on" </c:if> >
							<a class="returnStatus" id="${statuse}">
								<spring:message code="order.refund.status.${status.index}" /> 
							</a><%--1=未审核，2=审核通过，3=审核不通过，4=已到货 --%>
						</li>		
					</c:forEach>
				</ul>
			</div>
		</c:if>
		
		<!--start 下单管理table-->
		<div class="order-management">
			<table id="order-tab" width="100%">
				<thead class="tab-control">
					<tr>
						<th width="11%">订单编号</th>
						<th width="10%">交易号</th>
						<th width="3%">包裹号</th>
						<th width="10%">下单时间</th>
						<th width="10%">总金额</th>
						<th width="9%">支付方式</th>
						<th width="10%">支付状态</th>
						<th width="10%">订单状态</th>
						<th width="7%">物流状态</th>
						<th width="9%">订单来源</th>
						<th width="8%">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${orderPage.result}" var="order" varStatus="status">
						<tr class="list-tr">
							<td colspan="11" class="td-nobor">
								<table class="tab-control">
									<tr class="tr-height" <c:if test="${order.haveOrderCrm}">style="background-color:#99CCFF;"</c:if>>
										<td class="num-icon" width="11%">
											<input type="hidden" value="${order.orderId}" id='orderId' />
											<input type="hidden" value="${order.orderNo}" id='orderNo' />
											<input type ="hidden" value="" id="orderReturnId"/>
											<i></i><label><a onmouseout="hideMessage('${order.orderId}');" onmouseover="showMessage('${order.orderId}');">${order.orderNo}</a></label>
											<div class="msgContentDiv" id="msgContentDiv${order.orderId}"></div>
										</td>
										<td width="10%">${order.orderDeal.dealCode }</td>
										<td width="3%">${order.packageNo}</td>
										<td width="12%"><fmt:formatDate value='${order.createTime}' pattern='yyyy-MM-dd HH:mm:ss' /></td>
										<td width="10%">${order.paymentAmount }</td>
										<td width="12%">
											<c:if test="${order.payType !=null && order.payType !=''}">
												<c:if test="${order.payType eq 1}">
													<c:choose>
														<c:when test="${order.gateWayId !=null && order.gateWayId !=''}">
															<spring:message code="order.payment.type.${order.gateWayId}"/>
														</c:when>
														<c:otherwise>
															<spring:message code="order.payment.type.${order.payType}"/>
														</c:otherwise>
													</c:choose>
												</c:if>
												<c:if test="${order.payType eq 2}">
													<spring:message code="order.payment.type.${order.payType}"/>
												</c:if>
											</c:if>
										</td>
										
										<td width="10%">
											<c:if test="${order.payStatus ==null}">
												未付款
											</c:if> 
											<c:if test="${order.payStatus !=null}">
												<spring:message code="order.payment.status.${order.payStatus }" />
											</c:if>
										</td>
										<td width="10%">
											<c:if test="${empty order.refundStatus || orderPage.params.status != orderStatusReturn}">
												<spring:message code="order.status.${order.status }" />
												<c:if test="${not empty order.orderCancel.status && orderPage.params.status == orderStatusWaitSend}">
													(<spring:message code="order.wait.status.${order.orderCancel.status }" />)
												</c:if>
											</c:if>
											<c:if test="${not empty order.refundStatus && orderPage.params.status == orderStatusReturn}">
												<spring:message code="order.refund.status.${order.refundStatus}" />
											</c:if> 
										</td>
										<td width="7%">
											<c:if test="${not empty order.logisticStatus}">
												<spring:message code="order.logistics.status.${order.logisticStatus }" />
											</c:if>
											<c:if test="${ empty order.logisticStatus}">
												未接单
											</c:if>
										</td>
										<td width="9%">
											<c:if test="${order.orderType !=null && order.orderType !=''}">
												<spring:message code="order.source.${order.orderType }" />
											</c:if>
										</td>
										<td width="8%">
            								<a href="${_ctxPath}/admin/order/order-printInvoice.htm?orderHead.orderId=${order.orderId}" class="blue" target="_blank">发货单打印</a><br/>
            								<c:if test="${order.status == 2}">
												<c:if test="${order.orderCancel.status == null}">
													<a href="javascript:cancelOrder('${order.orderId}');" class="blue">取消订单</a>
												</c:if>
											</c:if>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		
		<div class="table-bm-wrap cf">
			<div class="fn-right">
				<div class="pagination pagination-right">
					<c:if test="${not empty orderPage.result}">
						<yp:commPage page="${orderPage}" beanName="orderPage"></yp:commPage>
					</c:if>
				</div>
			</div>
		</div>
	</div>
	
	<jsp:include page="/WEB-INF/pages/include/foot.jsp"></jsp:include>
</body>

<script type="text/javascript">
	$("#seller input").on('input',function(){
	var initial = $(this).val();
	$.ajax({
		type : 'POST',
		url : '${_ctxPath}/admin/order/order-getSellersByInitial.htm',
		data : {
			"initial" : initial
		},
		success : function(json) {
			if(json.code){
				var data = eval(json.info);
				var str = "";
				for(var o in data){  
					str = str + data[o].sellerName + "_" + data[o].userId + ",";
			    }
				if(str.length > 0){
					str = str.substr(0,str.length - 1);
				}
				$("#seller textarea").html(str).ready(function(){
					$("#seller").trigger("change");
				});
			}
		},
		error:function(){
			alert("查询失败 ");
		}
	});
	});
	
	
	$("#brand input").on('input',function(){
		var initial = $(this).val();
		$.ajax({
			type : 'POST',
			url : '${_ctxPath}/admin/order/order-getBrandsByInitial.htm',
			data : {
				"initial" : initial
			},
			success : function(json) {
				if(json.code){
					var data = eval(json.info);
					var str = "";
					for(var o in data){  
						str = str + data[o].name + "_" + data[o].brandId + ",";
				    }
					if(str.length > 0){
						str = str.substr(0,str.length - 1);
					}
					$("#brand textarea").html(str).ready(function(){
						$("#brand").trigger("change");
					});
				}
			},
			error:function(){
				alert("查询失败 ");
			}
		});
		});
	
	$(document).ready(function() {
		$("#search").bind("click", function() {
			var keywords = $(".J-keywords").val();
			if(keywords == $(".J-keywords").attr("data-default")){
				$(".J-keywords").val("");
			}
			
			var keywords2 = $(".J-keywords2").val();
			if(keywords2 == $(".J-keywords2").attr("data-default")){
				$(".J-keywords2").val("");
			}
			
			var keywords_packageNo = $(".J-keywords_packageNo").val();
			if(keywords_packageNo == $(".J-keywords_packageNo").attr("data-default")){
				$(".J-keywords_packageNo").val("");
			}
			if($("#beginTime").val() && $("#endTime").val()){
				if(compareDate($("#beginTime").val(),$("#endTime").val())){
					alert("开始时间不能大于结束时间！");
					return;
				}
			}
			$("#subform").submit();
		});
		
		$(".returnStatus").bind("click",function(){
			$("#returnStatus").val($(this).attr("id"));
			$("#search").click();
		});
		
		$(".waitStatus").bind("click",function(){
			$("#waitStatus").val($(this).attr("id"));
			$("#search").click();
		});
		
		$("#status_con li").bind("click", function() {
			if ($(this).val() == 0) {
				$("#status").val("");
			} else {
				$("#status").val($(this).val());
			}
			$("#returnStatus").val("");
			$("#waitStatus").val("");
			$("#search").click();
		});
		
		$("#export").bind("click", function() {
			if($("tbody").html().trim()==""){
				return;
			}
			var keywords = $(".J-keywords").val();
			if(keywords == $(".J-keywords").attr("data-default")){
				$(".J-keywords").val("");
			}
			$("#subform").attr("action","${_ctxPath}/admin/order/order-exportOrders.htm");
			$("#subform").submit();
			$("#subform").attr("action","${_ctxPath}/admin/order/order-searchOrders4Manager.htm");
		});
		
		//防止在一次请求 多次点击
		var isPost = true;
	 	$(".tr-height").on("click", function() {
			$this = $(this);
			var orderId = $this.find('#orderId').val();
			var orderReturnId = $this.find('#orderReturnId').val();
			var returnStatus = $('#returnStatus').val();<%--当前选中的退货订单状态--%>
			var status = $('#status').val();<%--当前选中的订单状态--%>
			if (!$(this).next(".show-tr")[0]) {
				if(isPost){
					isPost =false;
					$.ajax({
						type : 'POST',
						url : '${_ctxPath}/admin/order/order-getOrder4Manager.htm',
						data : {
							"orderHead.orderId" : orderId,
							"orderPage.params.orderReturnId":orderReturnId,
							"orderPage.params.returnStatus":returnStatus,
							"orderPage.params.status":status,
							"orderPage.params.orderId":orderId
						},
						success : function(html) {
							var content;
							if (typeof html == "object") {
								data = eval(html);
								content = data.info;
							} else {
								content = html;
							}
							$($this).after($(content));
							$this.addClass("change");
							$this.click();
							isPost = true;
						},
						error:function(){
							isPost = true;
						}
					});
				}
			}
		}); 
	 	
	 	//订单内包裹切换
	    $('.order-ul li').live('click',function(){
	    	var _this = $(this),
	    		_idx = _this.attr("id");
	    	$('.order-ul li').removeClass('cur');
	    	_this.addClass('cur');
	    	
	    	$('.package').eq(_idx).show().siblings().hide();
	    })
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
			if(sdate > edate) {      
			    return true;         
			}else{   
			    return false;      
		    }   
	    }      
	}    

	//待发货-同意退款
	function confirmCancelPayment(orderCancelId,paymentAmount){
		var money = $("#money_"+orderCancelId).val();
		if(!money){
			alert("请输入退款金额！");
			return;
		}
		if(!/^(?!0\d)\d+(\.\d{0,3})?$/.test(money)){
			alert("请输入正确的金额数字，最多可以有3为小数！");
			return;
		}
		money = parseFloat(money);
		if(money<=0 || money > paymentAmount){
			alert("退款金额不正确！");
			return;
		}
		
		$.ajax({
			type:'post',
			data:{
				'orderCancel.orderCancelId':orderCancelId,
				'orderCancel.refundAmount':money
			},
			url:'${_ctxPath}/admin/order/order-agreePayment.htm',
			success:function(data){
				if(data.code=='true'){
					$("#agreePaymentlabel_"+orderCancelId).html("已完成");
					$("#cancelStatusL_"+orderCancelId).html("已完成");
				}else{
					if(undefined != data.info){
						alert(data.info);
					}
				}
			},
			error:function(data){
			},
			oncomplete:function(data){
			}
		});
	}
	
	//同意退款
	function confirmPayment(orderRefundPaymentId,orderRefundId,payType,payId){
		$.ajax({
			type:'post',
			data:{
				'orderRefundPayment.orderRefundPaymentId':orderRefundPaymentId,
				'orderRefundPayment.ordeRrefundId':orderRefundId
			},
			url:'${_ctxPath}/admin/order/order-confirmPayment.htm',
			success:function(data){
				if(data.code=='true'){
					$id = $("#confirmPayment"+orderRefundPaymentId);
					var $a = $id.closest(".show-tr").prev("tr").find(".c-blue");
					$id.parent().append("已完成");
					$id.remove();
					//移除"退款"操作
					if($(".confirmPayment").length == 0){
						$a.remove();	
					}
					
					$id = $("#refundStatusL"+orderRefundId);
					$id.html("已完成");
				}else{
					if(undefined != data.info){
						alert(data.info);
					}
				}
			},
			error:function(data){
			},
			oncomplete:function(data){
			}
		});
	}
		//农行直连支付--同意退款
		function confirmPayment4AgriculturalBank(orderRefundPaymentId,orderRefundId,payType,payId){
			//refundMoney_
			var refundAmount = $("#refundMoney_"+orderRefundPaymentId).val();
			if(!refundAmount){
				$.dialog({
			        title: true,
			        content:"请输入退款金额！",
			        lock:true
			    });
				return;
			}
			if(!checkPrice(refundAmount)){
				$.dialog({
			        title: true,
			        content:"退款金额输入格式不正确！",
			        lock:true
			    });
				return;
			}
			//return;
			$.ajax({
				type:'post',
				data:{
					'orderRefundPayment.orderRefundPaymentId':orderRefundPaymentId,
					'orderRefundPayment.ordeRrefundId':orderRefundId,
					'orderRefundPayment.refundAmount':refundAmount
				},
				url:'${_ctxPath}/admin/order/order-confirmPayment4AgriculturalBank.htm',
				success:function(data){
					if(data.code=='true'){
						//清除退款金额输入框
						$("#confirmPaymentArea"+orderRefundPaymentId).empty();
						$("#confirmPaymentArea"+orderRefundPaymentId).html("成功退款："+refundAmount+"元");
						$id = $("#confirmPayment"+orderRefundPaymentId);
						var $a = $id.closest(".show-tr").prev("tr").find(".c-blue");
						$id.parent().append("已完成");
						$id.remove();
						//移除"退款"操作
						if($(".confirmPayment").length == 0){
							$a.remove();	
						}
						$id = $("#refundStatusL"+orderRefundId);
						$id.html("已完成");
					}else{
						if(undefined != data.info){
							alert(data.info);
						}
					}
				},
				error:function(data){
				},
				oncomplete:function(data){
				}
			});
		}
		
		function checkPrice(price){
			  return (/^(([1-9]\d*)|\d)(\.\d{1,2})?$/).test(price.toString());
		}
		//显示客服评价
		function showMessage(orderId)
		{
			$.ajax({
				url:_ctxPath + "/admin/orderCrm/orderCrm-ajaxGetLastOrderCrm.htm",
				type:"POST",
				data:{'orderId':orderId},
				dataType:"html",
				async: false,
				success:function(data){
					if(data!=null && data.length>0)
					{  
					    $("#msgContentDiv"+orderId).html(data);
					    $("#msgContentDiv"+orderId).show();
					    /* $("#msgContentDiv").attr("display","block"); */
					}
				},
				error:function(data){
				}
			});
		}
		//隐藏客服评价
		function hideMessage(orderId)
		{
			$("#msgContentDiv"+orderId).hide();
			/* $("#msgContentDiv").attr("display","none"); */
		}
		

		//货到付款订单 待发货状态---管理员取消订单操作
		function cancelOrder(orderId){
			
			var dialog = $.dialog({
			    lock: true,
			    title:false,
			    okValue: "确认",
		        ok: function(){
					var cc = $("#productSkuForm").serializeArray();
		        	$.ajax({
						type:'POST',
						url: _ctxPath + '/admin/order/order-saveCancelOrder.htm',
						data: $("#cancelReasonForm").serialize(),
						success:function(msg){
							if(msg.code == "true"){
								$.dialog({
						            title: false,
						            content: msg.info,
						            time : 2000
						        });
						        $('#search').click();
							}else{
								$.dialog({
						            title: false,
						            content: msg.info,
						            time : 2000
						        });
							}
						}
					});
		        },
			    cancelValue:"取消",
			    cancel: function(){
			    },
			    visible: false
		  });
		  
		  $.ajax({
				type:'POST',
				url: _ctxPath + '/admin/order/order-goCancelOrder.htm',
				data: "orderHead.orderId=" + orderId,
				success:function(html){
					dialog.visible().content(html);
				},
				error: function(xhr){
					popupDialog(xhr.responseText);
		        }
					});
				  $(".d-close").hide();
		}
		
</script>

</html>