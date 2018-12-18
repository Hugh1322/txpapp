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
						<ul class="layout">
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
										<td colspan="2">优惠金额：
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
								<td width="15%">
									<span class="coin">&yen;</span>
									<label>
										<c:if test="${not empty orderHead.totalPostage}">
											${orderHead.totalPostage}
										</c:if>
										<c:if test="${empty orderHead.totalPostage}">
											0.00
										</c:if>
									</label>
								</td>
								
							</tr>
							<tr>
								<!--  <td width="15%">
									<label>优惠金额：-<span class="coin">&yen;</span><c:if test="${not empty orderHead.denomination}">${denomination}</c:if><c:if test="${empty orderHead.denomination}">0.00</c:if>
									</label>
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
										<%-- ${orderHead.paymentAmountView }--%>
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
								<td colspan="6">销售激励：
									<c:if test="${empty orderHead.sellInspire}">0</c:if>
									<c:if test="${not empty orderHead.sellInspire}">${orderHead.sellInspire }</c:if>
								</td>
							</tr>
							<tr>
								<td colspan="6">支付宝帐号：${orderHead.accountInfo}</td>
							</tr>
						</table>
					</div>
				</div>
				<div class="m-fr f-wr">
					<div class="fr-tab"><!-- 样式控制 -->
						<ul class="m-clear">
							<li class="bot-no">收货信息</li>
							<li>物流状态</li>
							<li>商家信息</li>
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
							<li><label>收货人: <span id="adr_receiverName${orderHead.orderId}">${orderAddress.receiverName}</span></label></li>         
							<li><label>手机:  <span id="adr_mobile${orderHead.orderId}">${orderAddress.mobile }</span></label></li>         
							<li><label>电话: ${orderAddress.telephone }</label></li>        
							<li><label>邮编: ${orderAddress.postCode}</label></li>
							<li><label> <span id="adr_receiverAddress${orderHead.orderId}">${orderAddress.receiveAddress }</span></label></li>
							<li><label>用户备注：${orderHead.orderRemark}</label></li>
						</ul>
						<c:if test="${orderHead.status eq 2 }">
							<input type="button" id="alterRecive${orderHead.orderId}" onclick="javascript:alterRecive('${orderHead.orderId}');" class="m-btn"  value="修改收货信息" />
						</c:if>

	        		</div>
				  	<div class="order-tdwidth fr-tabcont tabcont-item m-hide">
                        <div class="layout">
                            <div class="package" style="display:block;">
                                <p>
                                    <label>物流公司：${orderAddress.expressName}</label>
                                    <label>面单号：${orderAddress.expressNo}</label>
                                    <label>发货时间：<fmt:formatDate value='${orderAddress.sendProductTime}' pattern='yyyy-MM-dd HH:mm:ss' /></label>
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
                            </div>
                        </div>
		          	</div>
		            <div class="order-tdwidth fr-tabcont tabcont-item m-hide"><!-- 卖家信息 -->
                        <div class="layout">
                            <div class="package" style="display:block;">
                                <p>
                                    <label>商家姓名：${orderAddress.sellerName}</label>
                                    <label>手机：${orderAddress.sellerTel}</label><br>
                                    <label>邮箱：${orderAddress.sellerEmail}</label>
                                </p>
                            </div>
                        </div>
		          	</div>
				</div>
			</div>
			
			<!-- 客服留言 -->
			<div class="m-clear m-bd back-shop">
			     <h4>客服留言：</h4>
			     <div class="m-fl">
                 <form method="post" id="form1">
				        <div class="msg2">
								<div class="msg-main2" id="msg-main_${orderHead.orderId}">
									<ul style="height:100px; overflow-y:scroll; padding:5px; border:1px solid #ccc; margin:10px 0;">
										<c:forEach items="${orderCrmList}" var="orderCrm" varStatus="status">
											<li>
												<p style="padding:0;">
													<b>${orderCrm.userName }</b><span> <fmt:formatDate
															value='${orderCrm.recordTime }' pattern='yyyy-MM-dd HH:mm' />
													</span>
												</p>
												<p style="padding:0;">${orderCrm.remark }</p>
											</li>
										</c:forEach>
									</ul>
								</div>
								<aut:authorize url="/admin/orderCrm/orderCrm-addOrderCrm">
									 <div class="msg-foot">
										<div class="m-clear">
											<input type="hidden" name="orderCrm.orderId" id="orderIdCrm_${orderHead.orderId}"/>
											<textarea class="J-txt" style="height: 50px;" name="orderCrm.remark" id="remark_${orderHead.orderId}" onkeypress="return KeyDown('${orderHead.orderId}')"></textarea>
											<a class="save-msg J-save" href="javascript:void(0);" onclick="saveOrderCrm2('${orderHead.orderId}')" style=" height: 25px; line-height: 25px; margin-bottom: 10px; margin-left: 0; width: 80px;">记 录</a>
										</div>
										<div id="remarkTip_${orderHead.orderId}"></div>
									</div>
        					 </aut:authorize>
						 </div>
					</form> 
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
			                                            <label id="cancelStatusL_${orderCancel.orderCancelId}">
															<c:if test="${orderCancel.status!=null && orderCancel.status!=''}">
																<spring:message code="order.wait.status.${orderCancel.status}" /> 
															</c:if>
														</label>     
													</li>	  
	                                            	<li>
	                                            		<b>审核日期：</b><br/>
	                                            		<c:if test="${orderCancel.status == cancelStatuses[3]}">
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
		                                <td class="bd-last" width="220px">
											<c:if test="${orderCancel.status==cancelStatuses[1]}">
												<b>退款审核中</b>
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
												<!-- 分期送订单隐藏 -->
												<c:if test="${orderHead.orderType eq 5}">
													<b>请在【分期送】菜单完成审核操作</b>
												</c:if>
												<c:if test="${orderHead.orderType ne 5}">
												<b id="agreePaymentlabel_${orderCancel.orderCancelId}">
													<label>退款金额：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><br/>
													<input type="text" id="money_${orderCancel.orderCancelId}" value=""/>
												  	<aut:authorize url="/admin/order/order-agreePayment">
														<p>
															<input type="button" id="cancelbtn_${orderCancel.orderCancelId}" class="m-btn agreePayment" value="同意退款" onclick="confirmCancelPayment(${orderCancel.orderCancelId},${orderHead.paymentAmount})" />
														</p>
													</aut:authorize>
											 	</b>
											 	</c:if>
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
		                            <div class="back-sum">应退金额：￥
		                            	<c:if test="${refund.returnFreight == null || refund.returnFreight == 0}"><%-- 不退运费 --%>
			                            <fmt:formatNumber value="${refund.refundMoneyExcludeTotalPostage}" pattern="0.00"/>
			                            </c:if>
		                            	<c:if test="${refund.returnFreight == 1}"><%-- 退运费  --%>
			                            <fmt:formatNumber value="${refund.refundMoneyIncludeTotalPostage}" pattern="0.00"/>
			                            </c:if>
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
		                                                            <td width="70px" rowspan="2"><img src="<yp:thumbImage originalPath='${refundItem.imageUrls}' imageType='t84'></yp:thumbImage>" /></td>
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
		                                                    <td>
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
		                                <td  class="bd-last" width="180px">
											<c:if test="${refund.status==itemStatuses[1]}">
												<b>待审核</b>
											</c:if>
											<c:if test="${refund.status==itemStatuses[3]}">
												<b>审核未通过</b><br/>
												<b>审核描述:</b>${refund.reviewDescribe}
											</c:if>
											<c:if test="${refund.status==itemStatuses[2]}">
												<b>待退货</b>
											</c:if>
											<c:if test="${refund.status==itemStatuses[4]}">
												<b>待确认收货</b>
											</c:if>
											<c:if test="${refund.status==itemStatuses[5]}">
												<b>
												<!-- 农行直连支付
													<p>
														<c:choose>  
														   <c:when test="${orderHead.gateWayType eq 2 and orderHead.gateWayId eq 1066}">
															   <aut:authorize url="/order/order-confirmPayment4AgriculturalBank">
																   	<div id="confirmPaymentArea${refund.refundPayment.orderRefundPaymentId}" style='margin-bottom: 10px;'>
																		<label>退款金额：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label><br/>
																		<input type="text" id="refundMoney_${refund.refundPayment.orderRefundPaymentId}" value=""/>
																	</div>
																	<input type="button" class="m-btn confirmPayment" value="同意退款"
																	id="confirmPayment${refund.refundPayment.orderRefundPaymentId}"
																	onclick="confirmPayment4AgriculturalBank(${refund.refundPayment.orderRefundPaymentId},${refund.orderRefundId},'${orderHead.gateWayType}','${orderHead.gateWayId }')" />
															   </aut:authorize>
														   </c:when>  
														   <c:otherwise>
															   <aut:authorize url="/order/order-confirmPayment">
																   	<input type="button" class="m-btn confirmPayment" value="同意退款"
																	id="confirmPayment${refund.refundPayment.orderRefundPaymentId}"
																	onclick="confirmPayment(${refund.refundPayment.orderRefundPaymentId},${refund.orderRefundId})" />
																</aut:authorize>
														   </c:otherwise>  
														</c:choose>
													</p>  -->
													<!-- 农行直连支付 -->
												<!-- alter by 徐国飞 -->
												<aut:authorize url="/order/order-confirmBackProduct">
													<p>
														<input type="button" class="m-btn confirmPayment" value="同意退款"
															id="confirmPayment${refund.refundPayment.orderRefundPaymentId}"
															onclick="confirmPayment(${refund.refundPayment.orderRefundPaymentId},${refund.orderRefundId})" />
													</p>
												</aut:authorize> 
												</b>
											</c:if>
											<c:if test="${refund.status==itemStatuses[6]}">
												<!-- alter by 徐国飞 -->
												<b>已完成</b>
												
												 <!-- 农行直连支付
														<c:choose>  
														   <c:when test="${orderHead.gateWayType eq 2 and orderHead.gateWayId eq 1066}">
															   <b>已完成退款:${refund.refundPayment.refundAmount}</b>
														   </c:when>  
														     
														   <c:otherwise>
															   <b>已完成</b>
														   </c:otherwise>  
														</c:choose>  -->
													<!-- 农行直连支付 -->
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
<script type="text/javascript">
//修改收货信息
function alterRecive(orderId){
		var dialog = $.dialog({
		    lock: true,
		    title:false,
		    okValue: "确认",
	        ok: function(){
	        	if($("#receiver_province").val()==0){
	        		popupDialog("请选择省份！");
	        	}else if($("#receiver_city").val()==0){
	        		popupDialog("请选择城市！");
	        	}else if($("#receiver_region").val()==0){
	        		popupDialog("请选择区域！");
	        	}else if(!$("#receiver_detailAddress").val()){
	        		popupDialog("请填写详细地址！");
	        	}else{
	        		var adr = $("#receiver_province").find("option:selected").text()+$("#receiver_city").find("option:selected").text()+$("#receiver_region").find("option:selected").text()+$("#receiver_detailAddress").val();
	        		var receiverName = $("#alter_receiverName").val();
	        		var reciverMobie = $("#alter_mobile").val();
	        		if(receiverName.lengh<=0){
	        			popupDialog('收货人姓名不能为空');
	        		}if($("#receiver_detailAddress").val().length>50){
	        			popupDialog('详细地址不能超过50个字符');
	        		}else if(!/^(13[0-9]|14[0-9]|15[0-9]|18[0-9])\d{8}$/i.test(reciverMobie)){
						popupDialog('手机号码格式不正确');
	        		}else{
						$.ajax({
							type:'POST',
							url: _ctxPath + '/admin/order/order-alterRecive.htm',
							data: $("#alterReciveForm").serialize(),
							success:function(msg){
								if(msg.code == "true"){
									$.dialog({
							            title: false,
							            content: msg.info,
							            time : 3000,
							            ok: function(){
							            	$(this).hide();
							            	$("#adr_receiverName"+orderId).text(receiverName);
							            	$("#adr_mobile"+orderId).text(reciverMobie);
							            	$("#adr_receiverAddress"+orderId).text(adr);
									        //$('#alterRecive'+orderId).click();
							            }
							        });
									
								}else{
									$.dialog({
							            title: false,
							            content: msg.info,
							            time : 2000
							        });
								}
							}
						});
					}
	        	}
	        	
	        },
		    cancelValue:"取消",
		    cancel: function(){
		    },
		    visible: false
	  });
		 
	  $.ajax({
			type:'POST',
			url: _ctxPath + '/admin/order/order-goReciveAlterInfo.htm',
			data: {'orderHead.orderId':orderId},
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

