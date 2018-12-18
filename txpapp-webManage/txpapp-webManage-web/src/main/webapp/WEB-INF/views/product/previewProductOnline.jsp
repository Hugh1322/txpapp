<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>
<!DOCTYPE HTML>
<html lang="en-US">
<head>
	<meta charset="UTF-8">
	<title>预览商品</title>
	<link rel="stylesheet" type="text/css" href="${_cssPath}/global.css" media="all" />
	<!--page css-->
	<link rel="stylesheet" type="text/css" href="${_cssPath}/pages/goodsDetail.css" media="all" />
</head>
<body>
	<!--头部 start-->
	<!--头部 end-->
	<!--详情部分 start-->
	<div class="bColor">
	<div class="w_norm">
		<input type="hidden" id="productId" value="${productOnline.productId }"/>
		<!--面包屑 start-->
		<div class="crumbs">
			首页<span>></span>
			<c:forEach items="${productOnline.propsMap['catalog'] }" var="prop">
			<a href="#" title="${prop.name }">${prop.name }</a><span>></span>
			</c:forEach>
			${yipin:cutString(productOnline.name,15)}
		</div>
		<!--面包屑 end-->
		<!--商品信息 start-->
		<div class="goodsDetail cf">
			<!--左侧轮播 -->
			<div class="goods_left" id="goods_left">
				<div class="slide_box_wrap">
					<div class="slide_box">
						<div class="slides_container">
							<c:forEach items="${productOnline.imageList }" var="image">
							<img src="<yp:thumbImage originalPath='${image}' imageType='t91'></yp:thumbImage>" alt="" width="510" height="510"/>
							</c:forEach>
						</div>
						<a href="javascript:void(0)" class="prev"></a>
						<a href="javascript:void(0)" class="next"></a>
					</div>
				</div>
				<ul class="pagination cf">  
					<c:forEach items="${productOnline.imageList }" var="image" varStatus="status">
					<li <c:if test="${status.index eq 0 }">class="current"</c:if>>
					<a href="#${status.index }"><img src="<yp:thumbImage originalPath='${image}' imageType='t87'></yp:thumbImage>" alt="" width="100px" height="100px"/></a>
					</li>
					</c:forEach>
				</ul>
			</div>
			<!--右侧信息 -->
			<div class="goods_right">
				<form id="goodsForm">
					<h3>${productOnline.name }</h3>
					<div class="p25 goods_price">
						一品价：<span class="red">
						<i class="f14">￥</i><span class="J_price">${productOnline.productSku.unitPrice }</span></span> 
						<br>
						<del>原价：<span class="f12">￥</span><span class="J_oPrice">${productOnline.productSku.marketPrice }</span></del>
						节省：<span class="f12">￥</span><span class="J_js">${productOnline.productSku.marketPrice - productOnline.productSku.unitPrice }</span>
					</div>
					<div class="p25 goods_msg">
						<p class="goods_wi">重量：<span class="J_wi">${productOnline.productSku.skuWeight }</span>g</p>
						<p class="goods_dress">产地：
						<c:forEach items="${productOnline.propsMap['area'] }" var="prop" varStatus="status">
						<c:if test="${status.index != 0 }"><span>|</span></c:if>${prop.name }
						</c:forEach>
						</p>
						<div class="cf goods_sku">
							<span>规格：</span>
							<ul class="cf J_sku">
								<c:forEach items="${productOnline.productSkus }" var="productSku">
								<li  
								<c:choose>
									<c:when test="${productSku.inventory eq 0 }">class="disable"</c:when>
									<c:when test="${productSku.productSkuId eq productOnline.productSku.productSkuId }">class="cur"</c:when>
								</c:choose>
									data-productSkuId="${productSku.productSkuId }" data-weight="${productSku.skuWeight }" data-price="${productSku.unitPrice }" data-oPrice="${productSku.marketPrice }" data-num="${productSku.inventory }">
								<span>${productSku.skuSpecification }</span> 
								<img src="${_imagesPath }/btn/gou.png" alt="" class="gou"/>
								</li>
								</c:forEach>
							</ul>
						</div>
						<%-- 
						<p class="goods_fy">运费：<span class="J_yf">${product.productSku.postage }</span>元</p>
						<p class="goods_yh">优惠：<span class="J_yh">${product.productSku.postage }</span>元<span class="cf90">（运费优惠）</span></p>
						--%>
						<p class="goods_fy">运费：为保证商品质量，我们坚持原产地发货,运费将<b>按发货地分别收取</b>，具体运费以结算页面为准！</p>
						<c:if test="${productOnline.sellType eq sellTypeYS }">
						<p class="goods_time">预计发货时间：<span class="red"><fmt:formatDate value="${productOnline.preDeliveryTime }" pattern="yyyy-MM-dd"/></span></p>
						</c:if>
						<c:if test="${not empty productOnline.recommendedReason }">
						<div class="goods_tj">
							<span class="red">推荐理由：</span>${productOnline.recommendedReason }
						</div>
						
							<div class="goods_zc"> 支持：
								<c:if test="${productOnline.productSku.payType==1}">
									在线支付
								</c:if>
								<c:if test="${productOnline.productSku.payType==2}">
									在线支付    |  货到付款
								</c:if>
							</div>
						
						</c:if>
					</div>
				</form>
			</div>
		</div>
		<!--商品信息 end-->
	</div>
		<!--产品详情和服务保障 start-->
		<div class="product_details" id="product_details">
			<div class="hd" id="suspendHd">
				<a href="#product_details" class="cur">产品详情</a>
				<a href="#service">服务保障</a>
			</div>
			<div class="bd">
				<div class="product" id="product">
					<h3>产品详情</h3>
					<div class="product_list">
						${productOnline.description }
					</div>
				</div>
				<div id="service" class="H70"></div>
				<div class="service" id="service">
					<h3>服务保障</h3>
					<p>一城一品所售的商品均为正规品牌，供应商类型包括品牌生产商、品牌授权总代理商、品牌授权总经销商、品牌分公司、品牌分支机构及国际品牌驻中国的办事处。如您对货品有任何不满需要退换货，具体信息请查看 <a href="${_product_exchanged_url }" target="_blank">${_product_exchanged_url }</a></p>
					<dl>
						<dt>·关于快递About the Courier</dt>
						<dd>我们默认使用圆通快递，如发其它快递、EMS，请联系我们在线客服！</dd>
					</dl>
					<dl>
						<dt>·关于发货About Delivery</dt>
						<dd>每日下午5:00以前的顾客，均可以当天发货，5:00以后的顾客，次日发货。</dd>
					</dl>
					<dl>
						<dt>·色差说明Component Description</dt>
						<dd>因拍摄灯光及不同显示器色差等问题可能造成商品图片与实物有色差,一切以实物为准。</dd>
					</dl>
				</div>
			</div>
		</div>
		<!--产品详情和服务保障 end-->
	</div>
	<!--底部 start-->
	<!--悬浮条 start-->
	<div class="suspend">
		<div class="suspendWidth">
			<ul class="fl J_tab">
				<li><a href="#product_details" class="cur">产品详情</a></li>
				<li><a href="#service">服务保障</a></li>
			</ul>
			<div class="cf fl pr_msg">
				<img src="<yp:thumbImage originalPath='${productOnline.defaultImage}' imageType='t87'></yp:thumbImage>" alt="" class="fl"/>
				<div class="fl">
					<p><b>${yipin:cutString(productOnline.name,15)}</b></p>
					<p>一品价：<span class="red">￥</span><b class="red J_price">${productOnline.productSku.unitPrice }</b>规格：<span class="J_gz">${productOnline.productSku.skuSpecification }</span> 重量：<span class="J_wi">${productOnline.productSku.skuWeight }</span>g</p>
				</div>
			</div>
			<c:if test="${productOnline.sellType eq sellTypeYS }">
			<div class="fl pr_time">
				预计发货时间：<span class="red"><fmt:formatDate value="${productOnline.preDeliveryTime }" pattern="yyyy-MM-dd"/></span>
			</div>
			</c:if>
		</div>
	</div>
	<!--悬浮条 end-->
	<script src="${_jsPath }/jquery/jquery.1.8.1.js" language="javascript"></script>
	<jsp:include page="/WEB-INF/views/include/foot.jsp"></jsp:include>
	<!--js-->
	<!--page js-->
	<script type="text/javascript" src="${_jsPath}/plugin/slides.min.jquery.js"></script>
	<script type="text/javascript" src="${_jsPath}/plugin/lazyload.js"></script>
	<script type="text/javascript" src="${_jsPath}/pages/goodsDetail.js"></script>
</body>
</html>