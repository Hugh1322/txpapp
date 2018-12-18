<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>订单发货监控</title>
<link href="${ _cssPath}/pages/orderManagement.css" rel="stylesheet" />
<link href="${_jsPath }/plugin/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" />
<link href="${ _cssPath}/common.css" rel="stylesheet" />
<link href="${_cssPath }/pages/message.css" rel="stylesheet" /> 
<link href="${_jsPath }/plugin/artdialog/skins/ytoxl.css" rel="stylesheet" />

<script src="${_jsPath }/plugin/My97DatePicker/WdatePicker.js"></script>
<script src="${_jsPath }/pages/searchOrderCrms.js" language="javascript"></script>
<script src="${_jsPath }/jquery/jquery.1.8.1.js" language="javascript"></script>
<script src="${_jsPath }/plugin/My97DatePicker/WdatePicker.js"></script>
<script src="${_jsPath }/plugin/formvalidator/formValidatorRegex.js" language="javascript"></script>
<script src="${_jsPath }/plugin/formvalidator/formValidator-4.1.3.js" language="javascript"></script>
</head>
<body>
	<jsp:include page="../include/header.jsp" flush="true" />
	<div class="body m-w980p">
		<!--start form-->
		<form class="m-mt10p m-clear" action="${_ctxPath}/admin/order/orderMonitoring-searchOrders.htm" method="post" id="subform">
			<input type="hidden" id="orderStatus" name="orderPage.params.status" value="${orderPage.params.status}" />
			<input type="hidden" id="timeInterval" name="orderPage.params.timeInterval" value="${orderPage.params.timeInterval}" />
			<input type="hidden" id="logisticStatus" name="orderPage.params.logisticStatus" value="${orderPage.params.logisticStatus}" />
            <div  class="m-clear">
                <span class="m-fl">
					<select name="orderPage.params.timeType" class="m-sel">
						<c:forEach items="${timeList }" var="time">
							<option value="${time }"
								<c:if test="${orderPage.params.timeType==time }">
									selected = "selected"
								</c:if>
							>
								<spring:message code="order.timement.type.${time}"/>
							</option>
						</c:forEach>
					</select>
                    <input id="beginTime" name="orderPage.params.beginTime" value="${orderPage.params.beginTime}" class="Wdate" type="text" readOnly="readOnly" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endTime\')}',readOnly:true})"/>
                    <label>至 </label>
                    <input id="endTime" name="orderPage.params.endTime" value="${orderPage.params.endTime }" class="Wdate" type="text" readOnly="readOnly" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'beginTime\')||\'%y-%M-%d\'}',readOnly:true})"/>
                	
                	<input type="text" class="J-keywords txt-input input-marks" data-default="输入收货人、订单号、电话" name="orderPage.params.keyWords" value="${orderPage.params.keyWords }" />
                	<aut:authorize url="/admin/order/order-search">
	     				<input type="button" class="m-btn m-btn-search" value="查 询" id="search" /> 
					</aut:authorize>
                </span>

                <c:if test="${not empty orderPage.result}">
                    <span class="m-fr curr-num">
                        <label>当前显示： </label>
                        <yp:commPageSize page="${orderPage}" beanName="orderPage"></yp:commPageSize>
                    </span>
                </c:if>
            </div>
		</form>
		<br/>
		
		<div class="body-nav subnav m-mt10p" id="status_con">
				<ul class="m-clear">
					<li value="2">
						<a
							<c:if test="${orderPage.params.status == '2' }"> class="current-chose"</c:if>>
							 待发货
						</a>
					</li>
					<li value="3">
						<a 
							<c:if test="${orderPage.params.status == '3' }"> class="current-chose" </c:if>>
							已发货
						</a>
					</li>
				</ul>
		</div>
		
		<div class="child-menu">
			<ul>
				<c:if test="${orderPage.params.status == '2'}">
					<li <c:if test="${orderPage.params.timeInterval == 'hour24' }"> class="on" </c:if>>
						<a class="hourStatus" id="hour24">
							24小时以内（${hour24 }）
						</a>
					</li>
					<li <c:if test="${orderPage.params.timeInterval == 'hour48' }"> class="on" </c:if>>
						<a class="hourStatus" id="hour48">
							48小时以内（${hour48 }）
						</a>
					</li>
					<li <c:if test="${orderPage.params.timeInterval == 'hour72' }"> class="on" </c:if>>
						<a class="hourStatus" id="hour72">
							72小时以内（${hour72 }）
						</a>
					</li>
					<li <c:if test="${orderPage.params.timeInterval == 'hour73' }"> class="on" </c:if>>
						<a class="hourStatus" id="hour73">
							72小时以上（${hour73 }）
						</a>
					</li>
				</c:if>
				<c:if test="${orderPage.params.status == '3'}">
					<li <c:if test="${orderPage.params.logisticStatus == 'logisticAll' }"> class="on" </c:if>>
						<a class="countStatus" id="logisticAll">
							全部（${countAll }）
						</a>
					</li>
					<li <c:if test="${orderPage.params.logisticStatus == 'logisticGot' }"> class="on" </c:if>>
						<a class="countStatus" id="logisticGot">
							走件中（${countGot }）
						</a>
					</li>
					<li <c:if test="${orderPage.params.logisticStatus == 'logisticSigned' }"> class="on" </c:if>>
						<a class="countStatus" id="logisticSigned">
							正常签收（${countSigned }）
						</a>
					</li>
					<li <c:if test="${orderPage.params.logisticStatus == 'logisticFailed' }"> class="on" </c:if>>
						<a class="countStatus" id="logisticFailed">
							问题件（${countFailed }）
						</a>
					</li>
				</c:if>
			</ul>
		</div>


		<div class="order-management">
			<table id="order-tab" width="100%">
				<thead class="tab-control">
					<tr>
						<c:if test="${orderPage.params.status == '3'}">
							<th width="8%">走件状态</th>
						</c:if>
						<th width="10%">订单号</th>
						<th width="20%">商家名称</th>
						<th width="12%">下单时间</th>
						<th width="10%">收货人</th>
						<th width="11%">收货人电话</th>
						<th width="10%">商家联系人</th>
						<th width="11%">商家电话</th>
						<c:if test="${orderPage.params.status == '2'}">
							<th width="8%">操作</th>
						</c:if>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${orderPage.result}" var="order" varStatus="status">
						<tr class="list-tr">
							<td colspan="11" class="td-nobor">
								<table class="tab-control">
									<tr class="tr-height">
										<c:if test="${orderPage.params.status == '3'}">
											<td class="num-icon" width="8%">
												<c:choose> 
													<c:when test="${order.logisticStatus == '3'}">
														走件中
													</c:when> 
													<c:when test="${order.logisticStatus == '5'}">
														正常签收
													</c:when> 
													<c:otherwise>
														问题件
													</c:otherwise>
												</c:choose>
											</td>
										</c:if>
										<td width="10%">
											${order.orderNo }
											<input type="hidden" value="${order.orderId}" id='orderId' />
										</td>
										<td width="20%"><a href="${_ctxPath}/admin/order/orderMonitoring-getSellerDetailInfo.htm?userId=${order.userId}" class="J_tr">${order.companyName }</a></td>
										<td width="12%"><fmt:formatDate value='${order.createTime}' pattern='yyyy-MM-dd HH:mm' /></td>
										<td width="10%">${order.receiverName }</td>
										<td width="11%">${order.mobile }</td>
										<td width="10%">${order.contactName }</td>
										<td width="11%">${order.contactMobile }</td>
										<c:if test="${orderPage.params.status == '2'}">
											<td width="8%">
												<aut:authorize url="/admin/orderCrm/orderCrm-addOrderCrm">
													<a href="javascript:void(0);" class="blue" onclick="rugeSendMsg(${order.orderId });">短信催促</a><br/>
            									</aut:authorize>
											</td>
										</c:if>
									</tr>
								</table>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		
		<div class="table-bm-wrap cf">
			<div class="fn-right">
				<div class="pagination pagination-right">
					<c:if test="${not empty orderPage.result}">
						<yp:commPage page="${orderPage}" beanName="orderPage"></yp:commPage>
					</c:if>
				</div>
			</div>
		</div>
	</div>
	
	<jsp:include page="/WEB-INF/pages/include/foot.jsp"></jsp:include>
</body>

<script type="text/javascript">
	var isUrgeMsg = true;
	
	$(document).ready(function() {
		
		$("#search").bind("click", function() {
			var keywords = $(".J-keywords").val();
			if(keywords == $(".J-keywords").attr("data-default")){
				$(".J-keywords").val("");
			}
			if($("#beginTime").val() && $("#endTime").val()){
				if(compareDate($("#beginTime").val(),$("#endTime").val())){
					alert("开始时间不能大于结束时间！");
					return;
				}
			}
			$("#subform").submit();
		});
		
		$("#status_con li").bind("click", function() {
			var orderStatus = $(this).val();
			if(orderStatus == '2'){
				$("#timeInterval").val("hour24");
			} else{
				$("#logisticStatus").val("logisticAll");
			}
			$("#orderStatus").val(orderStatus);
			
			$("#search").click();
		});
		
		$(".hourStatus").bind("click",function(){
			$("#timeInterval").val($(this).attr("id"));
			$("#search").click();
		});
		
		$(".countStatus").bind("click",function(){
			$("#logisticStatus").val($(this).attr("id"));
			$("#search").click();
		});
		
		
		//防止在一次请求 多次点击
		var isPost = true;
	 	$(".tr-height").on("click", function(e) {
	 		$this = $(this);
			var orderId = $this.find('#orderId').val();
			if (!$(this).next(".show-tr")[0] && isUrgeMsg) {
				if(isPost){
					isPost = false;
					$.ajax({
						type : 'POST',
						url : '${_ctxPath}/admin/order/orderMonitoring-getOrderDetailInfo.htm',
						data : {
							"orderHead.orderId" : orderId
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
	});
	
	function rugeSendMsg(orderId){
		isUrgeMsg = false; 
		$.ajax({
			type : 'POST',
			url : '${_ctxPath}/admin/order/orderMonitoring-urgeSendMessage.htm',
			data : {
				'orderHead.orderId': orderId
			},
			success : function(data) {
				if(data.info == 'true'){
					alert("短信催发成功");
				} else{
					alert("短信催发失败");
				}
				isUrgeMsg = true;
			},
			error:function(data){
				alert("短信催发失败");
				isUrgeMsg = true;
			}
		});
	}
</script>

</html>