<!DOCTYPE html>
<%@page language="java"
	import="com.txp.app.contants.Product"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>
<html lang="zh">
<head>
<meta charset="utf-8" />
<title>修改前台显示信息</title>
<link href="${_cssPath }/common.css" rel="stylesheet" />
<script type="text/javascript" src="${_jsPath }/jquery/jquery.1.8.1.js"></script>
<script src="${_jsPath }/plugin/formvalidator/formValidatorRegex.js"
	language="javascript"></script>
<script src="${_jsPath }/plugin/formvalidator/formValidator-4.1.3.js"
	language="javascript"></script>
<style>
.order-management {
	margin-top: 10px;
}

.order-management table {
	border: 1px solid #BFAD61;
}

.order-management table td {
	border-bottom: 1px solid #BFAD61;
	padding-left: 5px;
}

.order-management table a {
	color: #36c;
}

.centerT {
	text-align: center;
}

.hide {
	display: none;
}

.m-5 {
	margin-right: 10px;
}

.relative {
	position: relative;
}

.tip {
	position: absolute;
	display: block;
	color: #f00;
}
</style>
<body>
	<!--start header-->
	<jsp:include page="../../include/header.jsp"></jsp:include> 
	<!--end header-->
	<!--start body-->
	<div class="body m-w980p">
		<!--start form-->
		<form class="m-mt10p m-clear"  id="subform"
			action="${_ctxPath}/seller/product/group/gp-getGroupItemList.htm"
			method="post" id="subform">
			<div class="m-search" style="margin-top: 10px;">
				<span>开团前名称：${groupActivity.beforeName } | 开团后名称：${groupActivity.afterName } </span>
				<aut:authorize url="/admin/order/order-search">
					<input type="button" class="m-btn m-btn-search" value="刷新"
						id="refresh_btn" onclick="doRefresh();"/>
				</aut:authorize>
				<input id="status" type="hidden"
					name="groupItemPage.params.groupId"
					value="${groupItemPage.params.groupId}" />
				<aut:authorize url="/admin/order/order-exportOrders">
					<input type="button" class="m-btn" value="导出" id="export" />
				</aut:authorize>
				
				<span class="m-fr curr-num"> 
				<label>当前显示： </label>
					<c:if test="${not empty groupItemPage.result}">
		              <label >当前显示：</label>
		              <yp:commPageSize page="${groupItemPage}" beanName="groupItemPage"></yp:commPageSize><br/>
		           	</c:if>
			    </span>
			</div>
		</form>
		<!--start 品牌管理table-->
		<div class="m-mt10p  order-management">
			<table class="tab-control">
				<thead class="tab-control">
					<tr>
						<th width="10%">商品SKU</th>
						<th width="10%">商品名称</th>
						<th width="10%">初始已售出件数</th>
						<th width="10%">实际已售出件数</th>
						<th width="10%">初始想买人数</th>
						<th width="10%">实际想买人数</th>
						<th width="10%">锚点值</th>
						<th width="10%">锚点名称</th>
						<th width="10%">权重</th>
						<th width="10%">操作</th>
					</tr>
				</thead>
				<tbody>
					<c:choose>
						<c:when test="${empty groupItemPage.result}">
							<tr>
								<td id="no_result" colspan="12">无相关数据！</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach items="${groupItemPage.result}" var="item"
								varStatus="status">
								<tr class="list-tr">
									<td>${item.skuId}</td>
									<td>${item.productName}</td>
									<td>
										<div class="relative">
											<span class="input_span_${item.id}"id="J_quantitySpan_${item.id}" class="J_len">${item.frontQuantity}</span>
											<input style="width: 120px;" id="J_quantity_${item.id}"  type="text" value="" maxLength="5" class="hide J_input txt-input" /> 
											<span id="J_quantity_tip_${item.id}" class="J_tip tip"></span>
										</div>
									</td>
									<td>${item.quantity}</td>
									<td><span class="input_span_${item.id}" id="J_psersonSpan_${item.id}">${item.frontPersonCount}</span>
										<input style="width: 120px;" id="J_person_${item.id}" type="text" value="" maxLength="5"  class="hide J_input txt-input" />
										<span id="J_person_tip_${item.id}" class="J_tip tip"></span> 
									</td>
									<td>${item.personCount}</td>
									<td><span class="input_span_${item.id}" id="J_anchorSpan_${item.id}">${item.anchor}</span>
										<input style="width: 120px;" id="J_anchor_${item.id}" type="text" value="" maxLength="5"  class="hide J_input txt-input" />
										<span id="J_anchor_tip_${item.id}" class="J_tip tip"></span> 
									</td>
									<td><span class="input_span_${item.id}" id="J_anchorNameSpan_${item.id}">${item.anchorName}</span>
										<input style="width: 120px;" id="J_anchorName_${item.id}" type="text" value="" maxLength="5"  class="hide  txt-input" />
										<span id="J_anchorName_tip_${item.id}" class="J_tip tip"></span> 
									</td>
									<td><span class="input_span_${item.id}" id="J_heavySpan_${item.id}">${item.heavy}</span>
										<input style="width: 120px;" id="J_heavy_${item.id}" type="text" value="" maxLength="5"  class="hide J_input txt-input" />
										<span id="J_heavy_tip_${item.id}" class="J_tip tip"></span> 
									</td>
									<td>
									<a href="javascript:" class="J_change" id="edit_button_${item.id}" lang="${item.id}" >修改件数人数</a> <a
								       href="javascript:" class="J_save J_a m-5 hide" lang="${item.id}" >保存</a> <a
								       href="javascript:" class="J_cancel J_a hide" lang="${item.id}" >取消</a>
									</td>
								</tr>
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</tbody>
			</table>
		</div>
		<!--end 品牌管理table-->
		<div class="table-bm-wrap cf">
			<div class="fn-right">
				<div class="pagination pagination-right">
					<c:if test="${not empty groupItemPage.result}">
						<yp:commPage page="${groupItemPage}" beanName="groupItemPage"></yp:commPage>
					</c:if>
				</div>
			</div>
		</div>
	</div>
	<!--end body-->
</body>
<jsp:include page="/WEB-INF/views/include/foot.jsp"></jsp:include>
<script type="text/javascript">
$(function() {
	//修改
	$(".J_change").on("click", function() {
		var id = $(this).attr("lang");
		$('.input_span_'+id).hide();
		
		$("#J_quantity_"+id).show();
		$("#J_person_"+id).show();
		$("#J_anchor_"+id).show();
		$("#J_anchorName_"+id).show();
		$("#J_heavy_"+id).show();
		
		$("#J_quantity_"+id).val($("#J_quantitySpan_"+id).html());
		$("#J_person_"+id).val($("#J_psersonSpan_"+id).html());
		$("#J_anchor_"+id).val($("#J_anchorSpan_"+id).html());
		$("#J_anchorName_"+id).val($("#J_anchorName_"+id).html());
		$("#J_heavy_"+id).val($("#J_heavySpan_"+id).html());
		
		$(this).hide();
		$(this).siblings().show();
		
	});
	//取消
	$(".J_cancel").on("click", function() {
		var id = $(this).attr("lang");
		$("#edit_button_"+id).show();
		$("#edit_button_"+id).siblings().hide();
		
		$('.input_span_'+id).show();
		
		$("#J_quantity_"+id).hide();
		$("#J_person_"+id).hide();
		$("#J_anchor_"+id).hide();
		$("#J_anchorName_"+id).hide();
		$("#J_heavy_"+id).hide();
	});
	//保存
	$(".J_save").on("click", function() {
		var id = $(this).attr("lang");
		var quanTip = $("#J_quantity_tip_"+id).html();
		var personTip = $("#J_person_tip_"+id).html();
		var anchorTip = $("#J_anchor_tip_"+id).html();
		var anchorNameTip = $("#J_anchorName_tip_"+id).html();
		if(quanTip!='' || personTip!=''|| anchorTip!=''|| anchorNameTip!=''){
			return false;
		}
		var url = _ctxPath+"/seller/product/group/gp-updateGroupItem.htm"
		$.ajax({
			type:'POST',
			url: url,
			async:false,
			data:{
				"item.id":id,"item.frontQuantity":$("#J_quantity_"+id).val(),
				"item.frontPersonCount":$("#J_person_"+id).val(),
				"item.anchor":$("#J_anchor_"+id).val(),
				"item.anchorName":$("#J_anchorName_"+id).val(),
				"item.heavy":$("#J_heavy_"+id).val()
				},
			success:function(msg){
				if(msg.code == "true"){
					alert("修改前台显示信息成功！");
				}else if(msg.code == "false"){
					submitStatus = true;
					alert("修改前台显示信息数失败，请重试！");
				}
			},
			error: function(xhr){
				submitStatus = true;
				alert("修改前台显示信息失败，请重试！");
	        }
		});
		doRefresh();
	});
	//正则验证
	$(".J_input").blur(function() {
		var $this = $(this);
		var $tip = $(this).next();
		var reg = /^(0||[1-9]{1}[0-9]{0,4})$/;
		var value = $.trim($(this).val());
		if (value == "") {
			$tip.html("不能为空");
			return false;
		} else {
			if (!reg.test(value)) {
				$tip.html("请输入0-99999的正整数");
				return false;
			} else {
				$tip.html("");
			}
		}
	});
	$(".J_input").focus(function() {
		var $this = $(this);
		var $tr = $this.parents("tr");
		var $tip = $tr.find(".J_tip");
		$tip.html("");
	});
});

function doRefresh(){
	$("#subform").submit();
	$("#subform").submit();
	$.dialog({
		title : false,
		content : "刷新成功！",
		time : 2000
	});
}

$('#export').bind('click', function() {
	if($("#no_result").length !=0 ){
	    alert("无相关记录,不能导出！");
		return;
	}
	$('#subform').attr("action","${_ctxPath}/seller/product/group/gp-exportGroupItemList.htm");
	$('#subform').submit();
	$('#subform').attr("action","${_ctxPath}/seller/product/group/gp-getGroupItemList.htm");
});
</script>

</html>