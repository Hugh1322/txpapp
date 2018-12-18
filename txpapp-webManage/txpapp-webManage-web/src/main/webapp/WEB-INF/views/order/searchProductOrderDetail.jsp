<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>产品订单列表</title>
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
</head>
<body>
	<jsp:include page="../include/header.jsp" flush="true" />
	<div class="body m-w980p">
		<!--start form-->
		<form class="m-mt10p m-clear" action="${_ctxPath}/admin/order/order-searchProductOrderDetail.htm" method="post" id="subform">
       
            <div  class="m-clear">
                <span class="m-fl">
                	订单结算状态：
                    <select name="orderPage.params.cashStatus" >
						<option value="${orderCashStatus[0]}" <c:if test="${orderCashStatus[0] eq orderPage.params.cashStatus}">selected = "selected"</c:if>>请选择</option>
						<option value="${orderCashStatus[1]}" <c:if test="${orderCashStatus[1] eq orderPage.params.cashStatus}">selected = "selected"</c:if>>待结算</option>
						<option value="${orderCashStatus[2]}" <c:if test="${orderCashStatus[2] eq orderPage.params.cashStatus}">selected = "selected"</c:if>>已结算</option>
					</select>
					
					<input type="text" class="J-keywords txt-input input-marks" data-default="输入收货人、订单号" name="orderPage.params.keywords" value="${orderPage.params.keywords }" />
	      			
	      			<aut:authorize url="/admin/order/order-search">
	      				<input type="button" class="m-btn m-btn-search" value="查 询" id="search" /> 
					</aut:authorize>
		      		<aut:authorize url="/admin/order/order-exportManagerCashOrders">
		      			<input type="button" class="m-btn" value="导出" id="export" />
		      		</aut:authorize>
                </span>

                <c:if test="${not empty orderPage.result}">
                    <span class="m-fr curr-num">
                        <label>当前显示： </label>
                        <yp:commPageSize page="${orderPage}" beanName="orderPage"></yp:commPageSize>
                    </span>
                </c:if>
            </div>
		</form>
		
		<!--start 下单管理table-->
		<div class="order-management">
			<table id="order-tab" width="100%">
				<thead class="tab-control">
					<tr>
						<th width="13%">订单编号</th>
						<th width="13%">下单时间</th>
						<th width="10%">总金额</th>
						<th width="8%">支付方式</th>
						<th width="10%">支付状态</th>
						<th width="10%">订单状态</th>
						<th width="13%">订单来源</th>
						<th width="10%">订单结算状态</th>
						<th width="13%">结算完成时间</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${orderPage.result}" var="order" varStatus="status">
						<tr class="list-tr">
							<td colspan="10" class="td-nobor">
								<table class="tab-control">
									<tr class="tr-height">
										<td class="num-icon" width="13%">
											<input type="hidden" value="${order.orderId}" id='orderId' />
											<input type="hidden" value="${order.orderNo}" id='orderNo' />
											<input type ="hidden" value="" id="orderReturnId"/>
											<i></i><label><a>${order.orderNo}</a></label>
										</td>
										<td width="13%"><fmt:formatDate value='${order.createTime}' pattern='yyyy-MM-dd HH:mm:ss' /></td>
										<td width="10%">${order.paymentAmount }</td>
										<td width="8%">
											<c:if test="${order.payType !=null && order.payType !=''}">
												<spring:message code="order.payment.type.${order.payType }" />
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
										<td width="13%">
											<c:if test="${order.orderType !=null && order.orderType !=''}">
												<spring:message code="order.source.${order.orderType }" />
											</c:if>
										</td>
										<td width="10%">
											<c:if test="${order.orderAddress.cashStatus !=null && order.orderAddress.cashStatus !=''}">
												<spring:message code="order.cash.status.${order.orderAddress.cashStatus }" />
											</c:if>
										</td>
										<td width="13%"><fmt:formatDate value='${order.orderAddress.cashTime}' pattern='yyyy-MM-dd HH:mm:ss' /></td>
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
	$(document).ready(function() {
		
		$("#search").bind("click", function() {
			$("#sellerId").val("");
			$("#beginTime").val("");
			$("#endTime").val("");
			var keywords = $(".J-keywords").val();
			if(keywords == $(".J-keywords").attr("data-default")){
				$(".J-keywords").val("");
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
			$("#subform").attr("action","${_ctxPath}/admin/order/order-exportManagerCashOrders.htm?orderPage.params.productId=${orderPage.params.productId}");
			$("#subform").submit();
			$("#subform").attr("action","${_ctxPath}/admin/order/order-searchOrders4CashManager.htm");
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
	
	
</script>

</html>