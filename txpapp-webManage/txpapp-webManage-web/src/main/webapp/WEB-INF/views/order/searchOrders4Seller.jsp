<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>商家订单管理</title>
<link href="${ _cssPath}/common.css" rel="stylesheet" />
<link href="${ _cssPath}/pages/orderManagement.css" rel="stylesheet" />
<link href="${_jsPath }/plugin/formvalidator/themes/Default/style/style.css" rel="stylesheet" />

<script src="${_jsPath }/jquery/jquery.1.8.1.js" language="javascript"></script>
<script src="${_jsPath }/plugin/My97DatePicker/WdatePicker.js"></script>
<script src="${_jsPath }/pages/manageModule.js" language="javascript"></script>
<script src="${_jsPath }/plugin/formvalidator/formValidatorRegex.js" language="javascript"></script>
<script src="${_jsPath }/plugin/formvalidator/formValidator-4.1.3.js" language="javascript"></script>
<script type="text/javascript" src="${_jsPath}/plugin/uploadify/jquery.uploadify.v2.1.4.min.js"></script>
<script type="text/javascript" src="${_jsPath}/plugin/uploadify/swfobject.js"></script>
</head>
<body>
	<jsp:include page="../include/header.jsp" flush="true" />
	<div class="body m-w980p">
		<!--start form-->
		<form class="sub-form" action="${_ctxPath}/admin/order/order-searchOrders4Seller.htm" method="post" id="subform">
			<input type="hidden" name="orderPage.params.sellerId" value="${orderPage.params.sellerId }"/>
			<input type="hidden" name="orderPage.params.sellerFlag" value="true" />
			<input type="hidden" id="status" name="orderPage.params.status" value="${orderPage.params.status}" /><%--订单状态 --%>
			<input type="hidden" id="returnStatus" name="orderPage.params.returnStatus" value="${orderPage.params.returnStatus}" /><%--退货订单状态 --%>
			<input type="hidden" id="waitStatus" name="orderPage.params.waitStatus" value="${orderPage.params.waitStatus}" /><%--待退货订单状态 --%>
			<div class="m-clear m-mt10p">
				<div class="m-fl"> 
					<%-- <select name="orderPage.params.brandId" class="m-sel">
						<option value="">全部品牌</option>
						<c:forEach items="${brandList }" var="brand">
							<option value="${brand.brandId }"
								<c:if test="${orderPage.params.brandId==brand.brandId }"> selected = "selected" </c:if>>
									${brand.name}
							</option>
						</c:forEach>
					</select> --%>
					<span style="float:left; margin-right:5px;">品牌</span>	
                <div  id="brand" class="searchInput" style="float:left; width:150px;margin-right: 15px;">
					<input type="text" name="orderPage.params.brandName" id="" value="${orderPage.params.brandName}" class="inputType"/>
					<input type="hidden" name="orderPage.params.brandId" class="valueId" value="${orderPage.params.brandId}"/>
					<textarea name="" rows="" cols="" class="textData"></textarea>
					<div><ul></ul></div>
				</div>
					<select name="orderPage.params.payType" class="m-sel">
						<option value="">全部支付方式</option>
						<c:forEach items="${payList }" var="pay">
							<option value="${pay }"
								<c:if test="${orderPage.params.payType==pay }">
									selected = "selected"
								</c:if>
								><spring:message code="order.payment.type.${pay}"/></option>
						</c:forEach>
					</select>
					<select name="orderPage.params.timeType" class="m-sel">
						<c:forEach items="${timeList }" var="time">
							<option value="${time }"
							<c:if test="${orderPage.params.timeType==time }">
									selected = "selected"
								</c:if>
								><spring:message code="order.timement.type.${time}"/></option>
						</c:forEach>
					</select>
					<input id="beginTime" name="orderPage.params.beginTime" value="${orderPage.params.beginTime}" class="Wdate" type="text" readOnly="readOnly" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
					<label>至 </label> 
					<input id="endTime" name="orderPage.params.endTime" value="${orderPage.params.endTime }" class="Wdate" type="text" readOnly="readOnly" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
					
					<input type="text" name="orderPage.params.keywords" value="${orderPage.params.keywords }" class="J-keywords txt-input input-marks" data-default="输入买家姓名、电话、订单号" />
					<select name="orderPage.params.orderType" class="m-sel">
							<option value=""
								<c:if test="${orderPage.params.orderType=='' || orderPage.params.orderType==null}">
									selected = "selected"
								</c:if>>全部订单</option>
							<option value="1" 
								<c:if test="${orderPage.params.orderType==1 }">
									selected = "selected"
								</c:if>>普通订单</option>
							<option value="4"
								<c:if test="${orderPage.params.orderType==4 }">
									selected = "selected"
								</c:if>>团购订单</option>
							<option value="3"
								<c:if test="${orderPage.params.orderType==3 }">
									selected = "selected"
								</c:if>>抢购订单</option>
							<option value="6"
								<c:if test="${orderPage.params.orderType==6 }">
									selected = "selected"
								</c:if>>兑换订单</option>
					</select>
					订单金额<input type="text"  class="txt-input input-marks" name="orderPage.params.paymentAmount" value="${orderPage.params.paymentAmount}" />
					<input type="text" name="orderPage.params.dealCode" value="${orderPage.params.dealCode}" class="J-keywords2 txt-input input-marks" data-default="输入交易号" />
					<input type="text" name="orderPage.params.packageNo" value="${orderPage.params.packageNo}" class="J-keywords_packageNo txt-input input-marks" data-default="包裹序号" />
					
					<input type="button" class="m-btn m-btn-search" value="查 询" id="search" /> 
					
		      		<aut:authorize url="/admin/order/order-exportSellerOrders">
		      			<input type="button" class="m-btn" value="导出" id="export" />
		      		</aut:authorize>
				</div>
				<div style="position: absolute;top: 190px;width: 600px;">温馨提示：所有货到付款方式订单，录入金刚系统时候代收金额填写“<font color="red">订单总金额</font>”。</div>
				
				<c:if test="${not empty orderPage.result}">
					<div class="m-fr curr-num">
						<label>当前显示： </label> 
		        		<yp:commPageSize page="${orderPage}" beanName="orderPage"></yp:commPageSize>
					</div>
	      		</c:if>
	      	</div>
		</form>
		<div class="m-clear m-mt10p">
			<div class="m-fl body-nav subnav" id="status_con" style="margin-top: 15px">
				<ul class="m-clear">
					<li >
					<a
						<c:if test="${orderPage.params.status==null || orderPage.params.status=='' }"> class="current-chose"</c:if>>
						 全部订单
					</a>
					</li>
					<c:forEach items="${statuses }" var="statuse" varStatus="status">
					<c:if test="${statuse < 6}">	
						<li value="${statuse}">
						<a
							<c:if test="${orderPage.params.status==status.index+1 }"> class="current-chose" </c:if>>
								<spring:message code="order.status.${status.index+1}" /> 
						</a>
						</li>
					</c:if>
					<!-- 部分退货 和 全部退货  显示退货 -->
					<c:if test="${statuse == 6}">	
						<li value="${statuse}">
						<a
							<c:if test="${orderPage.params.status==status.index+1 }"> class="current-chose" </c:if>>
								退货 
						</a>
						</li>
					</c:if>
					</c:forEach>
				</ul>
			</div>
				
			<div class="m-fr">
				<a class="download m-fr" href="${_ctxPath}/admin/order/order-downloadTemplate.htm">点击下载模板</a>
					<div class="inline">
					<script type="text/javascript">
						$(document).ready(
										function() {
											var uploadDefaultParams = {
												'auto' : true,
												'buttonImg' : '${_jsPath}/plugin/uploadify/batch.jpg',
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
												$('#search').click();
											};
												$('#imgUpload').uploadify(
														uploadlogoParams);
										});
					</script>
					<input type="file" id="imgUpload" name="file" />
				</div>
			</div>
			
			<div class="m-fr">
				<c:if test="${orderPage.params.status == orderStatusWaitSend}">
					<input type="button" class="m-btn" value="确认订单" id="confirm" onclick="javascript:batchConfirm();"/>
				</c:if>
			</div>
		</div>
		
		<%--当选择查询状态是待发货时 --%>
		<c:if test="${orderPage.params.status == orderStatusWaitSend}">	
			<div class="child-menu"><%--1=退款审核中，2=退款未通过，3=审核通过，4=已退款 --%>
				<ul>
					<c:forEach items="${cancelStatuses}" var="wait" varStatus="status">
						<li 
							<c:if test="${status.index==0 && (orderPage.params.waitStatus==''||orderPage.params.waitStatus==0)}"> class="on" </c:if>
							<c:if test="${status.index!=0 && orderPage.params.waitStatus!=null && orderPage.params.waitStatus==status.index }"> class="on" </c:if> 
							>
							<a class="waitStatus" id="${wait}">
								<spring:message code="order.wait.status.${status.index}" /> 
							</a>
						</li>
					</c:forEach>
				</ul>
			</div>
		</c:if>
		
		<%--当选择查询状态是退货时 --%>
		<c:if test="${orderPage.params.status == orderStatusReturn}">	
			<div class="child-menu"><%--1=未审核，2=审核通过，3=审核不通过，4=已到货 --%>
				<ul>
					<c:forEach items="${itemStatuses}" var="statuse" varStatus="status">
						<li 
							<c:if test="${status.index==0 && (orderPage.params.returnStatus==''||orderPage.params.returnStatus==0)}"> class="on" </c:if>
							<c:if test="${status.index!=0 && orderPage.params.returnStatus==status.index }"> class="on" </c:if> >
							<a class="returnStatus" id="${statuse}">
								<spring:message code="order.refund.status.${status.index}" /> 
							</a><%--1=未审核，2=审核通过，3=审核不通过，4=已到货 --%>
						</li>		
					</c:forEach>
				</ul>
			</div>
		</c:if>
		
		<!--start 下单管理table-->
		<div class="order-management">
			<table id="order-tab" width="100%">
				<thead class="tab-control">
					<tr>
						<th width="5%"><input id="checkboxAll" type="checkbox"/></th>
						<th width="10%">订单编号</th>
						<th width="12%">交易号</th>
						<th width="3%">包裹序号</th>
						<th width="13%">下单时间</th>
						<th width="7%">总金额</th>
						<th width="10%">支付方式</th>
						<th width="8%">支付状态</th>
						<th width="8%">订单状态</th>
						<th width="8%">确认状态</th>
						<th width="8%">订单来源</th>
						<th width="14%">操作</th>
					</tr>
				
				</thead>
				<tbody>
				
					<c:forEach items="${orderPage.result}" var="order" varStatus="status">
						<tr class="list-tr">
							<td colspan="12" class="td-nobor">
								<table class="tab-control">
									<tr class="tr-height">
										<td width="5%">
											<input name="checkbox" type="checkbox"/>
										</td>
										<td class="num-icon" width="10%">
											<input type="hidden" value="${order.orderId}" id='orderId' />
											<input type="hidden" value="${order.orderNo}" id='orderNo' />
											<input type="hidden" value="" id="orderReturnId"/>
											<i></i><label><a>${order.orderNo}</a></label>
										</td>
										<td width="12%">${order.orderDeal.dealCode }</td>
										<td  width="3%">
											${order.packageNo}
										</td>
										<td width="13%"><fmt:formatDate value='${order.createTime}' pattern='yyyy-MM-dd HH:mm:ss' /></td>
										<td width="7%">${order.paymentAmount }</td>
										<td width="10%">
											<%-- <c:if test="${order.payType !=null && order.payType !=''}">
												<spring:message code="order.payment.type.${order.payType }" />
											</c:if> --%>
											<c:if test="${order.payType !=null && order.payType !=''}">
												<c:if test="${order.payType eq 1}">
													<c:if test="${order.gateWayId !=null && order.gateWayId !=''}">
														<spring:message code="order.payment.type.${order.gateWayId}"/>
													</c:if>
												</c:if>
												<c:if test="${order.payType eq 2}">
													<spring:message code="order.payment.type.${order.payType}"/>
												</c:if>
											</c:if>
										</td>
										<td width="8%">
											<c:if test="${order.payStatus ==null}">
												未付款
											</c:if> 
											<c:if test="${order.payStatus !=null}">
												<spring:message code="order.payment.status.${order.payStatus }" />
											</c:if>
										</td>
										<td width="8%">
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
										<td width="8%">
											<c:if test="${order.confirmStatus == 1}">
												未确认
											</c:if>
											<c:if test="${order.confirmStatus == 2}">
												已确认
											</c:if>
										</td>
										<td width="8%">
											<c:if test="${order.orderType !=null && order.orderType !=''}">
												<spring:message code="order.source.${order.orderType }" />
											</c:if>
										</td>
										<td width="14%">
											<c:if test="${orderPage.params.status == orderStatusReturn && (order.refundStatus==orderReturnItemStatusNotAudit || orderPage.params.returnStatus == orderReturnItemStatusNotAudit)}">
												<a href="javascript:;" class="c-blue">退货审核</a>
												<br/>
											</c:if>
											<c:if test="${order.status == 3 and order.payType != 2}">
												<a href="javascript:void(0);" class="blue J_orderId" >修改物流单号</a>
												<input type="hidden" value="${order.orderId}" />
												<input type="hidden" value="${order.payType}" class="J_payType"/><br/>
											</c:if>
											<a href="${_ctxPath}/admin/order/order-printInvoice.htm?orderHead.orderId=${order.orderId}" class="blue" target="_blank">发货单打印</a><br/>
											<c:if test="${order.status == 2}">
												<c:if test="${order.confirmStatus != 2 && (order.orderCancel.status == null || order.orderCancel.status == 2)}">
													<a href="javascript:confirmOrder('${order.orderId}');" class="blue">确认订单</a><br/>
												</c:if>
												
												<c:if test="${order.orderCancel.status == null}">
													<a href="javascript:cancelOrder('${order.orderId}');" class="blue">取消订单</a>
												</c:if>
												
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
			<!--S 右功能区-->
			<div class="fn-right">
				<!--S 分页-->
				<div class="pagination pagination-right">
					<c:if test="${not empty orderPage.result}">
						<yp:commPage page="${orderPage}" beanName="orderPage"></yp:commPage>
					</c:if>
				</div>
				<!--E 分页-->
			</div>
			<!--E 右功能区-->
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
			<p>&nbsp&nbsp&nbsp&nbsp新单号:<input name="new" id="new" type="text" oncopy="return false;" oncut="return false;"/></p>
			<p>确认新单号:<input name="checkNew" id="checkNew" type="text" /></p>
			<p id="time" style="height:24px;width:300px;"></p>
		</div>
	</div>
<jsp:include page="/WEB-INF/pages/include/foot.jsp"></jsp:include>
<script type="text/javascript">

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
	$(document).ready(function() {
		$(".returnStatus").bind("click",function(){
			$("#returnStatus").val($(this).attr("id"));
			$('#search').click();
		});
		
		$(".waitStatus").bind("click",function(){
			$("#waitStatus").val($(this).attr("id"));
			$("#search").click();
		});
		
		$('#status_con li').bind('click', function() {
			if ($(this).val() == 0) {
				$('#status').val('');
			} else {
				$('#status').val($(this).val());
			}
			$("#returnStatus").val("");
			$("#waitStatus").val("");
			$('#search').click();
		});
		
		$('#search').bind('click', function() {
			var keywords = $(".J-keywords").val();
			if(keywords == $(".J-keywords").attr("data-default")){
				$(".J-keywords").val("");
			}
			var keywords2 = $(".J-keywords2").val();
			if(keywords2 == $(".J-keywords2").attr("data-default")){
				$(".J-keywords2").val("");
			}
			var keywords_packageNo = $(".J-keywords_packageNo").val();
			if(keywords_packageNo == $(".J-keywords_packageNo").attr("data-default")){
				$(".J-keywords_packageNo").val("");
			}
			if($("#beginTime").val() && $("#endTime").val()){
				if(compareDate($("#beginTime").val(),$("#endTime").val())){
					alert("开始时间不能大于结束时间！");
					return;
				}
			}
			
			if($("#status").val()==6 && !$("#returnStatus").val()){
				$("#returnStatus").val(0);
			}
			
			$('#subform').submit();
		});
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
								$("#time").html("货到付款订单,你还剩余<front style='color:red'>"+mi+"</front>分<front style='color:red'>"+se+"</front>秒修改物流单号 ");
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
		$('#export').bind('click', function() {
			if($.trim($('tbody').html())==''){
				return;
			}
			if($("#beginTime").val() && $("#endTime").val()){
				if(compareDate($("#beginTime").val(),$("#endTime").val())){
					alert("开始时间不能大于结束时间！");
					return;
				}
			}
			var keywords = $(".J-keywords").val();
			if(keywords == $(".J-keywords").attr("data-default")){
				$(".J-keywords").val("");
			}

			$('#subform').attr("action","${_ctxPath}/admin/order/order-exportSellerOrders.htm");
			$('#subform').submit();
			$('#subform').attr("action","${_ctxPath}/admin/order/order-searchOrders4Seller.htm");
		});
	
		//防止在一次请求 多次点击
		var isPost = true;
		$(".tr-height").on("click", function() {
			$this = $(this);
			var orderId = $this.find('#orderId').val();
			var returnStatus = $('#returnStatus').val();<%--当前选中的退货订单状态--%>
			var orderReturnId = $this.find('#orderReturnId').val();
			var status = $('#status').val();<%--当前选中的订单状态--%>
			if (!$(this).next(".show-tr")[0]) {
				if(isPost){
					isPost = false;
					$.ajax({
						type : 'POST',
						url : '${_ctxPath}/admin/order/order-getOrder4Seller.htm',
						data : {
							"orderHead.orderId" : orderId,
							"orderPage.params.returnStatus":returnStatus,
							"orderPage.params.orderReturnId":orderReturnId,
							"orderPage.params.status":status,
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
	
	//订单内包裹切换
    $('.order-ul li').live('click',function(){
    	var _this = $(this),
    	_idx = _this.attr("id");
    	
    	$('.order-ul li').removeClass('cur');
    	_this.addClass('cur');
    	
    	$('.package').eq(_idx).show().siblings().hide();
    })

	function returnOrder(){
		if($('tbody').html().trim()==''){
			return;
		}
		var keywords = $(".J-keywords").val();
		if(keywords == $(".J-keywords").attr("data-default")){
			$(".J-keywords").val("");
		}
		var keywords_packageNo = $(".J-keywords_packageNo").val();
		if(keywords_packageNo == $(".J-keywords_packageNo").attr("data-default")){
			$(".J-keywords_packageNo").val("");
		}
		$('#subform').attr("action","${_ctxPath}/admin/order/order-exportReturnOrders.htm");
		$('#subform').submit();
		$('#subform').attr("action","${_ctxPath}/admin/order/order-searchOrders4Seller.htm");
	}
	
	
	//比较日前大小  如果开始大于结束，返回true
	function compareDate(checkStartDate, checkEndDate) {      
	    var arys1= new Array();      
	    var arys2= new Array();      
		if(checkStartDate != null && checkEndDate != null) {      
		    arys1=checkStartDate.split('-');      
		    var sdate=new Date(arys1[0],parseInt(arys1[1]-1),arys1[2]);      
		    arys2=checkEndDate.split('-');      
		    var edate=new Date(arys2[0],parseInt(arys2[1]-1),arys2[2]);      
			if(sdate > edate) {      
			    return true;         
			}else{   
			    return false;      
		    }   
	    }      
	}   

	//待发货退款 - 审核通过
	function passCelAudit(id,orderId){
		$.ajax({
			type:'post',
			data:{'orderCancel.orderCancelId':id,'orderCancel.orderId':orderId},
			url:'${_ctxPath}/admin/order/order-passCancelAudit.htm',
			success:function(data){
				if(data.code=='true'){
					$id = $("#passCA_"+id);
					$id.parent().siblings().remove();
					$id.parent().parent().append('<p>待退款<p>');
					$id.parent().remove();
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
	
	//待发货退款 - 审核不通过
	function rejectCelAudit(id){
		var reason = $("#rejectCAR_"+id).val();
		if(!reason){
			alert("请填写未通过原因");
			return;
		}
		
		//审核原因不能超过50个字符(包含汉字)
		var ascRegexp = "/[^/x00-/xFF]/g";
		var reasonLen=reason.replace(ascRegexp, '..').length;
		if(reasonLen>50){
			$("#rejectCARL_"+id).html("<font color='red'>审核原因不能超过50个字符(包含汉字)</font>");
			return false;
		}
		$.ajax({
			type:'post',
			data:{
				'orderCancel.orderCancelId':id,
				'orderCancel.reviewDescribe':reason
			},
			url:'${_ctxPath}/admin/order/order-rejectCancelAudit.htm',
			success:function(data){
				if(data.code=='true'){
					$id=$("#rejectCA_"+id);
					$id.parent().siblings().remove();
					$id.parent().parent().append("<b>审核未通过</b><br/><b>审核描述:</b>"+reason);
					$id.parent().remove();
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

	function onChangeOfCheckboxIncludeFreight(orderItemId) {
		var returnFreight = $("#checkboxReturnFreight_" + orderItemId).is(':checked');
		var result = null;
		if (returnFreight == true) {
			result = $("#refundMoney_" + orderItemId).attr("refundMoneyIncludeTotalPostage");
		} else {
			result = $("#refundMoney_" + orderItemId).attr("refundMoneyExcludeTotalPostage");
		}
		$("#refundMoney_" + orderItemId)[0].innerHTML = result;
	}
	
	//退货 - 审核通过
	function passAudit(id, orderItemId){
		$.ajax({
			type:'post',
			data:{'orderRefund.orderRefundId':id, 'orderRefund.returnFreight': ($("#checkboxReturnFreight_" + orderItemId).is(':checked') ? 1 : 0)},
			url:'${_ctxPath}/admin/order/order-passAudit.htm',
			success:function(data){
				//success 改变按钮 变成  同意退款 并添加注释  同时移除  审核通过  和  审核不通过
				$id = $("#passAudit"+id);
				$id.parent().siblings().remove();
				//$id.parent().parent().append('<p><input type="button" class="btn btn-danger" value="同意退款" id="agreePayment'+id+'" onclick="agreePayment('+id+')"  /><p>');
				$id.parent().parent().append('<p>待发货<p>');
				$id.parent().remove();
				
				$id = $("#rejectAuditReasonP"+id);
				$id.parent().siblings().remove();
				$id.parent().remove();
			},
			error:function(data){
				if(undefined != data.info){
					alert(data.info);
				}
			}
		});
	}
	
	//退货 - 审核不通过
	function rejectAudit(id){
		var  reason = $("#rejectAuditReason"+id).val();
		if(reason==""){
			$("#rejectAuditReasonL"+id).html("<font color='red'>请填写未通过原因</font>");
			return;
		}
		
		//审核原因不能超过50个字符(包含汉字)
		var ascRegexp = "/[^/x00-/xFF]/g";
		var reasonLen=reason.replace(ascRegexp, '..').length;
		if(reasonLen>50){
			$("#rejectAuditReasonL"+id).html("<font color='red'>审核原因不能超过50个字符(包含汉字)</font>");
			return false;
		}
    
		$.ajax({
			type:'post',
			data:{'orderRefund.orderRefundId':id,'orderRefund.reviewDescribe':reason},
			url:'${_ctxPath}/admin/order/order-rejectAudit.htm',
			success:function(data){
				$("#rejectAudit"+id).parent().siblings().remove();
				$("#rejectAudit"+id).parent().parent().append("<b>审核未通过</b><br/><b>审核描述:</b>"+reason);
				$("#rejectAudit"+id).parent().remove();
				$("#cancelStatusL"+id).html("审核未通过");
			},
			error:function(data){
				alert("error:"+data);
			},
			oncomplete:function(data){
				alert("complement:"+data);
			}
		});
	}

	// 退货 - 确认收货
	function confirmBack(id,packageTotalPrice){
		$("#confirmBackProduct"+id).attr("disabled","disabled");//第一次点击时，灰掉按钮
        $.ajax({
			type : 'POST',
			url : '${_ctxPath}/admin/order/order-confirmBackProduct.htm',
			data : {
				'orderRefundId': id,
				'packageTotalPrice': packageTotalPrice
			},
			success : function(data) {
				$id = $("#confirmBackProduct"+id);
				$id.parent().siblings().remove();
				$id.parent().parent().append("待退款");
				$id.parent().remove();
				
				$id = $("#refundStatusL"+id);
				$id.html("待退款");
			},
			error:function(data){
				if(undefined != data.info){
					alert(data.info);
				}
				//后台出错时，恢复按钮事件
				$("#confirmBackProduct"+id).removeAttr("disabled");
			}
		});
   	}
	 String.prototype.startWith=function(s){
	  if(s==null||s==""||this.length==0||s.length>this.length)
	   return false;
	  if(this.substr(0,s.length)==s)
	     return true;
	  else
	     return false;
	  return true;
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
	
	
	/**
	*	批量确认订单
	*/
	function batchConfirm() {
		var checkbox = $("input[name='checkbox']:checked");
		
		if(checkbox.length > 0 && confirm('您确认需要确认选中的订单吗？')){
			var orderIds = "";
			
			for (var i=0; i < checkbox.length; i++) {
				var jInput = $(checkbox[i]).parent().next().children();
				var orderId = $(jInput[0]).attr("value");
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
	}
	
	$("#checkboxAll").on("click",function(){
			var checkLen=$("#order-tab tbody:checked:not(:disabled)").length;
			if($(this).is(":checked")){
				$("input[name='checkbox']").prop("checked",true);
			}else{
				$("input[name='checkbox']").prop("checked",false);
			}
	});
	
</script>
</body>
</html>