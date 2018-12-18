<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="aut" uri="http://www.springsecurity.org/jsp" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@page import="com.ytoxl.module.yipin.base.dataobject.resultmap.ExpressMessage" %>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>订单管理-销售单管理-明细</title>
		<link rel="stylesheet" type="text/css" href="${_jsPath }/new/css/base.css"/>
        <link rel="stylesheet" href="${_jsPath }/new/calendar/kalendae.css" type="text/css" charset="utf-8">
        <script type="text/javascript" src="${_jsPath }/new/js/jquery-1.11.0.min.js"></script>
		<script src="${_jsPath }/new/calendar/kalendae.standalone.js" type="text/javascript" charset="utf-8"></script>
        <script type="text/javascript" src="${_jsPath }/new/js/manage_basefun.js"></script>
        <script src="${_jsPath}/plugin/select/linkage_sel.js?v=${_resVerion}"></script>
	</head>
	<body>
		<jsp:include page="../include/headerNew.jsp" flush="true" />
			<!--main start-->
			<div class="main">
				
				<!--面包屑-->
				<div class="crumb">
					<p>
						<a href="" class="home"><i></i></a>
						<span class="sep"></span>
						<a href="">订单管理</a>
						<span class="sep"></span>
						<a href="${_ctxPath}/admin/order/orderMgr-goSaleOrders.htm">销售单管理</a>
						<span class="sep"></span>
						${orderHead.orderNo}
					</p>
				</div>
				
				<!--一个盒子-->
				<div class="section">
					<form id="alterReciveForm">
					    <input type="hidden" name="orderHead.orderId"	value="${orderHead.orderId }" />
					    <input type="hidden" name="orderAddress.orderAddressId" value="${orderAddress.orderAddressId }" />
						<div class="line">
							<div class="col">
								<span class="sp">用户名：</span>
								<p class="sp-con" title="${orderHead.username}">
								     <c:choose>
								        <c:when test="${fn:length(orderHead.username)>20}">
								            ${fn:substring(orderHead.username,0,20)}...
								        </c:when>
								        <c:otherwise>
								             ${orderHead.username}
								        </c:otherwise>
								     </c:choose>
								</p>
							</div>
							<div class="col">
								<span class="sp">邮编：</span><p class="sp-con">${orderAddress.postCode}</p>
							</div>
							<div class="col">
								<span class="sp">收货人：</span><input <c:if test="${orderHead.status != 2}">disabled="disabled" </c:if> type="text" id="alter_receiverName" name="orderAddress.receiverName" value="${orderAddress.receiverName}" class="inputText"/>
							</div>
							<div class="col">
								<span class="sp">收货手机：</span><input <c:if test="${orderHead.status != 2}">disabled="disabled" </c:if> type="text" id="alter_mobile" name="orderAddress.mobile" value="${orderAddress.mobile}" class="inputText"/>
							</div>
						</div>
						<div class="line">
							<div class="col getAddress">
								<span class="sp">收货地址：</span><!--<input type="text" name="" id="" value="${orderAddress.receiveAddress}" class="inputText w395"/>-->
								<div class="fl module_Select">
	                                <select <c:if test="${orderHead.status != 2}">disabled="disabled" </c:if> id="receiver_province" ></select>
	                            </div>
								<div class="fl module_Select">
	                                <select <c:if test="${orderHead.status != 2}">disabled="disabled" </c:if>  id="receiver_city" ></select>                                
	                            </div>
	                            <div class="fl module_Select">
	                                <select <c:if test="${orderHead.status != 2}">disabled="disabled" </c:if> id="receiver_region"  name="orderAddress.regionId"></select>
	                            </div>
	                            <input <c:if test="${orderHead.status != 2}">disabled="disabled" </c:if> type="text" id="receiver_detailAddress" name="orderAddress.detailAddress" value="${orderAddress.detailAddress}" title="${orderAddress.detailAddress}"  class="inputText bgcf9f w170"/>
							</div>
							<div class="col">
								<span class="sp">配送方式：</span><p class="sp-con">${orderAddress.expressName}</p>
							</div>
							<div class="col">
								<span class="sp">支付方式：</span><p class="sp-con">
								    <c:if test="${orderHead.payType !=null && orderHead.payType !=''}">
											<c:if test="${orderHead.payType eq 1}">
												<c:choose>
													<c:when test="${orderHead.gateWayId !=null && orderHead.gateWayId !=''}">
														<spring:message code="order.payment.type.${orderHead.gateWayId}"/>
													</c:when>
													<c:otherwise>
														<spring:message code="order.payment.type.${orderHead.payType}"/>
													</c:otherwise>
												</c:choose>
											</c:if>
											<c:if test="${orderHead.payType eq 2}">
												<spring:message code="order.payment.type.${orderHead.payType}"/>
											</c:if>
								    </c:if>
								</p>
							</div>
						</div>
						<div class="line">
							<div class="col">
								<span class="sp">支付状态：</span><p class="sp-con">
								    <c:if test="${orderHead.payStatus ==null}">
										未付款
									</c:if> 
									<c:if test="${orderHead.payStatus !=null}">
										<spring:message code="order.payment.status.${orderHead.payStatus }" />
									</c:if>
								   
								</p>
							</div>
							<div class="col">
								<span class="sp">交易流水号：</span><p class="sp-con">
								     
								</p>
							</div>
							<div class="col">
								<span class="sp">支付宝账号：</span><p class="sp-con">
								     ${orderHead.accountInfo}
								</p>
							</div>
							<div class="col">
								<span class="sp">买家身份证：</span>
								<input <c:if test="${orderHead.status != 2}">disabled="disabled" 
										</c:if> type="text" id="alter_receiverIDCardNo" 
										name="orderAddress.receiverIDCardNo" 
										value="${orderAddress.receiverIDCardNo}" 
										class="inputText"/>
							</div>
						</div>
						<div class="line">
							<div class="col">
								<span class="sp">支付时间：</span><p class="sp-con">
									<fmt:formatDate value='${orderHead.callbackTime}' pattern='yyyy-MM-dd HH:mm'/>
								</p>
							</div>
						</div>
						<c:if test="${orderHead.status == 2}"> 
						     <!-- 待发货状态才能发货 -->
							<div class="btns">
							    <input id="saveAddressBut" class="maageBtn_1" type="button" value="保存" />
							</div>
						</c:if>
					</form>
				</div>
				
				<!--一个盒子-->
				<div class="section">
					
					<div class="line">
						<div class="col">
							<span class="sp">销售单号：</span><p class="sp-con">${orderHead.orderNo}</p>
						</div>
						<div class="col">
							<span class="sp">交易单号：</span><p class="sp-con">${orderHead.orderDeal.dealCode}</p>
						</div>
						<div class="col">
							<span class="sp">订购时间：</span><p class="sp-con"><fmt:formatDate value='${orderHead.createTime}' pattern='yyyy-MM-dd HH:mm'/></p>
						</div>
						<div class="col">
							<span class="sp">面单号：</span><p class="sp-con">${orderAddress.expressNo}</p>
						</div>
					</div>
					<div class="line">
						<div class="col">
							<span class="sp">发货时间：</span><p class="sp-con"><fmt:formatDate value='${orderAddress.sendProductTime}' pattern='yyyy-MM-dd HH:mm'/></p>
						</div>
						<div class="col">
							<span class="sp">销售单状态：</span><p class="sp-con">
								<c:if test="${empty orderHead.refundStatus}">
									<spring:message code="order.status.${orderHead.status }" />
									<c:if test="${not empty orderHead.orderCancel.status}">
										(<spring:message code="order.wait.status.${orderHead.orderCancel.status }" />)
									</c:if>
								</c:if>
								<c:if test="${not empty orderHead.refundStatus}">
									<spring:message code="order.refund.status.${orderHead.refundStatus}" />
								</c:if> 
							</p>
						</div>
						<div class="col">
							<span class="sp">订单来源：</span><p class="sp-con">
							    <c:if test="${orderHead.orderType !=null && orderHead.orderType !=''}">
									<spring:message code="order.source.${orderHead.orderType }" />
								</c:if>
							</p>
						</div>
						<div class="col wl">
							<span class="sp">配送信息：</span><p class="sp-con"><i class="i-wl"></i></p>
							<div class="wl-info">
							        <c:set var="status_success" value="<%=ExpressMessage.STATUS_SUCCESS%>"></c:set>
									<span class="arrow"></span>
									<p>${orderAddress.expressName}  运单号：${orderAddress.expressNo}</p>
									<c:choose>
							             	<c:when test="${orderAddress.expressMessage.status eq status_success }">
								            	<ul>
													<c:forEach items="${orderAddress.expressMessage.data }" var="dataItem">
														<li class="c-ff4400">
															${dataItem.context }
															<span>${dataItem.time }</span>
														</li>
													</c:forEach>
									            </ul>
							            	</c:when>
								            <c:otherwise><p>暂未查到物流信息！</p></c:otherwise>
							        </c:choose>
							</div>
						</div>
					</div>
					
					<c:if test="${not empty orderHead.cancelTime }">
					<div class="line">
						<div class="col">
							<span class="sp">订单取消时间：</span>
							<p class="sp-con">
							<fmt:formatDate value='${orderHead.cancelTime}' pattern='yyyy-MM-dd HH:mm'/>
							</p>
						</div>
						
					</div>
					</c:if>
				</div>
				
				<!--一个盒子-->
				<div class="section">
					
					<div class="line">
						<div class="col">
							<span class="sp">对外备注：</span><p class="sp-con"><font color="red">${orderHead.orderRemark}</font></p>
						</div>
					</div>
					
					<div class="line">
						<div class="col">
							<span class="sp">客服备注：</span>
							<div class="sp-con remark">
								<ul id="remark_ul">
									<c:forEach items="${orderCrmList}" var="orderCrm" varStatus="statusRemark">
									     <c:choose>
									       <c:when test="${statusRemark.index==0}"><li class="c-ff4400"></c:when>
									       <c:otherwise><li></c:otherwise>
									     </c:choose>
									     <span>${orderCrm.userName}  <fmt:formatDate value='${orderCrm.recordTime }' pattern='yyyy-MM-dd HH:mm' /></span><p>${orderCrm.remark}</p></li>
									</c:forEach>
								</ul>
								<c:if test="${isAdmin}">
								<p class="remarkInput">
									<input type="text" name="" id="remark_${orderHead.orderId}" value="" onkeypress="return KeyDown('${orderHead.orderId}')" />
									<a href="javascript:void(0);" onclick="addOrderCrm('${orderHead.orderId}');" class="enter"></a>
								</p>
								</c:if>
							</div>
						</div>
					</div>
					
				</div>
				
				<!--一个盒子-->
				<div class="section">
					
					<div class="line">
						<div class="col">
							<span class="sp">售前退款：</span>
							<div class="sp-con">
								 <c:forEach items="${orderCancelBef}" var="cancel">
							      	<a href="javascript:void(0);"  data-cancelStatus="${cancel.status }"  data-cancelId="${cancel.orderCancelId }" class="getOrderCancelDetail">${cancel.orderCancelNo}</a>
							  	 </c:forEach>
							  	 <c:if test="${isAdmin eq true }">
							  	 	<a href="javascript:void(0);" data-refundType="0" data-orderId="${orderHead.orderId}"  class="add addNewOrderCancel orderCancelBef"></a>
							  	 </c:if>
							  	 
							</div>
						</div>
						<div class="col">
							<span class="sp">售后退货：</span>
							<div class="sp-con" >
							  <div id="refundDivA">
								  <c:forEach items="${orderRefundNoList}" var="orderRefundNo">
								      <a href="javascript:void(0);" onclick="showRefund('${orderRefundNo}','${orderHead.orderId}');">${orderRefundNo}</a>
								  </c:forEach>
							  </div>
							  <c:if test="${orderHead.isCanAddRefundGood==true}">
							      <a href="javascript:void(0);" onclick="showRefund('','${orderHead.orderId}');" class="add"></a>
							  </c:if>
							</div>
						</div>
						<div class="col">
							<span class="sp">售后退款：</span>
							<div class="sp-con">
								<c:forEach items="${orderCancelAft}" var="cancel">
							      	<a href="javascript:void(0);"  data-cancelStatus="${cancel.status }"  data-cancelId="${cancel.orderCancelId }" class="getOrderCancelDetail">${cancel.orderCancelNo}</a>
							  	 </c:forEach>
							  	 <c:if test="${isAdmin eq true }">
							  	 	<a href="javascript:void(0);"  data-refundType="1"  data-orderId="${orderHead.orderId}"  class="add addNewOrderCancel orderCancelAft"></a>
							  	 </c:if>
							</div>
						</div>
						<div class="col">
							<span class="sp">增加积分：</span><div class="sp-con"><a href="" class="add"></a></div>
						</div>
					</div>
					<div class="line">
						<div class="col">
							<span class="sp">商 家：</span>
							<p class="sp-con"><input type="text" name="" id="" value="${orderAddress.sellerName}" class="inputText3"/></p>
						</div>
						<div class="col">
							<span class="sp">手 机：</span>
							<p class="sp-con">${orderAddress.sellerTel}</p>
						</div>
						<div class="col">
							<span class="sp">邮 箱：</span>
							<p class="sp-con"><input type="text" name="" id="" value="${orderAddress.sellerEmail}" class="inputText3"/></p>
						</div>
						<div class="col">
							<span class="sp">结算类型：</span>
							<p class="sp-con">
							     <c:if test="${product.settlementType!=null}">
							           <spring:message code="product.settlementType.${product.settlementType}"/>
							     </c:if>
							</p>
						</div>
					</div>
					
				</div>
				
				<!--优惠信息-->
				<div class="mb20 orderActivity table">
				        <p>
				           <c:forEach items="${couponList}" var="coupon" varStatus="sta">
				               <c:if test="${sta.count==1}">
				                    本单参与优惠活动，  优惠券ID：${coupon.couponCode}，<span>优惠券名称：${coupon.name}，金额：${coupon.denomination}</span>
				               </c:if>
				           </c:forEach>
				        </p>
					<table cellspacing="0px" bordercolor="#cfd7dd" border="1px">
						<tr>
							<th>销售金额</th>
							<th>支付总积分</th>
							<th>现金积分</th>
							<th>促销积分</th>
							<th>获得积分</th>
							<th>运费</th>
							<th>优惠</th>
							<th>折扣</th>
							<th>礼品卡</th>
							<th>应收金额</th>
							<th></th>
						</tr>
						<tr>
							<td>￥${orderHead.originalAmount}</td>
							<td>0</td>
							<td>0</td>
							<td>0</td>
							<td>0</td>
							<td>￥${orderHead.totalPostage}</td>
							<td>${orderHead.couponAmount}</td>
							<td>${orderHead.sumDenomination}</td>
							<td>0</td>
							<td class="c-ff4400">￥${orderHead.paymentAmount}</td>
							<td></td>
						</tr>
					</table>
				</div>
				
				<!--商品信息-->
				<div class="mb20 orderProduct table">
					<table cellspacing="0px" bordercolor="#cfd7dd" border="1px">
						<tr>
							<th>商品图片</th>
							<th>商品SKU</th>
							<th>商品名称</th>
							<th>数量</th>
							<th>规格</th>
							<th>价格</th>
							<th>单位成本<span class="c-999">(结算价)</span></th>
							<th>折扣</th>
							<th>优惠</th>
							<th>积分</th>
							<th>金额小计</th>
						</tr>
						<c:forEach items="${orderHead.items}" var="item" varStatus="sta">
						   <c:if test="${sta.count%2!=0}"><tr class="ptb12"></c:if>
						   <c:if test="${sta.count%2==0}"><tr class="even ptb12"></c:if>
						   
						   <td><a target="_blank" href="http://www.yichengpin.com/order/order-snapshot.do?orderItemId=${item.orderItemId}"><img src="<yp:thumbImage originalPath='${item.defaultImage}' imageType='t84'></yp:thumbImage>" /></a></td>
							<td>${item.productSku.productSkuId}</td>
							<td class="c-258"><a target="_blank" href="http://www.yichengpin.com/order/order-snapshot.do?orderItemId=${item.orderItemId}">${item.productName}</a></td>
							<td>${item.num}</td>
							<td>${item.productProp}</td>
							<td>￥${item.unitPrice}</td>
							<td>￥${item.settlementPrice}</td>
							<td>${item.denomination}</td>
							<td>￥
							    ${item.couponAmount}
							</td>
							<td>0</td>
							<td class="c-ff4400">￥${(item.unitPrice*item.num)-item.couponAmount-item.denomination}</td>
						</c:forEach>
					</table>
				</div>
				
				<!--发货-->
				<div class="deliver">
					<%-- <span class="sp">发货：</span>
					<div class="fl module_Select">
                        <select id="test_1" class="trueMenu">
                            <c:forEach items="${listExpresses }" var="express" >
                            	<option value="${express.expressId }">${express.expressName}</option>
                            </c:forEach>
                        </select>
                        
                        <div class="newSelectCer"></div>
                    </div>
                    <input type="text" name="" id="" value="发货单号" class="inputText"/>
                    <button class="maageBtn_Green">确认发货</button> --%>
                    
                    <!-- 如果订单是未发货  显示发货信息 -->
                   	<c:if test="${(orderAddress.expressNo==null || orderAddress.expressNo== '') and orderHead.payType != 2 and orderHead.confirmStatus != 2}">
	                     <form id="form${orderHead.orderId}_${orderAddress.orderAddressId}" class="m-search">
	                             <span class="sp">发货：</span>
	                             <div class="fl module_Select">
		                             <select class="trueMenu" id="expressId${orderHead.orderId}_${orderAddress.orderAddressId}">
			                              <c:forEach items="${listExpresses }" var="express" >
			                              	<option value="${express.expressId }">${express.expressName}</option>
			                              </c:forEach>
		                             </select>
		                             <div class="newSelectCer"></div>
	                             </div>
	                             
	                             <input id="expressNo${orderHead.orderId}_${orderAddress.orderAddressId}" type="text" class="inputText" />
	                             
	                             <!-- 如果订单是未发货,如果存在退款申请，则必须是退款未通过,才 显示发货按钮 -->
	       						<c:if test="${orderHead.status == orderStatusWaitSend && (orderCancel==null || (orderCancel!=null && orderCancel.status==cancelStatuses[2]))}">
	                              <aut:authorize url="/admin/order/order-confirmSendProduct">
	                              		<input onclick="confirmSend('${orderHead.payType}','${orderHead.orderId}','${orderAddress.orderAddressId}')" type="button" class="maageBtn_Green" value="确认发货" />
	                              </aut:authorize>
	                            </c:if>
	                            
	                     </form>
                   	</c:if>
                   	<!-- 如果已经发货 显示物流信息 -->
		            <c:if test="${orderAddress.expressNo!=null && orderAddress.expressNo!= ''}">
                              <p>
                                  <label>物流公司：${orderAddress.expressName}</label>
                                  <label>面单号：${orderAddress.expressNo}</label>
                              </p>
                              
                    </c:if>                        	
                   	<c:if test="${orderHead.logisticStatus == 1}">
                   		已接单
                   	</c:if>
                   	
                   	<c:if test="${orderHead.status == 3 and orderHead.payType != 2}">
						<a href="javascript:void(0);" class="blue J_orderId" >修改物流单号</a>
						<input type="hidden" value="${orderHead.orderId}" />
						<input type="hidden" value="${orderHead.payType}" class="J_payType"/><br/>
					</c:if>
				</div>
				<div class="orderBtn">
				  <c:if test="${orderHead.status == 2}">
					<%--<c:if test="${orderHead.confirmStatus != 2 && (orderHead.orderCancel.status == null || orderHead.orderCancel.status == 2)}">
					     <input onclick="confirmOrder('${orderHead.orderId}');" type="button" class="maageBtn_1" value="确认订单" />
					</c:if>
					 <c:if test="${orderHead.orderCancel.status == null}">
						<input onclick="cancelOrder('${orderHead.orderId}');" type="button" class="maageBtn_1" value="取消订单"  />
					</c:if> --%>
				  </c:if>	
				</div>
				
			</div>
			<!--main end-->
			
			<!--##############################################弹出层  start####################################################-->
			<div id="popDiv" class="popupWrap" >
					<div class="shadeBg"></div>
					<!--新建售后退货单-->
					<div id="returnGoods" class="popup saleAfter">
						
					</div>
			</div>
			<!--####################################################弹出层  end#################################################-->
			<style>
				.checkTimeDiv{padding:10px;}
				.checkTimeDiv p{padding:5px 0;}
				.d-buttons{text-align: center;}
			</style>
			<div id="checkTimeDiv" style="display:none;">
				<div class="checkTimeDiv">
					<div id="old"></div>
					<input name="checkOrderId" id="checkOrderId" type="hidden" />
					<p>&nbsp&nbsp&nbsp&nbsp新单号:<input style="border:1px solid #ccc; margin-top:5px;" name="new" id="new" type="text" oncopy="return false;" oncut="return false;"/></p>
					<p>确认新单号:<input style="border:1px solid #ccc; margin-top:5px;" name="checkNew" id="checkNew" type="text" /></p>
					<p id="time" style="height:24px;width:300px;"></p>
				</div>
			</div>
	</body>
<script type="text/javascript">

	$(function(){
		
		 //初始化收货地址省市区下拉框
		 var linkage = new linkageSelect();
		 var province = '${regionModel.provinceId}';
		 var city = '${regionModel.cityId}';
		 var regionId = '${orderAddress.regionId}';
	     linkage.init({
	         "oneSel":['#receiver_province','请选择',province],
	         "twoSel":['#receiver_city', '请选择',city],
	         "threeSel":['#receiver_region', '请选择',regionId]
	     });
	     //保存收货地址
	     $("#saveAddressBut").bind("click", function(){
	    	 if($("#receiver_province").val()==0){
	        		alert("请选择省份！");
	        	}else if($("#receiver_city").val()==0){
	        		alert("请选择城市！");
	        	}else if($("#receiver_region").val()==0){
	        		alert("请选择区域！");
	        	}else if(!$("#receiver_detailAddress").val()){
	        		alert("请填写详细地址！");
	        	}else{
	        		var adr = $("#receiver_province").find("option:selected").text()+$("#receiver_city").find("option:selected").text()+$("#receiver_region").find("option:selected").text()+$("#receiver_detailAddress").val();
	        		var receiverName = $("#alter_receiverName").val();
	        		var reciverMobie = $("#alter_mobile").val();
	        		if(receiverName.lengh<=0){
	        			alert('收货人姓名不能为空');
	        		}if($("#receiver_detailAddress").val().length>50){
	        			alert('详细地址不能超过50个字符');
	        		}else if(!/^(13[0-9]|14[0-9]|15[0-9]|18[0-9]|17[0-9]|16[0-9]|12[0-9]|19[0-9])\d{8}$/i.test(reciverMobie)){
	        			alert('手机号码格式不正确');
	        		}else{
						$.ajax({
							type:'POST',
							url: _ctxPath + '/admin/order/order-alterRecive.htm',
							data: $("#alterReciveForm").serialize(),
							success:function(msg){
								if(msg.code == "true"){
									alert("收货地址修改成功！");
								}else{
									alert(msg.info);
								}
							}
						});
					}
	        	}
			});
	     
		$("#search").bind("click", function() {
			$("#subform").submit();
		});	
		
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
		
		/*配送物流信息*/
		$(".i-wl").click(function(){
			$(this).closest(".col").find(".wl-info").show();
		});
		$(".wl-info").mouseleave(function(){
			$(".wl-info").hide();
		});
		/*计算高度*/
		var wH = $(window).height();
		$(".popup").css("height",(wH-100)+'px');
		$(".popup").css("margin-top",(-(wH-100)/2)+'px');
		
		$(window).resize(function (){
			var wH = $(window).height();
			$(".popup").css("height",(wH-100)+'px');
			$(".popup").css("margin-top",(-(wH-100)/2)+'px');
		})
		
		//查看退款单详情
		$(".getOrderCancelDetail").bind("click", function() {
			getOrderCancelDetail($(this));
		});
		
		//管理员新建退款
		$(".addNewOrderCancel").bind("click", function() {
			var _this= $(this);
			var orderId = _this.attr("data-orderId");
			var refundType = _this.attr("data-refundType");
			var detailDialog = $.dialog({
				    lock: true,
				    title:false,
				    okValue: "确认",
			        ok: function(){
			        	var bnkOfDepositFlag = true;
			        	var personNameFlag = true;
			        	var refundAccountNoFlag = true;
			        	var refundAmountFlag = true;
			        	var payType = $(".refundPayType:checked").val();
			        	if(payType==1){
			        		$("#bankOfDeposit").blur();
			        		bankOfDepositFlag = checkTrim($("#bankOfDeposit").val())&&($("#bankOfDeposit").val().length<=25);
			        	}
			        	$("#personName").blur();
			        	personNameFlag = checkTrim($("#personName").val())&&($("#personName").val().length<=25);
			        	$("#refundAccountNo").blur();
			        	refundAccountNoFlag = checkTrim($("#refundAccountNo").val())&&($("#refundAccountNo").val().length<=25);
			        	$("#refundAmount").blur();
			        	refundAmountFlag = checkRefundAmountValue($("#refundAmount").val());
			        	if(!(bnkOfDepositFlag&&personNameFlag&&refundAccountNoFlag&&refundAmountFlag)){
			        		return false;
			        	}else{
			        		$.ajax({
								type:'POST',
								url: _ctxPath + '/admin/order/orderMgr-saveOrderCancel.htm',
								data: $("#orderCancelForm").serialize(),
								success:function(msg){
									if(msg.code == "true"){
										showMsgDialog("申请退款成功，请等待商户审核！退款单号:<a href='javascript:void(0);' onclick='javascript:getOrderCancelDetail($(this));' data-cancelStatus='"+msg.infoValues[2]+"' data-cancelId='"+msg.infoValues[1]+"' class='getOrderCancelDetail'>"+msg.infoValues[0]+"</a>");
										if(refundType==0){
											//售前退款
											$(".orderCancelBef").before("<a href='javascript:void(0);' onclick='javascript:getOrderCancelDetail($(this));' data-cancelStatus='"+msg.infoValues[2]+"' data-cancelId='"+msg.infoValues[1]+"' class='getOrderCancelDetail'>"+msg.infoValues[0]+"</a>");
										}else{
											$(".orderCancelAft").before("<a href='javascript:void(0);' onclick='javascript:getOrderCancelDetail($(this));' data-cancelStatus='"+msg.infoValues[2]+"' data-cancelId='"+msg.infoValues[1]+"' class='getOrderCancelDetail'>"+msg.infoValues[0]+"</a>");
										}
									}else{
										showMsgDialog(msg.info);
										return false;
									}
								},
								error: function(xhr){
									showMsgDialog(xhr.responseText);
						        }
							});
			        	}
			        	
			        },
			        cancelValue:"取消",
					cancel:true,
				    visible: false
			  });
				 
			  $.ajax({
					type:'POST',
					url: '${_ctxPath}/admin/order/orderMgr-addOrderCancel.htm',
					data: {'orderHead.orderId':orderId,'orderCancel.refundType':refundType},
					success:function(html){
						detailDialog.visible().content(html);
						$(".popupOuter").ready(function(){
							createModule($(".popupOuter"));
						})
					},
					error: function(xhr){
						showMsgDialog(xhr.responseText);
			        }
				});
			  $(".d-close").hide();
		});
		
	})
		
		//查看退款单详情
		function getOrderCancelDetail(obj){
			var _this= obj;
			var orderCancelId = _this.attr("data-cancelId");
			var cancelStatus = _this.attr("data-cancelStatus");
			var _okBtn = "确认";
			var _noBtn = "取消";
			if('${isAdmin}'!='true'){
				if(cancelStatus==1){
					_okBtn = "审核通过";
					_noBtn = "审核不通过";
				}
			}else if('${isAdmin}'=='true'){
				if(cancelStatus==3){
					_okBtn = "确认退款";
				}
			}
			var detailDialog = $.dialog({
				    lock: true,
				    title:"退款单详情",
				    okValue: _okBtn,
			        ok: function(){
					      if(_okBtn=="审核通过"){
					        //============审核通过===================START============
								var orderId = $("#currentCancelOrderId").val();
								var cancelId = $("#currentCancelOrderCancelId").val();
								$.dialog({
									title: "提示",
									lock:true,
									content: "审核通过后，请等待管理员确认退款。",
								    okValue: "确定",
								    ok: function(){
								    	$.ajax({
											type:'post',
											data:{'orderCancel.orderCancelId':cancelId,'orderCancel.orderId':orderId},
											url:'${_ctxPath}/admin/order/order-passCancelAudit.htm',
											success:function(data){
												if(data.code=='true'){
													showMsgDialog("审核成功！");
													_this.attr("data-cancelStatus","3");
												}else{
													if(undefined != data.info){
														showMsgDialog(data.info);
													}
												}
											},
											error:function(data){
												if(undefined != data.info){
													showMsgDialog(data.info);
												}
											}
										});
								    },
								    cancelValue:"取消",
								    cancel: function(){
								    	
								    }
								});
// 							============审核通过===================END============	
					      }else if(_okBtn=="确认退款"){
					    	//============确认退款===================START============
					    		var orderId = $("#currentCancelOrderId").val();
								var cancelId = $("#currentCancelOrderCancelId").val();
								var paymentAmount = $("#currentCancelPaymentAmount").val();
								var dialogHtmlContent = '请输入退款金额：<p>'
									+'<input type="text" id="refundMoney" value=""/>'
									+'</p><label style="color:red;" id="refundL"/>';
								$.dialog({
									title: "提示",
									lock:true,
									content: dialogHtmlContent,
								    okValue: "确定",
								    ok: function(){
								    	var money = $("#refundMoney").val();
										if(!money){
											$("#refundL").html("请输入退款金额！");
											return false;
										}
										if(!/^(?!0\d)\d+(\.\d{0,3})?$/.test(money)){
											$("#refundL").html("请输入正确的金额数字，最多可以有3为小数！");
											return false;
										}
										money = parseFloat(money);
										if(money<=0 || money > paymentAmount){
											$("#refundL").html("退款金额不能大于实际付款金额！");
											return false;
										}
										$.ajax({
											type:'post',
											data:{
												'orderCancel.orderCancelId':cancelId,
												'orderCancel.refundAmount':money
											},
											url:'${_ctxPath}/admin/order/order-agreePayment.htm',
											success:function(data){
												if(data.code=='true'){
													showMsgDialog("退款成功！");
													_this.attr("data-cancelStatus","4");
												}else{
													if(undefined != data.info){
														showMsgDialog(data.info);
													}
												}
											},
											error:function(data){
											},
											oncomplete:function(data){
											}
										});
								    },
								    cancelValue:"取消",
								    cancel: function(){
								    	
								    }
								});
							//============确认退款===================END============
					      }
			        },
			        cancelValue:_noBtn,
			        cancel: function(){
			        	//============审核不通过===================START============
			        	  if(_noBtn=="审核不通过"){
			        		var orderId = $("#currentCancelOrderId").val();
							var cancelId = $("#currentCancelOrderCancelId").val();
			  				var dialogHtmlContent = '请输入审核不通过的原因：<p>'
			  					+'<textarea id="rejectCAR" rows="3" cols="30"}/>'
			  					+'</p><label style="color:red;" id="rejectCARL"/>';
			  				$.dialog({
			  					title: "提示",
			  					lock:true,
			  					content: dialogHtmlContent,
			  				    okValue: "确定",
			  				    ok: function(){
			  				    	var reason = $("#rejectCAR").val();
			  						if(!reason){
//			   							showMsgDialog("请填写未通过原因");
//			   							return;
			  							$("#rejectCARL").html("请填写未通过原因");
			  							return false;
			  						}
			  						//审核原因不能超过50个字符(包含汉字)
			  						var ascRegexp = "/[^/x00-/xFF]/g";
			  						var reasonLen=reason.replace(ascRegexp, '..').length;
			  						if(reasonLen>50){
			  							$("#rejectCARL").html("审核原因不能超过50个字符(包含汉字)");
			  							return false;
			  						}
			  						$.ajax({
			  							type:'post',
			  							data:{
			  								'orderCancel.orderCancelId':cancelId,
			  								'orderCancel.reviewDescribe':reason
			  							},
			  							url:'${_ctxPath}/admin/order/order-rejectCancelAudit.htm',
			  							success:function(data){
			  								if(data.code=='true'){
			  									showMsgDialog("审核成功！");
												_this.attr("data-cancelStatus","2");
			  								}else{
			  									if(undefined != data.info){
			  										showMsgDialog(data.info);
			  									}
			  								}
			  							},
			  							error:function(data){
			  								if(undefined != data.info){
			  									showMsgDialog(data.info);
			  								}
			  							}
			  						});
			  				    },
			  				    cancelValue:"取消",
			  				    cancel: function(){
			  				    	
			  				    }
			  				});
			        	  }
			        	//============审核不通过===================END============	
			        },
				    visible: false
			  });
				 
			  $.ajax({
					type:'POST',
					url: '${_ctxPath}/admin/order/orderMgr-getRefundOrderDetail.htm',
					data: {'orderCancel.orderCancelId':orderCancelId},
					success:function(html){
						detailDialog.visible().content(html);
						$(".popupOuter").ready(function(){
							createModule($(".popupOuter"));
						})
					},
					error: function(xhr){
						showMsgDialog(xhr.responseText);
			        }
				});
			  
			//隐藏取消按钮
			   if('${isAdmin}'!='true'){
					if(cancelStatus!=1){
						$(".d-button[value=\"取消\"]").hide();
					}
				}else if('${isAdmin}'=='true'){
					if(cancelStatus!=3){
						$(".d-button[value=\"取消\"]").hide();
					}
				}
		}
	
	//点击回车提交客服内容
	var KeyDown=function(orderId){
		 var event=arguments.callee.caller.arguments[0]||window.event;//消除浏览器差异
	    if(event.keyCode==13)
	    {
	    	event.keyCode=0;
	    	addOrderCrm(orderId);
	    	return false;
	    }
	}
	//增加客服评价
	function addOrderCrm(orderId){
		var userName = '',
		myDate = new Date();
		myDate = ChangeTimeToString(myDate);
		var temp =$("#remark_"+orderId).val();
		
		var kgTemp=temp.replace(/[ ]/g,"");
		if(temp==null || temp.length==0 || kgTemp.length==0)
		{
			alert("内容不能为空，或者全部是空格");return false;
		}
		else if(temp.length>500)
		{
			alert("请输入500字符以内的内容");return false;
		}
		else{
			temp=temp.replace(/<[^>]+>/g,"");
			$("#remark_"+orderId).val("");
			$.ajax({
				url:_ctxPath + "/admin/orderCrm/orderCrm-addOrderCrm.htm",
				type:"POST",
				data:{'orderCrm.remark':temp,'orderCrm.orderId':orderId},
				async: false,
				success:function(data){
					userName=data.info;
					$("#remark_ul").find("li").each(function(){ 
						$(this).attr("class","");
					});
					var temp_html ="<li class=\"c-ff4400\"><span>"+userName+""+myDate+"</span><p>"+temp+"</p></li>"
					$("#remark_ul").html(temp_html+$("#remark_ul").html());
					return true;
				},
				error:function(data){
					alert("客服留言出错，请联系一城一品客服");
				}
			});
		}
	}
	function ChangeTimeToString(DateIn){
		var Year =Month = Day = Hour =Minute = 0,
				CurrentDate="";
		// 初始化时间
		Year=DateIn.getFullYear();
		Month=DateIn.getMonth()+1;
		Day=DateIn.getDate();
		Hour=DateIn.getHours();
		Minute=DateIn.getMinutes();
		Seconds=DateIn.getSeconds()
		CurrentDate=Year+"-";
		if(Month>=10){
			CurrentDate=CurrentDate+Month+"-";
		}
		else{
			CurrentDate=CurrentDate+"0"+Month+"-";
		}
		if(Day>=10){
			CurrentDate=CurrentDate+Day;
		}
		else{
			CurrentDate=CurrentDate+"0"+Day;
		}
		if(Hour>=10){
			CurrentDate=CurrentDate+" "+Hour;
		}
		else{
			CurrentDate=CurrentDate+" 0"+Hour;
		}
		if(Minute >=10){
			CurrentDate = CurrentDate +":"+Minute;
		}
		else{
			CurrentDate =CurrentDate+":0"+ Minute;
		}
		return CurrentDate;
	}
	//*******************查询或添加退货信息*****************
	function showRefund(refundNo,orderId)
	{
		//initTable();
		//定义商品列表
		$.ajax({
			url:_ctxPath + "/admin/order/orderMgr-showRefundGood.htm",
			type:"POST",
			data:{'orderRefund.orderRefundNo':refundNo,'orderHead.orderId':orderId},
			async: false,
			success:function(data){
				if(refundNo.length>0){
					$.dialog({
						lock:true,
						title:false,
						content: data	  				   
					});
				}else{
					$.dialog({
						lock:true,
						title:false,
						content: data,
						okValue: "确定",
						 ok: function(){
							    var customerName=$("#customerName_rg").val();
								if(customerName=="" || customerName.length==0){
									showMsgDialog("联系人不能为空");return false;
								}
								var mobile=$("#mobile_rg").val();
								if(mobile=="" || mobile.length==0){
									showMsgDialog("手机号码不能为空");return false;
								}
								if (!/^(13[0-9]|14[0-9]|15[0-9]|18[0-9]|17[0-9]|16[0-9]|12[0-9]|19[0-9])\d{8}$/i.test(mobile)) 
							    {  
									showMsgDialog("手机号码格式不对");return false;
							    }
								
								var refundReasonTypeSelect=$("#refundReasonTypeSelect").val();
								if(refundReasonTypeSelect=="" || refundReasonTypeSelect.length==0){
									showMsgDialog("退款原因不能为空");return false;
								}
								var refundReason=$("#refundReason_rg").val();
								if(refundReason=="" || refundReason.length==0){
									showMsgDialog("退款理由不能为空");return false;
								}
								if(refundReason.length>500){
									showMsgDialog("退款理由长度不能大于500");return false;
								}
								//获取商品列表
								var orderItemIds="";
								var nums="";
								$("[name = orderItemIdCheckbox_rg]:checkbox").each(function(){ 
									if($(this).is(':checked')==true){
										orderItemIds+=$(this).attr("value")+",";
										if(parseInt($("#num_"+$(this).attr("value")).val()==0)<=0){
											alert("退货数量必须大于0");return false;
										}
										nums+=$("#num_"+$(this).attr("value")).val()+",";
									}
								});
								if(orderItemIds=="" || orderItemIds.length==0){
									showMsgDialog("未选中商品");return false;
								}
								
								var orderId=$("#orderIdHidden").val();
								
								//保存退款商品信息
								$.ajax({
										url:_ctxPath + "/admin/order/orderMgr-addRefundRecord.htm",
										type:"POST",
										data:{'orderRefund.orderId':orderId,'orderRefund.customerName':customerName,'orderRefund.mobile':mobile
											,'orderRefund.refundReasonType':refundReasonTypeSelect,
											'orderRefund.refundReason':refundReason,"orderItemIds":orderItemIds,"nums":nums},
										dataType:"json",
										async: false,
										success:function(data){ 
											var s="";
											for(var i=0;i<data.length;i++)
											{
											   s+="<a href=\"javascript:void(0);\" onclick=\"showRefund('"+data[i]+"','"+orderId+"');\">"+data[i]+"</a>   ";
											}
											/* $("#popDiv").hide();
											$("#returnGoods").hide(); */
											$("#refundDivA").html($("#refundDivA").html()+s);
											showMsgDialog("新建退货单成功，退货单号："+s);
										},
										error:function(data){
											showMsgDialog("添加退货信息出错，请联系一城一品客服");return false;
										}
									});
						}
					});
				}
				$(".d-dialog").ready(function(){
					createModule($(".d-dialog"));
				})
			},
			error:function(data){
				alert("退货页面加载出错，请联系一城一品客服");
			}
		});
		/* $("#popDiv").show();
		$("#returnGoods").show(); */
	}
	//隐藏查询或添加退货信息
	function hideRefund()
	{
		$("#popDiv").hide();
		$("#returnGoods").hide();
	}
	//全选按钮
	function selectAllCheck(ownId,sName)
	{
		if($("#"+ownId).is(':checked')==true)
		{
			$("[name = "+sName+"]:checkbox").each(function(){ 
				$(this).attr("checked","checked");
			});
		}else{
			$("[name = "+sName+"]:checkbox").each(function(){ 
				$(this).removeAttr("checked");
			});
		}
	}
	//初始化table
	function initTable()
	{
		$("#customerName_rg").val("");
		$("#mobile_rg").val("");
		$("#refundReason_rg").val("");
		$("#images_rg").html("");
		$("#images_dl_rg").show();
		$("#addRetGoodsButton").show();
		$("#selectAll_rg").show();
		$("#refundReasonTypeSelect").get(0).selectedIndex=0;
	}
	//检查数字不能超过最大
	function checkMaxNum(id)
	{
		var num=$("#"+id).val();
		var maxNum=$("#"+id).attr("maxNum");
		var re = /^[1-9]+[0-9]*]*$/;
	    if (!re.test(num))  
	    {  
	    	$("#"+id).val(maxNum);
	    }else{
	    	if(num>maxNum){
	    		$("#"+id).val(maxNum);
	    	}
	    }
	}
	//新建保存退货单
	function addRetGoods()
	{
		var customerName=$("#customerName_rg").val();
		if(customerName=="" || customerName.length==0){
			alert("联系人不能为空");return;
		}
		var mobile=$("#mobile_rg").val();
		if(mobile=="" || mobile.length==0){
			alert("手机号码不能为空");return;
		}
		if (!/^(13[0-9]|14[0-9]|15[0-9]|18[0-9]|17[0-9]|16[0-9]|12[0-9]|19[0-9])\d{8}$/i.test(mobile)) 
	    {  
			alert("手机号码格式不对");return;
	    }
		
		var refundReasonTypeSelect=$("#refundReasonTypeSelect").val();
		if(refundReasonTypeSelect=="" || refundReasonTypeSelect.length==0){
			alert("退款原因不能为空");return;
		}
		var refundReason=$("#refundReason_rg").val();
		if(refundReason=="" || refundReason.length==0){
			alert("退款理由不能为空");return;
		}
		if(refundReason.length>500){
			alert("退款理由长度不能大于500");return;
		}
		//获取商品列表
		var orderItemIds="";
		var nums="";
		$("[name = orderItemIdCheckbox_rg]:checkbox").each(function(){ 
			if($(this).is(':checked')==true){
				orderItemIds+=$(this).attr("value")+",";
				nums+=$("#num_"+$(this).attr("value")).val()+",";
			}
		});
		if(orderItemIds=="" || orderItemIds.length==0){
			alert("未选中商品");return;
		}
		//保存退款商品信息
		$.ajax({
				url:_ctxPath + "/admin/order/order-addRefundRecord.htm",
				type:"POST",
				data:{'orderRefund.customerName':customerName,'orderRefund.mobile':mobile
					,'orderRefund.refundReasonType':refundReasonTypeSelect,
					'orderRefund.refundReason':refundReason,"orderItemIds":orderItemIds,"nums":nums},
				dataType:"json",
				async: false,
				success:function(data){ 
					var s="新建退货单成功，退货单号：";
					for(var i=0;i<data.length;i++)
					{
					   s+=(i+1)+":"+data[i]+"  ";
					}
					alert("创建成功:"+s);
					$("#popDiv").hide();
					$("#returnGoods").hide();
				},
				error:function(data){
					alert("添加退货信息出错，请联系一城一品客服");
				}
			});
	}
	
	//确认发货
	function confirmSend(orderPayType,id,pkgId){
		var num = id.toString();
    	var expressName = $("#expressId"+id+"_"+pkgId+" option:selected").text();
		var expressId = $("#expressId"+id+"_"+pkgId+" option:selected").val();
        var expressMailNo = $("#expressNo"+id+"_"+pkgId).val();
        var paytype = orderPayType;
        if('请输入快递单号'== expressMailNo || ''==expressMailNo){
        	alert("请输入快递单号");
        	return;
        }
        if(expressMailNo.length>20){
        	alert("请输入1-20位快递单号");
        	$("#expressNo"+id+"_"+pkgId).val("");
        	return;
        }
        if(paytype == 2 ){
        	if(expressMailNo.startWith("D") && expressMailNo.length ==10 && !isNaN(expressMailNo.substring(1))){
        	}else{
        		alert("货到付款订单,请输入以D开头,9位数字结尾的订单号 ");
        		return;
        	}
        }
        checkMailNo(expressId,expressName,expressMailNo,id,pkgId);
   }
   function checkMailNo(expressId,expressName,expressMailNo,id,pkgId){
		  $.ajax({
				type : 'POST',
				url : '${_ctxPath}/admin/order/order-checkMailNo.htm',
				data : {
						'orderAddress.expressNo' :expressMailNo
						},
				success : function(data) {
					if(data.code=='true'){
						$.dialog({
							"title":false,
							"content":data.info,
							"okValue":"确定",
							"cancelValue":"取消",
							"cancel":true,
							"ok":function(){
								sendProduct(expressId,expressName,expressMailNo,id,pkgId);		
							}
							
						});
					}else{
						sendProduct(expressId,expressName,expressMailNo,id,pkgId);
					}
				},
				error:function(data){
					if(undefined != data.info){
						alert(data.info);
					}
				}
			});
	}
	function sendProduct(expressId,expressName,expressMailNo,id,pkgId){
		$.ajax({
			type : 'POST',
			url : '${_ctxPath}/admin/order/order-confirmSendProduct.htm',
			data : {'orderAddress.expressId':expressId,
					'orderAddress.expressName' : expressName,
					'orderAddress.expressNo' :expressMailNo,
					'orderAddress.orderId': id,
					'orderAddress.orderAddressId': pkgId
					},
			success : function(data) {
				if(data.code=='true'){
					alert(data.info);
					var content='<td colspan="3"><label>状态：</label><span>已发货</span>\t'+'<label>物流公司：</label><span>'+expressName+'</span>\t'+'<label>运单号码：</label><span>'+expressMailNo+'</span></td>'
					$tr = $("#form"+id+"_"+pkgId);
					$tr.empty();
					$tr.html(content);
					$('#search').click();
				}else{
					if(undefined != data.info){
						alert(data.info);
					}
				}
			},
			error:function(data){
				if(undefined != data.info){
					alert(data.info);
				}
			}
		});
	}
	//确认订单
	function confirmOrder(orderId){
		if(confirm('您确认需要确认此订单吗？')){
			$.ajax({
				type : 'POST',
				url : '${_ctxPath}/admin/order/order-confirmOrder.htm',
				data : {'orderHead.orderId':orderId},
				success : function(data) {
					if(data.code=='true'){
						alert(data.info);
						$('#search').click();
					}else{
						if(undefined != data.info){
							alert(data.info);
						}
					}
				},
				error:function(data){
					if(undefined != data.info){
						alert(data.info);
					}
				}
			});
		  	$(".d-close").hide();
		}		
	}
	//取消订单
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
	//修改物流单号
	var timer;
	$(".J_orderId").on("click",function(){	
		if(timer){
			
			clearInterval(timer);
		}
		$("#time").html("");
		var orderID=$(this).next().val();
		var orderpayType=$(this).parent().find(".J_payType");
		$.ajax({
			type : 'POST',
			url : '${_ctxPath}/admin/order/order-getSendProductTime.htm',
			data : {
					'orderAddress.orderId': orderID
					},
			success : function(data) {
				if(data.code=='true'){
					var jsonObj = eval('(' + data.info + ')');
					$("#old").html("&nbsp&nbsp&nbsp&nbsp原单号:" + jsonObj.expressNo);
					$("#new").val("");
					$("#checkOrderId").val(orderID);
					$("#checkNew").val("");
					$("#new,#checkNew").prop("disabled",false);
					$(".d-state-highlight").prop("disabled",false);
					$.dialog({
						"title":false,
						"content":$("#checkTimeDiv").html(),
						"okValue":"确定",
						"cancelValue":"取消",
						"cancel":true,
						"ok":function(){
							var newExpressNo = $("#new").val();
							var checkExpressNo = $("#checkNew").val();
							var orderId = $("#checkOrderId").val();
							
							if(newExpressNo.length == 0){
								alert("单号不能为空!");
							}else if(newExpressNo == checkExpressNo){
								if(orderpayType.val() == 2 ){
						        	if(newExpressNo.startWith("D") && newExpressNo.length ==10 && !isNaN(newExpressNo.substring(1))){
						        		
						        	}else{
						        		alert("货到付款订单,请输入以D开头,9位数字结尾的订单号 ");
						        		return;
						        	}
						     	 }
								$.ajax({
									type : 'POST',
									url : '${_ctxPath}/admin/order/order-updateExpressNo.htm',
									data : {
											'orderAddress.expressNo': newExpressNo,
											'orderAddress.orderId':orderId
											},
									success : function(data) {
										if(data.code=='true'){
											alert("修改成功 !");
											$('#search').click();
										}else{
											if(undefined != data.info){
												alert(data.info);
											}
										}
									},
									error:function(data){
										if(undefined != data.info){
											alert(data.info);
										}
									}
								});
							}else{
								alert("两次输入新单号不同，请检查!");
							}
						}
						
					});
					//倒计时
					var sendTime=jsonObj.sendTime;
					timer=setInterval(function(){
						var newTime=new Date().getTime();
						var time=15*60*1000;
						var areTime=(sendTime+time-newTime)/1000;
						var se=Math.floor(areTime%60);
						var mi=Math.floor(areTime/60);
						if(sendTime+time>=newTime){
							$("#time").html("你还剩余<front style='color:red'>"+mi+"</front>分<front style='color:red'>"+se+"</front>秒修改物流单号 ");
						}else{
							$("#new,#checkNew").prop("disabled",true);
							$(".d-state-highlight").prop("disabled",true);
							$("#time").html("已过<front style='color:red'>15</front>分钟不能修改 ");
							if(timer){
								
								clearInterval(timer);
							}
						}
					},1000);
				}else{
					if(undefined != data.info){
						alert(data.info);
					}
				}
			},
			error:function(data){
				if(undefined != data.info){
					alert(data.info);
				}
			}
		});
	});
</script>
</html>