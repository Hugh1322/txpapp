<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>
<!DOCTYPE HTML>
<html lang="en-US">
<head>
<meta charset="UTF-8">
<title>预览团购商品</title>
<!--page css-->
<link rel="stylesheet" type="text/css" href="${_cssPath}/global.css"
	media="all" />
<!--page css-->
<link rel="stylesheet" type="text/css"
	href="${_cssPath}/pages/goodsDetail.css" media="all" />
</head>
<body>
	<!--详情部分 start-->
	<div class="bColor">
		<div class="w_norm">
			<input type="hidden" id="productId" value="${product.productId }" />
			<!--面包屑 start-->
			<div class="crumbs">
				首页<span>></span>
				<c:forEach items="${item.propsMap['catalog'] }" var="prop">
				${prop.name}<span>></span>
				</c:forEach>
				${yipin:cutString(item.productName,15)}
			</div>
			<!--面包屑 end-->
			<!--商品信息 start-->
			<div class="goodsDetail cf">
				<!--左侧轮播 -->
				<div class="goods_left" id="goods_left">
					<div class="slide_box_wrap">
						<div class="slide_box">
							<div class="slides_container">
								<c:forEach items="${item.imageUrls }" var="image">
									<img
										src="<yp:thumbImage originalPath='${image}' imageType='t91'></yp:thumbImage>"
										alt="${yipin:cutString(item.productName,15)}" width="510"
										height="510" />
								</c:forEach>
							</div>
							<a href="javascript:void(0)" class="prev"></a> <a
								href="javascript:void(0)" class="next"></a>
						</div>
					</div>
					<ul class="pagination cf">
						<c:forEach items="${item.imageUrls }" var="image"
							varStatus="status">
							<li <c:if test="${status.index eq 0 }">class="current"</c:if>>
								<a href="#${status.index }"><img
									src="<yp:thumbImage originalPath='${image}' imageType='t87'></yp:thumbImage>"
									alt="${yipin:cutString(product.name,15)}" width="100px"
									height="100px" /> </a>
							</li>
						</c:forEach>
					</ul>
				</div>

				<!--右侧信息 -->
				<div class="goods_right goods_YPright">
					<h2>
						<span class="ypt_title">一品团</span>${item.productName }
					</h2>
					<c:if test="${not empty item.recommendedReason }">
						<div class="goods_yptj">
							<span class="red">推荐理由：</span>${item.recommendedReason }
						</div>
					</c:if>
					<div class="p25 goods_price">
						团购价：<span class="red"><i class="f14">￥</i><span
							class="J_price">${item.price }</span> </span>
						<del>
							原价：<span class="f12">￥</span><span class="J_oPrice">${item.sku.marketPrice
								}</span>
						</del>
						节省：<span class="f12">￥</span><span class="J_js">${item.sku.marketPrice
							- item.price }</span>
					</div>
					<div class="p25 goods_msg">
						<p class="goods_wi">
							重量：<span class="J_wi">${item.sku.skuWeight }</span>g
						</p>
						<p class="goods_dress">
							产地：
							<c:forEach items="${item.propsMap['area'] }" var="prop"
								varStatus="status">
								<c:if test="${status.index == 0 }">
									<a
										href="${_ctxPath }/lp-1-${prop.propId}-0-0-100-100000-0-0.htm"
										title="${prop.name}" target="_blank">${prop.name }</a>
								</c:if>
								<c:if test="${status.index != 0 }">
									<span>|</span>${prop.name}</c:if>
							</c:forEach>
						</p>
						<div class="cf goods_sku">
							<span>规格：</span>
							<ul class="cf J_sku">
								<input type="hidden" id="groupItemId" value="${item.id}" />

								<input type="hidden" id="notLogined"
									value="${empty session.SPRING_SECURITY_CONTEXT.authentication.principal}" />
								<li class="goods_skuli cur"
									data-productSkuId="${item.sku.productSkuId }"
									data-weight="${item.sku.skuWeight }"
									data-price="${item.price }"
									data-oPrice="${item.sku.marketPrice }"
									data-num="${item.quantity }" class="goods_skuli"><span>${item.sku.skuSpecification
										}</span> <img src="${_imagesPath }/btn/gou.png"
									alt="${yipin:cutString(item.productName,15)}" class="gou" />
								</li>
							</ul>
						</div>
						<p class="goods_fy">
							运费：为保证商品质量，我们坚持原产地发货,运费将<b>按发货地分别收取</b>，具体运费以结算页面为准！
						</p>
						<p class="goods_zc">
							支持：<c:if test="${item.sku.payType==1}">
									在线支付
								</c:if>
								<c:if test="${item.sku.payType==2}">
									在线支付    |  货到付款
								</c:if>
						</p>

				</div>
			</div>

			<!--商品信息 end-->
		</div>
		<div class="product_details" id="product_details">
			<div class="hd" id="suspendHd">
				<a href="#product_details" class="cur">产品详情</a> <a href="#service">服务保障</a>
			</div>
			<div class="bd">
				<div class="product" id="product">
					<h3>产品详情</h3>
					<div class="product_list">${item.desc }</div>
				</div>
				<div id="service" class="gap"></div>
				<div class="lsmain">

					<h3>服务保障</h3>
					<dl>
						<dt>品质保证：</dt>
						<dd>一城一品所售的商品均为正规品牌，供应商类型包括品牌生产商、品牌授权总代理商、品牌授权总经销商、品牌分公司、品牌分支机构及国际品牌驻中国的办事处。并且一城一品设有专业的品控管理，对所有商品进行品质监控。</dd>
					</dl>
					<dl>
						<dt>产地精选：</dt>
						<dd>圆通物流全国6000多配送网点，12万一线员工精选当地最优、最地道、最好口碑的特产。</dd>
					</dl>
					<dl class="lsli">
						<dt>关于退换货：</dt>
						<dd>
							如您对货品有任何的不满需要退换货，具体信息请查看 <a
								href="http://www.yichengpin.com/help/help-100008${_seoPath}"
								target="_blank" class="lslia">http://www.yichengpin.com/help/help-100008${_seoPath}</a>
						</dd>
					</dl>
					<dl>
						<dt>关于快递：</dt>
						<dd>一城一品将通过专业的物流公司为会员提供快速便捷的包裹配送，配送范围覆盖全国大部分地区（港澳台地区除外）。</dd>
					</dl>
					<dl>
						<dt>关于发货：</dt>
						<dd>每日17点前的订单可当日发货，17点后的订单次日发货。</dd>
					</dl>
					<dl>
						<dt>关于包装：</dt>
						<dd>由于所有商品均为产地直送，存在包装更新等因素，请一切以实物为准。</dd>
					</dl>
					<dl>
						<dt>关于色差：</dt>
						<dd>因拍摄灯光及不同显示器色差等问题可能造成商品图片与实物有色差，一切以实物为准。</dd>
					</dl>

				</div>
			</div>
		</div>
		<!--产品详情和服务保障 end-->
	</div>
	<!--底部 start-->

	<script src="${_jsPath }/jquery/jquery.1.8.1.js" language="javascript"></script>
	<jsp:include page="/WEB-INF/views/include/foot.jsp"></jsp:include>
	<script type="text/javascript"
		src="${_jsPath}/plugin/slides.min.jquery.js"></script>
	<script type="text/javascript" src="${_jsPath}/plugin/lazyload.js"></script>
	<script type="text/javascript" src="${_jsPath}/pages/goodsDetail.js"></script>
</body>
</html>