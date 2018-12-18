<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.txp.app.contants.Prop"%>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<meta charset="utf-8" />
<title>我的收入</title>
<link href="${_cssPath }/common.css" rel="stylesheet" />
<script type="text/javascript" src="${_jsPath }/jquery/jquery.1.8.1.js"></script>

<style>
	.order-management{margin-top:10px;}
	.order-management table{border:1px solid #BFAD61;}
	.order-management table td{border-bottom:1px solid #BFAD61;padding-left:5px;}
</style>
<script>
		function apply(accountsId){
			$.dialog({
	            title: false,
	            lock: true,
	            content: "是否确定申请审核 ？",
	            okValue: "确认",
	            ok: function(){ 
	            	$.ajax({
	        			type:'POST',
	        			url: _ctxPath + '/admin/accounts/sellerAccounts-apply4Settlement.htm',
	        			data: "accountsId="+accountsId,
	        			success:function(msg){
	        				 if(msg.code == "true"){
	        					alert(msg.info);
	        					subQuery();
	        				} 
	        			},
	        			error: function(xhr){
	        				popupDialog(xhr.responseText);
	        	        }
	        		});
	            },
	            cancelValue: "取消",
	            cancel: true
	     	});
			$(".d-close").hide();
		};
		
		function exportExls(){
			var path = "${_ctxPath}/admin/accounts/sellerAccounts-export.htm";  
		    $('#subform').attr("action", path).submit();;  
		}

</script>
<body>
	<!--start header-->
	<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
	<!--end header-->
	<div class="body m-w980p">
		<!--start form-->
		<form class="m-mt10p m-clear" action="${_ctxPath}/admin/accounts/sellerAccounts-sellerAccountsReport.htm" method="post" id="subform">
			<p class="f14" style="font-weight:bold;padding-bottom:10px;">已收入：
			
			<c:choose>
		       <c:when test="${CreditTotaled == null}">
		            	0
		       </c:when>
		       <c:otherwise>
		              ${CreditTotaled}
		       </c:otherwise>
		</c:choose>
		元
			<span style="margin-left:20px;">已成交总金额：
			<c:choose>
		       <c:when test="${ AllAmount == null}">
		            	0
		       </c:when>
		       <c:otherwise>
		              ${ AllAmount }
		       </c:otherwise>
		</c:choose>
			元</span></p>
            <div  class="m-clear">
                <span class="m-fl">
                	状态：
                    <select name="saPage.params.status" class="m-sel">
                    		 <option value="">全部</option>
							 <c:forEach items="${accountsStatuts }" var="obj">
                        		<option value="${obj }"
								<c:if test="${saPage.params.status==obj }">
									selected = "selected"
								</c:if>
								><spring:message code="sellerAccounts.status.${obj}"/></option>
                        	</c:forEach>
                    </select>
                                                     交易时间：
                    <select name="saPage.params.dateTime" class="m-sel">
                        <c:forEach items="${date }" var="objdate">
                        <option value="${objdate }"
                        <c:if test="${saPage.params.dateTime==objdate }">
									selected = "selected"
								</c:if>
                        >${objdate }</option>
                        </c:forEach>
                    </select>
                    <input type="submit" class="m-btn m-btn-search" value="查 询" id="search" /> 
                    	<c:if test="${not empty saPage.result}">
	      			<input type="button" class="m-btn" value="导出" id="export" onclick="exportExls()" />  
	      				</c:if>
                </span>
                <span class="m-fr curr-num">
                      	<c:if test="${not empty saPage.result}">
						    <div class="m-fr curr-num">
									<label>当前显示： </label> 
					        		<yp:commPageSize page="${saPage}" beanName="saPage"></yp:commPageSize>
							</div>
				      	</c:if>

                    </span>
                
            </div>
		</form>
		<!--start 下单管理table-->
		<div class="order-management">
			<table id="order-tab" width="100%">
				<thead class="tab-control">
					<tr>
						<th width="20px">ID</th>
						<th width="70px">结算周期</th>
						<th width="">商品销售数量</th>
						<th width="">商品销售收入</th>
						<th width="30px">退款</th>
						<th width="30px">退货</th>
						<th width="">退款退货后收入</th>
						<th width="">应收运费</th>
						<th width="">服务费率</th>
						<th width="">应付服务费</th>
						<th width="">应付其他垫款项</th>
						<th width="">应付销售激励</th>
						<th width="">应收账款合计</th>
						<th width="">上期未结账款合计</th>
						<th width="">本期应收账款合计</th>
						<th width="">结算状态</th>
						<th width="">结算完成时间</th>
						<th width="50px">操作</th>
					</tr>
				</thead>
				<tbody class="income_tbody">
					<c:forEach items="${saPage.result}" var="sa" >
						<tr class="tr-height" accountsId="${sa.accountsId}" accountsStatus="${sa.status }" >
							<td>${sa.accountsId}</td>
							<td>
							<a href="${_ctxPath}/admin/order/order-searchOrders4CashManager.htm?orderPage.params.sellerId=${sa.userId}&orderPage.params.beginOverProductTime=<fmt:formatDate value="${sa.clearingStartTime }" pattern="yyyy-MM-dd"/>&orderPage.params.endOverProductTime=<fmt:formatDate value="${sa.clearingEndTime }" pattern="yyyy-MM-dd"/>">
							<fmt:formatDate value="${sa.clearingStartTime }" pattern="yyyy-MM-dd"/>至<fmt:formatDate value="${sa.clearingEndTime }" pattern="yyyy-MM-dd"/>
							</a>
							</td>
							<td>${sa.salesQuantity }</td>
							<td>${sa.salesMoney}</td>
							<td>${sa.returnSales }</td>
							<td>${sa.returnPro }</td>
							<td>${sa.unReturnSales }</td>
							<td>${sa.freight }</td>
							<td>${sa.serverRateStr }</td>
							<td>${sa.serverMoney }</td>
							<td>${sa.otherMoney }</td>
							<td>${sa.stimulate }</td>
							<td>${sa.accountsTotal}</td>
							<td>${sa.lastUnsettled}</td>
							<td>${sa.receivable}</td>
							<td>
								<c:if test="${sa.status==0 }">
									申请审核
								</c:if>
								<c:if test="${sa.status==1 }">
									待审核
								</c:if>
								<c:if test="${sa.status==2 }">
									待付款
								</c:if>
								<c:if test="${sa.status==3 }">
									已完成
								</c:if>
								<c:if test="${sa.status==4 }">
									已过期
								</c:if>
								<c:if test="${sa.status==5 }">
									未通过
								</c:if>
							</td>
							<td><fmt:formatDate value="${sa.finishTime }" pattern="yyyy-MM-dd"/></td>
							<td>
								<c:if test="${sa.status==0 }">
									<input type="button" class="m-btn" value="申请结算" onclick="apply('${sa.accountsId}')"/>
								</c:if>
								
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
					<c:if test="${not empty saPage.result}">
						<yp:commPage page="${saPage}" beanName="saPage"></yp:commPage>
					</c:if>
				</div>
				<!--E 分页-->
			</div>
			<!--E 右功能区-->
		</div>
	</div>
	<!--start footer-->
	<jsp:include page="/WEB-INF/views/include/foot.jsp"></jsp:include>
</body>
</html>