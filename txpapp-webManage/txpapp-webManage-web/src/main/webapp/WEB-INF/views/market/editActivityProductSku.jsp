<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>市场活动</title>
<link href="${_cssPath }/common.css" rel="stylesheet" />
<link href="${_cssPath }/pages/arrangement.css" rel="stylesheet" />
<link href="${_cssPath }/pages/bannerManage.css" rel="stylesheet" />
<link href="${_jsPath }/plugin/artdialog/skins/ytoxl.css"
	rel="stylesheet" />
<script src="${_jsPath }/jquery/jquery.1.8.1.js" language="javascript"></script>
<script src="${_jsPath }/plugin/artdialog/jquery.artDialog.min.js"></script>
<script src="${_jsPath}/plugin/formvalidator/formValidator-4.1.3.js"
	language="javascript"></script>
<script src="${_jsPath}/plugin/formvalidator/formValidatorRegex.js"
	language="javascript"></script>
<script src="${_jsPath}/pages/specAdv.js" language="javascript"></script>
<script type="text/javascript" src="${_jsPath }/plugin/My97DatePicker/WdatePicker.js"></script>
<!--[if IE]>
		<script src="${_jsPath}/pages/ieplaceholder.js"></script>
	<![endif]-->
<style>
.curPosition {
	height: 30px;
	line-height: 30px;
	padding-top: 20px;
}
</style>
</head>
<body>
	<!-- 正文内容 -->
	<div class="body m-w980p">
		<!-- 当前位置 -->
		<form method="post" id="editActivityFrom" action="">
			<input type = "hidden" name= "activity.id" value ="${activity.id}">
			<input type = "hidden" name= "marketActivityProduct.productSkuId" value ="${marketActivityProduct.productSkuId}">
			<div class="m-mt10p addBanner">
  					<div class="addADV cf">
					<label>SKU: </label>
					<div class="infoADV"> 
						${marketActivityProduct.productSkuId}
					</div>
				</div>
				<div class="addADV cf">
					<label><i class="red">*</i>商品名称:</label>
					<div class="infoADV">
						 ${marketActivityProduct.name}
					</div>
				</div>
<%-- 				<div class="addADV cf">
					<label><i class="red">*</i>结算价:</label>
					<div class="infoADV">
						<input  type="text" name="marketActivityProduct.skuSettlementPrice" value="${marketActivityProduct.skuSettlementPrice}" class="iText" id="skuSettlementPrice" />
					</div>
				</div> --%>
				<div class="addADV cf">
					<label>活动结算价:</label>
					<div class="infoADV">
						<input  type="text" name="marketActivityProduct.actSettlePrice" value="${marketActivityProduct.actSettlePrice}" class="iText" id="actSettlePrice" /> 
					</div>
				</div>	
				<div class="addADV cf">
					<label><i class="red">*</i>活动结算价折扣:</label>
					<div class="infoADV">
						<input  type="text" name="marketActivityProduct.actSettleDiscount" value="${marketActivityProduct.actSettleDiscount}" class="iText" id="actSettleDiscount" /> 
					</div>
				</div>
				
				<div class="addADV cf">
					<label><i class="red">*</i>活动价: </label>
					<div class="infoADV">
						<input  type="text" name="marketActivityProduct.activityPrice" value="${marketActivityProduct.activityPrice ==null ? marketActivityProduct.unitPrice : marketActivityProduct.activityPrice }" class="iText" /> 
					</div>
				</div>
				

				<div class="addADV cf" id = "rulePlus">
					<label><i class="red">*</i>一品价: </label>
					<div class="infoADV">
						${marketActivityProduct.unitPrice}(元)
					</div>
				</div>	
				
				<div class="addADV cf" id = "rulePlus">
					<label><i class="red">*</i>历史销量: </label>
					<div class="infoADV">
						${marketActivityProduct.salesQuantity}(件)
					</div>
				</div>	
				
							
				<div class="addADV cf" id = "rulePlus">
					<label><i class="red">*</i>重量: </label>
					<div class="infoADV">
						 ${marketActivityProduct.weight}
					</div>
				</div>				
				
				<div class="addADV cf" id = "rulePlus">
					<label><i class="red">*</i>规格: </label>
					<div class="infoADV">
						 ${marketActivityProduct.rule}
					</div>
				</div>				
						
				<div class="addADV cf" id = "rulePlus">
					<label><i class="red">*</i>库存: </label>
					<div class="infoADV">
						<c:if test="${not empty marketActivityProduct.inventory}">
							${marketActivityProduct.inventory}(件)
						</c:if>
						<c:if test="${empty marketActivityProduct.inventory}">
							0(件)
						</c:if>						
					</div>
				</div>	
				
				
				<c:if test="${not empty marketActivityProduct.activityProductInventory}">
					<div class="addADV cf" id = "rulePlus">
						<label><i class="red">*</i>活动商品库存: </label>
						<div class="infoADV">
								${marketActivityProduct.activityProductInventory}(件)
							<input type = "radio"  style ="width:auto" name ="addActivityInventory" value="plus"/>加<input type = "text" name="activityProductInventoryAdd" />
							<input type = "radio"   style ="width:auto" name="addActivityInventory" value="minus"/>减<input type = "text" name="activityProductInventoryMinus" />
						</div>
					</div>	
				</c:if>
				
				<div class="addADV cf" id = "rulePlus">
					<label><i class="red">*</i>活动商品限购件数: </label>
					<div class="infoADV">
						<input  type="text" name="marketActivityProduct.activityProductLimitBuy" value="${marketActivityProduct.activityProductLimitBuy}" class="iText" id="activityProductLimitBuy" /> (件)
					</div>
				</div>	
							
				<div class="addADV cf" id = "rulePlus">
					<label><i class="red">*</i>活动商品开始时间: </label>
					<div class="infoADV">
							<input style="font-size: 12px;" name = "marketActivityProduct.startTime"  value="<fmt:formatDate value='${marketActivityProduct.startTime}' pattern='yyyy-MM-dd HH:mm:ss' />" class="Wdate startTime_edit"
							type="text"  onFocus="WdatePicker({minDate:'#F{$dp.$D(\'startTime\')}',maxDate:'#F{$dp.$D(\'endTime\')}',dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
				</div>	
				
				
				<div class="addADV cf" id = "rulePlus">
					<label><i class="red">*</i>活动商品结束时间: </label>
					<div class="infoADV">
						<input style="font-size: 12px;" name = "marketActivityProduct.endTime"  value="<fmt:formatDate value='${marketActivityProduct.endTime}' pattern='yyyy-MM-dd HH:mm:ss' />" class="Wdate endTime_edit"
						type="text" readonly="readonly" onFocus="WdatePicker({minDate:'#F{$dp.$D(\'startTime\')}',maxDate:'#F{$dp.$D(\'endTime\')}',dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
					</div>
				</div>	
			</div>	
			</div>
		</form>
	</div>
	<script type="text/javascript">
		$("input[name^='activityProductInventory']").focus(function(){
			$(this).prev().attr("checked","checked");
		});
		$("input[name='addActivityInventory']").on('click',function(){
			$(this).next().focus();
		});
	</script>
</body>
</html>