<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../include/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>发货单[一城一品]</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<style type="text/css">
<!--
.STYLE2 {
	font-size: 18px
}

.STYLE6 {
	font-size: 10px
}
-->
</style>
</head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0"
	marginheight="0">
	<!-- Save for Web Slices (未标题-1.psd) -->
	<table id="__01" width="1000" height="831" border="0" cellpadding="0"
		cellspacing="0">
		<tr>
			<td colspan="3"><img src="${_imagesPath}/sales_list.gif"
				width="338" height="183" alt="">
			</td>
			<td colspan="4"><table width="662" height="183" border="0">
					<tr>
						<td width="19%"><div align="right">订购日期：</div>
						</td>
						<td width="81%"><fmt:formatDate
								value='${orderHead.createTime}' pattern='yyyy-MM-dd' /></td>
					</tr>
					<tr>
						<td><div align="right">订单号：</div>
						</td>
						<td>${orderHead.orderNo}</td>
					</tr>
					<tr>
						<td><div align="right">快递单号：</div>
						</td>
						<td>${orderHead.orderAddress.expressNo}</td>
					</tr>
					<tr>
						<td><div align="right">收货人姓名：</div>
						</td>
						<td>${orderHead.orderAddress.receiverName}</td>
					</tr>
					<tr>
						<td><div align="right">收货人电话：</div>
						</td>
						<td>${orderHead.orderAddress.mobile}</td>
					</tr>
					<tr>
						<td><div align="right">收货人地址：</div>
						</td>
						<td>${orderHead.orderAddress.receiveAddress}</td>
					</tr>
					<tr>
						<td><div align="right">邮编：</div>
						</td>
						<td>${orderHead.orderAddress.postCode}</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="7">
				<table width="992" height="30" border="1" bordercolor="#000000">
					<tr>
						<td bordercolor="#000000">&nbsp;</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="7"><table width="992" border="0" bordercolor="#000000">
					<tr>
						<td width="120"><strong>序号</strong>
						</td>
						<td width="526"><strong>商品名称</strong>
						</td>
						<td width="121"><strong>数量</strong>
						</td>
						<td width="197"><strong>单价</strong>
						</td>
					</tr>
					<c:forEach items="${orderHead.items}" var="item" varStatus="status">
						<tr>
							<td>${status.index + 1}</td>
							<td>${item.productName}</td>
							<td>${item.num}</td>
							<td>${item.unitPrice}元</td>
						</tr>
					</c:forEach>
				</table>
			</td>
		</tr>
		<tr>
			<td rowspan="5"><img
				src="images/&#x672a;&#x6807;&#x9898;-1_05.gif" width="1"
				height="489" alt="">
			</td>
			<td colspan="6"><table width="992" border="1" bordercolor="#000000">
					<tr>
						<td width="79%"><strong>小计</strong>
						</td>
						<td width="21%"><strong>${orderHead.originalAmount}元</strong>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="6"><table width="992" height="62" border="0">
					<tr>
						<td width="170"><div align="right">
								<strong>配送费（元）:</strong>
							</div>
						</td>
						<td width="150"><strong><c:if test="${not empty orderHead.totalPostage}">${orderHead.totalPostage}</c:if><c:if test="${empty orderHead.totalPostage}">0.00</c:if>元 </strong>
						</td>
						<td width="160"><div align="right">
								<strong>促销折扣（元）：</strong>
							</div>
						</td>
						<td width="160"><strong>-<c:if test="${not empty orderHead.denomination}">${orderHead.denomination}</c:if><c:if test="${empty orderHead.denomination}">0.00</c:if>元</strong>
						</td>
						<td width="160"><div align="right">
								<strong>订单总额（元）：</strong>
							</div>
						</td>
						<td width="166"><strong>${orderHead.originalAmount +
								orderHead.totalPostage}元</strong>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<td><div align="right">
								<strong>应付金额（元）：</strong>
							</div>
						</td>
						<td><strong>${orderHead.paymentAmount}元</strong>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="6"><table width="992" height="42" border="1"
					bordercolor="#000000">
					<tr>
						<td bgcolor="#FFFFFF"><span class="STYLE2">非常感谢您在一城一品网购物，以下是为您推荐的商品，我们期待您的再次光临！</span>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="6"><img src="${_imagesPath}/recommend.gif"
				width="992" height="209">
				<table width="1000" border="0">
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="6"><img src="${_imagesPath}/sales_list_bottom.gif"
				width="999" height="133" alt="">
			</td>
		</tr>
		<tr>
			<td><img src="images/&#x5206;&#x9694;&#x7b26;.gif" width="1"
				height="1" alt="">
			</td>
			<td><img src="images/&#x5206;&#x9694;&#x7b26;.gif" width="209"
				height="1" alt="">
			</td>
			<td><img src="images/&#x5206;&#x9694;&#x7b26;.gif" width="128"
				height="1" alt="">
			</td>
			<td><img src="images/&#x5206;&#x9694;&#x7b26;.gif" width="73"
				height="1" alt="">
			</td>
			<td><img src="images/&#x5206;&#x9694;&#x7b26;.gif" width="194"
				height="1" alt="">
			</td>
			<td><img src="images/&#x5206;&#x9694;&#x7b26;.gif" width="189"
				height="1" alt="">
			</td>
			<td><img src="images/&#x5206;&#x9694;&#x7b26;.gif" width="206"
				height="1" alt="">
			</td>
		</tr>
	</table>
	<!-- End Save for Web Slices -->
</body>

</html>