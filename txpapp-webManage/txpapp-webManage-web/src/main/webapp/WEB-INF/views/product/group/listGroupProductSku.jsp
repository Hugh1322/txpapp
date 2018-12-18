<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>

<c:if test="${skulist !=null}">
	<c:forEach items="${skulist}" var="skuEntry">
		<div class="fl">
			<p>卖家-${skuEntry.key}</p>
		</div>
		<ul class="fl">
		    <c:forEach items="${skuEntry.value}" var="sku">
				<li data-id="${sku.product.productId }" data-rank="${sku.product.rank}" data-time="<fmt:formatDate value="${sku.product.preDeliveryTime}" pattern="yyyy-MM-dd HH:mm:ss"/>">
					<div class="J_msg">
						<img src="${_filePath }/${sku.product.coverPicture}" alt="" width="58" height="66" />
						<div class="defaSku">
							<p>名称：${sku.product.name}</p>
							<p>规格：${sku.skuSpecification}</p>
							<p>价格：${sku.unitPrice }元</p>
						</div>
					</div>
					<p class="cb">
						<input type="radio" class="subCheck" name="productId" value="${sku.productSkuId}"/>
						<input id="skuId_${sku.productSkuId}" type="hidden" value="${sku.productSkuId}"/>
						<input id="skuSpecification_${sku.productSkuId}" type="hidden" value="${sku.skuSpecification}"/>
						<input id="weight_${sku.productSkuId}" type="hidden" value="${sku.skuWeight}"/>
						<input id="quantity_${sku.productSkuId}" type="hidden" value="${sku.inventory}"/>
						<input id="skuCode_${sku.productSkuId}" type="hidden" value="${sku.skuCode}"/>
						<input id="unitPrice_${sku.productSkuId}" type="hidden" value="${sku.unitPrice}"/>
						<input id="marketPrice_${sku.productSkuId}" type="hidden" value="${sku.marketPrice}"/>
					</p>
				</li>
			</c:forEach>
		</ul>
	</c:forEach>
</c:if>

