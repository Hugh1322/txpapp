<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="aut" uri="http://www.springsecurity.org/jsp" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>订单管理-销售单管理</title>
		<link rel="stylesheet" type="text/css" href="${_jsPath }/new/css/base.css?v=${_resVerion}"/>
        <link rel="stylesheet" href="${_jsPath }/new/calendar/kalendae.css?v=${_resVerion}" type="text/css" charset="utf-8">
        <script type="text/javascript" src="${_jsPath }/new/js/jquery-1.11.0.min.js?v=${_resVerion}"></script>
		<script src="${_jsPath }/new/calendar/kalendae.standalone.js?v=${_resVerion}" type="text/javascript" charset="utf-8"></script>
        <script type="text/javascript" src="${_jsPath }/new/js/manage_basefun.js?v=${_resVerion}"></script>
        <script type="text/javascript" src="${_jsPath}/plugin/uploadify/jquery.uploadify.v2.1.4.min.js?v=${_resVerion}"></script>
		<script type="text/javascript" src="${_jsPath}/plugin/uploadify/swfobject.js?v=${_resVerion}"></script>
	</head>
	<body>
		<jsp:include page="../include/headerNew.jsp" flush="true" />
			<!--main-->
			<div class="main">
				
				<!--面包屑-->
				<div class="crumb">
					<!--<a href="" class="fr export"><i></i><input type="button" name="" id="" value="导出"/></a>-->
					<aut:authorize url="/admin/order/order-exportSaleOrders">
						<button class="fr export" id="export"><i></i>
			      				导出
						</button>
					</aut:authorize>
					<p>
						<a href="" class="home"><i></i></a>
						<span class="sep"></span>
						<a href="">订单管理</a>
						<span class="sep"></span>
						<a href="">销售单管理</a>
					</p>
				</div>
				
				<!--查询条件-->
				<form class="m-mt10p m-clear" action="${_ctxPath}/admin/order/orderMgr-searchSaleOrders.htm" method="get" id="subform">
				<div class="query">
					<div class="line">
						<c:choose>
							<c:when test="${isAdmin eq true }">
								<div id="seller" class="col searchInput">
									<span class="sp">商家：</span>
									<input type="text" name="resultPage.params.sellerName" id="" value="${resultPage.params.sellerName}" class="inputText"/>
									<input type="hidden" name="resultPage.params.sellerId" class="valueId" value="${resultPage.params.sellerId}"/>
									<textarea name="" rows="" cols="" class="textData"></textarea>
									<div><ul></ul></div>
								</div>
							</c:when>
							<c:otherwise>
								<input type="hidden" name="resultPage.params.sellerId" class="valueId" value="${resultPage.params.sellerId}"/>
							</c:otherwise>
						</c:choose>
						<div id="brand" class="col searchInput">
							<span class="sp">品牌：</span>
							<input type="text" name="resultPage.params.brandName" id="" value="${resultPage.params.brandName}" class="inputText"/>
							<input type="hidden" name="resultPage.params.brandId" class="valueId" value="${resultPage.params.brandId}"/>
							<textarea name="" rows="" cols="" class="textData"></textarea>
							<div><ul></ul></div>
						</div>
						<div class="col">
							<span class="sp">支付方式：</span>
							<div class="fl">
                                <div class="fl module_Select">
                                	<select name="resultPage.params.payType" class="trueMenu">
										<option value="">全部支付方式</option>
										<c:forEach items="${payList }" var="pay" varStatus="status">
											<option value="${pay }"
												<c:if test="${resultPage.params.payType==pay }">
													selected = "selected"
												</c:if>
												<c:if test="${resultPage.params.payType!=pay and (status.count eq 1) }">
													selected = "selected"
												</c:if>
												><spring:message code="order.payment.type.${pay}"/></option>
										</c:forEach>
									</select>
                                    <div class="newSelectCer"></div>
                                </div>
								<div class="fl module_Select">
									<select name="resultPage.params.timeType" class="trueMenu">
										<c:forEach items="${timeList }" var="time" varStatus="status">
											<option value="${time }" 
												<c:if test="${resultPage.params.timeType==time }">
													selected = "selected"
												</c:if>
												<c:if test="${resultPage.params.timeType!=time and (status.count eq 1) }">
													selected = "selected"
												</c:if>
												><spring:message code="order.timement.type.${time}"/></option>
										</c:forEach>
									</select>
                                    <div class="newSelectCer"></div>
                                </div>
                              <input type="text" name="resultPage.params.beginTime" value="${resultPage.params.beginTime }" class="inputText bgcf9f calendarOne beginTime"/>
								<span class="fl">至&nbsp;&nbsp;</span>
							  <input type="text" name="resultPage.params.endTime" value="${resultPage.params.endTime }" class="inputText bgcf9f calendarOne endTime"/>
							</div>
						</div>
					</div>

					<div class="line">
						<div class="col">
							<span class="sp">用户名：</span>
							<input type="text" name="resultPage.params.username" id="" value="${resultPage.params.username }" class="inputText bgcf9f"/>
						</div>
						<div class="col">
							<span class="sp">收货人：</span><input type="text" name="resultPage.params.receiverName" id="" value="${resultPage.params.receiverName }" class="inputText bgcf9f"/>
						</div>
						<div class="col">
							<span class="sp">收货地址：</span><input type="text" name="resultPage.params.receiveAddress" id="" value="${resultPage.params.receiveAddress }" class="inputText bgcf9f"/>
						</div>
						<div class="col">
							<span class="sp">收货手机：</span><input type="text" name="resultPage.params.mobile" id="" value="${resultPage.params.mobile }" class="inputText bgcf9f"/>
						</div>
					</div>
					<div class="line">
						<div class="col">
							<span class="sp">订单号：</span><input type="text" name="resultPage.params.orderNo" id="" value="${resultPage.params.orderNo }" class="inputText bgcf9f"/>
						</div>
						<div class="col">
							<span class="sp">交易号：</span><input type="text" name="resultPage.params.dealCode" id="" value="${resultPage.params.dealCode }" class="inputText bgcf9f"/>
						</div>
						<div class="col">
							<span class="sp">包裹号：</span><input type="text" name="resultPage.params.packageNo" id="" value="${resultPage.params.packageNo }" class="inputText bgcf9f"/>
						</div>
						<div class="col">
							<span class="sp">订单金额：</span><input type="text" name="resultPage.params.paymentAmount" id="" value="${resultPage.params.paymentAmount }" class="inputText bgcf9f"/>
						</div>
						<div class="col">
							<span class="sp">商品sku：</span><input type="text" name="resultPage.params.productSkuId" id="" value="${resultPage.params.productSkuId}" class="inputText bgcf9f"/>
						</div>
					</div>
					<div class="line">
						<div class="col">
							<span class="sp">订单类型：</span>
							<div class="fl module_Select">
								<select name="resultPage.params.orderType" class="trueMenu">
									<option value=""
										<c:if test="${resultPage.params.orderType=='' || resultPage.params.orderType==null}">
											selected = "selected"
										</c:if>>全部订单</option>
									<option value="1" 
										<c:if test="${resultPage.params.orderType==1 }">
											selected = "selected"
										</c:if>>普通订单</option>
									<option value="4"
										<c:if test="${resultPage.params.orderType==4 }">
											selected = "selected"
										</c:if>>团购订单</option>
									<option value="3"
										<c:if test="${resultPage.params.orderType==3 }">
											selected = "selected"
										</c:if>>抢购订单</option>
									<option value="6"
										<c:if test="${resultPage.params.orderType==6 }">
											selected = "selected"
										</c:if>>兑换订单</option>
									<option value="7"
										<c:if test="${resultPage.params.orderType==7 }">
											selected = "selected"
										</c:if>>海外购订单</option>
									<option value="8"
										<c:if test="${resultPage.params.orderType==8 }">
											selected = "selected"
										</c:if>>零元试吃</option>
									<option value="9"
										<c:if test="${resultPage.params.orderType==9 }">
											selected = "selected"
										</c:if>>内部订单</option>
								</select>
                                <div class="newSelectCer"></div>
                            </div>
						</div>
						<div class="col">
							<span class="sp">订单状态：</span>
							<div class="fl module_Select">
								<select name="resultPage.params.status" id="status" class="trueMenu">
									<option value=""
										<c:if test="${resultPage.params.status=='' || resultPage.params.status==null}">
											selected = "selected"
										</c:if>>全部状态</option>
									<option value="1" 
										<c:if test="${resultPage.params.status==1 }">
											selected = "selected"
										</c:if>>待付款</option>
									<option value="2" 
										<c:if test="${resultPage.params.status==2 }">
											selected = "selected"
										</c:if>>待发货</option>
									<option value="3" 
										<c:if test="${resultPage.params.status==3 }">
											selected = "selected"
										</c:if>>已发货</option>
									<option value="4" 
										<c:if test="${resultPage.params.status==4 }">
											selected = "selected"
										</c:if>>已完成</option>
									<option value="5" 
										<c:if test="${resultPage.params.status==5 }">
											selected = "selected"
										</c:if>>已取消</option>
									<option value="6" 
										<c:if test="${resultPage.params.status==6 }">
											selected = "selected"
										</c:if>>全部退货</option>
									<option value="7" 
										<c:if test="${resultPage.params.status==7 }">
											selected = "selected"
										</c:if>>部分退货</option>
								</select>
                                <div class="newSelectCer"></div>
                            </div>
						</div>
						<div class="col">
							<span class="sp">付款状态：</span>
							<div class="fl module_Select">
								<select name="resultPage.params.payStatus" class="trueMenu">
									<option value=""
										<c:if test="${resultPage.params.payStatus=='' || resultPage.params.payStatus==null}">
											selected = "selected"
										</c:if>>全部状态</option>
									<option value="1" 
										<c:if test="${resultPage.params.payStatus==1 }">
											selected = "selected"
										</c:if>>未付款</option>
									<option value="2" 
										<c:if test="${resultPage.params.payStatus==2 }">
											selected = "selected"
										</c:if>>已付款</option>
								</select>
                                <div class="newSelectCer"></div>
                            </div>
						</div>
						
					</div>
					<div class="btns">
						<input id="searchBtn" class="maageBtn_1" type="button" value="查询" />
					</div>
					<input type="hidden" name="resultPage.params.adminFlag" value="true" />
					<input type="hidden" name="resultPage.currentPage" value="0" />
<%-- 					<input type="hidden" id="status" name="resultPage.params.status" value="${resultPage.params.status}" /> --%>
				</div>
				</form>
				
				<!--查询结果-表格-->
				<div class="tableData">
					<ul class="tab m-clear">
						<li><a <c:if test="${resultPage.params.status==null || resultPage.params.status=='' }"> class="cur"</c:if>>全部订单</a></li>
						<c:forEach items="${statuses }" var="statuse" varStatus="status">
								<li value="${statuse}">
								<a
									<c:if test="${resultPage.params.status==status.index+1 }"> class="cur" </c:if>>
										<spring:message code="order.status.${status.index+1}" /> 
								</a>
								</li>
						</c:forEach>
					</ul>
					<!-- 商户"批量确认"和"批量发货" -->
					<c:if test="${isAdmin ne true }">
						<div class="tableTitle fr mt45">
							<c:if test="${resultPage.params.status == orderStatusWaitSend}">
								<a href="javascript:;" class="aBtn" id="batchConfirm">FIO确认订单</a>
							</c:if>
								<a class="download m-fr" href="${_ctxPath}/admin/order/order-downloadTemplate.htm">点击下载模板</a>
								<div class="inline fr">
									<script type="text/javascript">
													$(document).ready(
														function() {
															var uploadDefaultParams = {
																'auto' : true,
																'buttonImg' : '${_jsPath}/plugin/uploadify/fileBtn.png',
																'cancelImg' : '${_jsPath}/plugin/uploadify/cancel.png',
																'expressInstall' : '${_jsPath}/plugin/uploadify/expressInstall.swf',
																'fileDataName' : 'file',
																'fileDesc' : '请选择xls、xlsx文件',
																'width' : 80,
																'fileExt' : '*.xls;*.xlsx',
																'multi' : false,
																'script' : '${_ctxPath}/admin/order/order-batchUpload.htm?user.userId=${orderPage.params.sellerId}',
																'sizeLimit' : 2097152,
																'uploader' : '${_jsPath}/plugin/uploadify/uploadify.allglyphs.swf'
															};
						
															var uploadlogoParams = uploadDefaultParams;
						
															uploadlogoParams.onComplete = function(
																	event, ID, fileObj,
																	response, data) {
																alert($.parseJSON(response).info);
																$('#searchBtn').click();
															};
																$('#imgUpload').uploadify(
																		uploadlogoParams);
													});
									</script>
									<input type="file" id="imgUpload" name="file" />
								</div>
							</div>
					</c:if>
					
					<div class="table">
						<table border="1px" bordercolor="#cfd7dd" cellspacing="0px">
							<tr>
								<th>
									<c:if test="${isAdmin ne true }">
										<input id="checkboxAll" type="checkbox"/>
									</c:if>
									订单号
								</th>
								<th>交易号</th>
								<th>包裹号</th>
								<th>收货人</th>
								<th class="txRight">支付金额</th>
								<th>运费</th>
								<th>支付方式</th>
								<th>订购时间 </th>
								<th>物流状态</th>
								<th>FIO确认状态</th>
								<th>订单来源</th>
								<th>订单状态</th>
								<th>付款状态</th>
								<th>身份证审核</th>
								<th>操作</th>
							</tr>
							<c:forEach items="${resultPage.result}" var="order" varStatus="status">
								<tr <c:if test="${status.count%2 eq 0}">class="even"</c:if>>
									<td class="c-258">
										<c:if test="${isAdmin ne true }">
											<input name="checkbox" type="checkbox" value="${order.orderId}"/>
										</c:if>
										<a target="_blank" <c:if test="${order.haveOrderCrm eq true }"> style='color:red;' title="*客服有信息备注" </c:if> href="${_ctxPath}/admin/order/orderMgr-getOrderDetail.htm?orderHead.orderId=${order.orderId}">${order.orderNo}</a>
									</td>
									<td>${order.orderDeal.dealCode }</td>
									<td>${order.packageNo}</td>
									<td>${order.orderAddress.receiverName }</td>
									<td class="txRight">${order.paymentAmount }</td>
									<td>${order.totalPostage }</td>
									<td>
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
									<td><fmt:formatDate value='${order.createTime}' pattern='yyyy-MM-dd HH:mm:ss' /></td>
									<td>
										<c:if test="${not empty order.logisticStatus}">
												<spring:message code="order.logistics.status.${order.logisticStatus }" />
										</c:if>
										<c:if test="${ empty order.logisticStatus}">
												未接单
										</c:if>
									</td>
									<td>
										<c:if test="${order.confirmStatus == 1}">
												未确认
										</c:if>
										<c:if test="${order.confirmStatus == 2}">
												已确认
										</c:if>
									</td>
									<td>
										<c:if test="${order.orderType !=null && order.orderType !=''}">
												<spring:message code="order.source.${order.orderType }" />
										</c:if>
									</td>
									<td>
										 <spring:message code="order.status.${order.status }" />
									</td>
									<td>
										 <spring:message code="order.payment.status.${order.payStatus}" />
									</td>
									<td>
												查看 | 通过 
									</td>
									<td>
										<a href="${_ctxPath}/admin/order/order-printInvoice.htm?orderHead.orderId=${order.orderId}" class="blue" target="_blank">发货单打印</a><br/>
										<c:if test="${order.status == 3 and order.payType != 2}">
											<a href="javascript:void(0);" data-payType="${order.payType}" data-orderId="${order.orderId}" class="blue J_orderId" >修改物流单号</a>
										</c:if>
            							<c:if test="${order.status == 2}">
            								<c:if test="${order.confirmStatus != 2}">
												<a href="javascript:confirmOrder('${order.orderId}');" class="blue">FIO确认订单</a><br/>
											</c:if>
										</c:if>
										<!-- (在线支付)待发货订单取消并退款【管理员】-->
										<c:if test="${isAdmin eq true && order.status == 2 && order.payType == 1}">
												<a href="javascript:;"  data-refundType="1"  data-orderId="${order.orderId}" class="blue updateOrderCancel">取消并退款</a>
										</c:if> 
										<!-- 待付款订单取消 取消订单功能暂时隐藏
										<c:if test="${order.status == 1}">
											<c:if test="${order.orderCancel.status == null}">
												<a href="javascript:cancelOrder('${order.orderId}');" class="blue">取消订单</a>
											</c:if>
										</c:if> -->
									</td>
								</tr>
							</c:forEach>
						</table>
					</div>
					
				</div>
				
				<!--分页-->
				<div class="module_page" totNum="${resultPage.total}" >
				?&
				<c:forEach items="${resultPage.params}" var="map">
					resultPage.params.${map.key }=${map.value }&
				</c:forEach>
				   
				</div>
				
			</div>
			
				<style>
					.checkTimeDiv{padding:10px;}
					.checkTimeDiv p{padding:5px 0;}
				</style>
				<div id="checkTimeDiv" style="display:none;">
					<div class="checkTimeDiv">
						<div id="old"></div>
						<input name="checkOrderId" id="checkOrderId" type="hidden" />
						<p>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp新单号:<input  style="border:1px solid #ccc; margin-top:5px;" name="new" id="new" type="text" oncopy="return false;" oncut="return false;"/></p>
						<p>确认新单号:<input  style="border:1px solid #ccc; margin-top:5px;" name="checkNew" id="checkNew" type="text" /></p>
						<p id="time" style="height:24px;width:300px;"></p>
					</div>
				</div>
	</body>
<script type="text/javascript">
	
	$(function(){
		
		$("#searchBtn").bind("click", function() {
			if($(".beginTime").val()&&$(".endTime").val()){
				if(compareDate($(".beginTime").val(),$(".endTime").val())){
					showMsgDialog("开始时间不能大于结束时间！");
					return;
				}
			}
			$("#subform").submit();
		});	
		
		//管理员取消并退款
		$(".updateOrderCancel").bind("click", function() {
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
										var content = "申请退款成功，请等待商户审核！退款单号:<a href='javascript:void(0);' onclick='javascript:getOrderCancelDetail($(this));' data-cancelStatus='"+msg.infoValues[2]+"' data-cancelId='"+msg.infoValues[1]+"' class='getOrderCancelDetail'>"+msg.infoValues[0]+"</a>";
										$.dialog({
											title: "提示",
											lock:true,
											content: content,
											okValue: "确定",
											ok:function(){
												$('#searchBtn').click();
											}
										});
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
					data: {'orderHead.orderId':orderId,'orderCancel.refundType':refundType,'andCancelOrderFlag':true},
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
		
		$(".tableData li").bind("click", function() {
			if ($(this).val() == 0) {
				$("#status").find("option").eq(0).attr("selected","selected");
			} else {
				$("#status").find("option").eq($(this).val()).attr("selected","selected");
			}
			$("#searchBtn").click();
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
					showMsgDialog("查询失败 ");
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
					showMsgDialog("查询失败 ");
				}
			});
		});
		
		/**
		*	批量确认订单
		*/
		$("#batchConfirm").on("click",function(){
			var checkbox = $("input[name='checkbox']:checked");
			
			if(checkbox.length > 0 && confirm('您确认需要确认选中的订单吗？')){
				var orderIds = "";
				
				for (var i=0; i < checkbox.length; i++) {
					var orderId = $(checkbox[i]).attr("value");
					orderIds += orderId;
					orderIds += ",";
				}
				orderIds = orderIds.substring(0, orderIds.length - 1);
				  $.ajax({
						type : 'POST',
						url : '${_ctxPath}/admin/order/order-batchConfirmOrder.htm',
						data : {'orderHead.orderIds':orderIds},
						success : function(data) {
							if(data.code=='true'){
								alert(data.info);
								$('#searchBtn').click();
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
			}
		});
		
		$('#export').bind('click', function() {
			if($.trim($('tbody').html())==''){
				return;
			}
			if($(".beginTime").val() && $(".endTime").val()){
				if(compareDate($(".beginTime").val(),$(".endTime").val())){
					showMsgDialog("开始时间不能大于结束时间！");
					return;
				}
			}
			var keywords = $(".J-keywords").val();
			if(keywords == $(".J-keywords").attr("data-default")){
				$(".J-keywords").val("");
			}

			$('#subform').attr("action","${_ctxPath}/admin/order/orderMgr-exportSaleOrders.htm");
			$('#subform').submit();
			$('#subform').attr("action","${_ctxPath}/admin/order/orderMgr-searchSaleOrders.htm");
		});
		
		
		//修改物流单号
		var timer;
		$(".J_orderId").on("click",function(){	
			if(timer){
				clearInterval(timer);
			}
			$("#time").html("");
			var orderID=$(this).attr("data-orderId");
			var orderpayType=$(this).attr("data-payType");
			$.ajax({
				type : 'POST',
				url : '${_ctxPath}/admin/order/order-getSendProductTime.htm',
				data : {'orderAddress.orderId': orderID},
				success : function(data) {
					if(data.code=='true'){
						var jsonObj = eval('(' + data.info + ')');
						$("#old").html("&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp原单号:" + jsonObj.expressNo);
						$("#new").val("");
						$("#checkOrderId").val(orderID);
						$("#checkNew").val("");
						$("#new,#checkNew").prop("disabled",false);
						$(".d-state-highlight").prop("disabled",false);
						$.dialog({
							title: "提示",
							lock:true,
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
									if(orderpayType == 2 ){
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
		
	})
	
	function confirmOrder(orderId){
		if(confirm('您确认需要确认此订单吗？')){
			$.ajax({
				type : 'POST',
				url : '${_ctxPath}/admin/order/order-confirmOrder.htm',
				data : {'orderHead.orderId':orderId},
				success : function(data) {
					if(data.code=='true'){
						alert(data.info);
						$('#searchBtn').click();
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
		  	$(".d-close").hide();
		}		
	}
	
	//待发货状态---管理员取消订单操作
		function cancelOrder(orderId){
			var dialog = $.dialog({
			    lock: true,
			    title:false,
			    okValue: "确认",
		        ok: function(){
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
						        $('#searchBtn').click();
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
					showMsgDialog(xhr.responseText);
		        }
				});
				$(".d-close").hide();
		}
</script>
</html>