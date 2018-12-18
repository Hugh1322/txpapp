<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>
<%@page import="com.ytoxl.module.yipin.order.dataobject.OrderHead"%>
<html lang="zh">
<head>
<meta charset="utf-8" />
<title>CPS管理</title>
<link href="${_cssPath }/common.css" rel="stylesheet" />
<link href="${_jsPath }/plugin/My97DatePicker/skin/WdatePicker.css"
	rel="stylesheet" />
<script type="text/javascript" src="${_jsPath }/jquery/jquery.1.8.1.js"></script>
<script src="${_jsPath }/plugin/My97DatePicker/WdatePicker.js"></script>
<script src="${_jsPath }/plugin/formvalidator/formValidatorRegex.js"
	language="javascript"></script>
<script src="${_jsPath }/plugin/formvalidator/formValidator-4.1.3.js"
	language="javascript"></script>
<script type="text/javascript">
    
    </script>
<body>
	<!--start header-->
	<jsp:include page="../include/header.jsp"></jsp:include>
	<!--end header-->
	<!--start body-->
	<div class="body m-w980p">
		<!--start form-->
		<form class="m-mt10p m-clear"
			action="${_ctxPath}/admin/cpsOrder/cpsOrderDeal-detail.htm"
			method="post" id="subform">
			<div class="m-clear">
				<div>
					<select name="cpsOrderDealDetailPage.params.cpsServerId"
						class="m-sel">
						<option value="">所有CPS服务商</option>
						<c:forEach items="${cpsServers}" var="cpsServer">
								<option value="${cpsServer.id}" <c:if test="${cpsServer.id == cpsOrderDealDetailPage.params.cpsServerId}">selected = "selected"</c:if>>
									${cpsServer.name}
								</option>
						</c:forEach>
					</select> 
					
					<select name="cpsOrderDealDetailPage.params.cpsStatus"
						class="m-sel">
						<option value="">所有数据状态</option>
						<c:forEach items="<%=OrderHead.CPS_STATUS %>" var="ss">
								<option value="${ss}" <c:if test="${ss eq cpsOrderDealDetailPage.params.cpsStatus}">selected = "selected"</c:if>>
									<spring:message code="cps.data.status.${ss}"/>
								</option>
						</c:forEach>
					</select>
				</div>
				<span class="m-fl" style="margin-top: 10px;"> <select
					name="cpsOrderDealDetailPage.params.selectTimeType" class="m-sel">
						<option value="ORDER_CREATE_TIME" <c:if test="${cpsOrderDealDetailPage.params.selectTimeType=='ORDER_CREATE_TIME' }"> selected = "selected" </c:if>>下单时间</option>
						<option value="REFUND_TIME" <c:if test="${cpsOrderDealDetailPage.params.selectTimeType=='REFUND_TIME' }"> selected = "selected" </c:if>>退款申请时间</option>
						<option value="REFUND_FINISH_TIME" <c:if test="${cpsOrderDealDetailPage.params.selectTimeType=='REFUND_FINISH_TIME' }"> selected = "selected" </c:if>>退款完成时间</option>
						<option value="ORDER_FINISH_TIME" <c:if test="${cpsOrderDealDetailPage.params.selectTimeType=='ORDER_FINISH_TIME' }"> selected = "selected" </c:if>>订单完成时间</option>
				</select> <label>日期：</label> <input id="beginTime"
					name="cpsOrderDealDetailPage.params.beginTime"
					value="${cpsOrderDealDetailPage.params.beginTime}" class="Wdate"
					type="text" readOnly="readOnly"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" /> <label>至 </label>
					<input id="endTime" name="cpsOrderDealDetailPage.params.endTime"
					value="${cpsOrderDealDetailPage.params.endTime }" class="Wdate"
					type="text" readOnly="readOnly"
					onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{\'%y-%M-%d\'}'})" /> </span>

				<c:if test="${not empty cpsOrderDealDetailPage.result}">
					<span class="m-fr curr-num"> <label>当前显示： </label> <yp:commPageSize
							page="${cpsOrderDealDetailPage}" beanName="cpsOrderDealDetailPage"></yp:commPageSize>
						<br/><a style="color: #f63c30;" href="${_ctxPath}/admin/cpsOrder/cpsOrderDeal-list.htm?menuFlag=100884">≤返回上一级</a>
					</span>
				</c:if>
			</div>
			<div class="m-search" style="margin-top: 10px;">
				<input type="button" class="m-btn m-btn-search" value="查 询"
					id="search" /> 
				<input type="button" class="m-btn" value="导出Excel"
					id="export" />
			</div>
			<div class="m-search" style="margin-top: 10px;margin-left:5px;">
				<span style="font-size:14px;"><span style="margin-left: 8px;">交易订单数：${totalOrderDealNum }</span>
					<span style="margin-left: 8px;">发货订单数：${totalOrderNum }</span>
				</span>
			</div>
		</form>
		<!--start 品牌管理table-->
		<div class="m-mt10p" style="width:1100px;">
			<table class="tab-control" >
				<thead>
					<tr>
						<th width="10%">交易时间（下单时间）</th>
						<th width="5%">订单状态</th>
						<th width="7%">交易完成时间</th>
						<th width="7%">发货订单号</th>
						<th width="10%">订货编号(交易订单号)</th>
						<th width="5%">商品编号(SKU)</th>
						<th width="3%">数量</th>
						<th width="5%">销售单价</th>
						<th width="5%">销售金额</th>
						<th width="5%">退款金额</th>
						<th width="6%">退款申请时间</th>
						<th width="6%">退款结束时间</th>
						<th width="5%">服务商</th>
						<th width="5%">联盟会员编号</th>
						<th width="4%">数据状态</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty cpsOrderDealDetailPage.result}">
							<tr>
								<td colspan="15">没有找到预订记录！</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach items="${cpsOrderDealDetailPage.result}" var="deal"
								varStatus="status">
								<tr class="list-tr">
									<td>
										<fmt:formatDate value='${deal.dealCreateTime}'
											pattern='yyyy-MM-dd HH:mm:ss' />
									</td>
									<td>
										<spring:message code="order.status.${deal.orderStatus}"/>
									</td>
									<td>
										<fmt:formatDate value='${deal.orderFinishTime}'
											pattern='yyyy-MM-dd HH:mm:ss' />
									</td>
									<td>${deal.orderNo }</td>
									<td>${deal.dealCode }</td>
									<td>${deal.productSkuId}</td>
									<td>${deal.orderItemNumber}</td>
									<td>${deal.orderItemPrice}</td>
									<td>${deal.orderItemAmount}</td>
									<td>${deal.refundAmount}</td>
									<td>
										<fmt:formatDate value='${deal.refundCreateTime}'
											pattern='yyyy-MM-dd HH:mm:ss' />
									</td>
									<td>
										<fmt:formatDate value='${deal.refundFinishTime}'
											pattern='yyyy-MM-dd HH:mm:ss' />
									</td>
										<c:forEach items="${cpsServers}" var="cpsServer">
											<c:if test="${deal.orderOrigin == null}">
												<c:if test="${cpsServer.id == deal.cpsServerId}">
												<td>${cpsServer.name}</td>
												</c:if>
											</c:if>
											<c:if test="${deal.orderOrigin != null}">
												<c:if test="${cpsServer.id == deal.orderOrigin}">
												<td>${cpsServer.name}</td>
												</c:if>
											</c:if>
										</c:forEach>
									<td>${deal.cpsServerUnionNo}</td>
									<td>
										<spring:message code="cps.data.status.${deal.cpsStatus}"/>
									</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
		<!--end 品牌管理table-->
		<div class="table-bm-wrap cf">
			<div class="fn-right">
				<div class="pagination pagination-right">
					<c:if test="${not empty cpsOrderDealDetailPage.result}">
						<yp:commPage page="${cpsOrderDealDetailPage}" beanName="cpsOrderDealDetailPage"></yp:commPage>
						<input type="hidden" id="totalNum" value="${cpsOrderDealDetailPage.total }"/>
					</c:if>
				</div>
			</div>
		</div>
	</div>

</body>
<jsp:include page="/WEB-INF/pages/include/foot.jsp"></jsp:include>
<script type="text/javascript">
	$(document).ready(function() {
		$(".add-seo-info").hide();
		$("#search").bind("click", function() {
			if($("#beginTime").val() && $("#endTime").val()){
				if(compareDate($("#beginTime").val(),$("#endTime").val())){
					return;
				}
			}
			$("#subform").submit();
		});
		
		//
		$("#description").input();
		$("#export").bind("click", function() {
			 if($("#totalNum").val()==null){
				    alert("没有预订记录，不能导出！");
					return;
			 }
			 /*if($("#totalNum").val()>50000){
				    alert("导出记录不能超过5万条！");
					return;
			 }*/
			 $("#subform").attr('action','${_ctxPath}/admin/cpsOrder/cpsOrderDeal-exportDetail.htm');
		     $("#subform").submit();
		     $("#subform").attr('action','${_ctxPath}/admin/cpsOrder/cpsOrderDeal-detail.htm');
		});
		
		
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
		    var add3month = new Date(arys1[0],parseInt(arys1[1]-1)+3,arys1[2]);  
			if(sdate > edate) { 
				alert("开始时间不能大于结束时间！");
			    return true;         
			}else if(add3month<edate){
				alert("起止时间前后选择不超3个自然月！");
				return true;
			}else{   
			    return false;      
		    }   
	    }      
	}    

	
</script>

</html>