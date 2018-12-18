<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="aut" uri="http://www.springsecurity.org/jsp" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>订单管理-退款单管理</title>
        <link rel="stylesheet" type="text/css" href="${_jsPath }/new/css/base.css?v=${_resVerion}"/>
        <link rel="stylesheet" href="${_jsPath }/new/calendar/kalendae.css?v=${_resVerion}" type="text/css" charset="utf-8">
        <script type="text/javascript" src="${_jsPath }/new/js/jquery-1.11.0.min.js?v=${_resVerion}"></script>
		<script src="${_jsPath }/new/calendar/kalendae.standalone.js?v=${_resVerion}" type="text/javascript" charset="utf-8"></script>
        <script type="text/javascript" src="${_jsPath }/new/js/manage_basefun.js?v=${_resVerion}"></script>
        <script type="text/javascript" src="${_jsPath}/plugin/uploadify/jquery.uploadify.v2.1.4.min.js?v=${_resVerion}"></script>
		<script type="text/javascript" src="${_jsPath}/plugin/uploadify/swfobject.js?v=${_resVerion}"></script>
	</head>
	<body>
		<!-- header -->
		<jsp:include page="../include/headerNew.jsp" flush="true" />
			<!--main-->
			<div class="main">
				
				<!--面包屑-->
				<div class="crumb">
					<!--<a href="" class="fr export"><i></i><input type="button" name="" id="" value="导出"/></a>-->
					<button class="fr export" id="export"><i></i>导出</button>
					<p>
						<a href="" class="home"><i></i></a>
						<span class="sep"></span>
						<a href="">订单管理</a>
						<span class="sep"></span>
						<a href="">退款单管理</a>
					</p>
				</div>
				
				<!--查询条件-->
				<form class="m-mt10p m-clear" action="${_ctxPath}/admin/order/orderMgr-searchRefundOrders.htm" method="get" id="subform">
				<div class="query">
					
					<div class="line">
						<div class="col">
							<span class="sp">退款单号：</span><input type="text" name="resultPage.params.orderCancelNo" id="" value="${resultPage.params.orderCancelNo }" class="inputText"/>
						</div>
						<div class="col">
							<span class="sp">订单号：</span><input type="text" name="resultPage.params.orderNo" id="" value="${resultPage.params.orderNo }" class="inputText"/>
						</div>
						<div class="col">
							<span class="sp">退款类型：</span>
							<div class="fl module_Select">
                                <select name="resultPage.params.refundType" class="trueMenu">
                                  <option value="" selected>ALL</option>
                                  <option value="0" <c:if test="${resultPage.params.refundType==0 }">selected = "selected" </c:if> >
                                  	<spring:message code="orderCancel.refundType.0"/>
                                  </option>
                                  <option value="1" <c:if test="${resultPage.params.refundType==1 }">selected = "selected" </c:if> >
                                  	<spring:message code="orderCancel.refundType.1"/>
                                  </option>
                                </select>
                                <div class="newSelectCer"></div>
                            </div>
						</div>
						<div class="col">
							<span class="sp">申请时间：</span>
							
							 <input type="text" name="resultPage.params.beginTime" value="${resultPage.params.beginTime }" class="inputText bgcf9f calendarOne beginTime"/>
								<span class="fl">至&nbsp;&nbsp;</span>
							  <input type="text" name="resultPage.params.endTime" value="${resultPage.params.endTime }" class="inputText bgcf9f calendarOne endTime"/>
						</div>
					</div>
					<div class="line">
						<div class="col">
							<span class="sp">退款状态：</span>
							<div class="fl module_Select">
                                <select name="resultPage.params.status" class="trueMenu">
                                  <option value="" selected>ALL</option>
                                  <c:forEach items="${cancelStatuses }" var="statuse" varStatus="status">
										<option value="${statuse }" <c:if test="${resultPage.params.status==statuse }">selected = "selected" </c:if> >
		                                  	<spring:message code="order.wait.status.${statuse }"/>
		                                </option>
								 </c:forEach>
                                </select>
                                <div class="newSelectCer"></div>
                            </div>
						</div>
						<div class="col">
							<span class="sp">退款原因：</span>
							<div class="fl module_Select">
                                <select name="resultPage.params.refundReasonType" class="trueMenu">
                                  <option value="" selected>ALL</option>
                                  <option value="0" <c:if test="${resultPage.params.refundReasonType==0 }">selected = "selected" </c:if> >
                                  	<spring:message code="orderCancel.refundReasonType.0"/>
                                  </option>
                                  <option value="1" <c:if test="${resultPage.params.refundReasonType==1 }">selected = "selected" </c:if> >
                                  	<spring:message code="orderCancel.refundReasonType.1"/>
                                  </option>
                                  <option value="2" <c:if test="${resultPage.params.refundReasonType==2 }">selected = "selected" </c:if> >
                                  	<spring:message code="orderCancel.refundReasonType.2"/>
                                  </option>
                                  <option value="3" <c:if test="${resultPage.params.refundReasonType==3 }">selected = "selected" </c:if> >
                                  	<spring:message code="orderCancel.refundReasonType.3"/>
                                  </option>
                                </select>
                                <div class="newSelectCer"></div>
                            </div>
						</div>
						<div class="col">
							<span class="sp">退款方式：</span>
							<div class="fl module_Select">
                                <select name="resultPage.params.refundPayType" class="trueMenu">
                                  <option value="" selected>ALL</option>
                                  <option value="0" <c:if test="${resultPage.params.refundPayType==0 }">selected = "selected" </c:if> >
                                  	<spring:message code="orderCancel.refundPayType.0"/>
                                  </option>
                                  <option value="1" <c:if test="${resultPage.params.refundPayType==1 }">selected = "selected" </c:if> >
                                  	<spring:message code="orderCancel.refundPayType.1"/>
                                  </option>
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
				</div>
				</form>
				<!--查询结果-表格-->
				<div class="tableData">
					<div class="tableTitle">
						<c:if test="${isAdmin eq true }">
							<!-- 管理员 -->
<!-- 							<a href="javascript:;">财务批量审核</a> -->
<!-- 							<a href="javascript:;" class="addNewOrderConcel"><i>+</i>新建退款单</a> -->
						</c:if>
						
						<c:if test="${isAdmin ne true }">
							<!-- 商户审核 -->
<!-- 							<a href="javascript:;" id="sellerBatchReview">商家批量审核</a> -->
						</c:if>
					</div>
					<div class="table">
						<table border="1px" bordercolor="#cfd7dd" cellspacing="0px">
							<tr>
								<th>
<!-- 									<input id="checkboxAll" type="checkbox"/> -->
									退款单
								</th>
								<th>订单号</th>
								<th>退款类型</th>
								<th>退款原因</th>
								<th>退款方式</th>
								<th>关联RMA</th>
								<th>申请时间</th>
								<th>退款单状态 </th>
								<th>操作</th>
							</tr>
							<c:forEach items="${resultPage.result}" var="cancel" varStatus="status">
								<tr <c:if test="${status.count%2 eq 0}">class="even"</c:if>>
									<td class="c-258">
<%-- 										<input data-cancelStatus="${cancel.status }" name="checkbox" type="checkbox" value="${cancel.orderCancelId}"/> --%>
										<span data-cancelId='${cancel.orderCancelId }' data-cancelStatus="${cancel.status }"  class="getOrderCancelDetail curpointer">${cancel.orderCancelNo }</span>
									</td>
									<td>
										<a href="${_ctxPath}/admin/order/orderMgr-getOrderDetail.htm?orderHead.orderId=${cancel.orderId}">${cancel.orderHead.orderNo }</a>
									</td>
									<td>
										<spring:message code="orderCancel.refundType.${cancel.refundType}"/>
									</td>
									<td>
										<spring:message code="orderCancel.refundReasonType.${cancel.refundReasonType}"/>
									</td>
									<td>
										<spring:message code="orderCancel.refundPayType.${cancel.cancelItem.refundPayType}"/>
									</td>
									<td>${cancel.refund.orderRefundNo}</td>
									<td><fmt:formatDate value='${cancel.createTime}' pattern='yyyy-MM-dd HH:mm:ss' /></td>
									<td class="c-15b74e">
										<spring:message code="order.wait.status.${cancel.status}"/>
									</td>
									<td>
										<c:if test="${isAdmin ne true }">
											<!-- 商户审核 -->
											<c:choose>
												<c:when test="${cancel.status eq 1}">
													<a href="javascript:;" data-cancelId='${cancel.orderCancelId }' data-orderId='${cancel.orderId }' class="sellerReviewYes">审核通过</a>
													<a href="javascript:;" data-cancelId='${cancel.orderCancelId }' data-orderId='${cancel.orderId }' class="sellerReviewNo">审核不通过</a>											
												</c:when>
												<c:otherwise>
													<span data-cancelId='${cancel.orderCancelId }' data-cancelStatus="${cancel.status }" class="getOrderCancelDetail curpointer">查看</span>
												</c:otherwise>
											</c:choose>
										</c:if>
										<c:if test="${isAdmin eq true }">
											<!-- 管理员确认退款 -->
											<c:choose>
												<c:when test="${cancel.status eq 3}">
													<a href="javascript:;" class="confirmRefund" 
													data-paymentAmount='${cancel.refundAmount}'  
													data-cancelStatus="${cancel.status }" 
													data-cancelId='${cancel.orderCancelId }' 
													data-orderId='${cancel.orderId }'>确认退款</a>
													<a href="javascript:;" class="invalidRefund" 
													data-cancelStatus="${cancel.status }" 
													data-cancelId='${cancel.orderCancelId }'>退款作废</a>
												</c:when>
												<c:otherwise>
													<span data-cancelId='${cancel.orderCancelId }' data-cancelStatus="${cancel.status }" class="getOrderCancelDetail curpointer">查看</span>
												</c:otherwise>
											</c:choose>
										</c:if>
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
			//商家审核通过
			$(".sellerReviewYes").bind("click", function() {
				var _this = $(this);
				var orderId = _this.attr("data-orderId");
				var cancelId = _this.attr("data-cancelId");
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
									var tdOpt = _this.parent();//操作
									var tdStatus = _this.parent().prev();//状态
									$(tdOpt).html("<span onclick='javascript:getOrderCancelDetail($(this));'  data-cancelStatus='3' data-cancelId='"+cancelId+"' class='getOrderCancelDetail curpointer'>查看</span>");
									$(tdStatus).html("待退款");
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
			});
			
			//商家审核不通过
			$(".sellerReviewNo").bind("click", function() {
				var _this = $(this);
				var orderId = _this.attr("data-orderId");
				var cancelId = _this.attr("data-cancelId");
				var dialogHtmlContent = '请输入审核不通过的原因：<p>'
					+'<textarea id="rejectCAR" style="border:1px solid #ccc; margin-top:5px;" rows="3" cols="30"}/>'
					+'</p><label style="color:red;" id="rejectCARL"/>';
				$.dialog({
					title: "提示",
					lock:true,
					content: dialogHtmlContent,
				    okValue: "确定",
				    ok: function(){
				    	var reason = $("#rejectCAR").val();
						if(!reason){
// 							showMsgDialog("请填写未通过原因");
// 							return;
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
									var tdOpt = _this.parent();//操作
									var tdStatus = _this.parent().prev();//状态
									$(tdOpt).html("<span onclick='javascript:getOrderCancelDetail($(this));'  data-cancelStatus='2'  data-cancelId='"+cancelId+"' class='getOrderCancelDetail curpointer'>查看</span>");
									$(tdStatus).html("审核未通过");
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
			});
			
			//管理员确认退款
			$(".confirmRefund").bind("click", function() {
				var _this = $(this);
				var orderId = _this.attr("data-orderId");
				var cancelId = _this.attr("data-cancelId");
				var paymentAmount = _this.attr("data-paymentAmount");
				var dialogHtmlContent = '请输入退款金额：<p>'
					+'<input type="text" id="refundMoney" value="" style="border:1px solid #ccc; margin-top:5px;"/>'
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
									var tdOpt = _this.parent();//操作
									var tdStatus = _this.parent().prev();//状态
									$(tdOpt).html("<span onclick='javascript:getOrderCancelDetail($(this));'  data-cancelStatus='4' data-cancelId='"+cancelId+"' class='getOrderCancelDetail curpointer'>查看</span>");
									$(tdStatus).html("已退款");
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
			});
			
			
			//管理员确认退款阶段可以作废退款单
			$(".invalidRefund").bind("click", function() {
					var _this = $(this);
					var cancelId = _this.attr("data-cancelId");
					var dialogHtmlContent = '请输入退款单作废原因：<p>'
						+'<textarea id="invalidCAR" style="border:1px solid #ccc; margin-top:5px;" rows="5" cols="30"}/>'
						+'</p><label style="color:red;" id="invalidCARL"/>';
					$.dialog({
						title: "提示",
						lock:true,
						content: dialogHtmlContent,
					    okValue: "确定",
					    ok: function(){
					    	var reason = $("#invalidCAR").val();
							if(!reason){
								$("#invalidCARL").html("请填写作废原因");
								return false;
							}
							//审核原因不能超过50个字符(包含汉字)
							var ascRegexp = "/[^/x00-/xFF]/g";
							var reasonLen=reason.replace(ascRegexp, '..').length;
							if(reasonLen>50){
								$("#invalidCARL").html("作废原因不能超过200个字符(包含汉字)");
								return false;
							}
							$.ajax({
								type:'post',
								data:{
									'orderCancel.orderCancelId':cancelId,
									'orderCancel.invalidReason':reason
								},
								url:'${_ctxPath}/admin/order/order-invalidRefund.htm',
								success:function(data){
									if(data.code=='true'){
										showMsgDialog(data.info);
										var tdOpt = _this.parent();//操作
										var tdStatus = _this.parent().prev();//状态
										$(tdOpt).html("<span onclick='javascript:getOrderCancelDetail($(this));'  data-cancelStatus='2'  data-cancelId='"+cancelId+"' class='getOrderCancelDetail curpointer'>查看</span>");
										$(tdStatus).html("已作废");
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
			});
			
			//查看退款单详情
			$(".getOrderCancelDetail").bind("click", function() {
				getOrderCancelDetail($(this));
			});
			
			//判断是否可选中
			/**
			$("input[name='checkbox']").on("change",function(){
				if($(this).is(":checked")){
					var status = $(this).attr("data-cancelStatus");
					if(status != 1 && status != 3){
						 if(status == 2){
							showMsgDialog("该订单已审核过！");
							$(this).prop("checked",false);
						 }else if(status == 4){
							showMsgDialog("该订单已退款！");
							$(this).prop("checked",false);
						 }
					}
				}
			});
			*/
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
 
				$('#subform').attr("action","${_ctxPath}/admin/order/orderMgr-exportOrderCancels.htm");
				$('#subform').submit();
				$('#subform').attr("action","${_ctxPath}/admin/order/orderMgr-searchRefundOrders.htm");
			});
		})
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
					        $(".sellerReviewYes[data-cancelId='"+orderCancelId+"']").click();
					      }else if(_okBtn=="确认退款"){
					    	$(".confirmRefund[data-cancelId='"+orderCancelId+"']").click();
					      }
			        },
			        cancelValue:_noBtn,
			        cancel: function(){
			        	  if(_noBtn=="审核不通过"){
			        		$(".sellerReviewNo[data-cancelId='"+orderCancelId+"']").click();
			        	  }
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
	</script>
	
</html>
