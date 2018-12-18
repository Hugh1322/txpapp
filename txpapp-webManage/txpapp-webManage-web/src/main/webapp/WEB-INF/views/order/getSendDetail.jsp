<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="aut" uri="http://www.springsecurity.org/jsp" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>

<form id="shipperForm">
	<div class="popupOuter" style="height:360px">
				<div class="popCon">
					<div class="popInfo">
						<ul>
							<li><span>派送管理编号：</span>${logisticsSend.lsNo }</li>
							<li><span>订单号：</span>${logisticsSend.orderNo }</li>
							<li><span>派送扫描时间：</span><fmt:formatDate value='${logisticsSend.sendTime}' pattern='yyyy-MM-dd HH:mm:ss' /></li>
							<li><span>快递单号：</span>${logisticsSend.expressNo }</li>
							<li><span>接单是否异常：</span>
								${shipper.exceptionFlag}
							</li>
							<li><span>签收时间：</span><fmt:formatDate value='${logisticsSend.receiveTime}' pattern='yyyy-MM-dd HH:mm:ss' /></li>
							<li><span>签收异常原因：</span>
							<select id="shipper_exception_reason" class="trueMenu" <c:if test="${logisticsSend.exceptionFlag!='是' }">
												disabled="disabled"
											</c:if>>
										<option value=""
											<c:if test="${logisticsSend.exceptionReason==''}">
												selected = "selected"
											</c:if>></option>
										<option value="中转"
											<c:if test="${logisticsSend.exceptionReason=='中转'}">
												selected = "selected"
											</c:if>>中转</option>
										<option value="派送" 
											<c:if test="${logisticsSend.exceptionReason=='派送'}">
												selected = "selected"
											</c:if>>派送</option>
										<option value="发货" 
											<c:if test="${logisticsSend.exceptionReason=='发货'}">
												selected = "selected"
											</c:if>>发货</option>
									</select>
							</li>	
							<li><span>签收时长：</span>${logisticsSend.receiveHours}h</li>
														
						</ul>
					</div>
					<div ><span>商品名称：</span>${logisticsSend.productsName}</div>
					<div class="popReason">
						<dl class="dl">
							<dt class="dt">异常备注：
							<dd class="dd">
								<div class="bdStyle1">
								<c:if test="${logisticsSend.exceptionFlag=='是' }">
									<textarea id="shipper_reason_area">${logisticsSend.remark}</textarea>
								</c:if>
								</div>
							</dd>
						</dl>
						
					</div>
				</div>
				
		</div>
		<input type="hidden" id="shipper_reason" name="logisticsSend.exceptionReason" value="${logisticsSend.exceptionReason }" />
		<input type="hidden" name="logisticsSend.orderNo" value="${logisticsSend.orderNo }" />
	</form>	