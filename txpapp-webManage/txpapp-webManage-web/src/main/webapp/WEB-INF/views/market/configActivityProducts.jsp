<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>设置活动商品</title>
<link href="${_cssPath }/common.css" rel="stylesheet" />
<link href="${_cssPath }/pages/configFullReduceProduct.css" rel="stylesheet" />
<link href="${_jsPath }/plugin/artdialog/skins/ytoxl.css"	rel="stylesheet" />
<script src="${_jsPath }/jquery/jquery.1.8.1.js" language="javascript"></script>
<script src="${_jsPath }/plugin/My97DatePicker/WdatePicker.js"></script>
<script src="${_jsPath }/plugin/formvalidator/formValidatorRegex.js"></script>
<script src="${_jsPath}/plugin/formvalidator/formValidatorRegex.js"
	language="javascript"></script>
<script src="${_jsPath}/plugin/formvalidator/formValidator-4.1.3.js"
	language="javascript"></script>
	<script>
		var _skuList = 5;
		var activityId2= "${activityProduct.params.marketActivityId}";
		var ActivityStartTime = '<fmt:formatDate value="${activity.startTime }"  pattern="yyyy-MM-dd HH:mm:ss"/>';
		var ActivityEndTime = '<fmt:formatDate value="${activity.endTime}"  pattern="yyyy-MM-dd HH:mm:ss"/>';
	</script>
<script src="${_jsPath }/pages/configActivityProducts.js"></script>
<!--[if IE]>
		<script src="${_jsPath}/pages/ieplaceholder.js">
		var activity = '${activityProduct.params.marketActivityId }'
		</script>
	<![endif]-->
</head>
<body>
	<!--start header-->
	<jsp:include page="../include/header.jsp"></jsp:include>
	<div class="body m-w980p">
		<!-- 当前位置 -->
		<div class="curPosition" style = "margin-top:10px;">
			当前位置：<a href="${_ctxPath}/marketactivity/marketact-listActivities.htm">营销工具</a>-> <a href="${_ctxPath}/marketactivity/marketact-listActivities.htm">活动管理</a>-> 设置活动商品
		</div>			
		<form class="sub-form m-clear m-mt10p"
			action="${_ctxPath }/test/user/market/configActivityProducts.do" id="addForm"
			method="post" onSubmit="return chkForm();" >
			<div class="m-fl">
			
			<input name="activityProduct.params.marketActivityId" value="${activityProduct.params.marketActivityId }" type="hidden"/>
			<input name="listType" value="${activityProduct.params.listType }" type="hidden" id="listType"/>
			<input name="activity.sellTypes" value="${activity.sellTypes }" type="hidden" id="sellTypes"/>
			<br/>
			
			<strong style="font-size: 14px;">活动规则</strong>
			<hr></hr>
			<table style="font-size: 14px;">
				<tr><td>活动名称：</td><td>${activity.name}</td></tr>
				<tr><td>活动代码：</td><td>${activity.code}</td></tr>
				<tr><td>活动时间：</td>
				<td>
				<fmt:formatDate value="${activity.startTime }"  pattern="yyyy-MM-dd HH:mm:ss"/> 至 <fmt:formatDate value="${activity.endTime }" pattern="yyyy-MM-dd HH:mm:ss"/>
				<input type="hidden" id="startTime" value="" />
				<input type="hidden" id="endTime" value="" />
				</td></tr>
				<tr><td>活动描述：</td><td>${activity.activityDesc}</td></tr>
				<tr><td></td><td></td></tr>
			</table>
			<br/>
				<strong style="font-size: 14px;">条件查询功能区</strong>
				<hr/>
				商品名称：<input type="text" style="height:24px;width:140px;" name="activityProduct.params.name" value="${activityProduct.params.name }"/>&nbsp;&nbsp;&nbsp;&nbsp;
				商品状态：<select style="height:24px;" name="activityProduct.params.status">
							<option value="" >全部状态</option>
							<option value="1" <c:if test="${activityProduct.params.status == 1 }"> selected = "selected" </c:if>>草稿</option>
							<option value="6" <c:if test="${activityProduct.params.status == 6 }"> selected = "selected" </c:if>>销售中</option>
							<option value="7" <c:if test="${activityProduct.params.status == 7 }"> selected = "selected" </c:if>>已售罄</option>
							<option value="8" <c:if test="${activityProduct.params.status == 8 }"> selected = "selected" </c:if>>已下架</option>
						</select>
						<br /><br />
				商品类目：<select  name="activityProduct.params.kind1" id="bigcatalog" class="m-sel"  style="width:100px;height:24px;"><option value="-1">请选择</option></select>
						 <select class="m-sel" style="width:100px;height:24px;"  name="activityProduct.params.kind2" id="smallcatalog"><option value="-1">请选择</option></select>
						 <br/><br/>
				<%--商家代码：<input type="text" style="height:24px;"/> --%>
				商家名称：<select name="activityProduct.params.username"  style="height:24px;width:338px;">
	                        <option value="">全部商家</option>
	                        <c:forEach items="${sellers }" var="seller" varStatus="status">
								<option value="${seller.userId }"
									<c:if test="${seller.userId == activityProduct.params.username }"> selected = "selected" </c:if>>
									${seller.companyName}
								</option>
							</c:forEach>
	                    </select>
						<br/><br/>
				SKU 编码：<input type="text" id="skuCodes" name="activityProduct.params.skuCodes" value="${activityProduct.params.skuCodes }" 
          				class="J-keywords txt-input txt-input-w input-marks" id="searchname" style="width:330px;height:24px;" /><br/><br/>
				销量：<input type="text" style="height:24px;" name="activityProduct.params.salesQuantityF" value="${activityProduct.params.salesQuantityF }"/>至<input type="text" style="height:24px;" name="activityProduct.params.salesQuantityB" value="${activityProduct.params.salesQuantityB }"/>
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;结算价格：<input type="text" style="height:24px;" name="activityProduct.params.unitPriceF" value="${activityProduct.params.unitPriceF }"/>至<input type="text" style="height:24px;" name="activityProduct.params.unitPriceB" value="${activityProduct.params.unitPriceB }"/>
				<br/><br/>
				<input type="submit"   value="查询" style="margin-left:200px;width:100px;"/>
			</div>
		</form>
		<strong style="font-size: 14px;">批量设置功能区</strong>
		<hr/>
		<form action="${_ctxPath }/marketactivity/marketact-addAllProductToActivity.htm" id="addAllProductForm" method="post" style ="position:relative;">
		<div style="margin-top:10px;margin-bottom:10px;">
			设置活动结算价折扣：<input class="activity_discount_set" value=""/>
			<input id="activity_discount_but" type="button" value="设置"/><br/><br/>
			调整活动价（一品价倍数）：<input class="activityPrice_set" value=""/>
			<input id="activityPrice_but" type="button" value="设置"/><br/><br/>
			设置活动时间：<input id="setStartTime" style = "width:150px;"name="activity.startTime" value="" class="Wdate"
				type="text" readonly="readonly"
				onFocus="WdatePicker({minDate:'%y-%M-{%d}',maxDate:'#F{$dp.$D(\'setEndTime\')}',dateFmt:'yyyy-MM-dd HH:mm:ss'})" />  至
				<input id="setEndTime" style = "width:150px;" name="activity.endTime" value="" class="Wdate"
				type="text" readonly="readonly"
				onFocus="WdatePicker({minDate:'#F{$dp.$D(\'setStartTime\')}',dateFmt:'yyyy-MM-dd HH:mm:ss'})"/>
			<input id="activityTime_but" type="button" value="设置"/>
		</div>
		<hr/>
		
		<div style = "position: absolute;margin-top:13px;left: 390px;">
			<input type="button" id = "allProductSku"  class="m-btn" value="选择全场商品" style="width: 120px;"/>
			<input type="button" id = "cancelAllProductSku"  class="m-btn" value="取消全场商品" style="width: 120px;"/>
			<input type="button" id="updateMarketProduct" class="m-btn" style="margin-left:200px;" value = "保存"/>
			 <input type="button"  class="m-btn" id="backToMarketList"  value="返回" /> <span style="color: #bf3028"><-点我</span>
		</div>
		
		<div class="m-mt10p business-management">
			<div class="body-nav subnav m-mt10p" id="status_con">
				<c:if test="${empty orderPage.params.orderId}">	
					<ul class="m-clear">
						<li>
							<a onclick="allMarketProduct();" 
							<c:if test="${activityProduct.params.listType==null || activityProduct.params.listType=='' || activityProduct.params.listType ==2 }"> class="current-chose"</c:if>>
								 商品列表
							</a>
						</li>
						<li>
							<a onclick="marketProduct();" 
							<c:if test="${activityProduct.params.listType!=null && activityProduct.params.listType==1 }"> class="current-chose"</c:if>>
								 已选商品
							</a>
						</li>
						<li>
							<a onclick="marketProduct3();"
									<c:if test="${activityProduct.params.listType!=null && activityProduct.params.listType==3 }"> class="current-chose"</c:if>>
								已选商品3
							</a>
						</li>
						<li>
							<a onclick="marketProduct4();"
									<c:if test="${activityProduct.params.listType!=null && activityProduct.params.listType==4 }"> class="current-chose"</c:if>>
								已选商品4
							</a>
						</li>
					</ul>
				</c:if>
			</div>
		  	<input type="hidden" id="hasSelectProductSkuIds" name="hasSelectProductSkuIds" value="" />
		  	<input type="hidden"  id="marketActivityId" name="marketActivityProduct.activityId" value="${activityProduct.params.marketActivityId }" />
		  	<input type="hidden"  id="activityProductSkuId" name="marketActivityProduct.productSkuId" value="" />
			<table class="tab-control" id="tab" style="clear: both;width: 1000px;">
				<thead>
					<tr>
						<!-- <th width="2%" class="select-sku select-all-sku"> <em></em>  </th> -->
						<th><input class="input-checkbox" type="checkbox"  name = "allChecks"  style ="width:14px;"></th>
						<th width="5%">SKU</th>
						<th width="7%">商品名称</th>
						<th width="6%">结算价</th>
						<th width="6%">活动结算价</th>
						<th width="6%">活动结算价折扣</th>
						<th width="6%">活动价</th>
						<th width="6%">一品价</th>
						<th width="6%">历史销量</th>
						<th width="6%">重量</th>
						<th width="7%">规格</th>
						<th width="6%">库存</th>
						<th width="5%">活动商品库存</th>
						<th width="5%">活动商品限购件数</th>
						<th width="6%">活动商品开始时间</th>
						<th width="6%">活动商品结束时间</th>
						<c:if test="${activityProduct.params.listType!=null && activityProduct.params.listType==1 }">
							<th width="6%">操作</th>
						</c:if>
						<c:if test="${activity.sellTypes==8 }">
						<th>消耗积分</th>
						</c:if>
					</tr>
				</thead>
				<tbody>
				<c:forEach items = "${activityProduct.result}" var = "fullReductionActivity" varStatus="stat">
					<tr>
					<td class="select-sku select-sub-sku"> 11111  </td>
					<td> ${fullReductionActivity.productSkuId } </td>
					<td>${fullReductionActivity.name }  </td>
					<td>
						${fullReductionActivity.skuSettlementPrice}
						<input type="hidden" name="productList[${stat.index}].productSkuId" value="${fullReductionActivity.productSkuId }" /> 
						<input  type="hidden" name="productList[${stat.index}].activityId" value="${activityProduct.params.marketActivityId }" /> 
					</td>
					<td><input style="border: 0;" readonly="readonly" id="actSettlePrice_${fullReductionActivity.productSkuId}" value="${fullReductionActivity.actSettlePrice}"  name="productList[${stat.index}].actSettlePrice"/> </td>
					<td><input style="border: 0;" readonly="readonly" class="actSettleDiscount" id="actSettleDiscount_${fullReductionActivity.productSkuId}" value="${fullReductionActivity.actSettleDiscount}"  name="productList[${stat.index}].actSettleDiscount"/> </td>
					<td> <input class="activityPrice" id="activityPrice_${fullReductionActivity.productSkuId}" productskuid="${fullReductionActivity.productSkuId }" value="${fullReductionActivity.activityPrice ==null ? fullReductionActivity.unitPrice : fullReductionActivity.activityPrice }"  name="productList[${stat.index}].activityPrice"/> </td>
					<td >${fullReductionActivity.unitPrice } <input type="hidden"  id="unitPrice_${fullReductionActivity.productSkuId}"  value="${fullReductionActivity.unitPrice }"/></td>
					<td> ${fullReductionActivity.salesQuantity } </td>
					<td> ${fullReductionActivity.weight } </td>
					<td> ${fullReductionActivity.rule } </td>
					<td> 
						${fullReductionActivity.inventory}
						<input type = "hidden" id = "inventory_${fullReductionActivity.productSkuId}" value ="${fullReductionActivity.inventory}" name="productList[${stat.index}].inventory"/>
						<input type = "hidden" id = "productInventory_${fullReductionActivity.productSkuId}" name="productList[${stat.index}].productInventory" value ="${fullReductionActivity.productInventory}"/>
					</td>
					<td>
						<c:if test="${empty fullReductionActivity.activityProductInventory}">
							<input style="border:1;" id="activityProductInventory_${fullReductionActivity.productSkuId}" onblur = "checkProductInventory(${fullReductionActivity.productSkuId});" value="${fullReductionActivity.inventory}"  name="productList[${stat.index}].activityProductInventory"/>
						</c:if>
						<c:if test="${!empty fullReductionActivity.activityProductInventory}">
							<input style="border:1;" id="activityProductInventory_${fullReductionActivity.productSkuId}" onblur = "checkProductInventory(${fullReductionActivity.productSkuId});" value="${fullReductionActivity.activityProductInventory}"  name="productList[${stat.index}].activityProductInventory"/>
						</c:if>						
					</td>
					<td> 
						<c:if test="${empty fullReductionActivity.activityProductLimitBuy}">
							<input style="border:1;" id="activityProductLimitBuy_${fullReductionActivity.productSkuId}" onblur = "checkProductLimitBuy(${fullReductionActivity.productSkuId});" value="0"  name="productList[${stat.index}].activityProductLimitBuy"/>
						</c:if>
					
						<c:if test="${!empty fullReductionActivity.activityProductLimitBuy}">
							<input style="border:1;" id="activityProductLimitBuy_${fullReductionActivity.productSkuId}"  onblur = "checkProductLimitBuy(${fullReductionActivity.productSkuId});" value="${fullReductionActivity.activityProductLimitBuy}"  name="productList[${stat.index}].activityProductLimitBuy"/>
						</c:if>
					
					</td>
					<td>
						<c:if test="${empty fullReductionActivity.startTime}">
							<input style="font-size: 12px;" name="productList[${stat.index}].startTime" id = "activityProductStartTime_${fullReductionActivity.productSkuId}"   value="<fmt:formatDate value='${activity.startTime}' pattern='yyyy-MM-dd HH:mm:ss' />" class="Wdate startTime_edit"
							type="text" readonly="readonly" onFocus="WdatePicker({minDate:'#F{$dp.$D(\'startTime\')}',maxDate:'#F{$dp.$D(\'endTime\')}',dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
						</c:if>
						<c:if test="${!empty fullReductionActivity.startTime}">
							<input style="font-size: 12px;" name="productList[${stat.index}].startTime" id = "activityProductStartTime_${fullReductionActivity.productSkuId}" value="<fmt:formatDate value='${fullReductionActivity.startTime}' pattern='yyyy-MM-dd HH:mm:ss' />" class="Wdate startTime_edit"
							type="text" readonly="readonly" onFocus="WdatePicker({minDate:'#F{$dp.$D(\'startTime\')}',maxDate:'#F{$dp.$D(\'endTime\')}',dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
						</c:if>
					</td>
					<td> 
						<c:if test="${empty fullReductionActivity.endTime}">
							<input style="font-size: 12px;" name="productList[${stat.index}].endTime" id = "activityProductEndTime_${fullReductionActivity.productSkuId}" value="<fmt:formatDate value='${activity.endTime}' pattern='yyyy-MM-dd HH:mm:ss' />" class="Wdate endTime_edit"
						type="text" readonly="readonly" onFocus="WdatePicker({minDate:'#F{$dp.$D(\'startTime\')}',maxDate:'#F{$dp.$D(\'endTime\')}',dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
						</c:if>
					<c:if test="${!empty fullReductionActivity.endTime}">
					<input style="font-size: 12px;" name="productList[${stat.index}].endTime" id = "activityProductEndTime_${fullReductionActivity.productSkuId}" value="<fmt:formatDate value='${fullReductionActivity.endTime}' pattern='yyyy-MM-dd HH:mm:ss' />" class="Wdate endTime_edit"
					type="text" readonly="readonly" onFocus="WdatePicker({minDate:'#F{$dp.$D(\'startTime\')}',maxDate:'#F{$dp.$D(\'endTime\')}',dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
						</c:if>	
					</td>
					<c:if test="${activity.sellTypes==8 }">
					<td>
						<input style="border:1;" id="point_${fullReductionActivity.productSkuId}" onblur = "checkProductLimitBuy(${fullReductionActivity.productSkuId});" value="${fullReductionActivity.point}"  name="productList[${stat.index}].point"/>
					</td>
					</c:if>
					<c:if test="${activityProduct.params.listType!=null && activityProduct.params.listType==1 }">
						<td><a href="javascript:;" onclick ="editActivityProductSku(${fullReductionActivity.productSkuId},${activityProduct.params.marketActivityId})">编辑</a></td>
					</c:if>
					</tr>
				</c:forEach>
				<c:if test="${empty activityProduct.result}">
				<tr>
					<td colspan="14">没有找到相关记录！</td>
				</tr>
				</c:if>
				</tbody>
			</table>
		</div>
		<div class="table-bm-wrap cf">
			<!--S 右功能区-->
			<div class="fn-right">
				<!--S 分页-->
				<div class="pagination pagination-right">
					<c:if test="${not empty activityProduct.result}">
						<yp:commPage page="${activityProduct}" beanName="activityProduct"></yp:commPage>
					</c:if>
				</div>
				<!--E 分页-->
			</div>
			<!--E 右功能区-->
		</div>
		<!--end 商家管理table-->
		
		</form>
	</div>

	<!--end foot-->
	<jsp:include page="/WEB-INF/views/include/foot.jsp"></jsp:include>
	

<script  language="javascript">
$(function(){
	loadBigCatalog();
	
	if('${activityProduct.params.skuCodes }' == null || '${activityProduct.params.skuCodes }' == "") {
		$("#skuCodes").val("最多输入10个sku编码，且用英文逗号分隔开");
	}
});
var loadBigCatalog = function(){
	var catagory = 10001;
	$("#bigcatalog").html('<option value="-1">请选择</option>');
	$.ajax({
        "url": "${_ctxPath}/admin/product/product-getPropMsg.htm",
        "type": 'get',
        "dataType" : "json", 
        "data":{"selectKey":catagory,"level":1},
        "success": function (result) {
        	// 数据是否存在
            if (result) {
            	var jsonData = $.parseJSON(result.info).data;
                for (var i = 0; i < jsonData.length; i ++) {
                	//TODO
                	if(i<9){
                		$("#bigcatalog").append('<option value="'+jsonData[i].propId+'">'+jsonData[i].name+'</option>');
                	}
                    
                }
                if('${activityProduct.params.kind1}' != '') {
                	$("#bigcatalog option").each(function(){
                  	   if($(this).val() == '${activityProduct.params.kind1}'){
                  	   		$(this).attr("selected", true);
                  	   }
                  	  });
                     kind2SelectForKind1(10001,'${activityProduct.params.kind1}');
                }
                
            }
            
        },
        "error": function () {
        //    alert('请求错误，请稍后尝试:'+url);
        }
    });
}


$("#bigcatalog").change(function(){
	var parentId = $(this).children('option:selected').val();  
	//alert('parentId:' + parentId);
	var catagory = 10001;
	$("#smallcatalog").html('<option value="-1">请选择</option>');
	if(parentId==-1){
		return;
	}
	$.ajax({
        "url": "${_ctxPath}/admin/product/product-getPropMsg.htm",
        "type": 'get',
        "dataType" : "json", 
        "data":{"selectKey":catagory+"-"+parentId,"level":2},
        "success": function (result) {
        	// 数据是否存在
            if (result) {
            	var jsonData = $.parseJSON(result.info).data;
                for (var i = 0; i < jsonData.length; i ++) {
                    $("#smallcatalog").append('<option value="'+jsonData[i].propId+'">'+jsonData[i].name+'</option>');
                }
                $("#smallcatalog option").each(function(){
              	   if($(this).val() == '${activityProduct.params.kind2}'){
              	   		$(this).attr("selected", true);
              	   }
              	});
            }
            
        },
        "error": function () {
          //  alert('请求错误，请稍后尝试:'+url);
        }
    });
	
});
function kind2SelectForKind1(catagory,parentId) {
	$("#smallcatalog").html('<option value="-1">请选择</option>');
	if(parentId==-1){
		return;
	}
	$.ajax({
        "url": "${_ctxPath}/admin/product/product-getPropMsg.htm",
        "type": 'get',
        "dataType" : "json", 
        "data":{"selectKey":catagory+"-"+parentId,"level":2},
        "success": function (result) {
        	// 数据是否存在
            if (result) {
            	var jsonData = $.parseJSON(result.info).data;
                for (var i = 0; i < jsonData.length; i ++) {
                    $("#smallcatalog").append('<option value="'+jsonData[i].propId+'">'+jsonData[i].name+'</option>');
                }
                $("#smallcatalog option").each(function(){
              	   if($(this).val() == '${activityProduct.params.kind2}'){
              	   		$(this).attr("selected", true);
              	   }
              	});
            }
            
        },
        "error": function () {
          //  alert('请求错误，请稍后尝试:'+url);
        }
    });
}
//sku文本框
$("#skuCodes").focus(function() {
	if($("#skuCodes").val() == "最多输入10个sku编码，且用英文逗号分隔开") {
		$("#skuCodes").val("");
	}
});
$("#skuCodes").blur(function() {
	if($("#skuCodes").val() == "") {
		$("#skuCodes").val("最多输入10个sku编码，且用英文逗号分隔开");
	}
});
function chkForm() {
	if($("#skuCodes").val() == "最多输入10个sku编码，且用英文逗号分隔开") {
		$("#skuCodes").val("");
	}
}
$("#backToMarketList").click(function() {
	window.location.href="${_ctxPath }/test/user/market/activityList.do";
});
//所有商品
function allMarketProduct() {
	$("#listType").val("2");
	$("#addForm").submit();
}

//已选商品
function marketProduct() {
	$("#listType").val("1");
	$("#addForm").submit();
}
//已选商品3
function marketProduct3() {
	$("#listType").val("3");
	$("#addForm").submit();
}
//已选商品4
function marketProduct4() {
	$("#listType").val("4");
	$("#addForm").submit();
}

$("#sellType4").change(function() {
	if($(this).attr("checked")) {
		$("#sellType1").attr("checked",false);
		$("#sellType1").attr("disabled",true);
		$("#sellType2").attr("checked",false);
		$("#sellType2").attr("disabled",true);
		$("#sellType3").attr("checked",false);
		$("#sellType3").attr("disabled",true);
	}else {
		$("#sellType1").attr("disabled",false);
		$("#sellType2").attr("disabled",false);
		$("#sellType3").attr("disabled",false);
	}
});
if($("#sellType4").attr("checked")) {
	$("#sellType1").attr("checked",false);
	$("#sellType1").attr("disabled",true);
	$("#sellType2").attr("checked",false);
	$("#sellType2").attr("disabled",true);
	$("#sellType3").attr("checked",false);
	$("#sellType3").attr("disabled",true);
}
</script>
</body>
</html>