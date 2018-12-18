<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.ytoxl.module.yipin.base.dataobject.resultmap.ExpressMessage" %>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>
<tr class="show-tr">
	<c:set var="orderCancel" value="${orderHead.orderCancel}"/>
	<c:set var="orderAddress" value="${orderHead.orderAddress}"/>
	<td colspan="12" class="show-tab">
		<div class="order-info">
			<div class="m-clear m-bd">
				<div class="m-fl f-wl">
					<div class="order-botcolor order-tdwidth">
						<h4>订单详情</h4>
						<ul>
						<!-- 订单所购的商品 -->
						<c:forEach items="${orderHead.items}" var="item">
							<li>
								<table>
									<tr>
										<td rowspan="3" width="70px"><img src="<yp:thumbImage originalPath='${item.defaultImage}' imageType='t84'></yp:thumbImage>" /></td>
										<td width="15%">${item.brandName}</td>
										<td width="25%">${item.productName}</td>
										<td width="25%"><span class="coin">&yen;</span><label>${item.unitPrice}</label></td>
										<td width="10%">X   ${item.num}</td>
									</tr>
									<tr>
										<td colspan="2" >销售激励：
											<c:if test="${not empty item.sellInspire}">
												  <span class="coin">&yen;</span> ${item.sellInspire}
											</c:if>
										</td>
										<td colspan="2" >SKU编码：
											${item.productSku.productSkuId}
										</td>
										
									</tr>
									<tr>
										<td colspan="2" >优惠金额：
											<c:set var ="countprice"  value="${item.unitPrice * item.num}"/>
											<c:if test="${not empty item.denomination}">
											 	-<span class="coin">&yen;</span> 
												<c:if test="${countprice < item.denomination}" >
													<c:set var="denomination" value="${countprice}" />
													${countprice}
												</c:if>
												<c:if test="${countprice >= item.denomination}">
													<c:set var="denomination" value="${item.denomination + denomination}" />
													${item.denomination}
												</c:if>
											</c:if>
										</td>
										<td colspan="2" >规格信息：<br/>
											${item.productProp}
										</td>
									</tr>
									<tr>
										<td colspan="1" >
										</td>
										<td colspan="3" >结算价：
											<c:if test="${not empty item.settlementPrice}">
												  <span class="coin">&yen;</span> ${item.settlementPrice}
											</c:if>
										</td>
									</tr>
								</table>
							</li>
						</c:forEach>
						</ul>
					</div>
					<div class="order-tdwidth">
						<table>
							<tr>
								<td width="15%">商品金额：</td>
								<td width="23%"><span class="coin">&yen;</span><label>${orderHead.originalAmount}</label></td>
								<td width="10%">运费：</td>
								<td width="15%"><span class="coin">&yen;</span><label>
									<c:if test="${not empty orderHead.totalPostage}">
										<span id="totalPostage">${orderHead.totalPostage}</span>
									</c:if>
									<c:if test="${empty orderHead.totalPostage}">
										<span id="totalPostage">0.00</span>
									</c:if>
								</label></td>
							</tr>
							<tr>
								<!--  <td colspan="6">
									<label>优惠金额：</label>-<span class="coin">&yen;</span>
									<label><c:if test="${not empty orderHead.denomination}">${denomination}</c:if><c:if test="${empty orderHead.denomination}">0.00</c:if></label>
								</td>-->
									<c:if test="${not empty orderHead.couponAmount and orderHead.couponAmount !='0.00'}">
								<td  width="23%">
									优惠劵金额：</td><td>-<label>
								     	 <span class="coin">&yen;</span><fmt:formatNumber value="${orderHead.couponAmount}" pattern="0.00"/>
									</label>
								</td>
								      </c:if>
									
									<c:if test="${not empty orderHead.denomination and orderHead.denomination !='0.00'}">
								<td  width="10%">
									活动优惠：</td><td>-<label>
								     	 <span class="coin">&yen;</span><fmt:formatNumber value="${orderHead.denomination}" pattern="0.00"/>
									</label>
								</td>
								      </c:if>
								
							</tr>
							<tr>
							<td colspan="6" width="*">
									支付总额：<span class="coin">&yen;</span>
									${orderHead.paymentAmount} 
								<%-- 	${orderHead.paymentAmountView }--%>
								</td>
							
							</tr>
							<c:if test="${orderHead.hasInvoice == orderInvoiceStatus}">
								<tr>
									<td colspan="6">
										<label>发票信息：<c:if test="${empty orderHead.invoiceTitle}">个人</c:if><c:if test="${not empty orderHead.invoiceTitle}">${orderHead.invoiceTitle}</c:if></label>
									</td>
								</tr>
							</c:if>
							<tr>
								<td colspan="6">
									<label>支付宝帐号：</label>
									<label>${orderHead.accountInfo}</label>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<div class="f-wr tab-change">
					<div class="fr-tab">
						<ul class="m-clear">
							<li class="bot-no">收货信息</li>
							<li>物流状态</li>
						</ul>
					</div>
					<div class="order-tdwidth fr-tabcont tabcont-item">
						<ul class="layout">
							<c:forEach items="${orderHead.items}" var="cs">
								<li>
									<label width="15%">${cs.brandName}</label>
									<label width="20%">${cs.productName}</label>
									<label width="20%">${cs.unitPrice}</label>
									<label width="10%">X ${cs.num}</label>
								</li>
							</c:forEach>
							<li><label>收货人: ${orderAddress.receiverName }</label></li>         
							<li><label>手机: ${orderAddress.mobile }</label></li>         
							<li><label>电话: ${orderAddress.telephone }</label></li>        
							<li><label>邮编: ${orderAddress.postCode }</label></li>
							<li><label>${orderAddress.receiveAddress }</label></li>
						</ul>
	        		</div>
					
					<div class="order-tdwidth fr-tabcont tabcont-item m-hide">
                        <div class="layout">
                         
                           	<!-- 如果订单是未发货  显示发货信息 -->
                           	<c:if test="${(orderAddress.expressNo==null || orderAddress.expressNo== '') and orderHead.payType != 2 and orderHead.confirmStatus != 2}">
	                            <form id="form${orderHead.orderId}_${orderAddress.orderAddressId}" class="m-search">
	                                <div>
	                                    <label>发货：</label>
	                                    <select class="select-mail" id="expressId${orderHead.orderId}_${orderAddress.orderAddressId}">
	                                     <c:forEach items="${listExpresses }" var="express" >
	                                     	<option value="${express.expressId }">${express.expressName}</option>
	                                     </c:forEach>
	                                    </select>
	                                    
	                                    <input id="expressNo${orderHead.orderId}_${orderAddress.orderAddressId}" type="text" class="odd-numbers" />
	                                    
	                                    <!-- 如果订单是未发货,如果存在退款申请，则必须是退款未通过,才 显示发货按钮 -->
	              						<c:if test="${orderHead.status == orderStatusWaitSend && (orderCancel==null || (orderCancel!=null && orderCancel.status==cancelStatuses[2]))}">
		                                    <aut:authorize url="/admin/order/order-confirmSendProduct">
		                                    		<input onclick="confirmSend('${orderHead.payType}','${orderHead.orderId}','${orderAddress.orderAddressId}')" type="button" class="confirm-btn" value="确认发货" />
		                                    </aut:authorize>
	                                    </c:if>
	                                   <%--  <c:if test="${orderHead.payType==2}">
	                                    <p>本单为<font style="color: red;">货到付款</font>订单，请仔细核对并确认，点击[确认发货]<font style="color: red;">15</font>分钟后将不能修改单号</p>
	                                    </c:if> --%>
	                                </div>
	                            </form>
                           	</c:if>
                          	
                           	<!-- 如果已经发货 显示物流信息 -->
				            <c:if test="${orderAddress.expressNo!=null && orderAddress.expressNo!= ''}">
                                <p>
                                    <label>物流公司：${orderAddress.expressName}</label>
                                    <label>面单号：${orderAddress.expressNo}</label>
                                </p>
                                <div>
                                   <c:if test="${orderAddress.expressMessage != null}">
							            <c:set var="status_success" value="<%=ExpressMessage.STATUS_SUCCESS%>"></c:set>
							            <c:choose>
							             	<c:when test="${orderAddress.expressMessage.status eq status_success }">
								            	<ul>
													<c:forEach items="${orderAddress.expressMessage.data }" var="dataItem">
														<li>
															<label>${dataItem.time }</label>
															<span>${dataItem.context }</span>
														</li>
													</c:forEach>
									            </ul>
							            	</c:when>
								            <c:otherwise><p>系统正在更新，给您带来不便请见谅，请稍后查询！</p></c:otherwise>
							            </c:choose>
						            </c:if>
                                </div>
                        	</c:if>                        	
                        	<c:if test="${orderHead.logisticStatus == 1}">
                        		已接单
                        	</c:if>
                        </div>
          			</div>
				</div>
			</div>
			
			<div class="m-clear m-bd back-shop">
                <h4>订单备注：</h4>
                <div class="m-fl">
                	${orderHead.orderRemark}
                </div>
	        </div>
 			
            <!-- 退款申请 -->
            <c:if test="${orderHead.status == orderStatusWaitSend && orderHead.orderCancel!=null}">
	            <div class="back-shop m-clear">
	            	<h4>退款申请:</h4>
	            </div>
	            <div class="fr-tabcont tabcont-item">
	                <div class="m-clear">
	                    <div class="back-content">
	                        <div class="back-bar m-clear">
	                            <div class="back-details">
		                            <span>申请日期：<fmt:formatDate value='${orderCancel.createTime}' pattern='yyyy-MM-dd HH:mm:ss' /></span>
		                            <span>联系人：${orderCancel.customerName}</span>
		                            <span>联系电话：${orderCancel.mobile}</span>
	                            </div>
	                            <div class="back-sum">订单金额：￥${orderHead.paymentAmount}</div>
	                        </div>
	                        <table class="back-table">
	                            <tbody>         
	                                <tr>
		                                <td width="<c:if test="${orderCancel.status==cancelStatuses[1]}">728px</c:if><c:if test="${orderCancel.status!=cancelStatuses[1]}">528px</c:if>">
		                                    <div class="order-botcolor order-tdwidth bd-none">
		                                        <ul class="layout">
			                                        <!-- 订单所购的商品 -->
			                                        <c:forEach items="${orderHead.items}" var="orderItem">
			                                            <li>
			                                                <table>
			                                                    <tbody>
			                                                        <tr>
			                                                            <td width="70px" rowspan="2"><img src="<yp:thumbImage originalPath='${orderItem.defaultImage}' imageType='t84'></yp:thumbImage>" /></td>
			                                                            <td width="15%">${orderItem.productName}</td>
			                                                            <td width="35%">${orderItem.productProp}</td>
			                                                            <td width="15%"><span class="coin">¥</span><label>${orderItem.unitPrice}</label></td>
			                                                            <td width="10%">X   ${orderItem.num}</td>
			                                                        </tr>
			                                                    </tbody>
			                                                </table>
			                                            </li>
			                                        </c:forEach>
			                                        <li><p>问题描述：${orderCancel.refundReason}</p></li>
		                                        </ul>
		                                    </div>
		                                </td>
		                                <c:if test="${orderCancel.status!=cancelStatuses[1]}">
			                                <td width="200px">
			                                	<div class="back-hd">
			                                		<ul>
				                                    	<li>
				                                    		<b>退款审核状态：</b><br/>
		                                                	<label>
																<c:if test="${orderCancel.status!=null && orderCancel.status!=''}">
																	<spring:message code="order.wait.status.${orderCancel.status}" /> 
																</c:if>
															</label>  
														</li>
		                                            	<li>
		                                            		<b>审核日期：</b><br/>
		                                            		<c:if test="${orderCancel.status == cancelStatuses[2] || orderCancel.status == cancelStatuses[3]}">
		                                            			<fmt:formatDate value='${orderCancel.sellerCheckTime}' pattern='yyyy-MM-dd HH:mm:ss' />
		                                            		</c:if>
		                                            		<c:if test="${orderCancel.status == cancelStatuses[4]}">
		                                            			<fmt:formatDate value='${orderCancel.adminCheckTime}' pattern='yyyy-MM-dd HH:mm:ss' />
		                                            		</c:if>
		                                            	</li>
			                                   		</ul>
			                                   	</div>    
			                                </td>
		                                </c:if>
		                                <td width="220px"<c:if test="${orderHead.orderType == 5}"> class="bd-last"</c:if>>
											<c:if test="${orderCancel.status==cancelStatuses[1]}">
												<c:if test="${orderHead.orderType != 5}">
												<b>
												  	<aut:authorize url="/admin/order/order-passCancelAudit">
														<p><input type="button" class="m-btn" value="审核通过" id="passCA_${orderCancel.orderCancelId}" onclick="passCelAudit(${orderCancel.orderCancelId},${orderCancel.orderId});" /></p>
												  	</aut:authorize>
												  	<aut:authorize url="/admin/order/order-rejectCancelAudit">
														<p><input type="button" class="m-btn" value="审核不通过" id="rejectCA_${orderCancel.orderCancelId}" onclick="rejectCelAudit(${orderCancel.orderCancelId});" /></p>
												  	</aut:authorize>
												  	<p id="rejectCARP_${orderCancel.orderCancelId}" >
												  		审核未通过原因：
												  		<textarea id="rejectCAR_${orderCancel.orderCancelId}" rows="3" cols="30"}/>
												  		<label id="rejectCARL_${orderCancel.orderCancelId}"/>
												  	</p>
											 	</b>
											 	</c:if>
												<c:if test="${orderHead.orderType == 5}">
												<b>
												  	退款审核中
											 	</b>
											 	</c:if>
											</c:if>
											<!-- 订单项状态为 审核未通过 -->
											<c:if test="${orderCancel.status==cancelStatuses[2]}">
												<b>审核未通过</b><br/>
												<p>
													<b>审核描述:</b><br/>
													${orderCancel.reviewDescribe}
												</p>
											</c:if>
											<!-- 订单项状态为 审核通过  -->
											<c:if test="${orderCancel.status == cancelStatuses[3]}">
												<b>待退款</b>
											</c:if>
											<c:if test="${orderCancel.status==cancelStatuses[4]}">
												<b>已退款</b>
											</c:if>
		                                </td>
		                            </tr>              
	                            </tbody>
	                        </table>
	                    </div>
	                </div>
	            </div>
            </c:if>
            
            
			<!-- 退货商品信息 -->
			<c:if test="${orderHead.orderRefunds!=null && orderHead.orderRefunds[0]!=null}">
	            <div class="back-shop m-clear">
	           		<h4>退货商品:</h4>
	            </div>
			    <div class="fr-tabcont tabcont-item">
	                <div class="m-clear">
	                    <c:forEach items="${orderHead.orderRefunds}" var="refund">
	                    	<c:set var="refundItem" value="${refund.orderItem }"/>
		                    <div class="back-content">
		                        <div class="back-bar m-clear">
		                            <div class="back-details">
		                            <span>申请日期：<fmt:formatDate value='${refund.createTime}' pattern='yyyy-MM-dd HH:mm:ss' /></span>
		                            <span>联系人：${refund.customerName}</span>
		                            <span>联系电话：${refund.mobile}</span>
		                            <span>${refund.refundExpress.expressName}</span>
		                            <span>${refund.refundExpress.expressNo}</span>
		                            </div>
		                            <div class="back-sum">应退金额： ￥
		                            	<span id="refundMoney_${refundItem.orderItemId}" refundMoneyIncludeTotalPostage="${refund.refundMoneyIncludeTotalPostage}" refundMoneyExcludeTotalPostage="${refund.refundMoneyExcludeTotalPostage}"><c:if test="${refund.returnFreight == null || refund.returnFreight == 0}"><%-- 不退运费 --%><fmt:formatNumber value="${refund.refundMoneyExcludeTotalPostage}" pattern="0.00"/></c:if><c:if test="${refund.returnFreight == 1}"><%-- 退运费  --%><fmt:formatNumber value="${refund.refundMoneyIncludeTotalPostage}" pattern="0.00"/></c:if></span>
		                            </div>
		                        </div>
		                        <table class="back-table">
		                            <tbody>         
		                                <tr>
			                                <td width="568px">
			                                    <div class="order-botcolor order-tdwidth bd-none">
			                                        <ul class="layout">
				                                        <!-- 订单所购的商品 -->
			                                            <li>
			                                                <table>
			                                                    <tbody>
			                                                        <tr>
			                                                            <td width="70px" rowspan="2"><img src="<yp:thumbImage originalPath='${refundItem.defaultImage}' imageType='t84'></yp:thumbImage>" /></td>
			                                                            <td width="15%">${refundItem.productName}</td>
			                                                            <td width="35%">${refundItem.productProp}</td>
			                                                            <td width="15%"><span class="coin">¥</span><label>${refundItem.unitPrice}</label></td>
			                                                            <td width="10%">X   ${refund.refundNum}</td>
			                                                        </tr>
			                                                    </tbody>
			                                                </table>
			                                            </li>
			                                        </ul>
			                                        <p>问题描述：${refund.refundReason}</p>
			                                                                                                           买家退货图片：
			                                        </br>
			                                        <table>
			                                            <tbody>
			                                                <tr>
			                                                	<td width="70px" rowspan="2">
			                                                	<c:set value="${ fn:split(refund.imageUrls, ',') }" var="images" />
			 		                                        		<c:forEach items="${ images }" var="image" begin="0" end="3">
			 		                                        			<c:if test="${not empty image}">
			                                            	        		<img src="<yp:thumbImage originalPath='${image}' imageType='t84'></yp:thumbImage>" />&nbsp;
			                                            	        	</c:if>
			                                               			</c:forEach>
			                                                	</td>
			                                                </tr>
			                                            </tbody>
			                                        </table>
			                                    </div>
			                                </td>
			                                <td width="220px">
			                                    <div class="back-hd">
			                                        <ul>
			                                            <li>
			                                            	<b>退货审核状态：</b><br>
			   												<label id="refundStatusL${refund.orderRefundId}">
				                                                <c:if test="${refund.status!=null}">
				                                                    <spring:message code="order.refund.status.${refund.status}" /> 
				                                                </c:if>
			                                                </label>
														</li>
			                                            <li>
			                                            	<b>审核日期：</b><br>
			                                            	<fmt:formatDate value='${refund.adminCheckTime}' pattern='yyyy-MM-dd HH:mm:ss' />
			                                            </li>
			                                        </ul>
			                                    </div>
			                                </td>
			                                <td width="180px">
												<c:if test="${refund.status==itemStatuses[1]}">
													<b>
													  <aut:authorize url="/order/order-passAudit">
														<p><input type="button" class="m-btn" value="审核通过" id="passAudit${refund.orderRefundId}" onclick="passAudit(${refund.orderRefundId}, '${refundItem.orderItemId}')" />&nbsp;<input id="checkboxReturnFreight_${refundItem.orderItemId}" type="checkbox" onclick="onChangeOfCheckboxIncludeFreight('${refundItem.orderItemId}')"/><label for="checkboxIncludeFreight">退运费单</label></p>
													  </aut:authorize>
													  <aut:authorize url="/order/order-rejectAudit">
														  <p><input type="button" class="m-btn" value="审核不通过" id="rejectAudit${refund.orderRefundId}" onclick="rejectAudit(${refund.orderRefundId})" /></p>
														  <p id="rejectAuditReasonP">审核未通过原因：
														  <textarea id="rejectAuditReason${refund.orderRefundId}" rows="3" cols="30"}/>
														  <label id="rejectAuditReasonL${refund.orderRefundId}"/>
														  </p>
													  </aut:authorize>
													 </b>
												</c:if>
												<c:if test="${refund.status==itemStatuses[3]}">
													<b>审核未通过</b><br/>
													<b>审核描述:</b>${refund.reviewDescribe}
												</c:if>
												<c:if test="${refund.status==itemStatuses[2]}">
													<b>待退货</b>
												</c:if>
												<c:if test="${refund.status==itemStatuses[4]}">
												<b>								
													<aut:authorize url="/admin/order/order-confirmBackProduct">
														<p>
															<input type="button" class="m-btn confirmBackProduct" value="确认收货"
														id="confirmBackProduct${refund.orderRefundId}"
							                            	onclick="confirmBack(${refund.orderRefundId},<c:if test="${refund.returnFreight == null || refund.returnFreight == 0}"><%-- 不退运费 --%><fmt:formatNumber value="${refund.refundMoneyExcludeTotalPostage}" pattern="0.00"/></c:if><c:if test="${refund.returnFreight == 1}"><%-- 退运费  --%><fmt:formatNumber value="${refund.refundMoneyIncludeTotalPostage}" pattern="0.00"/></c:if>)" 
														/>
														</p>
													</aut:authorize>
												</b>
												</c:if>
												<c:if test="${refund.status==itemStatuses[5]}">
													<b>待退款</b>
												</c:if>
												<c:if test="${refund.status==itemStatuses[6]}">
													<b>已完成</b>
												</c:if>
			                                </td>
			                            </tr>              
		                            </tbody>
		                        </table>
		                    </div>
	                    </c:forEach>
	                </div>
	              </div>
              </c:if>
		</div>
	</td>
</tr>