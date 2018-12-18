<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.txp.app.contants.Product"%>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>
<html lang="zh">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>查看商品</title>
	<script src="${_jsPath }/jquery/jquery.1.8.1.js" language="javascript"></script>
	<link href="${_cssPath }/common.css" rel="stylesheet" />
  	<link href="${_cssPath }/pages/addProduct.css" rel="stylesheet" />
	<link rel="stylesheet" type="text/css" href="${_cssPath }/pages/produce-detail.css">
	<link rel="stylesheet" type="text/css" href="${_cssPath }/pages/addBrand.css">

	<script type="text/javascript" src="${_jsPath }/plugin/ckeditor/ckeditor.js"></script>

	<!-- 上传文件-->
	<link rel="stylesheet" type="text/css" href="${_cssPath }/customUpload.css">
	<script type="text/javascript" src="${_jsPath }/customUpload.js"></script>

<body>
	<!--start header-->
	<jsp:include page="../include/header.jsp"></jsp:include> 
    <!--end header-->
    <!--start body-->
    <div class="body m-w980p">
	    <div class="produce-top cf">
	    	<input type="hidden" id="productId" value="${product.productId }">
	    	<input type="hidden" id="sellType" value="${product.sellType }">
	    	<table border="0" class="addPro-table">
	    		<tr>
					<td  class="left-td tdL">销售方式：</td>
					<td>
					</td>
				</tr>
				<c:if test="${product.sellType == 2}">
					<tr>
						<td class="left-td tdL">预发货日期：</td>
						<td>
							<fmt:formatDate value="${product.preDeliveryTime }" pattern="yyyy-MM-dd"/>	
						</td>
					</tr>
				</c:if>
				<tr>
					<td class="left-td tdL">品牌：</td>
					<td>
						${product.brand.name }
					</td>
				</tr>
				<tr style="height: 200px;">
					<td class="left-td tdL">图片上传：</td>
					<td>
						<div id="upload"></div>
					</td>
				</tr>
				<tr>
					<td class="left-td tdL">点击上传：</td>
					<td>
						<button class="submit">submit</button>
						<span id="uploadMsg"></span>
					</td>
				</tr>
				<tr>
					<td class="left-td tdL">推荐图：</td>
					<td>
						<div class="brandImg-default">
							<%--<img src="http://we-mall.oss-cn-shanghai.aliyuncs.com/beadwalletmallImg/upload/cms/2018-06-12/57b3af8531c840489b556b4a48ae130f.jpg" class="imgshow"  id="brandImage" width="1045px" height="261px"/>--%>
							<img src="" class="imgshow"  id="brandImage" width="1045px" height="261px"/>
							<%--<img src="D:\upload\018eec56cabc9c6ac7252ce6f05f11.jpg@900w_1l_2o_100sh.jpg" class="imgshow"  id="brandImage" width="1045px" height="261px"/>--%>
						</div>
					</td>
				</tr>
				<tr>
					<td class="left-td tdL">附文本：</td>
					<td>
						<textarea class="brandImg-default" id="description" ></textarea>
					</td>
				</tr>
				<tr>
					<td class="left-td tdL">所在地区：</td>
					<td>
					<c:choose>
						<c:when test="${product.nation == 9999 }">国外</c:when>
						<c:when test="${product.nation == 10000 }">中国</c:when>
					</c:choose>
						${product.propsMap.area[0].name } &nbsp;&nbsp;${product.propsMap.area[1].name }
					</td>
				</tr>
				<tr>
					<td class="left-td tdL">分类：</td>
					<td>
						${product.firstcatalog }&nbsp;&nbsp;${product.propsMap.catalog[0].name } &nbsp;&nbsp;${product.propsMap.catalog[1].name }
					</td>
				</tr>
				<tr>
					<td class="left-td tdL">商品前台显示名称：</td>
					<td>
						${product.name }
					</td>
				</tr>
				<tr>
					<td class="left-td tdL">商品后台显示名称：</td>
					<td>
						${product.aliasName}
					</td>
				</tr>
				<tr>
					<td class="left-td tdL">商品关键词：</td>
					<td>
						${product.keyWord}
					</td>
				</tr>
				<tr>
					<td class="left-td tdL">支付方式：</td>
					<td>
						<input class="input-checkbox" type="checkbox" checked="checked" disabled="disabled"/>
						在线支付
						&nbsp;
						<c:if test="${product.payType == 2}"><input class="input-checkbox" type="checkbox" checked="checked" disabled="disabled"/></c:if>
						<c:if test="${product.payType == 1}"><input class="input-checkbox" type="checkbox" disabled="disabled"/></c:if>
						货到付款
					</td>
				</tr>
				<tr>
					<td class="left-td">结算类型：</td>
					<td>
					<input type="radio" name="product.settlementType" value="1" disabled="disabled" <c:if test='${product.settlementType==null || product.settlementType==1}'>checked</c:if>  />返点
					<input type="radio" name="product.settlementType" value="2" disabled="disabled" <c:if test='${product.settlementType==2}'>checked</c:if> />供货</td>
				</tr>				
				<c:if test="${product.sellType==3}">
					<tr>
						<td class="left-td tdL">抢购数量：</td>
						<td>
							${product.rushQuantity }
						</td>
					</tr>
				</c:if>
				<tr>
					<td class="left-td tdL">生产商：</td>
					<td>${product.manufacturer}</td>
				</tr>
				<tr>
					<td class="left-td tdL">生产地址：</td>
					<td>${product.manufacturerAddress}</td>
				</tr>				
				<tr>
					<td class="left-td tdL">生产许可证：</td>
					<td>${product.manufactureLicence}</td>
				</tr>
				<tr>
					<td class="left-td tdL">有效期：</td>
					<td><fmt:formatDate value="${product.expiryDate}" pattern="yyyy-MM-dd"/></td>
				</tr>		
				<tr>
					<td class="left-td tdL">产品标准号：</td>
					<td>${product.productCode}</td>
				</tr>				
				<tr>
					<td class="left-td tdL">条码：</td>
					<td>${product.barCode}</td>
				</tr>				
				<tr>
					<td class="left-td tdL">是否有机：</td>
					<td>
						<c:if test="${product.isOrganic == 1}">是</c:if>
						<c:if test="${product.isOrganic != 1}">否</c:if>
					</td>
				</tr>				
				<tr>
					<td class="left-td tdL">是否含食品添加剂：</td>
					<td>
						<c:if test="${product.isAdditives == 1}">是</c:if>
						<c:if test="${product.isAdditives != 1}">否</c:if>
					</td>
				</tr>
				
				<tr>
					<td class="left-td tdL">推荐理由：</td>
					<td>
						${product.recommendedReason }
					</td>
				</tr>
				<tr>
					<td class="left-td tdL">库存：</td>
					<td>111</td>
				</tr>
				<tr valign="top">
					<td class="left-td tdL"></td>
					<td colspan="3" class="small">
						<table>
							<tr>
								<td width="450">
									<table class="repertories" width="630" class="small">
										<tr>
											<th width="12%">规格</th>
											<th width="12%">重量</th>
											<th width="12%">库存数</th>
											<th width="26%">商品标识</th>
											<th width="38%">结算价</th>
										</tr>
										<c:forEach items="${product.productSkus }" var="sku">
										<tr>
											<td>${sku.skuSpecification }</td>
											<td>${sku.skuWeight }</td>
											<td>${sku.inventory }</td>
											<td>${sku.sellerSkuCode }</td>
											<td>${sku.settlementPrice}</td>
										</tr>
									</c:forEach>
									</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr valign="top">
					<td class="left-td tdL">商品图片：</td>
					<td colspan="3">
						<table class="no-border-table">
							<tr>
								<c:forEach items="${product.imageList}" var="image">
									<td width="120">
										<div class="default-img">
											<img src="" />
										</div>
									</td>
								</c:forEach>
								<c:if test="${empty product.imageList}">
									<td width="120">暂无</td>
								</c:if>
							</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td class="left-td tdL">商品描述：</td>
					<td>
						<div style="overflow:auto">
							<c:choose>
								<c:when test="${empty product.description}">
									暂无
								</c:when>
								<c:otherwise>
									${product.description}
								</c:otherwise>							
							</c:choose>
						</div>
				</tr>
			</table>
		</div>
		<c:set var="notPass" value="<%= Product.STATUS_NO_PASS %>"></c:set>
        <c:set var="checkPend" value="<%= Product.STATUS_CHECK_PEND %>"></c:set>
        	<!-- 历史审核失败原因 -->
        	<c:if test="${!empty product.auditLogs}">
	        	<table border="0" class="addPro-table auditLogStyle" width="80%">
        			<c:forEach items="${product.auditLogs}" var="auditLog">
		    		<tr>
						<td class="tdL1">${auditLog.auditRemark}</td>
						<td class="tdL">${auditLog.auditorName}</td>
						<td class="tdL"><fmt:formatDate value='${auditLog.auditTime}' pattern='yyyy-MM-dd HH:mm' /></td>
					</tr>
					</c:forEach>
				</table>
			</c:if>
	        <div class="goods-check">
	            <label>不通过原因：<br> (200字符以内)</label>
	            <textarea class="text-area input-marks" id="remark" >${product.remark }</textarea>
	            <span id="remarkTip" style="display: none;"><font color="red">请填写不通过原因</font></span>
	        </div>
        <div class="btn-check">
        		<c:if test="${mark == 2}">
           			<input type="button" class="m-btn" value="审核通过" id="pass"/>
            		<input type="button" class="m-btn" value="审核不通过" id="notPass"/>
        		</c:if>
            <input type="button" class="m-btn" value="返   回" id="back"/>
        </div>
	</div>
    <!--footer.jsp放置在这-->
    <jsp:include page="/WEB-INF/views/include/foot.jsp"></jsp:include>
	<script type="text/javascript" src="${_jsPath }/pages/viewProduct.js"></script>
	<script type="text/javascript">
	 	var STATUS_PASS = <%= Product.STATUS_PASS%>;
	    var STATUS_NO_PASS = <%= Product.STATUS_NO_PASS%>;
	    var STATUS_WAITING_SAMPLE = <%= Product.STATUS_WAITING_SAMPLE%>;
	    var STATUS_WAITING_REVIEW = <%= Product.STATUS_WAITING_REVIEW%>;
	    var STATUS_WAINTING_MAKING = <%= Product.STATUS_WAINTING_MAKING%>;
	</script>
</body>
</html>
<script>
	// 设置参数
	var options = {
		path: _ctxPath + '/upload/v1/fileUploadFiles.do',    // 上传图片时指定的地址路径，类似form变淡的action属性
//		path: _ctxPath + '/upload/v1/springUpload.do',    // 上传图片时指定的地址路径，类似form变淡的action属性
//		path: _ctxPath + '/upload/v1/fileUpload2.do',    // 上传图片时指定的地址路径，类似form变淡的action属性
		onSuccess: function (res) {    // 上传成功后执行的方法，res是接收的ajax响应内容
			console.log(res);
			console.log('upload succ');
			$("#uploadMsg").html("上传成功！");
			var testJson = eval("(" + res + ")");
//			alert(testJson.imgUrl);
//			$("#brandImage").attr("src",testJson.imgUrl);
			$("#brandImage").attr("src","http://we-mall.oss-cn-shanghai.aliyuncs.com/beadwalletmallImg/upload/cms/2018-06-12/57b3af8531c840489b556b4a48ae130f.jpg");
		},
		onFailure: function (res) {    // 上传失败后执行的方法，res是接收的ajax响应内容
			console.log('upload fail');
			console.log(res);
		}
	}
	// 执行生成图片上传插件的方法, 第一个参数是上面提到的准备生成组件的div选择器，第二个参数是设置的组件信息，执行方法后返回一个函数指针，指向执行上传功能的函数，通过把执行上传功能的函数暴露出来，用户就可以自己控制何时上传图片了。
	var upload = tinyImgUpload('#upload', options, 50, 50);

	document.getElementsByClassName('submit')[0].onclick = function (e) {
		$("#uploadMsg").html("");
		upload();
	}

	//富文本编辑
	var editor = CKEDITOR.replace("description");
</script>