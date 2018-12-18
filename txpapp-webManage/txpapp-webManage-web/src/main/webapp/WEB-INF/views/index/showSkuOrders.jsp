<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>预警商品订单</title>
<link href="${ _cssPath}/pages/orderManagement.css" rel="stylesheet" />
<link href="${_jsPath }/plugin/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" />
<link href="${ _cssPath}/common.css" rel="stylesheet" />
<link href="${_cssPath }/pages/message.css" rel="stylesheet" /> 
<link href="${_jsPath }/plugin/artdialog/skins/ytoxl.css" rel="stylesheet" />

<script src="${_jsPath }/plugin/My97DatePicker/WdatePicker.js"></script>
<script src="${_jsPath }/jquery/jquery.1.8.1.js" language="javascript"></script>
</head>
<body>
	<jsp:include page="../include/header.jsp" flush="true" />
	<div class="body m-w980p">
		<!--start form-->   
             <div class="m-mt10p">
                <c:if test="${not empty orderPage.result}">
                    <span class="m-fr curr-num">
                        <label>当前显示： </label>
                        <yp:commPageSize page="${orderPage}" beanName="orderPage"></yp:commPageSize>
                    </span>
                </c:if>
            </div>

		<!--start 下单管理table-->
		<div class="order-management">
			<table id="order-tab" width="100%">
				<thead class="tab-control">
					<tr>
						<th width="12%">订单编号</th>
						<th width="10%">交易号</th>
						<th width="12%">下单时间</th>
						<th width="10%">总金额</th>
						<th width="12%">支付方式</th>
						<th width="10%">支付状态</th>
						<th width="10%">订单状态</th>
						<th width="7%">物流状态</th>
						<th width="9%">订单来源</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${orderPage.result}" var="order" varStatus="status">
						<tr class="list-tr">
							<td colspan="11" class="td-nobor">
								<table class="tab-control">
									<tr class="tr-height">
										<td class="num-icon" width="12%">
											<input type="hidden" value="${order.orderId}" id='orderId' />
											<input type="hidden" value="${order.orderNo}" id='orderNo' />						
											<input type ="hidden" value="" id="orderReturnId"/>
											<i></i><label><a>${order.orderNo}</a></label>
										</td>
										<td width="10%">${order.orderDeal.dealCode }</td>
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
	
	<jsp:include page="/WEB-INF/views/include/foot.jsp"></jsp:include>
</body>

<script type="text/javascript">

	$(document).ready(function() {
	//防止在一次请求 多次点击
			var isPost = true;
			$(".tr-height").on("click", function() {
			$this = $(this);
			var orderId = $this.find('#orderId').val();
			if (!$(this).next(".show-tr")[0]) {
				if(isPost){
					isPost =false;
					$.ajax({
						type : 'POST',
						url : '${_ctxPath}/admin/order/order-getOrder4Manager.htm',
						data : {
							"orderHead.orderId" : orderId,
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
	});
</script>

</html>