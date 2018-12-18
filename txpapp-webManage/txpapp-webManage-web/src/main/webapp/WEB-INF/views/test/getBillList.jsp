<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>
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
<body>
<!--start header-->
<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
<!--end header-->
<div class="body m-w980p">
	<!--start form-->
	<form class="m-mt10p m-clear" action="" method="post" id="subform">
		<p class="f14" style="font-weight:bold;padding-bottom:10px;">已收入：￥9999.00<span style="margin-left:20px;">已成交总金额：111.00元</span></p>
		<div  class="m-clear">
                <span class="m-fl">
                	状态：
                    <select name="orderPage.params.brandId" class="m-sel">
						<option value="">请选择<option>
					</select>
                                                     交易时间：
                    <select name="orderPage.params.sellerId" class="m-sel">
						<option value="">2014-2-25</option>
					</select>
                    <input type="button" class="m-btn m-btn-search" value="查 询" id="search" />
	      			<input type="button" class="m-btn" value="导出" id="export" />
                </span>
                <span class="m-fr curr-num">
                        <label>当前显示： </label>

					<!-- 	<div style="float:right"> -->
	 <select name="orderPage.limit" class="m-sel" onchange="window.location = '?orderPage.params.beginTime=2014-04-03&orderPage.params.endTime=2014-04-09&orderPage.total=4&orderPage.sort=&orderPage.dir=asc&orderPage.limit=' + this.value;">
		 <!-- 	     <option value="20">-每页显示条数-</option> -->

		 <option value="20"
				 selected=selected
		 >每页20条</option>

		 <option value="50"

		 >每页50条</option>

		 <option value="100"

		 >每页100条</option>

		 <option value="200"

		 >每页200条</option>

		 <option value="500"

		 >每页500条</option>

	 </select>
					<!-- 	 </div> -->



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
				<th width="">结算状态</th>
				<th width="">结算完成时间</th>
				<th width="50px">操作</th>
			</tr>
			</thead>
			<tbody>
			<tr class="tr-height">
				<td class="num-icon">01</td>
				<td>2014-04-03至<br/>2014-04-03</td>
				<td>1</td>
				<td>￥500</td>
				<td>￥0</td>
				<td>￥100</td>
				<td>￥400</td>
				<td>5%</td>
				<td>￥20</td>
				<td>￥0</td>
				<td>￥50</td>
				<td>￥340</td>
				<td>￥0</td>
				<td>￥340</td>
				<td>待结算</td>
				<td>2012-01-00 11:11:11</td>
				<td><a href="#">申请结算</a></td>
			</tr>
			<tr class="tr-height">
				<td class="num-icon">01</td>
				<td>2014-04-03至<br/>2014-04-03</td>
				<td>1</td>
				<td>￥500</td>
				<td>￥0</td>
				<td>￥100</td>
				<td>￥400</td>
				<td>5%</td>
				<td>￥20</td>
				<td>￥0</td>
				<td>￥50</td>
				<td>￥340</td>
				<td>￥0</td>
				<td>￥340</td>
				<td>待结算</td>
				<td>2012-01-00 11:11:11</td>
				<td><a href="#">申请结算</a></td>
			</tr>
			<tr class="tr-height">
				<td class="num-icon">01</td>
				<td>2014-04-03至<br/>2014-04-03</td>
				<td>1</td>
				<td>￥500</td>
				<td>￥0</td>
				<td>￥100</td>
				<td>￥400</td>
				<td>5%</td>
				<td>￥20</td>
				<td>￥0</td>
				<td>￥50</td>
				<td>￥340</td>
				<td>￥0</td>
				<td>￥340</td>
				<td>待结算</td>
				<td>2012-01-00 11:11:11</td>
				<td><a href="#">申请结算</a></td>
			</tr>
			</tbody>
		</table>
	</div>
	<div class="table-bm-wrap cf">
		<div class="fn-right">
			<div class="pagination pagination-right">
				<div class="pagination">
					<a  class="prev_no" href="javascript:; "
					>
						<span class="disable"></span>
					</a>
					<a href="?orderPage.params.beginTime=2014-04-03&orderPage.params.endTime=2014-04-09&orderPage.total=4&orderPage.limit=20&orderPage.sort=&orderPage.dir=asc&orderPage.currentPage=0" ><span class="current">1</span></a>
					<a  href="javascript:; "   >
						<span class="next"></span>
					</a>
	    <span>
	                共<i>1</i>页<i>4</i>条
	                到 <input type="text" class="goto-num" id="pageIndex" value="1" onfocus="this.value='';" maxLength="8" />页
	    </span>
					<input type="button" value="转到" class="goto" id="go_page" onclick="window.location = '?orderPage.params.beginTime=2014-04-03&orderPage.params.endTime=2014-04-09&orderPage.total=4&orderPage.limit=20&orderPage.sort=&orderPage.dir=asc&orderPage.currentPage=' + (document.getElementById('pageIndex').value - 1 );" />
				</div>
			</div>
		</div>
	</div>
</div>
<!--start footer-->
<jsp:include page="/WEB-INF/views/include/foot.jsp"></jsp:include>
</body>
</html>