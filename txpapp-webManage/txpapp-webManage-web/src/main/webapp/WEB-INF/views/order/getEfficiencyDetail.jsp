<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="aut" uri="http://www.springsecurity.org/jsp" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>

<form id="shipperForm">
	<div class="popupOuter" style="height:360px">
				<div class="popCon">
					<div class="popInfo">
						<ul>
							<li><span>时效管理编号：</span>${logisticsEfficiency.lsNo }</li>
							<li><span>订单号：</span>${logisticsEfficiency.orderNo }</li>
							<li><span>下单时间：</span><fmt:formatDate value='${logisticsEfficiency.orderPayTime}' pattern='yyyy-MM-dd HH:mm:ss' /></li>
							<li><span>快递单号：</span>${logisticsEfficiency.expressNo }</li>
							<li><span>签收时间：</span><fmt:formatDate value='${logisticsEfficiency.receiveTime}' pattern='yyyy-MM-dd HH:mm:ss' /></li>
							<li><span>整体时效：</span>${logisticsEfficiency.hours}h</li>
														
						</ul>
					</div>
					<div ><span>商品名称：</span>${logisticsEfficiency.productsName}</div>
					<div class="popReason">
						<dl class="dl">
							<dt class="dt">备注：
							<dd class="dd">
								<div class="bdStyle1">
								<textarea id="shipper_reason_area">${logisticsEfficiency.remark}</textarea>
								</div>
							</dd>
						</dl>
						
					</div>
				</div>
				
		</div>
		
		<input type="hidden" name="logisticsEfficiency.orderNo" value="${logisticsEfficiency.orderNo }" />
	</form>	