<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	import="com.txp.app.contants.AdvPosition"%>
<%@include file="../../include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>满减设置商品</title>
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
</head>
<body>
	<!--start header-->
	<jsp:include page="../../include/header.jsp"></jsp:include>
	<div class="body m-w980p">
		<%--  <jsp:include page="../include/pageManageMenu.jsp"  flush="true" />  --%>
		<form class="sub-form m-clear m-mt10p"
			action="${_ctxPath }/seller/product/group/gp-configGroupProduct.htm" id="addForm"
			method="post" onSubmit="return chkForm();" >
			<div class="m-fl">
			<input name="groupItemPage.params.groupId" value="${groupItemPage.params.groupId }" type="hidden"></input>
			<input name="groupItemPage.params.listType" value="${groupItemPage.params.listType }" type="hidden" id="listType"></input>
			<span style="font-size: 25px;vertical-align: middle; text-align: center;">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;设置团购商品
			</span>
			</br>
				<strong style="font-size: 14px;">团购规则</strong>
				<hr></hr>
				<table style="font-size: 14px;">
					<tr><td>开团前专区名称：</td><td>${groupActivity.beforeName }</td></tr>
					<tr><td>开团前显示顺序：</td><td>${groupActivity.beforeRank }</td></tr>
					<tr><td>开团后专区名称：</td><td>${groupActivity.afterName }</td></tr>
					<tr><td>开团后显示顺序：</td><td>${groupActivity.afterRank }</td></tr>
					<tr><td>活动时间：</td><td>
					<fmt:formatDate value="${groupActivity.startTime }" pattern="yyyy-MM-dd HH:mm:ss"/> 至 <fmt:formatDate value="${groupActivity.endTime }" pattern="yyyy-MM-dd HH:mm:ss"/>
					</td></tr>
				</table>
				</br></br>
				<strong style="font-size: 14px;">查询商品</strong>
				<hr></hr>
				<br/>
				所属团购活动：<select name="groupItemPage.params.actId"  style="height:24px;width:338px;">
	                        <option value="">全部团购活动</option>
	                        <c:forEach items="${acts }" var="act" varStatus="status">
								<option value="${act.id }"
									<c:if test="${act.id == groupItemPage.params.actId }"> selected = "selected" </c:if>>
									${act.name}
								</option>
							</c:forEach>
	                    </select>
						<br/></br>
				商品名称：<input type="text" style="height:24px;width:140px;" name="groupItemPage.params.name" value="${groupItemPage.params.name }"/><br/><br/>
				商品类目：<select  name="groupItemPage.params.kind1" id="bigcatalog" class="m-sel"  style="width:100px;height:24px;"><option value="-1">请选择</option></select>
						 <select class="m-sel" style="width:100px;height:24px;"  name="groupItemPage.params.kind2" id="smallcatalog"><option value="-1">请选择</option></select>
						 </br></br>
				<%--商家代码：<input type="text" style="height:24px;"/> --%>
				商家名称：<select name="groupItemPage.params.username"  style="height:24px;width:338px;">
	                        <option value="">全部商家</option>
	                        <c:forEach items="${sellers }" var="seller" varStatus="status">
								<option value="${seller.userId }"
									<c:if test="${seller.userId == groupItemPage.params.username }"> selected = "selected" </c:if>>
									${seller.companyName}
								</option>
							</c:forEach>
	                    </select>
						<br/></br>
				SKU 编码：<input type="text" id="skuCodes" name="groupItemPage.params.skuCodes" value="${groupItemPage.params.skuCodes }" 
          				class="J-keywords txt-input txt-input-w input-marks" id="searchname" style="width:330px;height:24px;" /><br/></br>
				<input type="submit" class="m-btn" value="查询" /> &nbsp;&nbsp;&nbsp;<input type="button" class="m-btn" id="backToMarketList" value="返回" /> 
			</div>
		</form>
		<form action="${_ctxPath }/seller/product/group/gp-addAllProductToActivity.htm" id="addAllProductForm" method="post">
		<div class="m-mt10p business-management">
			<div class="body-nav subnav m-mt10p" id="status_con">
				<c:if test="${empty orderPage.params.orderId}">	
					<ul class="m-clear">
						<li>
							<a onclick="allMarketProduct();" 
							<c:if test="${groupItemPage.params.listType==null || groupItemPage.params.listType=='' || groupItemPage.params.listType ==2 }"> class="current-chose"</c:if>>
								 商品列表
							</a>
						</li>
						<li>
							<a onclick="marketProduct();" 
							<c:if test="${groupItemPage.params.listType!=null && groupItemPage.params.listType==1 }"> class="current-chose"</c:if>>
								 已选商品
							</a>
						</li>
					</ul>
				</c:if>
			</div>
		  	<input type="hidden" id="hasSelectActProductIds" name="hasSelectActProductIds" value="" />
		  	<input type="hidden"  id="groupId" name="item.groupId" value="${groupItemPage.params.groupId }" />
		  	<input type="hidden"  id="actProductId" name="item.actProductId" value="" />
			<table class="tab-control" id="tab" style="clear: both;">
				<thead>
					<tr>
						<th width="2%" class="select-sku select-all-sku"> <em></em>  </th>
						<th width="8%">SKU</th>
						<th width="10%">商品名称</th>
						<th width="10%">活动名称</th>
						<th width="15%">活动开始时间</th>
						<th width="15%">活动结束时间</th>
						<th width="10%">结算价</th>
						<th width="10%">活动结算价</th>
						<th width="10%">活动结算价折扣</th>
						<th width="10%">活动价</th>
					</tr>
				</thead>
				<tbody>
				<s:iterator value="groupItemPage.result" var="pro" status="stat">
					<input type="hidden" name="productList[${stat.index}].actProductId" value="${pro.actProductId }" /> 
					<input  type="hidden" name="productList[${stat.index}].groupId" value="${groupItemPage.params.groupId }" /> 
					<input  type="hidden" name="productList[${stat.index}].skuId" value="${pro.skuId }" /> 
					<input  type="hidden" name="productList[${stat.index}].productId" value="${pro.productId }" /> 
				<tr>
				<td class="select-sku select-sub-sku"> <em id="select-sub-sku-${pro.actProductId}" actProductId="${pro.actProductId }" <c:if test="${fn:contains(skuList,pro.skuId)==true}">class="sel"</c:if>></em>  </td>
				<td>${pro.skuId } </td>
				<td>${pro.product.name }  </td>
				<td>${pro.act.name }  </td>
				<td><fmt:formatDate value="${pro.actProduct.startTime }" pattern="yyyy-MM-dd HH:mm:ss"/> </td>
				<td><fmt:formatDate value="${pro.actProduct.endTime }" pattern="yyyy-MM-dd HH:mm:ss"/>  </td>
				<td>${pro.actProduct.settlementPrice}</td>
				<td>${pro.actProduct.actSettlePrice}</td>
				<td>${pro.actProduct.actSettleDiscount}</td>
				<td>${pro.actProduct.activityPrice}</td>
				</tr>
				</s:iterator>
				<c:if test="${empty groupItemPage.result}">
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
					<c:if test="${not empty groupItemPage.result}">
						<yp:commPage page="${groupItemPage}" beanName="groupItemPage"></yp:commPage>
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
	
	if('${groupItemPage.params.skuCodes }' == null || '${groupItemPage.params.skuCodes }' == "") {
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
                if('${groupItemPage.params.kind1}' != '') {
                	$("#bigcatalog option").each(function(){
                  	   if($(this).val() == '${groupItemPage.params.kind1}'){
                  		  	//$(this).val('${groupItemPage.params.kind1}');
                  	   		$(this).attr("selected", true);
                  	   }
                  	  });
                     kind2SelectForKind1(10001,'${groupItemPage.params.kind1}');
                }
                
            }
            
        },
        "error": function () {
        //    alert('请求错误，请稍后尝试:'+url);
        }
    });
	//$("#bigcatalog").trigger("change");
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
              	   if($(this).val() == '${groupItemPage.params.kind2}'){
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
              	   if($(this).val() == '${groupItemPage.params.kind2}'){
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
	window.location.href="${_ctxPath }/admin/zone/zone-searchZone.htm";
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

//选择事件
$(".select-all-sku").on('click', function() {
	var $this = $(this);
	var $thisEm = $this.children("em");// checkbox
	// 全选
	if ($thisEm.hasClass("sel")) {
		setProductSkuIds();
		$(".select-sub-sku em.sel").removeClass("sel");
		$thisEm.removeClass("sel");
		
		 doFormSubmit(_ctxPath+'/seller/product/group/gp-removeAllProductInActivity.htm');
		 
	} else {
		//判断之前已经选择了哪些，防止重复添加
		setProductSkuIds();
		//子级
		$(".select-sub-sku em").addClass("sel");
		$thisEm.addClass("sel");
		doFormSubmit($("#addAllProductForm").attr('action'));
	}
});

var doFormSubmit = function(action){
	var form = $("#addAllProductForm");
	 $.ajax({
			type: 'POST',
			url: action,
			data: form.serialize(),
			success: function(data){
				//alert(data.info);
		    },
			dataType:'json'
		});
}

var setProductSkuIds = function(){
	var $hasSelect = $(".select-sub-sku em.sel");
	var ids = '';
	if($hasSelect.length>0){
		$hasSelect.each(function(index,ele) {
			if(index>0){
				ids += ",";
			}
			ids += $(this).attr("actProductId");
		});
	}
	$("#hasSelectActProductIds").val(ids);
}


// 点选子集
$(".select-sub-sku").on('click',function() {
	var $this = $(this);
	var $thisEm = $this.children("em");// checkbox
	$("#actProductId").val($thisEm.attr("actProductId"));
	if ($thisEm.hasClass("sel")) {
		$thisEm.removeClass("sel");
		$('.select-all-sku em').removeClass("sel");
		
		$("#hasSelectActProductIds").val($thisEm.attr("actProductId"));
		doFormSubmit(_ctxPath+'/seller/product/group/gp-removeAllProductInActivity.htm');
	} else {
		$thisEm.addClass("sel");
		doFormSubmit(_ctxPath+'/seller/product/group/gp-addProductToActivity.htm');
	}
});
</script>
</body>
</html>