<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.txp.app.contants.AdvPosition"%>
<%@include file="../include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>广告位</title>
    <link href="${_cssPath }/common.css" rel="stylesheet" />
    <link href="${_cssPath }/pages/arrangement.css" rel="stylesheet" />
    <link href="${_cssPath }/pages/bannerManage.css" rel="stylesheet" />
    <link href="${_jsPath }/plugin/artdialog/skins/ytoxl.css" rel="stylesheet" />
    <script src="${_jsPath }/jquery/jquery.1.8.1.js"  language="javascript"></script>
    <script src="${_jsPath }/plugin/artdialog/jquery.artDialog.min.js"></script>
    <script type="text/javascript" src="${_jsPath}/plugin/uploadify/swfobject.js"></script>
	<script type="text/javascript" src="${_jsPath}/plugin/uploadify/jquery.uploadify.v2.1.4.min.js"></script>
	<script src="${_jsPath}/plugin/formvalidator/formValidator-4.1.3.js" language="javascript"></script>
	<script src="${_jsPath}/plugin/formvalidator/formValidatorRegex.js" language="javascript"></script>
	<!--[if IE]>
		<script src="${_jsPath}/pages/ieplaceholder.js"></script>
	<![endif]-->
</head>
<%
	pageContext.setAttribute("ADRESS_PRODUCT",com.txp.app.contants.AdvPosition.ADRESS_PRODUCT);
	pageContext.setAttribute("PRODUCT_CATEGORY",com.txp.app.contants.AdvPosition.PRODUCT_CATEGORY);
	pageContext.setAttribute("SHUFFLING_FIGURE",com.txp.app.contants.AdvPosition.SHUFFLING_FIGURE);
	pageContext.setAttribute("CITY_SELECT",com.txp.app.contants.AdvPosition.CITY_SELECT);
	pageContext.setAttribute("HOT_PRODUCT",com.txp.app.contants.AdvPosition.HOT_PRODUCT);
	pageContext.setAttribute("EVERYDAY_RECOMMEND",com.txp.app.contants.AdvPosition.EVERYDAY_RECOMMEND);
	pageContext.setAttribute("HOME_RIGHT_ADV_185",com.txp.app.contants.AdvPosition.HOME_RIGHT_ADV_185);
	pageContext.setAttribute("HOME_RIGHT_ADV_180",com.txp.app.contants.AdvPosition.HOME_RIGHT_ADV_180);
	pageContext.setAttribute("INDEX_BANNER",com.txp.app.contants.AdvPosition.INDEX_BANNER);
	pageContext.setAttribute("HOT_WORD",com.txp.app.contants.AdvPosition.HOT_WORD);
	pageContext.setAttribute("GROUP_PRODUCT",com.txp.app.contants.AdvPosition.GROUP_PRODUCT);
	pageContext.setAttribute("KIND_ADVERTISEMENT","KIND_ADVERTISEMENT");
	pageContext.setAttribute("HOME_CENTER_ADV",com.txp.app.contants.AdvPosition.HOME_CENTER_ADV);
	/* pageContext.setAttribute("ADV_TYPE_CROSS",com.ytoxl.module.yipin.content.dataobject.Advertisement.ADV_TYPE_CROSS);
	pageContext.setAttribute("ADV_TYPE_SMALL",com.ytoxl.module.yipin.content.dataobject.Advertisement.ADV_TYPE_SMALL); */
%>
<body>
	<!--start header-->
	<jsp:include page="../include/header.jsp"></jsp:include> 
	<div class="body m-w980p">
	<%--  <jsp:include page="../include/pageManageMenu.jsp"  flush="true" />  --%>
		 <c:if test="${index eq SHUFFLING_FIGURE}"><%--轮播图 --%>
				<form action="${_ctxPath}/admin/adv/adv_saveAdv.htm" method="post" id="advForm">
	  				<input name="adv.advertisementId" value="" type="hidden"/>
	            	<input name="adv.target" value="" type="hidden"/>
	            	<input name="adv.advertisementPositionId" value="" type="hidden"/>
	        <div class="m-mt10p addBanner">
				<!-- 轮播图 -->
				<div class="addADV cf">
					<label for=""><i class="red">*</i>位置：</label>
					<div class="infoADV">
						<div style="display:none;">
				          	<select id="advPositionWH" class="m-sel" readOnly="readOnly" >
								<option data-wh="${position.width}:${position.height}" value="${position.positionId}"selected="selected">
									<c:out value="${position.positionName}"></c:out>
								</option>
							</select>
						</div>
						<input  name="adv.positionId" value="${position.positionId}" type="hidden"/>
						<c:out value="${position.positionName}"></c:out>
					</div>
				</div>
				<div class="addADV cf">
					<label for=""><i class="red">*</i>广告位名称：</label>
					<div class="infoADV">
						<input type=text name="adv.advertisementName" id="advName" class="txt-input" />
						<div id="advNameTip"></div>
					</div>
				</div>
				<div class="addADV cf">
					<label for=""><i class="red">*</i>背景颜色：</label>
					<div class="infoADV">
						<input type=text name="adv.backColor" id="backColor" class="txt-input" />
						<div id="backColorTip"></div>
					</div>
				</div>
				<div class="addADV cf">
					<label for=""><i class="red">*</i>顺序：</label>
					<div class="infoADV">
						<input type="text" name="adv.rank" id="advRank" class="txt-input" /><span>请选择1-10之间的数字</span>
						<div id="advRankTip"></div>
					</div>
				</div>
				<div class="addADV cf">
					<label for=""><i class="red">*</i>广告图片：</label>
					<div class="infoADV">
	            		<input type="file" id="imgUpload" class="txt-input" name="file" />
	            		<div id="advUploadImageTip" ">
		            					<em class="c-red">*</em> 
			            				<span id="advPosition-${position.positionId}">请上传像素为${position.width}px*${position.height}px的图片</span>
		            	</div>
		            	<input type="hidden" id="uploadImageValueId" id="img" name="adv.imageUrl"/>
						<img src="" id="showImg" />
						<div id="imgTip"></div>
					</div>
				</div>
				<div class="addADV cf">
					<label for=""><i class="red">*</i>跳转地址：</label>
					<div class="infoADV">
						<input type="text" name="adv.url" id="advUrl" class="txt-input" />
						<div id="advUrlTip"></div>
					</div>
				</div>
				<div class="addADV cf">
					<label>&nbsp;</label>
					<div class="infoADV">
						<input type="button" id="submitForm"  onclick="addAdv('1')" value="保存" class="m-btn"/>
						<input type="button" id="cancelForm" value="取消" onclick="window.history.go(-1)" class="m-btn"/>
					</div>
				</div>
			</div>
			</form>
		 </c:if>
		 <c:if test="${index eq KIND_ADVERTISEMENT}"><%--分类广告位 --%>
				<form action="${_ctxPath}/admin/adv/adv_saveAdv.htm" method="post" id="advForm">
	  				<input name="adv.advertisementId" value="" type="hidden"/>
	            	<input name="adv.target" value="" type="hidden"/>
	            	<input name="adv.advertisementPositionId" value="" type="hidden" id="kind_advertisementPositionId"/>
	        <div class="m-mt10p addBanner">
				<!-- 分类广告位 -->
				<div class="addADV cf">
					<label for=""><i class="red">*</i>位置：</label>
					<div class="infoADV">
						<div style="display:none;">
				          	<select id="advPositionWH" class="m-sel" readOnly="readOnly" >
								<option data-wh="${position.width}:${position.height}" value="${position.positionId}"selected="selected">
									<c:out value="${position.positionName}"></c:out>
								</option>
							</select>
						</div>
						<input  name="adv.positionId" value="${position.positionId}" type="hidden"/>
						<c:out value="${position.positionName}"></c:out>
					</div>
				</div>
				<div class="addADV cf">
					<label for=""><i class="red">*</i>分类：</label>
					<div class="infoADV">
						<select  id="menus" class="m-sel one">
								<option value="-1">请选择</option>
								<c:forEach var="r" items="${regionP}" varStatus="status">
									<option value="${r.propId }" 
									<c:if test="${adv.p.parentId == r.propId }">
									selected="selected"
									</c:if>
									>${r.name }</option>
								</c:forEach>
								<option value="10000">区域广告</option>
						</select>	
						<div id="menusTip"></div>
					</div>
				</div>
				<div class="addADV cf">
					<label for=""><i class="red">*</i>广告位名称：</label>
					<div class="infoADV">
						<input type=text name="adv.advertisementName" id="advName" class="txt-input" />
						<div id="advNameTip"></div>
					</div>
				</div>
				<div class="addADV cf">
					<label for=""><i class="red">*</i>顺序：</label>
					<div class="infoADV">
						<input type="text" name="adv.rank" id="advRank" class="txt-input" /><span>请选择1-10之间的数字</span>
						<div id="advRankTip"></div>
					</div>
				</div>
				<div class="addADV cf">
					<label for=""><i class="red">*</i>广告图片：</label>
					<div class="infoADV">
	            		<input type="file" id="imgUpload" class="txt-input" name="file" />
	            		<div id="advUploadImageTip" ">
		            					<em class="c-red">*</em> 
			            				<span id="advPosition-${position.positionId}">请上传像素为${position.width}px*${position.height}px的图片</span>
		            	</div>
		            	<input type="hidden" id="uploadImageValueId" id="img" name="adv.imageUrl"/>
						<img src="" id="showImg" />
						<div id="imgTip"></div>
					</div>
				</div>
				<div class="addADV cf">
					<label for=""><i class="red">*</i>跳转地址：</label>
					<div class="infoADV">
						<input type="text" name="adv.url" id="advUrl" class="txt-input" />
						<div id="advUrlTip"></div>
					</div>
				</div>
				<div class="addADV cf">
					<label>&nbsp;</label>
					<div class="infoADV">
						<input type="button" id="submitForm"  onclick="addAdv('2')" value="保存" class="m-btn"/>
						<input type="button" id="cancelForm" value="取消" onclick="window.history.go(-1)" class="m-btn"/>
					</div>
				</div>
			</div>
			</form>
		 </c:if>
		 <c:if test="${index eq ADRESS_PRODUCT}">
		 <%--所在地 start--%>
		 <form action="${_ctxPath}/admin/adv/adv_saveAdv.htm" method="post" id="advForm">
				<!--start 商家管理table-->
	       		<div class="m-mt10p addBanner">
					<div class="addADV cf">
						<label for=""><i class="red">*</i>位置：</label>
						<div class="infoADV">
							<input  name="adv.positionId" value="${position.positionId}" type="hidden"/>
							<c:out value="${position.positionName}"></c:out>
						</div>
					</div>
					<div class="addADV cf">
						<label for=""><i class="red">*</i>区域：</label>
						<div class="infoADV" style="float: left;">
							<select  id="zone" class="m-sel one">
								<option value="-1">请选择</option>
								<c:forEach var="r" items="${regionP}" varStatus="status">
									<option value="${r.propId }" 
									<c:if test="${adv.p.parentId == r.propId }">
										selected="selected"
									</c:if>
									>${r.name }</option>
								</c:forEach>
							</select>
							<div id="zoneTip"></div>
						</div>
					</div>
					<div class="addADV cf">
						<label for=""><i class="red">*</i>所在地：</label>
						<div class="infoADV">
							<select name="adv.advertisementPositionId" id="address" class="m-sel two"><option value="-1">请选择</option></select>
							<div id="addressTip"></div>
						</div>
					</div>
					<div class="addADV cf">
						<label for=""><i class="red">*</i>广告名称：</label>
						<div class="infoADV">
							<input type="text"  name="adv.advertisementName" id="advName" class="txt-input"/>
							<div id="advNameTip"></div>
						</div>
					</div>
					<div class="addADV cf">
						<label for=""><i class="red">*</i>顺序：</label>
						<div class="infoADV">
							<input type="text"  name="adv.rank" id="advRank" class="txt-input"/><span>请选择1-10之间的数字</span>
							<div id="advRankTip"></div>
						</div>
					</div>
					<div class="addADV cf">
						<label for=""><i class="red">*</i>跳转地址：</label>
						<div class="infoADV">
							<input type="text" name="adv.url"  id="advUrl" class="txt-input"/>
							<div id="advUrlTip"></div>
						</div>
					</div>
					<div class="addADV cf">
						<label>&nbsp;</label>
						<div class="infoADV">
							<input type="button" id="submitForm"  onclick="addAdv('2')" value="保存" class="m-btn"/>
							<input type="button" id="cancelForm" value="取消" onclick="window.history.go(-1)" class="m-btn"/>
						</div>
					</div>
				</div>
				</form>
				</c:if>
				<!-- 瀑布流广告 -->
			<c:if test="${index eq HOME_CENTER_ADV}">
				<form action="${_ctxPath}/admin/adv/adv_saveAdv.htm" method="post" id="advForm">
				<!--start 商家管理table-->
	       		<div class="m-mt10p addBanner">
					<div  class="addADV cf">
					<label for=""><i class="red">*</i>位置：</label>
					<div class="infoADV">
					<input name="adv.positionId" value="${position.positionId}" type="hidden"/>
					<c:out value="${position.positionName}"></c:out>
					</div>		
				</div>
				<div class="addADV cf">
					<label for=""><i class="red">*</i>广告名称：</label>
					<div class="infoADV">
						<input type="text" name="adv.advertisementName" id="advName" class="txt-input" value="${adv.advertisementName }"/>
						<div id="advNameTip"></div>
					</div>
				</div>
				<div class="addADV cf">
					<label for=""><i class="red">*</i>广告图片：</label>
					<div class="infoADV">
			       		<input type="file" id="common_imgUpload" class="txt-input" name="file" />
			       		<div id="advUploadImageTip">
							<em class="c-red">*</em> 
							<span>请上传像素为<span>${position.width }px*${position.height }px</span>的图片</span>
			       		</div>
			          	<input type="hidden" id="uploadImageValueId" id="img" name="adv.imageUrl" value="${adv.imageUrl }"/>
					<img src="${_filePath }${adv.imageUrl}" id="showImg" width="${position.width }px" height="${position.height }px"/>
					<div id="imgTip"></div>
					</div>
				</div>
				<div class="addADV cf">
					<label for=""><i class="red">*</i>顺序：</label>
					<div class="infoADV">
					<input type="text" name="adv.rank" id="advRank" class="txt-input" value="${adv.rank }"/><span>请选择1-10之间的数字</span>
					<div id="advRankTip"></div>
					</div>
				</div>
				<div class="addADV cf">
					<label for=""><i class="red">*</i>显示位置：</label>
					<div class="infoADV">
					<input type="text" name="adv.advPlace" id="advPosition" class="txt-input" value="${adv.advPlace }"/><span>请选择1-10之间的数字</span>
					<div id="advAdvPlaceTip"></div>
					</div>
				</div>
				<div class="addADV cf">
					<label for=""><i class="red">*</i>跳转地址：</label>
					<div class="infoADV">
						<input type="text" name="adv.url" id="advUrl" class="txt-input" value="${adv.url }"/>
						<div id="advUrlTip"></div>
					</div>
				</div>
					<div class="addADV cf">
						<label>&nbsp;</label>
						<div class="infoADV">
							<input type="button" id="submitForm"  onclick="addAdv('2')" value="保存" class="m-btn"/>
							<input type="button" id="cancelForm" value="取消" onclick="window.history.go(-1)" class="m-btn"/>
						</div>
					</div>
				</div>
				</form>
		 </c:if>
		 <%--所在地 end--%>
		 <%--商品分类start --%>
		 <c:if test="${index eq PRODUCT_CATEGORY}">
		  <form action="${_ctxPath}/admin/adv/adv_saveAdv.htm" method="post" id="advForm">
			 <!--start 商家管理table-->
        	<div class="m-mt10p addBanner">
				<div  class="addADV cf">
					<label for=""><i class="red">*</i>位置：</label>
					<div class="infoADV">
					<input  name="adv.positionId" value="${position.positionId}" type="hidden"/>
					<c:out value="${position.positionName}"></c:out>
					</div>		
				</div>
				<div class="addADV cf">
					<label for=""><i class="red">*</i>分类：</label>
					<div class="infoADV">
						<select  id="menus" class="m-sel one">
								<option value="-1">请选择</option>
								<c:forEach var="r" items="${regionP}" varStatus="status">
									<option value="${r.propId }" 
									<c:if test="${adv.p.parentId == r.propId }">
										selected="selected"
									</c:if>
									>${r.name }</option>
								</c:forEach>
						</select>	
						<div id="menusTip"></div>
					</div>
				</div>
				<div class="addADV cf">
					<label for=""><i class="red">*</i>二级分类：</label>
					<div class="infoADV">
						<select name="adv.advertisementPositionId" id="category" class="m-sel two"><option value="-1">请选择</option></select>
						<div id="categoryTip"></div>
					</div>
				</div>
				<div class="addADV cf">
					<label for=""><i class="red">*</i>广告名称：</label>
					<div class="infoADV">
					<input type="text" name="adv.advertisementName" id="advName" class="txt-input"/>
					<div id="advNameTip"></div>
					</div>
				</div>
				<div class="addADV cf">
					<label for=""><i class="red">*</i>顺序：</label>
					<div class="infoADV">
					<input type="text" name="adv.rank" id="advRank" class="txt-input"/><span>请选择1-10之间的数字</span>
					<div id="advRankTip"></div>
					</div>
				</div>
				<div class="addADV cf">
					<label for=""><i class="red">*</i>跳转地址：</label>
					<div class="infoADV">
					<input type="text" name="adv.url" id="advUrl" class="txt-input"/>
					<div id="advUrlTip"></div>
					</div>
				</div>
				<div class="addADV cf">
						<label>&nbsp;</label>
						<div class="infoADV">
							<input type="button" id="submitForm"  onclick="addAdv('2')" value="保存" class="m-btn"/>
							<input type="button" id="cancelForm" value="取消" onclick="window.history.go(-1)" class="m-btn"/>
						</div>
					</div>		
        	</div>
		</form>
       <!--end 商家管理table-->
		 </c:if>
		 <%--商品分类 end--%>
	 	 <%--城市精选S --%>
	 	 <c:if test="${index eq CITY_SELECT}">
		 <form action="${_ctxPath}/admin/adv/adv_saveAdv.htm" method="post" id="advForm">
				<!--start 商家管理table-->
	       		<div class="m-mt10p addBanner">
					<div class="addADV cf">
					<label for=""><i class="red">*</i>位置：</label>
					<div class="infoADV">
						<div style="display:none;">
				          	<select id="advPositionWH" class="m-sel" readOnly="readOnly" >
								<option data-wh="${position.width}:${position.height}" value="${position.positionId}"selected="selected">
									<c:out value="${position.positionName}"></c:out>
								</option>
							</select>
						</div>
						<input  name="adv.positionId" value="${position.positionId}" type="hidden"/>
						<c:out value="${position.positionName}"></c:out>
					</div>
				</div>
					<!-- <div class="addADV cf">
						<label for=""><i class="red">*</i>广告名称：</label>
						<div class="infoADV">
							<input type="text"  name="adv.advertisementName" id="advName" class="txt-input"/>
							<div id="advNameTip"></div>
						</div>
					</div> -->
					<div class="addADV cf">
						<label for=""><i class="red">*</i>城市名称：</label>
						<div class="infoADV">
							<input type="text"  name="adv.cityName" id="cityName" class="txt-input"/><span>最大支持5个中文字长度</span>
							<div id="cityNameTip"></div>
						</div>
					</div>
					<div class="addADV cf">
						<label for=""><i class="red">*</i>城市介绍：</label>
						<div class="infoADV">
							<textarea name="adv.cityContent" id="cityContent" style="width: 350px; height: 70px;"></textarea><span>最大支持50个中文字长度</span>
							<div id="cityContentTip"></div>
						</div>
					</div>
					<div class="addADV cf">
					<label for=""><i class="red">*</i>城市图片：</label>
						<div class="infoADV">
		            		<input type="file" id="imgUpload" class="txt-input" name="file" />
		            		<div id="advUploadImageTip">
			            					<em class="c-red">*</em> 
				            				<span id="advPosition-${position.positionId}">请上传像素为${position.width}px*${position.height}px的图片</span>
			            	</div>
			            	<input type="hidden" id="uploadImageValueId" id="img" name="adv.imageUrl"/>
							<img src="" id="showImg" />
							<div id="imgTip"></div>
						</div>
					</div>
					
					<div class="addADV cf">
						<label for=""><i class="red">*</i>跳转地址：</label>
						<div class="infoADV">
							<input type="text" name="adv.url"  id="advUrl" class="txt-input"/>
							<div id="advUrlTip"></div>
						</div>
					</div>
					<div class="addADV cf">
						<label for=""><i class="red">*</i>商品名称：</label>
						<div class="infoADV">
							<input type="text"  name="adv.productName" id="productName" class="txt-input"/><span>最大支持8个中文字长度</span>
							<div id="productNameTip"></div>
						</div>
					</div>
					<div class="addADV cf">
					<label for=""><i class="red">*</i>商品图片：</label>
						<div class="infoADV">
		            		<input type="file" id="imgUpload1" class="txt-input" name="file1" />
		            		<div id="advUploadImageTip1">
			            					<em class="c-red">*</em> 
				            				<span id="advPosition-${position.positionId}">请上传像素为25px*25px的图片</span>
			            	</div>
			            	<input type="hidden" id="uploadImageValueId1" id="productImageUrl" name="adv.productImageUrl"/>
							<img src="" id="showImg1" />
							<div id="productImageUrlTip"></div>
						</div>
					</div>
					<div class="addADV cf">
						<label for=""><i class="red">*</i>跳转地址：</label>
						<div class="infoADV">
							<input type="text" name="adv.productUrl"  id="productUrl" class="txt-input"/>
							<div id="productUrlTip"></div>
						</div>
					</div>
					<div class="addADV cf">
						<label for=""><i class="red">*</i>顺序：</label>
						<div class="infoADV">
							<input type="text"  name="adv.rank" id="advRank" class="txt-input"/><span>请选择1-10之间的数字</span>
							<div id="advRankTip"></div>
						</div>
					</div>
					<div class="addADV cf">
						<label>&nbsp;</label>
						<div class="infoADV">
							<input type="button" id="submitForm"  onclick="addAdv('2')" value="保存" class="m-btn"/>
							<input type="button" id="cancelForm" value="取消" onclick="window.history.go(-1)" class="m-btn"/>
						</div>
					</div>
				</div>
				</form>
	       <!--end 商家管理table-->
		 </c:if>
		 <!-- 城市精选E -->
		 
		 <!-- 热销商品S -->
		 <c:if test="${index eq HOT_PRODUCT}">
				<form action="${_ctxPath}/admin/adv/adv_saveAdv.htm" method="post" id="advForm">
	  				<input name="adv.advertisementId" value="" type="hidden"/>
	            	<input name="adv.target" value="" type="hidden"/>
	            	<input name="adv.advertisementPositionId" value="" type="hidden"/>
	        <div class="m-mt10p addBanner">
				<div class="addADV cf">
					<label for=""><i class="red">*</i>位置：</label>
					<div class="infoADV">
						<div style="display:none;">
				          	<select id="advPositionWH" class="m-sel" readOnly="readOnly" >
								<option data-wh="${position.width}:${position.height}" value="${position.positionId}"selected="selected">
									<c:out value="${position.positionName}"></c:out>
								</option>
							</select>
						</div>
						<input  name="adv.positionId" value="${position.positionId}" type="hidden"/>
						<c:out value="${position.positionName}"></c:out>
					</div>
				</div>
				<div class="addADV cf">
						<label for=""><i class="red">*</i>类型：</label>
						<div class="infoADV">
							<select name="adv.type" id="imgType" class="m-sel two">
								<option value="-1">请选择</option>
								<c:forEach items="${types }" var="obj">
									<option value="${obj }"
									<c:if test="${adv.type==obj }">
									selected = "selected"
									</c:if>
									><spring:message code="advtisement.type.${obj}"/></option>
								</c:forEach>
							</select>
							<div id="imgTypeTip"></div>
						</div>
				</div>
				<div class="addADV cf">
					<label for=""><i class="red">*</i>广告位名称：</label>
					<div class="infoADV">
						<input type=text name="adv.advertisementName" id="advName" class="txt-input" />
						<div id="advNameTip"></div>
					</div>
				</div>
				<div class="addADV cf">
					<label for=""><i class="red">*</i>顺序：</label>
					<div class="infoADV">
						<input type="text" name="adv.rank" id="advRank" class="txt-input" /><span>请选择1-10之间的数字</span>
						<div id="advRankTip"></div>
					</div>
				</div>
				<div class="addADV cf">
					<label for=""><i class="red">*</i>广告图片：</label>
					<div class="infoADV">
	            		<input type="file" id="imgUpload" class="txt-input" name="file" />
	            		<div id="advUploadImageTip" ">
		            					<em class="c-red">*</em> 
			            				<span id="advPosition-${position.positionId}">
			            				请上传像素为<span id="imgSize">400px*360px</span>的图片
			            				</span>
		            	</div>
		            	<input type="hidden" id="uploadImageValueId" id="img" name="adv.imageUrl"/>
						<img src="" id="showImg" />
						<div id="imgTip"></div>
					</div>
				</div>
				<div class="addADV cf">
					<label for=""><i class="red">*</i>跳转地址：</label>
					<div class="infoADV">
						<input type="text" name="adv.url" id="advUrl" class="txt-input" />
						<div id="advUrlTip"></div>
					</div>
				</div>
				<div class="addADV cf">
					<label>&nbsp;</label>
					<div class="infoADV">
						<input type="button" id="submitForm"  onclick="addAdv('1')" value="保存" class="m-btn"/>
						<input type="button" id="cancelForm" value="取消" onclick="window.history.go(-1)" class="m-btn"/>
					</div>
				</div>
			</div>
			</form>
		 </c:if>
		 <!-- 热销商品E -->
		 
		 
		 
		  <c:if test="${index eq INDEX_BANNER}">
				<form action="${_ctxPath}/admin/adv/adv_saveAdv.htm" method="post" id="advForm">
	  				<input name="adv.advertisementId" value="" type="hidden"/>
	            	<input name="adv.target" value="" type="hidden"/>
	            	<input name="index" value="${index}" type="hidden"/>
	            	<input name="adv.advertisementPositionId" value="" type="hidden"/>
	        <div class="m-mt10p addBanner">
				<div class="addADV cf">
					<label for=""><i class="red">*</i>位置：</label>
					<div class="infoADV">
						<div style="display:none;">
				          	<select id="advPositionWH" class="m-sel" readOnly="readOnly" >
								<option data-wh="${position.width}:${position.height}" value="${position.positionId}"selected="selected">
									<c:out value="${position.positionName}"></c:out>
								</option>
							</select>
						</div>
						<input  name="adv.positionId" value="${position.positionId}" type="hidden"/>
						<c:out value="${position.positionName}"></c:out>
					</div>
				</div>
				<div class="addADV cf">
						<label for=""><i class="red">*</i>类型：</label>
						<div class="infoADV">
							<select name="adv.type" id="imgType" class="m-sel two">
								<option value="-1">请选择</option>
								<c:forEach items="${indexBannerTypes }" var="obj">
									<option value="${obj }" <c:if test="${adv.type==obj }"> selected = "selected" </c:if>><spring:message code="adv.index.banner.type.${obj}"/></option>
								</c:forEach>
							</select>
							<div id="imgTypeTip"></div>
						</div>
				</div>
				<div class="addADV cf">
					<label for=""><i class="red">*</i>广告位名称：</label>
					<div class="infoADV" style="width:350px;">
						<input type=text name="adv.advertisementName" maxlength="10" id="advName" class="txt-input" style="width:340px;"/>
						<div id="advNameTip"></div>
					</div>
				</div>
				<div class="addADV cf">
					<label for=""><i class="red">*</i>广告说明：</label>
					<div class="infoADV" >
						<textarea name="adv.advDescription" id="descContent"
							style="width: 450px; height: 70px;">${adv.advDescription}</textarea>
						<span>最大支持50个中文字长度</span>
						<div id="descContentTip"></div>
					</div>
				</div>
				<div class="addADV cf">
					<label for=""><i class="red">*</i>广告图片：</label>
					<div class="infoADV">
	            		<input type="file" id="imgUpload" class="txt-input" name="file" />
	            		<div id="advUploadImageTip" ">
		            					<em class="c-red">*</em> 
			            				<span id="advPosition-${position.positionId}">
			            				请上传像素为<span id="imgSize">1200px*320px</span>的图片
			            				</span>
		            	</div>
		            	<input type="hidden" id="uploadImageValueId" id="img" name="adv.imageUrl"/>
						<img src="" id="showImg" />
						<div id="imgTip"></div>
					</div>
				</div>
				<div class="addADV cf">
					<label for=""><i class="red">*</i>跳转地址：</label>
					<div class="infoADV" style="width:380px;">
						<input type="text" name="adv.url" id="advUrl" class="txt-input" style="width:370px;"/>
						<div id="advUrlTip"></div>
					</div>
				</div>
				<div class="addADV cf">
					<label>&nbsp;</label>
					<div class="infoADV">
						<input type="button" id="submitForm"  onclick="addAdv('2')" value="保存" class="m-btn"/>
						<input type="button" id="cancelForm" value="取消" onclick="window.history.go(-1)" class="m-btn"/>
					</div>
				</div>
			</div>
			</form>
		 </c:if>
		 
		 
		 
		 
		 <!-- 首页伸缩广告E -->
		 <!-- 首页每日推荐 -->
		 <c:if test="${index eq EVERYDAY_RECOMMEND}">
		 	<jsp:include page="everydayRecommend.jsp" flush="true"/>
		 </c:if>
		 <c:if test="${index eq HOME_RIGHT_ADV_185 or index eq HOME_RIGHT_ADV_180}">
		 	<jsp:include page="common.jsp" flush="true"/>
		 </c:if>
		 <%-- <c:if test="${index eq HOME_CENTER_ADV}">
		 	<jsp:include page="indexCenterAdv.jsp" flush="true"/>
		 </c:if> --%>
		 <c:if test="${index eq HOT_WORD}">
		 	<jsp:include page="hotWord.jsp" flush="true"/>
		 </c:if>
	 </div>
	<!--end foot-->
	<jsp:include page="/WEB-INF/views/include/foot.jsp"></jsp:include>
<script type="text/javascript">
$(document).ready(function(){
		if('${adv.imageUrl}'==''||'${adv.imageUrl}'==null){
			$('#showImg').hide();
		}
		if('${adv.productImageUrl}'==''||'${adv.productImageUrl}'==null){
			$('#showImg1').hide();
		}
		var uploadlogoParams = {
			'auto' : true,
			'buttonImg' : '${_jsPath}/plugin/uploadify/uploadimg_btn.png',
			'cancelImg' : '${_jsPath}/plugin/uploadify/cancel.png',
			'expressInstall' : '${_jsPath}/plugin/uploadify/expressInstall.swf',
			'fileDataName' : 'file',
			'fileDesc' : '请选择jpg、gif、png文件',
			'fileExt' : '*.jpg;*.jpeg;*.gif;*.png',
			'multi' : false,
			'script' : '${_ctxPath}/upload/upload.htm',
			'sizeLimit' : 2097152,
			'uploader' : '${_jsPath}/plugin/uploadify/uploadify.allglyphs.swf'
		};
		uploadlogoParams.scriptData = {'category' : 'adv'}; //目录名字 可以是多级  logo/2013/02/26
		uploadlogoParams.onComplete = function(event, ID, fileObj, response, data) {
			$('#uploadImageValueId').val(response);
			var url = '${_filePath}' + response;
			var whArray = $("#advPositionWH > option:selected").attr("data-wh").split(":");
			var typeValue=$("#imgType").val();
			if(typeValue!=null){
				if(typeValue==1){
					$('#showImg').attr({src: url, width: 400 + "px", height:360 + "px"});
				}else if(typeValue==4||typeValue==5){
					$('#showImg').attr({src: url, width: 400 + "px", height: 180 + "px"});
				}else if(typeValue==2||typeValue==3||typeValue==6||typeValue==7){
					$('#showImg').attr({src: url, width: 200 + "px", height: 180 + "px"});
				}else if(typeValue==8 ){
					$('#showImg').attr({src: url, width: 1200 + "px", height: 80 + "px"});
				}else if(typeValue==9 ){
					$('#showImg').attr({src: url, width: 1200 + "px", height: 320 + "px"});
				}else{
					$('#showImg').attr({src: url, width: 400 + "px", height: 360 + "px"});
				}
			}else{
				$('#showImg').attr({src: url, width: whArray[0]/2 + "px", height: whArray[1]/2 + "px"});
			}
			$('#showImg').show();
		};
		
		var uploadCityPro = {
				'auto' : true,
				'buttonImg' : '${_jsPath}/plugin/uploadify/uploadimg_btn.png',
				'cancelImg' : '${_jsPath}/plugin/uploadify/cancel.png',
				'expressInstall' : '${_jsPath}/plugin/uploadify/expressInstall.swf',
				'fileDataName' : 'file',
				'fileDesc' : '请选择jpg、gif、png文件',
				'fileExt' : '*.jpg;*.jpeg;*.gif;*.png',
				'multi' : false,
				'script' : '${_ctxPath}/upload/upload.htm',
				'sizeLimit' : 2097152,
				'uploader' : '${_jsPath}/plugin/uploadify/uploadify.allglyphs.swf'
			};
		uploadCityPro.scriptData = {'category' : 'adv'}; //目录名字 可以是多级  logo/2013/02/26
		uploadCityPro.onComplete = function(event, ID, fileObj, response, data) {
			$('#uploadImageValueId1').val(response);
			var url = '${_filePath}' + response;
			$('#showImg1').attr({src: url, width: 25+ "px", height:25 + "px"});
			$('#showImg1').show();
		};
		
		$('#imgUpload').uploadify(uploadlogoParams);
		$('#imgUpload1').uploadify(uploadCityPro);
		$(".one").change(function(){
	        var index = $(this).children('option:selected').val();  //弹出select的值
	        if('${index}' == 'KIND_ADVERTISEMENT') {
	        	$("#kind_advertisementPositionId").val(index);
	        }
	        if(index<0){
	        	//alert("aaa");
	        	$(".two").html("<option value=\"-1\">请选择</option>");
	        }else{//ajax 请求后台
	        	$.ajax({
	    			url:_ctxPath + "/admin/adv/showCategory.htm",
	    			type:"POST",
	    			data:{'adv.advertisementPositionId':index},
	    			dataType:"json",
	    			async: false,
	    			success:function(data){
	    				var html = "<option value=\"-1\">请选择</option>";
	    				if(data.info!=null&&data.info!=undefined){//不等于
	    					var array =  eval('(' + data.info + ')');   
	    					for(var i=0;i<array.length;i++){
	    						//alert(array[i].propId+""+array[i].name);
	    						html +="<option value='"+array[i].propId+"'>"+array[i].name+"</option>";;
	    					}
	    				}
	    				$(".two").html(html);
	    			}
	    		});
	        }
	    });
		$("#imgType").change(function(){
			var typeValue= $(this).val();
			if(typeValue==1){
				$("#imgSize").html("400px*360px");
			}else if(typeValue==4||typeValue==5){
				$("#imgSize").html("400px*180px");
			}else if(typeValue==2||typeValue==3||typeValue==6||typeValue==7){
				$("#imgSize").html("200px*180px");
			}else if(typeValue==8){
				$("#imgSize").html("1200px*80px");
			}else if(typeValue==9){
				$("#imgSize").html("1200px*320px");
			}else{
				$("#imgSize").html("400px*360px");
			}
		});
	});

//选择广告位置 改变图片大小提示
$(function(){
	var advPositionWH = $("#advPositionWH");
	var data,dataDetail;
	advPositionWH.on("change",function(){
		var $this = $(this).find("option:selected");
		var advPositionId = $this.val();
		$("#advUploadImageTip > span:visible").hide();
		$("#advPosition-" + advPositionId).show();
	});
	
});
function addAdv(index){
	var result = $.formValidator.pageIsValid('1');
	
	if(!result){
		return false;
	}else{
    if("${index}"=="HOT_WORD"){
			$.ajax({
    			url:_ctxPath + "/admin/adv/adv_checkHotWordNum.htm",
    			type:"GET",
    			async: false,
    			success:function(data){
    				if(data.code == "false"){
    					alert(data.info);
    				}
    			}
    		});
			
		}
	alert("保存成功，刷新首页看看效果吧！");
	}
	
	$("#advForm").submit();
}
$.formValidator.initConfig({formID:"advForm",theme:"Default",submitOnce:true,wideWord:false,onError:function(){}});
$("#menus").formValidator({onShow:"请选择分类",onFocus:"请选择分类",onCorrect:"谢谢你的配合"}).inputValidator({min:1,onError: "请选择分类"});
$("#category").formValidator({onShow:"请选择二级分类",onFocus:"请选择二级分类",onCorrect:"谢谢你的配合"}).inputValidator({min:1,onError: "请选择二级分类"});

$("#zone").formValidator({onShow:"请选择区域",onFocus:"请选择区域",onCorrect:"谢谢你的配合"}).inputValidator({min:1,onError: "请选择区域"});
$("#address").formValidator({onShow:"请选择所在地",onFocus:"请选择所在地",onCorrect:"谢谢你的配合"}).inputValidator({min:1,onError: "请选择所在地"});
$("#backColor").formValidator({onShow:"请输入背景色"}).inputValidator({min:1,max:10,onErrorMin:"请输入大于1个字符",onErrorMax:"请输入小于10个中文字",empty:{leftEmpty:false,rightEmpty:false,emptyError:"背景色两边不能有空格"},onError:"请输入背景色"});
$("#advName").formValidator({onShow:"请输入广告名称"}).inputValidator({min:1,max:10,onErrorMin:"请输入大于1个字符",onErrorMax:"请输入小于10个中文字",empty:{leftEmpty:false,rightEmpty:false,emptyError:"广告名称两边不能有空格"},onError:"请输入广告名称"});
$("#descContent").formValidator({onShow:"请输入广告说明",onFocus:"请输入广告说明",onCorrect:"谢谢你的配合"}).inputValidator({min:1,max:50,onErrorMax:"请输入小于50个中文字",onError: "请输入广告说明"});
$("#advRank").formValidator({empty:false,onShow:"请输入排序号",onCorrect:"谢谢你的合作，你的排序号正确"}).inputValidator({min:0,max:2,onErrorMax:"请填写1~10之间数字"}).regexValidator({regExp:"intege1",dataType:"enum",onError:"请填写1~10之间数字"})
	.functionValidator({
                    fun: function(val, el) {
	                    if(val>10){
	                    	return "请填写1~10之间数字";
	                    }
                    }
                });
$("#advPlace").formValidator({empty:false,onShow:"请输入显示位置数字",onCorrect:"谢谢你的合作，你的序号正确"}).inputValidator({min:0,max:3,onErrorMax:"请填写1~300之间数字"}).regexValidator({regExp:"intege1",dataType:"enum",onError:"请填写1~300之间数字"})
.functionValidator({
                fun: function(val, el) {
                    if(val>300){
                    	return "请填写1~300之间数字";
                    }
                }
            });
$("#uploadImageValueId").formValidator({tipID:"imgTip",onShow: "请输入图片名", onCorrect: "谢谢你的合作，你的图片名正确" }).inputValidator({min:1,onErrorMin:"请上传图片"}).regexValidator({ regExp: "picture", dataType: "enum", onError: "图片名格式不正确" });
$("#advUrl").formValidator({empty:false,onShow:"请输入跳转地址",onFocus:"请输入跳转地址"}).inputValidator({onError:"你输入网址格式不正确"}).regexValidator({regExp:"url",dataType:"enum",onError:"你输入网址格式不正确"});
$("#cityName").formValidator({onShow:"请输入城市名称"}).inputValidator({min:1,max:10,onErrorMin:"请输入大于1个字符",onErrorMax:"请输入小于6个中文字",empty:{leftEmpty:false,rightEmpty:false,emptyError:"城市名称两边不能有空格"},onError:"请输入城市名称"});
$("#cityContent").formValidator({onShow:"请输入城市介绍"}).inputValidator({min:1,max:100,onErrorMin:"请输入大于1个字符",onErrorMax:"请输入小于50个中文字",empty:{leftEmpty:false,rightEmpty:false,emptyError:"城市介绍两边不能有空格"},onError:"请输入城市介绍"});
$("#productName").formValidator({onShow:"请输入商品名称"}).inputValidator({min:1,max:16,onErrorMin:"请输入大于1个字符",onErrorMax:"请输入小于9个中文字",empty:{leftEmpty:false,rightEmpty:false,emptyError:"商品名称两边不能有空格"},onError:"请输入商品名称"});
$("#uploadImageValueId1").formValidator({tipID:"imgTip",onShow: "请输入图片名", onCorrect: "谢谢你的合作，你的图片名正确" }).inputValidator({min:1,onErrorMin:"请上传图片"}).regexValidator({ regExp: "picture", dataType: "enum", onError: "图片名格式不正确" });
$("#productUrl").formValidator({empty:true,onShow:"请输入跳转地址",onFocus:"请输入跳转地址"}).inputValidator({onError:"你输入网址格式不正确"}).regexValidator({regExp:"url",dataType:"enum",onError:"你输入网址格式不正确"});
$("#imgType").formValidator({onShow:"请选择图片类型",onFocus:"请选择图片类型",onCorrect:"谢谢你的配合"}).inputValidator({min:1,onError: "请选择图片类型"});

$("#everydayRecommed_imgUpload").uploadify(
		{
			'auto' : true,
			'buttonImg' : '${_jsPath}/plugin/uploadify/uploadimg_btn.png',
			'cancelImg' : '${_jsPath}/plugin/uploadify/cancel.png',
			'expressInstall' : '${_jsPath}/plugin/uploadify/expressInstall.swf',
			'fileDataName' : 'file',
			'fileDesc' : '请选择jpg、gif、png文件',
			'fileExt' : '*.jpg;*.jpeg;*.gif;*.png',
			'multi' : false,
			'script' : '${_ctxPath}/upload/upload.htm',
			'sizeLimit' : 2097152,
			'uploader' : '${_jsPath}/plugin/uploadify/uploadify.allglyphs.swf',
			'scriptData' : {'category' : 'adv'},
			onComplete : function(event, ID, fileObj, response, data) {
				$('#uploadImageValueId').val(response);
				//显示缩略图
				var suffix = response.split(".")[1];
				var url = '${_fileThumbPath}' + response + "_t102." + suffix;
				$('#showImg').attr({src: url}).show();
			}
		}
);
//每日推荐表单验证js
$("#everydayRecommed_advName").formValidator({
	onShow : "如：每日一款（最大支持10个汉字，建议使用4个汉字），用于首页右侧锚点名称",
	onFocus : "如：每日一款（最大支持10个汉字，建议使用4个汉字），用于首页右侧锚点名称"
}).inputValidator({
	min : 1,
	max : 10,
	onErrorMax : "请输入小于10个中文字",
	empty : {
		leftEmpty : false,
		rightEmpty : false,
		emptyError : "广告名称两边不能有空格"
	},
	onError : "请输入广告名称,如：每日一款（最大支持10个汉字，建议使用4个汉字），用于首页右侧锚点名称"
});
$("#everydayRecommed_advDescription").formValidator({
	onShow : "最大支持50个中文字长度，前台图片alt属性，不显示，用于SEO抓取",
	onFocus : "最大支持50个中文字长度，前台图片alt属性，不显示，用于SEO抓取"
}).inputValidator({
	min : 1,
	max : 50,
	onErrorMax : "请输入小于50个中文字",
	empty : {
		leftEmpty : false,
		rightEmpty : false,
		emptyError : "两边不能有空格"
	},
	onError : "最大支持50个中文字长度，前台图片alt属性，不显示，用于SEO抓取"
});

$("#common_imgUpload").uploadify(
		{
			'auto' : true,
			'buttonImg' : '${_jsPath}/plugin/uploadify/uploadimg_btn.png',
			'cancelImg' : '${_jsPath}/plugin/uploadify/cancel.png',
			'expressInstall' : '${_jsPath}/plugin/uploadify/expressInstall.swf',
			'fileDataName' : 'file',
			'fileDesc' : '请选择jpg、gif、png文件',
			'fileExt' : '*.jpg;*.jpeg;*.gif;*.png',
			'multi' : false,
			'script' : '${_ctxPath}/upload/upload.htm',
			'sizeLimit' : 2097152,
			'uploader' : '${_jsPath}/plugin/uploadify/uploadify.allglyphs.swf',
			'scriptData' : {'category' : 'adv'},
			onComplete : function(event, ID, fileObj, response, data) {
				$('#uploadImageValueId').val(response);
				var url = '${_filePath}' + response;
				$('#showImg').attr({src: url}).show();
			}
		}
);

$(function(){
	initWaterMark("advName","如：六一活动（最大支持10个汉字，建议使用4个汉字）");
	initWaterMark("descContent","最大支持50个中文字长度，前台图片alt属性，不显示，用于SEO抓取");
	initWaterMark("advUrl","例：http://www.yichengpin.com/item-100065-2-10060.do");
	if($.fn.placeholder){
		$('input[placeholder]').placeholder();
		$('textarea[placeholder]').placeholder();
	}
}); 


function initWaterMark(id,tip){
	$("#"+id).attr("placeholder",tip);
};
</script>
</body>
</html>