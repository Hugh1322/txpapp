<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>活动页面设置</title>
<link href="${_cssPath }/common.css" rel="stylesheet" />
<link href="${_cssPath }/pages/configFullReduceProduct.css" rel="stylesheet" />
<link href="${_jsPath }/plugin/artdialog/skins/ytoxl.css"	rel="stylesheet" />
<script src="${_jsPath }/jquery/jquery.1.8.1.js" language="javascript"></script>
<script src="${_jsPath }/plugin/My97DatePicker/WdatePicker.js"></script>
<script src="${_jsPath}/plugin/formvalidator/formValidatorRegex.js" language="javascript"></script>
<script type="text/javascript" src="${_jsPath}/plugin/uploadify/jquery.uploadify.v2.1.4.min.js"></script>
<script type="text/javascript" src="${_jsPath}/plugin/uploadify/swfobject.js"></script>
<script src="${_jsPath}/plugin/formvalidator/formValidator-4.1.3.js" language="javascript"></script>
<script src="${_jsPath }/pages/configActivityProducts.js"></script>
<!--[if IE]>
	<![endif]-->
</head>
<body>
	<!--start header-->
	<jsp:include page="../include/header.jsp"></jsp:include>
	<div class="body m-w980p">
		<!-- 当前位置 -->
		<div class="curPosition" style = "margin-top:10px;">
			当前位置：<a href="${_ctxPath}/marketactivity/marketact-listActivities.htm">营销工具</a>-> <a href="${_ctxPath}/marketactivity/marketact-listActivities.htm">活动管理</a>-> 活动页面设置
		</div>			
		<form class="sub-form m-clear m-mt10p"
			action="${_ctxPath }/marketactivity/marketact-configActivityPage.htm" id="addForm"
			method="post" onSubmit="return chkForm();" >
			<div class="m-fl">
			
			<input name="activityProduct.params.marketActivityId" value="${activityProduct.params.marketActivityId }" type="hidden"/>
			<input name="activityProduct.params.listType" value="${activityProduct.params.listType }" type="hidden" id="listType"/>
			<br/>
			
			<strong style="font-size: 14px;">活动规则</strong>
			<hr></hr>
			<table style="font-size: 14px;">
				<tr><td>活动名称：</td><td>${activity.name }</td></tr>
				<tr><td>活动代码：</td><td>${activity.code }</td></tr>
				<tr><td>活动时间：</td>
				<td>
				<fmt:formatDate value="${activity.startTime }"  pattern="yyyy-MM-dd HH:mm:ss"/> 至 <fmt:formatDate value="${activity.endTime }" pattern="yyyy-MM-dd HH:mm:ss"/>
				<input type="hidden" id="startTime" value="<s:date name="activity.startTime" format="yyyy-MM-dd HH:mm:ss"/>" />
				<input type="hidden" id="endTime" value="<s:date name="activity.endTime" format="yyyy-MM-dd HH:mm:ss"/>" />
				</td></tr>
				<tr><td>活动描述：</td><td>${activity.activityDesc}</td></tr>
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
		
		<form action="${_ctxPath }/marketactivity/marketact-addAllProductToActivity.htm" id="addAllProductForm" method="post" style ="position:relative;">
		
			<strong style="font-size: 14px;">设置活动页面</strong>
			<hr/>
			<div class="rel cf">
				<label for="" class="fl">广告图片：</label>
				<div class="fl pNone" style="position: relative;">
					<div class="default-img">
						<div class="del-img"></div>
						<img alt="" src="${_filePath}/${activity.advertisementPics}" id="labelIcoUploadImg" style="width:100px;height: 100px;"/>
					</div>
					<label for="" class="fl" style="position: absolute;left:125px;width: 200px;"><i class="red">*</i>图片规格应为1044px*250px</label>
					<input type="file" id="labelIcoUpload" class="txt-input" name="file"/>
					<input type="hidden" id="labelImgUrl" name="activity.advertisementPics" value="${activity.advertisementPics}"/>						
				</div>
			</div>	
			<br/>
					
			展现形式:<select style="height:24px;" name="activity.displayMode" id="displayMode">
				<option value="0"   <c:if test="${activity.displayMode==0}">selected="selected" </c:if> >全列表显示</option>
				<option value="1" <c:if test="${activity.displayMode==1}">selected="selected" </c:if>>按楼层显示</option>
			</select><br/><br/>
			活动链接:<input type = "radio" style = "width:auto" value = "0" name = "activity.activityLinkMode" <c:if test="${activity.activityLinkMode==0}">checked="checked" </c:if>/>自动
					<input type = "radio" style = "width:auto" value = "1" name ="activity.activityLinkMode" <c:if test="${activity.activityLinkMode==1}">checked="checked" </c:if>/>手动
					<input type ="text"  style ="width:200px;" name = "activity.activityLink" value ="${activity.activityLink}" onfocus="actLinkChecked();"/>
			<br/><br/>
		<hr/>
		
		<div style = "position: absolute;margin-top:13px;left: 190px;">
			<input type="button" id="updateActivityInfo" class="m-btn" style="margin-left:550px;" value = "保存" />
			 <input type="button"  class="m-btn" id="backToMarketList"  value="返回" /> 
		</div>
		
		<div class="m-mt10p business-management">
			<div class="body-nav subnav m-mt10p" id="status_con">
				<c:if test="${empty orderPage.params.orderId}">	
					<ul class="m-clear">
<%-- 						<li>
							<a onclick="allMarketProduct();" 
							<c:if test="${activityProduct.params.listType==null || activityProduct.params.listType=='' || activityProduct.params.listType ==2 }"> class="current-chose"</c:if>>
								 商品列表
							</a>
						</li>		 --%>			
					
						<li>
							<a onclick="marketProduct();" 
							<c:if test="${activityProduct.params.listType!=null && activityProduct.params.listType==1 }"> class="current-chose"</c:if>>
								 已选商品
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
						<th width="2%" class="select-sku select-all-sku"> <em class="sel"></em></th>
						<th width="6%">SKU</th>
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
						<th width="6%">活动商品开始时间</th>
						<th width="6%">活动商品结束时间</th>
						<th width="2%">排序</th>
						<th width="2%">描点数</th>
						<th width="2%">描点值</th>
					</tr>
				</thead>
				<tbody>
				<c:forEach items = "${activityProduct.result}" var = "fullReductionActivity" varStatus="stat">
					<tr>
					<td class="select-sku select-sub-sku"> <em id="select-sub-sku-${fullReductionActivity.productSkuId}" productskuid="${fullReductionActivity.productSkuId }" <c:if test="${fn:contains(skuList,fullReductionActivity.productSkuId)==true}">class="sel"</c:if>></em>  </td>
					<td> ${fullReductionActivity.productSkuId } </td>
					<td>${fullReductionActivity.name }  </td>
					<td>
						${fullReductionActivity.skuSettlementPrice }
						<input type="hidden" name="productList[${stat.index}].productSkuId" value="${fullReductionActivity.productSkuId }" /> 
						<input  type="hidden" name="productList[${stat.index}].activityId" value="${activityProduct.params.marketActivityId }" /> 
					</td>
					<td>${fullReductionActivity.actSettlePrice}</td>
					<td>${fullReductionActivity.actSettleDiscount}</td>
					<td>${fullReductionActivity.activityPrice ==null ? fullReductionActivity.unitPrice : fullReductionActivity.activityPrice}</td>
					<td >${fullReductionActivity.unitPrice}</td>
					<td> ${fullReductionActivity.salesQuantity} </td>
					<td> ${fullReductionActivity.weight} </td>
					<td> ${fullReductionActivity.rule} </td>
					<td> 
						${fullReductionActivity.inventory}
					</td>
					<td>
						<c:if test="${empty fullReductionActivity.activityProductInventory}">
							${fullReductionActivity.inventory}
						</c:if>
						<c:if test="${!empty fullReductionActivity.activityProductInventory}">
							${fullReductionActivity.activityProductInventory}
						</c:if>						
					</td>
					<td>
						<c:if test="${empty fullReductionActivity.startTime}">
							<fmt:formatDate value="${activity.startTime}"  pattern="yyyy-MM-dd HH:mm:ss"/> 
						</c:if>
						<c:if test="${!empty fullReductionActivity.startTime}">
							<fmt:formatDate value="${fullReductionActivity.startTime}"  pattern="yyyy-MM-dd HH:mm:ss"/> 
						</c:if>
					</td>
					<td> 
						<c:if test="${empty fullReductionActivity.endTime}">
							<fmt:formatDate value="${activity.endTime}"  pattern="yyyy-MM-dd HH:mm:ss"/>
						</c:if>
					<c:if test="${!empty fullReductionActivity.endTime}">
						<fmt:formatDate value="${fullReductionActivity.endTime}"  pattern="yyyy-MM-dd HH:mm:ss"/>
					</c:if>	
					</td>
					<td>
						<input type ="text" value="${fullReductionActivity.activityProductSort}" name="productList[${stat.index}].activityProductSort"/>
					</td>
					<td><input type ="text" value="${fullReductionActivity.anchorCount}" name="productList[${stat.index}].anchorCount"/></td>
					<td><input type ="text" value="${fullReductionActivity.anchorValue}" name="productList[${stat.index}].anchorValue"/></td>
					
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
	 //图片上传
	 if('${activity.advertisementPics}'==''||'${activity.advertisementPics}'==null){
			$('#labelIcoUploadImg').hide();
		}  
	
	 var uploadLabelIco = {
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
	 uploadLabelIco.scriptData = {'category' : 'product'};
	 uploadLabelIco.onComplete = function(event, ID, fileObj, response, data) {
			$('#labelImgUrl').val(response);
			var url = '${_filePath}' + response;
			$('#labelIcoUploadImg').attr({src: url, width: 254/2 + "px", height: 520/2 + "px"});
			$('#labelIcoUploadImg').show();
		};
	 $('#labelIcoUpload').uploadify(uploadLabelIco);
	
	
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

$("input[name='activity.activityLinkMode']").click(function(){
	if($(this).val()=='0'){
		$("input[name='activity.activityLink']").val("");
	}
});

function actLinkChecked(){
	$("input[name='activity.activityLinkMode']").eq(1).attr("checked","checked"); 
}


//如果有上传图片，显示交换按钮
$(".default-img").hover(function(){
	if($(this).find("img")!=null){
		$(this).find(".del-img").show();
		$(this).find(".del-img").attr("title","删除")
	}
},function(){
	$(this).find(".del-img").hide();
});

//删除图片
$(".del-img").on("click",function(){
	$(this).next("img").remove();
	$("#labelImgUrl").val("");
});


$("#bigcatalog").change(function(){
	var parentId = $(this).children('option:selected').val();  
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
			window.location.href="${_ctxPath }/marketactivity/marketact-listActivities.htm";
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