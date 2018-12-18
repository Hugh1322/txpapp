<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="aut" uri="http://www.springsecurity.org/jsp" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>

<form id="shipperForm">
	<div class="popupOuter" style="height:360px">
				<div class="popCon">
					<div class="popInfo">
						<ul>
							<li><span>揽收管理编号：</span>${logisticsShipper.lsNo }</li>
							<li><span>订单号：</span>${logisticsShipper.orderNo }</li>
							<li><span>下单时间：</span><fmt:formatDate value='${logisticsShipper.orderPayTime}' pattern='yyyy-MM-dd HH:mm:ss' /></li>
							<li><span>快递单号：</span>${logisticsShipper.expressNo }</li>
							<li><span>接单是否异常：</span>
								${logisticsShipper.exceptionFlag}
							</li>
							<li><span>接单时间：</span><fmt:formatDate value='${logisticsShipper.receiveTime}' pattern='yyyy-MM-dd HH:mm:ss' /></li>
							<li><span>接单异常原因：</span>
							<select id="shipper_exception_reason" class="trueMenu" <c:if test="${logisticsShipper.exceptionFlag!='是' }">
												disabled="disabled"
											</c:if>>
										<option value=""
											<c:if test="${logisticsShipper.exceptionReason==''}">
												selected = "selected"
											</c:if>></option>
										<option value="商户原因"
											<c:if test="${logisticsShipper.exceptionReason=='商户原因'}">
												selected = "selected"
											</c:if>>商户原因</option>
										<option value="快递公司原因" 
											<c:if test="${logisticsShipper.exceptionReason=='快递公司原因'}">
												selected = "selected"
											</c:if>>快递公司原因</option>
										<option value="其它" 
											<c:if test="${logisticsShipper.exceptionReason=='其它'}">
												selected = "selected"
											</c:if>>其它</option>
									</select>
							</li>	
							<li><span>接单时长：</span>${logisticsShipper.receiveHours}h</li>
														
						</ul>
					</div>
					<div ><span>商品名称：</span>${logisticsShipper.productsName}</div>
					<div class="popReason">
						<dl class="dl">
							<dt class="dt">异常备注：
							<dd class="dd">
								<div class="bdStyle1">
								<c:if test="${logisticsShipper.exceptionFlag=='是' }">
									<textarea id="shipper_reason_area">${logisticsShipper.remark}</textarea>
								</c:if>
								</div>
							</dd>
						</dl>
						
					</div>
				</div>
				
		</div>
		<input type="hidden" id="shipper_reason" name="logisticsShipper.exceptionReason" value="${logisticsShipper.exceptionReason }" />
		<input type="hidden" name="logisticsShipper.orderNo" value="${logisticsShipper.orderNo }" />
	</form>	