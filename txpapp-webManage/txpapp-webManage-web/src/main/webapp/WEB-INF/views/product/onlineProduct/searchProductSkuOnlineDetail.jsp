<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>

<tr class="show-tr">
	<td colspan="7" width="100%" class="show-tab">
		<div class="order-info" style="display: block;">
			<div class="layout">
				<div><h4>商品详情</h4></div>			
				<table>
					<thead>
						<tr>
							<td width="70px;">SKU编码</td>
							<td width="70px;">规格</td>
							<td width="70px;">现价</td>
							<td width="70px;">售卖价</td>
							<td width="70px;">原价</td>
							<td width="70px;">结算价</td>
							
							<td width="70px;">库存</td>
							<td width="70px;">销售状态</td>
							<td width="70px;">参加活动</td>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${productSkuList }" var="productSku">
							<tr>
								<td>${productSku.productSkuId }</td>
								<td>${productSku.skuSpecification }</td>
								<td>
									<c:if test="${not empty productSku.activityPrice}">
										${productSku.activityPrice }
									</c:if>
									<c:if test="${empty productSku.activityPrice}">
										${productSku.settlementPrice }
									</c:if>
										
								</td>
								<td>${productSku.unitPrice }</td>
								<td>${productSku.marketPrice }</td>
								<td>${productSku.settlementPrice }</td>
								<td>${productSku.inventory }</td>
								
								<td><spring:message code="product.sellType.${productSku.selleType}"/></td>
								
								<td>${productSku.activityCode }</td>
								
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</td>
</tr>


