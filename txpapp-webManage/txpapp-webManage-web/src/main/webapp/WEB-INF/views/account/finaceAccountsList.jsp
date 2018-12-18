<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
<body>
	<!--start header-->
	<jsp:include page="../include/header.jsp"></jsp:include> 
	<div class="body m-w980p income_fa">
		<form class="m-mt10p m-clear" action="${_ctxPath}/admin/accounts/accounts-showSellerReport.htm" id="search-form" method="post">
			    <div class="m-fl">
		          <label>商家：</label>
		          <input type="button" class="m-btn" value="请 选 择" id="incom_click"/>
		         <%--  
		          <label>结算状态：</label>
		          <select class="m-sel" name="famPage.params.status">
		          		<option value="-1">请选择</option>
		          		<c:forEach items="${accountsStatuts}" var="accounts" >
		          			<option  value="${accounts}"
		          			    <c:if test="${famPage.params.status eq accounts}">
		          			      selected="selected"
		          			    </c:if>
		          			>
		          			<spring:message code="accounts.status.${accounts}" /> 
		          			</option>
		          		</c:forEach>
		          </select> 
		          --%>
		          <input type="button" class="m-btn" id="inc_sel" value="查 询"/>
		          <c:if test="${not empty famPage.result}">
			      <input type="button" class="m-btn" id="account_export" value="导 出"/>
			      </c:if>
			      <input type="button" class="m-btn" id="account_check"value="商家结算审核"/>
			    </div>
			   	<c:if test="${not empty famPage.result}">
				    <div class="m-fr curr-num">
							<label>当前显示： </label> 
			        		<yp:commPageSize page="${famPage}" beanName="famPage"></yp:commPageSize>
					</div>
		      	</c:if>
		      	<!-- 商家信息列表 -->
		      	<%@include file="sellerInfo.jsp" %>
		</form>
		<div class="m-mt10p income_dowm">
			<table width="100%">
				<thead class="tab-control">
				<tr id="income_tr">
				   <th width="7%">商家名称</th>
				    <th width="6%">商品销售数量</th>
				    <th width="6%">商品销售收入</th>
				    <th width="6%">退款</th>
				    <th width="6%">退货</th>
				    <th width="7%">退款退货后收入</th>
				    <th width="6%">应付运费</th>
				    <th width="6%">服务费率</th>
				    <th width="6%">应收服务费</th>
				    <th width="8%">应付其他代垫款项</th>
				    <th width="6%">应付销售激励</th>	
				    <th width="6%">应付账款合计</th>	
				    <th width="7%">上期未结账款合计</th>	
				    <th width="7%">本期应付账款合计</th>	
				    <th width="6%">交易手续费</th>		
				    <th width="6%">净收入</th>	
				    <th width="5%">操作</th>	 
				</tr>
				</thead>
				<tbody class="income_tbody">
					<c:forEach items="${famPage.result}" var="fa" >
						<tr>
							<td>${fa.userName}</td>
							<td>${fa.salesQuantity }</td>
							<td>${fa.salesMoney }</td>
							<td>${fa.reimburse }</td>
							<td>${fa.salesReturn }</td>
							<td>${fa.unReturnSales }</td>
							<td>${fa.freight }</td>
							<td>${fa.serverChargeStr }</td>
							<td>${fa.serverCharge}</td>
							<td>${fa.otherCharge }</td>
							<td>${fa.salesIncentive }</td>
							<td>${fa.creditTotal }</td>
							<td>${fa.last}</td>
							<td>${fa.current }</td>
							<td>${fa.dealHanding }</td>
							<td>${fa.gross }</td>
							<td><input type="button" class="m-btn" value="详细信息" onclick="details('${fa.userId}')"/></td>
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
					<c:if test="${not empty famPage.result}">
						<yp:commPage page="${famPage}" beanName="famPage"></yp:commPage>
					</c:if>
				</div>
				<!--E 分页-->
			</div>
			<!--E 右功能区-->
		</div>
	</div>
	<!--end foot-->
	<jsp:include page="/WEB-INF/views/include/foot.jsp"></jsp:include>
	<script src="${_jsPath }/pages/financeAccount.js"  language="javascript"></script>
</body>
<script type="text/javascript">
  $(document).ready(function(){
	 $("#inc_sel").click(function(){
			var userIds = "";
			$(".checkAll").each(function(){
				if($(this).is(":checked")){
					userIds +=$(this).val()+"-";
				}
			});
			if(userIds!=""){
				$("#famPageUserList").val(userIds);
			}
			$("#search-form").submit();
	 }); 
	 $("#account_export").click(function(){//导出
			$('#search-form').attr("action","${_ctxPath}/admin/accounts/accounts-exportSellerAccounts.htm");
			$('#search-form').submit();
			$('#search-form').attr("action","${_ctxPath}/admin/accounts/accounts-showSellerReport.htm");
	 });
	 $("#incom_click").click(function(){
		 $(".income_up").show();
		 //ajax去后台获取用户
		 searcherSellert($("#currentPage").val());
	 })	 
 	$("#account_check").click(function(){
		 window.location = "${_ctxPath}/admin/accounts/accounts-accountCheck.htm";
	 });
	 $(".inup_bu").click(function(){$(".income_up").hide();})	 
	 $(".income_close").click(function(){$(".income_up").hide();})
     $(".icn_la").click(function(){setSelectAll();})
     $("#selAll").click(function(){selectAll();}) 
  });
 </script>
</html>