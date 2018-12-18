<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.txp.app.contants.FinanceAccounts"%>
<%@include file="../include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>财务结算</title>
	<link href="${ _cssPath}/common.css" rel="stylesheet" />
    <link href="${ _cssPath}/pages/buyerManagement.css" rel="stylesheet" />
    <link href="${_jsPath }/plugin/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" />
    <script src="${_jsPath }/jquery/jquery.1.8.1.js"  language="javascript"></script>
    <script src="${_jsPath }/plugin/form/jquery.form.js"  language="javascript"></script>
    <script src="${_jsPath }/plugin/My97DatePicker/WdatePicker.js"></script>
</head>
<%
/**待审核	 */
String wating =  FinanceAccounts.ACCOUNTS_WATING.toString() ;
/**代付款	 */
String pay = FinanceAccounts.ACCOUNTS_PAY.toString();
/**已取消	 */
String cancle = FinanceAccounts.ACCOUNTS_CANCLE.toString();
/**审核不通过	 */
String nopass = FinanceAccounts.ACCOUNTS_NOPASS.toString();
/**已经结算	 */
String finish = FinanceAccounts.ACCOUNTS_FINISH.toString();
pageContext.setAttribute("wating",wating);
pageContext.setAttribute("pay",pay);
pageContext.setAttribute("cancle",cancle);
pageContext.setAttribute("nopass",nopass);
pageContext.setAttribute("finish",finish);
%>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp"  flush="true" />
	 <div class="body m-w980p income_fa">
		<div class="concr_title" id="sellerInfo">
	         	
		</div>
		<form class="m-mt10p m-clear" action="${_ctxPath}/admin/accounts/accounts-showSellerReportDetail.htm" id="search-form" method="post">
		    <div class="m-fl">
	           <label>状态： </label>
	           <select class="m-sel" name="faPage.params.status">
		          	<option value="-1">请选择</option>
		          	<c:forEach items="${accountsStatuts}" var="accounts" >
		          		<option  value="${accounts}" data-dd="${faPage.params.status}-${accounts }-${faPage.params.status eq accounts}"
		          			    <c:if test="${faPage.params.status eq accounts}">
		          			      selected="selected"
		          			    </c:if>
		          		>
		          			<spring:message code="accounts.status.${accounts}" /> 
		          		</option>
		          	</c:forEach>
		      </select> 
		      <input type="hidden" id="seller" name="faPage.params.userId" value="${faPage.params.userId}"/>
	          <label>结算日期：</label>
	          <select name="faPage.params.accountTime" class="m-sel" >
	          	<option value="-1">请选择</option>
	          	<c:forEach items="${date}" var="d">
	          		 <option  value="${d}"
	          		 	<c:if test="${d eq faPage.params.accountTime}">
		          			      selected="selected"
		          		</c:if>
	          		 >
	          			${d}
	         		 </option>	 
	          	</c:forEach>   
	          </select>          
	          <input type="submit" class="m-btn" value="查 询"/>
	          <c:if test="${not empty faPage.result}">
		      	<input type="button" class="m-btn" id="export" value="导 出"/>
		      </c:if>
		      </div>
		      <c:if test="${not empty faPage.result}">
				    <div class="m-fr curr-num">
							<label>当前显示： </label> 
			        		<yp:commPageSize page="${faPage}" beanName="faPage"></yp:commPageSize>
					</div>
		     </c:if>
		</form>
		 <div class="m-mt10p income_dowm">
			<table width="100%">
				<thead class="tab-control">
				<tr id="income_tr">
				    <th width="9%">结算周期</th>
				    <th width="3%">商品销售数量</th>
				    <th width="6%">商品销售收入</th>
				    <th width="4%">退款</th>
				    <th width="4%">退货</th>
				    <th width="7%">退货退款后收入</th>
				    <th width="6%">应付运费</th>
				    <th width="6%">服务费率</th>
				    <th width="6%">应收服务费</th>
				    <th width="8%">应付其他代垫款项</th>
				    <th width="6%">应付销售激励</th>	
				    <th width="6%">应付账款合计</th>	
				    <th width="7%">上期未结账款合计</th>	
				    <th width="8%">本期应付账款合计</th>		
				    <th width="6%">交易手续费</th>	
				    <th width="5%">净收入</th>	 
				    <th width="5%">结算状态</th>
				    <th width="5%">结算完成时间</th>
				    <th width="5%">操作</th>
				</tr>
				</thead>
			<tbody class="income_tbody">
				<c:forEach items="${faPage.result}" var="fa">
					<tr>
						<td>${fa.accountTime }</td>
						<td>${fa.salesQuantity}</td>
						<td>${fa.salesMoney }</td>
						<td>${fa.reimburse}</td>
						<td>${fa.salesReturn}</td>
						<td>${fa.unReturnSales}</td>
						<td>${fa.freight}</td>
						<td>${fa.serverChargeStr}</td>
						<td>${fa.serverCharge}</td>
						<td>${fa.otherCharge}</td>
						<td>${fa.salesIncentive}</td>
						<%-- <td>${fa.creditTotal}</td> --%>
						<td>${fa.sa.accountsTotal}</td>
						<td>${fa.sa.lastUnsettled}</td>
						<td>${fa.sa.receivable}</td>
						<td>${fa.dealHanding}</td>
						<td>${fa.gross}</td>
						<td>
		          			<spring:message code="accounts.status.${fa.status}" />
						</td>
						<td><fmt:formatDate value="${fa.sa.finishTime}" pattern="yyyy-MM-dd"/></td>
						<td id="operationTb_${fa.accountsId}">
							<c:if test="${fa.status eq wating }">
								<input type="button" class="m-btn" value="审核通过" onclick="operationAccoutn('1','${fa.accountsId}')"/>
							</c:if>
							<c:if test="${fa.status eq pay }">
								<input type="button" class="m-btn" value="确认打款" onclick="operationAccoutn('2','${fa.accountsId}')"/>
							</c:if>
							<c:if test="${fa.status eq cancle }">
								已过期
							</c:if>
							<c:if test="${fa.status eq nopass }">
								审核不通过
							</c:if>
							<c:if test="${fa.status eq finish }">
								结算完成
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
			</table>
		</div>
		<!--end 买家管理table-->
		<div class="pagination pagination-right">
			<c:if test="${not empty faPage.result}">
				<yp:commPage page="${faPage}" beanName="faPage"></yp:commPage>
			</c:if>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/foot.jsp"></jsp:include>
</body>
<script>
 $(document).ready(function(){
	 //加载当前商家的名称金额
	 $.ajax({
		 	url:_ctxPath + "/admin/accounts/accounts-ajaxSellerAccounts.htm?data="+new Date(),
			type:"POST",
			data:{'faPage.params.userId':$("#seller").val()},
			dataType:"json",
			async: false,
			success:function(data){
				console.log(data.info);
				var list = eval(data.info);
				for(var i=0;i<list.length;i++){
					//console.log(list[i].totalPay+""+list[i].userName);
					$("#sellerInfo").html("商家名称：<span class='concr_ti_sp'>"+list[i].userName+"</span>已付账款<span class='concr_ti_f'>:"+list[i].totalPay+"</span> ");
				}
			}
	 });
	 $("#incom_click").click(function(){$(".income_up").show();})	 
	 $(".inup_bu").click(function(){$(".income_up").hide();})	 
	 $(".income_close").click(function(){$(".income_up").hide();})
     $(".icn_la").click(function(){setSelectAll();})
     $("#selAll").click(function(){selectAll();})
     $("#export").click(function(){
    	 $("#search-form").attr("action","${_ctxPath}/admin/accounts/accounts-exportSellerDetailReport.htm");
    	 $("#search-form").submit();
    	 $("#search-form").attr("action","${_ctxPath}/admin/accounts/accounts-showSellerReportDetail.htm");
     });
 })
 function operationAccoutn(type,accountsId){
	 var title = '';
	 if(type=='1'){
		 title = "确认审核通过？";
	 }else{
		 title = "确认打款？";
	 }
	 $.dialog({
		    lock: true,
		    padding: "10px",
		    title:"财务结算",
		    content:title,
		    fixed: true,
		    cancel: true,
		    cancelValue:"取  消",
		    ok:function(){
			   	 $.ajax({
			   		 	url:_ctxPath + "/admin/accounts/accounts-operationAccounts.htm?data="+new Date(),
			   			type:"POST",
			   			data:{'faPage.params.type':type,"faPage.params.accountsId":accountsId},
			   			dataType:"json",
			   			async: false,
			   			success:function(data){
			   				if(data.code=='true'){
			   					if(type=='1'){
			   						$("#operationTb_"+accountsId).html("<input type='button' class='m-btn' value='确认打款' onclick='operationAccoutn(2,"+accountsId+")'/>");
			   					}else{
			   						$("#operationTb_"+accountsId).html("结算完成");
			   					}
			   				}else{
			   					alert("操作失败,稍后再试.");
			   				}
			   			}
			   	 });
		    },
		    cancel:function(){
		    	 
		    },
		    okValue:"保  存"
	  });
 }
</script>
</html>