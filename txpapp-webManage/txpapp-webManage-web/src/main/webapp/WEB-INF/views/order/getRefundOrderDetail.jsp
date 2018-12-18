<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="aut" uri="http://www.springsecurity.org/jsp" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>

	<div class="popupOuter">
				<div class="popTitle">退款单</div>
				<div class="popCon">
					<div class="popInfo">
						<ul>
							<li><span>退款单号：</span>${orderCancel.orderCancelNo }</li>
							<li><span>订单号：</span>${orderCancel.orderHead.orderNo }</li>
							<li><span>申请时间：</span><fmt:formatDate value='${orderCancel.createTime}' pattern='yyyy-MM-dd HH:mm:ss' /></li>
							<li><span>退款类型：</span><spring:message code="orderCancel.refundType.${orderCancel.refundType}"/></li>
							<li><span>退款单状态：</span><spring:message code="order.wait.status.${orderCancel.status}"/></li>
							<li><span>关联退货单：</span>${orderCancel.refund.orderRefundNo}</li>
							<li><span>退款通道：</span><spring:message code="orderCancel.refundPayType.${orderCancel.cancelItem.refundPayType }"/></li>							
						</ul>
					</div>
					<div class="popTable">
						<table border="1px" cellspacing="0" bordercolor="#cfd7dd" width="100%">
							<tr class="linerBg">
								<th>商品SKU</th>
								<th>商品名称</th>
								<th>商品数量</th>
								<th class="txRight">销售价格</th>
								<th class="txRight">分摊优惠</th>
								<th class="txRight">分摊折扣</th>
								<th class="txRight">商品售价</th>
							</tr>
							<c:forEach items="${orderItemList}" var="orderItem" varStatus="status">
								<tr>
									<td>${orderItem.productSku.sellerSkuCode }</td>
									<td><c:if test="${orderItem.type==2}"><font color="red">[赠品]</font></c:if>${orderItem.productName }</td>
									<td>${orderItem.num }</td>
									<td class="txRight">￥${orderItem.unitPrice }</td>
									<td class="txRight">￥${orderItem.couponAmount}</td>
									<td class="txRight">￥${orderItem.totalDiscount}</td>
									<td class="c-ff4400 txRight">￥${orderItem.payAmount}</td>
								</tr>
							</c:forEach>
						</table>
					</div>
					<div class="popReason">
						
						<dl class="dl">
							<dt class="dt">退款申请人：</dt>
							<dd class="dd c-ff4400">
								<!-- 后台新建退款 申请人 -->
								<c:if test="${orderCancel.refundSource eq 1 }">
								${orderCancel.createPresonRole}
								</c:if>
								<!-- 前台用户申请申请人 -->
								<c:if test="${orderCancel.refundSource eq 0 }">
								${orderCancel.customerName}
								</c:if>
							</dd>
						</dl>
						<dl class="dl">
							<dt class="dt">商品金额：</dt>
							<!-- andy annotated and added below codes for modify the bug which happened on 20150203 -->
							<dd class="dd c-ff4400">￥${orderCancel.totalRefund}</dd>
							<!-- andy annotated and added above codes for modify the bug which happened on 20150203 -->
						</dl>
						<dl class="dl">
							<dt class="dt">退款金额：</dt>
							<!-- andy annotated and added below codes for modify the bug which happened on 20150203 -->
							<dd class="dd c-ff4400">￥${orderCancel.refundAmount}</dd>
							<!-- andy annotated and added above codes for modify the bug which happened on 20150203 -->
						</dl>
						<dl class="dl">
							<dt class="dt">联系人电话：</dt>
							<dd class="dd c-ff4400">${orderCancel.mobile}</dd>
						</dl>
						<c:choose>
							<c:when test="${orderCancel.cancelItem.refundPayType eq 1}">
									<!-- 银行卡 -->
								<dl class="dl">
									<dt class="dt">开户行：</dt>
									<dd class="dd"><p>${orderCancel.cancelItem.bankOfDeposit }</p></dd>
								</dl>
								<dl class="dl">
									<dt class="dt">开户账号：</dt>
									<dd class="dd"><p>${orderCancel.cancelItem.refundAccountNo }</p></dd>
								</dl>
								<dl class="dl">
									<dt class="dt">账号姓名：</dt>
									<dd class="dd"><p>${orderCancel.cancelItem.personName }</p></dd>
								</dl>																
							</c:when>
							<c:otherwise>
									<!-- 支付宝 -->
								<dl class="dl">
									<dt class="dt">支付宝账号：</dt>
									<dd class="dd"><p>${orderCancel.cancelItem.refundAccountNo }</p></dd>
								</dl>
								<dl class="dl">
									<dt class="dt">账号姓名：</dt>
									<dd class="dd"><p>${orderCancel.cancelItem.personName }</p></dd>
								</dl>
							</c:otherwise>
						</c:choose>
						<dl class="dl">
							<dt class="dt">退款原因：</dt>
							<dd class="dd">
								<div class="bdStyle1"><textarea name="">${orderCancel.refundReason }</textarea></div>
							</dd>
						</dl>
						<!-- 审核不通过原因 -->
						<c:if test="${not empty orderCancel.reviewDescribe }">
							<dl class="dl">
								<dt class="dt">审核不通过原因 ：</dt>
								<dd class="dd">
									<div class="bdStyle1"><textarea name="">${orderCancel.reviewDescribe }</textarea></div>
								</dd>
							</dl>
						</c:if>
						
					</div>
				</div>
				
		</div>
		<input type="hidden" id="currentCancelPaymentAmount" value="${orderCancel.orderHead.paymentAmount-orderCancel.orderHead.totalPostage }" />
		<input type="hidden" id="currentCancelOrderId" value="${orderCancel.orderId }" />
		<input type="hidden" id="currentCancelOrderCancelId" value="${orderCancel.orderCancelId }" />
		