<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>智能查件</title>
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
		<form class="m-mt10p m-clear" action="${_ctxPath}/admin/order/orderMonitoring-smartQueryMails.htm" method="post" id="subform">
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
                    <input id="beginTime" name="orderPage.params.beginTime" value="${orderPage.params.beginTime}" class="Wdate" type="text" readOnly="readOnly" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
                    <label>至 </label>
                    <input id="endTime" name="orderPage.params.endTime" value="${orderPage.params.endTime }" class="Wdate" type="text" readOnly="readOnly" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})"/>
                	
                	<input type="text" class="J-keywords txt-input input-marks" data-default="输入收货人、订单号、电话、运单号" name="orderPage.params.keyWords" value="${orderPage.params.keyWords }" />
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

		<div class="order-management">
			<table id="order-tab" width="100%">
				<thead class="tab-control">
					<tr>
						<th width="10%">运单号</th>
						<th width="10%">订单号</th>
						<th width="15%">商家名称</th>
						<th width="12%">下单时间</th>
						<th width="10%">收货人</th>
						<th width="10%">收货人电话</th>
						<th width="10%">订单状态</th>
						<th width="23%">物流跟踪记录</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${orderPage.result}" var="order" varStatus="status">
						<tr class="list-tr">
							<td colspan="11" class="td-nobor">
								<table class="tab-control">
									<tr class="tr-height">
										<td class="num-icon" width="10%">
											${order.expressNo }
										</td>
										<td width="10%">
											${order.orderNo }
											<input type="hidden" value="${order.orderId}" id='orderId' />
										</td>
										<td width="15%"><a href="${_ctxPath}/admin/order/orderMonitoring-getSellerDetailInfo.htm?userId=${order.userId}" class="J_tr">${order.companyName }</a></td>
										<td width="12%"><fmt:formatDate value='${order.createTime}' pattern='yyyy-MM-dd HH:mm' /></td>
										<td width="10%">${order.receiverName }</td>
										<td width="10%">${order.mobile }</td>
										<td width="10%">
											<c:choose> 
												<c:when test="${order.status == '1'}">
													待付款
												</c:when> 
												<c:when test="${order.status == '2'}">
													待发货
												</c:when> 
												<c:when test="${order.status == '3'}">
													已发货
												</c:when>
												<c:when test="${order.status == '4'}">
													已完成
												</c:when>
												<c:when test="${order.status == '5'}">
													已取消
												</c:when>
												<c:when test="${order.status == '6'}">
													已退货
												</c:when>
											</c:choose>
										</td>
										<td width="23%">&nbsp;</td>
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
		
		//防止在一次请求 多次点击
		var isPost = true;
	 	$(".tr-height").on("click", function() {
	 		$this = $(this);
			var orderId = $this.find('#orderId').val();
			if (!$(this).next(".show-tr")[0]) {
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
</script>

</html>