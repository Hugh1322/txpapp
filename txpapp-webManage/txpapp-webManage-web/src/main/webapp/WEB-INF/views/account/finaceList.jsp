<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.txp.app.contants.AdvPosition"%>
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
		<form class="m-mt10p m-clear" action="${_ctxPath}/admin/accounts/accounts-show.htm" id="search-form" method="post">
			    <div class="m-fl">
		          <label>商家：</label>
		          <input type="button" class="m-btn" value="请 选 择" id="incom_click"/>
		          <label>结算时间：</label>
		          <input type="text" name="faPage.params.startTime" value="${faPage.params.startTime}" class="Wdate" 
		          id="startTime"  onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endTime\',{d:-1});}',minDate:'#F{$dp.$D(\'endTime\',{d:-92});}',readOnly:true})" /> 
		          <label>至 </label>
		           <input type="text" name="faPage.params.endTime" value="${faPage.params.endTime}" class="Wdate" 
		          id="endTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'startTime\',{d:+92});}',maxDate:'%y-%M-%d',minDate:'#F{$dp.$D(\'startTime\')}',readOnly:true})"/>
		          <input type="button" class="m-btn" id="inc_sel" value="查 询"/>
		          <c:if test="${not empty faPage.result}">
			      	<input type="button" class="m-btn" id="account_export" value="导 出"/>
			      </c:if>
			    </div>
			   	<c:if test="${not empty faPage.result}">
				    <div class="m-fr curr-num">
							<label>当前显示： </label> 
			        		<yp:commPageSize page="${faPage}" beanName="faPage"></yp:commPageSize>
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
		    <th width="7%">已结算账款合计</th>	
		    <th width="6%">交易手续费</th>		
		    <th width="6%">净收入</th>	
		    <th width="5%">操作</th>	 
		</tr>
		</thead>
		<tbody class="income_tbody">
			<c:forEach items="${faPage.result }" var="fa" >
				<tr>
					<td>${fa.userName}</td>
					<td>${fa.salesQuantity }</td>
					<td>${fa.salesMoney }</td>
					<td>${fa.reimburse }</td>
					<td>${fa.salesReturn }</td>
					<td>${fa.unReturnSales }</td>
					<td>${fa.freight }</td>
					<td>${fa.serverChargeStr }</td>
					<td>${fa.serverCharge }</td>
					<td>${fa.otherCharge }</td>
					<td>${fa.salesIncentive }</td>
					<td>${fa.creditTotal }</td>
					<td>${fa.creditTotaled }</td>
					<td>${fa.dealHanding }</td>
					<td>${fa.gross }</td>
					<td><a href="${_ctxPath}/admin/order/order-searchOrders4CashManager.htm?orderPage.params.sellerId=${fa.userId}&orderPage.params.beginOverProductTime=${faPage.params.startTime}&orderPage.params.endOverProductTime=${faPage.params.endTime}&cacheType=1">查看</a></td></tr>
											
			</c:forEach>
		</tbody>
	</table>
	</div>

		<div class="table-bm-wrap cf">
			<!--S 右功能区-->
			<div class="fn-right">
				<!--S 分页-->
				<div class="pagination pagination-right">
					<c:if test="${not empty faPage.result}">
						<yp:commPage page="${faPage}" beanName="faPage"></yp:commPage>
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
<script>
  $(document).ready(function(){
	 $("#inc_sel").click(function(){
	   	var startTime_val=$("#startTime").val();
	   	var endTime_val=$("#endTime").val();
	   	if(startTime_val==""|endTime_val==""){
		   alert("请输入开始时间或者是结束时间");
		}else{//
			//将商家集合 抓取过来
			var userIds = "";
			$(".checkAll").each(function(){
				if($(this).is(":checked")){
					userIds +=$(this).val()+"-";
				}
			});
			if(userIds!=""){
				$("#userList").val(userIds);
			}
			$("#search-form").submit();
		}
	 }); 
	 $("#account_export").click(function(){//导出
		 var startTime_val=$("#startTime").val();
		 var endTime_val=$("#endTime").val();
		 if(startTime_val==""|endTime_val==""){
			   alert("请输入开始时间或者是结束时间");
		 }else{//
			 //form 表单序列化
			$('#search-form').attr("action","${_ctxPath}/admin/accounts/accounts-exportSellerReport.htm");
			$('#search-form').submit();
			$('#search-form').attr("action","${_ctxPath}/admin/accounts/accounts-show.htm");
	 	 }
	 });
	 $("#incom_click").click(function(){
		 $(".income_up").show();
		 //ajax去后台获取用户
		 searcherSellert($("#currentPage").val());
	 })	 
	 $(".inup_bu").click(function(){$(".income_up").hide();})	 
	 $(".income_close").click(function(){$(".income_up").hide();})
     $(".icn_la").click(function(){setSelectAll();})
     $("#selAll").click(function(){selectAll();}) 
  });

  </script>
</html>