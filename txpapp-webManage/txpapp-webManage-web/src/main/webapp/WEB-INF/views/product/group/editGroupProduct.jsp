﻿<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8" import="com.txp.app.contants.Prop" pageEncoding="UTF-8"%>
<%@page import="com.txp.app.contants.Product" %>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>
<html lang="zh">
<head>
<meta charset="utf-8" />
<title>新增团购商品</title>
	<link href="${_cssPath }/common.css" rel="stylesheet" />
	<link href="${_cssPath }/pages/bannerManage.css" rel="stylesheet" />
  	<link href="${_cssPath }/pages/addProduct.css" rel="stylesheet" />
  	<script type="text/javascript" src="${_jsPath }/jquery/jquery.1.8.1.js"></script>
  	<script type="text/javascript" src="${_jsPath}/plugin/uploadify/swfobject.js"></script>  
	<script type="text/javascript" src="${_jsPath}/plugin/uploadify/jquery.uploadify.v2.1.4.min.js"></script>
	<script type="text/javascript" src="${_jsPath }/plugin/ckeditor/ckeditor.js"></script>
	<script type="text/javascript" src="${_jsPath }/plugin/My97DatePicker/WdatePicker.js"></script>
	<script type="text/javascript" src="${_jsPath }/plugin/formvalidator/formValidatorRegex.js"></script>
  	<script type="text/javascript" src="${_jsPath }/plugin/formvalidator/formValidator-4.1.3.js"></script>
  	<script type="text/javascript">
  	 
  	</script>
  	<script type="text/javascript" src="${_jsPath }/pages/jquery.select.js"></script>
  	<style type="text/css">
  	
  	.skuTable {
	width: 700px
}

.skuTable th {
	height: 26px;
	line-height: 26px;
	background: #000;
	color: #fff;
	text-align: center;
	border-right: 1px solid #000
}

.skuTable td {
	height: 36px;
	text-align: center;
	border-left: 1px solid #bfad61;
	border-bottom: 1px solid #bfad61;
	border-right: 1px solid #bfad61
}

.skuTable-num {
	width: 60px;
	padding: 0 5px
}

.skuTable-width {
	width: 150px
}
  	</style>
  	
  </head>	
<body>
<!--start header-->
<jsp:include page="../../include/header.jsp"></jsp:include> 
<!--end header-->
<!--start body-->
<div class="body m-w980p">
	<form id="addForm" method="post" target="_blank" >
	<input id="id" name="item.id" value="${ item.id}" type="hidden" >
	<input id="skuId" name="item.skuId" value="${ item.skuId}" type="hidden" >
	<input id="brandId" name="item.brandId" value="${ item.brandId}" type="hidden" >
	<input id="area" name="item.area" value="${ item.area}" type="hidden" >
	<input id="kind" name="item.kind" value="${ item.kind}" type="hidden" >
	<input id="spec" name="item.spec" value="${ item.spec}" type="hidden" >
	<input id="spec" name="item.groupProductId" value="${ item.groupProductId}" type="hidden" >
	<input name="item.productStatus" value="${ product.status}" type="hidden" >
		<table border="0" class="addPro-table">
			<tr>
				<th width="145" class="left-td">商品属性</th>
				<th width="130">&nbsp;</th>
				<th width="160">&nbsp;</th>
				<th width="343">&nbsp;</th>
			</tr>
			<tr>
				<td class="left-td">*销售方式：</td>
				<td colspan="2" id="xsfs">团购</td>
			</tr>
			<tr>
				   <td class="left-td">
					<label for=""><i class="red">*</i>可销售品牌：</label> 
					</td>
					<td colspan="4" id="xsfs">
					<a href="javascript:void(0);" onclick="queryProduct('A')">A</a> 
					<a href="javascript:void(0);" onclick="queryProduct('B')">B</a> 
					<a href="javascript:void(0);" onclick="queryProduct('C')">C</a> 
					<a href="javascript:void(0);" onclick="queryProduct('D')">D</a> 
					<a href="javascript:void(0);" onclick="queryProduct('E')">E</a> 
					<a href="javascript:void(0);" onclick="queryProduct('F')">F</a> 
					<a href="javascript:void(0);" onclick="queryProduct('G')">G</a> 
					<a href="javascript:void(0);" onclick="queryProduct('H')">H</a> 
					<a href="javascript:void(0);" onclick="queryProduct('I')">I</a> 
					<a href="javascript:void(0);" onclick="queryProduct('J')">J</a> 
					<a href="javascript:void(0);" onclick="queryProduct('K')">K</a> 
					<a href="javascript:void(0);" onclick="queryProduct('L')">L</a> 
					<a href="javascript:void(0);" onclick="queryProduct('M')">M</a> 
					<a href="javascript:void(0);" onclick="queryProduct('N')">N</a> 
					<a href="javascript:void(0);" onclick="queryProduct('O')">O</a> 
					<a href="javascript:void(0);" onclick="queryProduct('P')">P</a>
					<a href="javascript:void(0);" onclick="queryProduct('Q')">Q</a> 
					<a href="javascript:void(0);" onclick="queryProduct('R')">R</a> 
					<a href="javascript:void(0);" onclick="queryProduct('S')">S</a> 
					<a href="javascript:void(0);" onclick="queryProduct('T')">T</a> 
					<a href="javascript:void(0);" onclick="queryProduct('U')">U</a> 
					<a href="javascript:void(0);" onclick="queryProduct('V')">V</a> 
					<a href="javascript:void(0);" onclick="queryProduct('W')">W</a> 
					<a href="javascript:void(0);" onclick="queryProduct('X')">X</a> 
					<a href="javascript:void(0);" onclick="queryProduct('Y')">Y</a> 
					<a href="javascript:void(0);" onclick="queryProduct('Z')">Z</a>
				</td>
			</tr>
			<tr>
			<td colspan="5">
				<div class="addsanpUp">
					<div class="cf seller" id="prolist"></div>
				</div> 
				<!-- <div class="cf seller" id="prolist"></div>
				<ul class="cf qzBox" id="qzBox"></ul> -->
			</td>
			</tr>
			<tr>
				<td class="left-td"><i class="red">*</i>品牌：</td>
				<td>
						 <input id="brandName"  disabled="disabled"/>  					 
				</td>
				<td colspan="2"><span id="brandIdTip"></span></td>
			</tr>
			<tr id='zpf'>
				<td class="left-td"><i class="red">*</i>所在地区：</td>
				<td colspan="2">
					<input id="p_province" disabled="disabled" value=""/>  					 
					<input id="p_city"  disabled="disabled" value=""/>  					 
				</td>
				<td> </td>
			</tr>
			<tr>
				<td class="left-td"><i class="red">*</i>分类：</td>
				<td colspan="2">
					<input name="bigcatalog" id="p_bigcatalog" value="" disabled="disabled"></input>
					<input name="smallcatalog" id="p_smallcatalog" value="" disabled="disabled"></input>
				</td>
				<td><span id="smallcatalogTip"></span></td>
			</tr>
			<tr>
				<td class="left-td"><i class="red">*</i>商品前台显示名称：</td>
				<td colspan="2"><input type="text" class="pro-name" name="item.productName" value="${item.productName }" id="name"/></td>
				<td><span id="nameTip"></span></td>
			</tr>
			<tr>
				<td class="left-td"><i class="red">*</i>商品后台显示名称：</td>
				<td colspan="2"><textarea style="width:400px;height:100px;" maxlength="200" name="item.productAlias" id="aliasName">${item.productAlias }</textarea></td>
				<td><span id="aliasNameTip"></span></td>
			</tr>
			<tr id="qgNum">
				<td class="left-td"><i class="red">*</i>限团数量：</td>
				<td colspan="2"><input type="text" class="pro-name" name="item.limitQuantity" value="${item.limitQuantity }" id="rushQuantity"/></td>
				<td><span id="rushQuantityTip"></span></td>
			</tr>
			<tr>
				<td class="left-td">推荐理由：</td>
				<td colspan="3">
					<textarea style="width:700px;" maxlength="150" name="item.recommendedReason" id="recommendedReason">${item.recommendedReason}</textarea>
				</td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td colspan="3">
					<span class="small">温馨提示：推荐理由字数最多是150个中文字</span>
				</td>
			</tr>
			 
			<tr>
				<td></td>
				<td colspan="3">
					<span id="sizeTip"></span>
				</td>
			</tr>
			<tr>
				<td class="left-td">*库存：</td>
				<td colspan="2">
					
					<input type="radio" class="input-radio" name="item.isShowInventory" checked="checked" value="0">
					<label><small>不显示</small></label>
					<input type="radio" class="input-radio" name="item.isShowInventory" value="1">
					<label><small>显示</small></label>
					
				</td>
				<td></td>
			</tr>
			<tr valign="top">
				<td colspan="4" class="small" align="center">
					<table>
						<tr  >
							<td width="450" >
								<table class="skuTable" width="630" class="small">
									<tr>
									 
										<th style="width:100px;">*规格</th>
										<th>*重量</th>
										<th>*库存数</th>
										<th>*团购库存数</th>
										<th>*商品标识</th>
										<th>*团购价</th>
										<th>*售卖价</th>
										<th>*原价</th>
									</tr>
									<tr>
										<td  id="skuSpecification"> ${product.productSku.skuSpecification }</td>
										<td id="p_weitht"> </td>
										<td id="inventory"> ${product.productSku.inventory }</td>
										<td >
										<input style="width: 50px" id="quantity" type="text"  name="item.inventory" value="${item.inventory }" ></td>
										<td id="skuCode">${product.productSku.skuCode } </td>
										<td ><input style="width: 50px" id="price" name="item.price" type="text" value="${item.price}"  ></td>
										<td id="unitPrice"> ${product.productSku.unitPrice} </td>
										<td id="marketPrice"> ${product.productSku.marketPrice}</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr valign="top" class="small">
				<td class="left-td">*商品图片：</td>
				<td colspan="3">
					<table class="no-border-table" >
						<tr>
							<td width="120">
								<div class="default-img">
									<div class="del-img"></div>
									<!-- <i class="img-prev"></i>
									<i class="img-next"></i> -->
								</div>
								<input type="hidden" name="productImg" id="fontImgUrl" class="imageUrl"/>
								<input type="file" id="fontImgUpload"/>
							</td>
							 <td width="120">
								<div class="default-img">
									<div class="del-img"></div>
									<i class="img-prev"></i>
									<i class="img-next"></i>
								</div>
								<input type="hidden" name="productImg" id="backImgUrl" class="imageUrl"/>
								<input type="file" id="backImgUpload"/>
							</td>
							<td width="120">
								<div class="default-img">
									<div class="del-img"></div>
									<i class="img-prev"></i>
									<i class="img-next"></i>
								</div>
								<input type="hidden" name="productImg" id="styleImgUrl" class="imageUrl"/>
								<input type="file" id="styleImgUpload"/>
							</td>
							<td width="120">
								<div class="default-img">
									<div class="del-img"></div>
									<i class="img-prev"></i>
									<i class="img-next"></i>
								</div>
								<input type="hidden" name="productImg" id="workmanshipImgUrl" class="imageUrl"/>
								<input type="file" id="workmanshipImgUpload"/>
							</td>
							<td width="120">
								<div class="default-img">
									<div class="del-img"></div>
									<i class="img-prev"></i>
									<i class="img-next"></i>
								</div>
								<input type="hidden" name="productImg" id="fiveImgUrl" class="imageUrl"/>
								<input type="file" id="fiveImgUpload"/>
							</td> 
							<td valign="bottom" id="no_img"><span id="imgUrlTip"></span></td>
						</tr>
						<tr>
							<td colspan="5">温馨提示：为保证图片效果请上传510px X 510px的商品图片</td>
						</tr>
						
					</table>
				</td>
			</tr>
			<tr valign="top" class="small">
				<td class="left-td">商品描述：</td>
				<td colspan="3">
					<textarea class="edit-textarea" maxlength="1000" name="item.desc" id="item_description">${item.desc }</textarea>
					
				</td>
			</tr>
			<tr>
				<td></td>
				<td colspan="2"><span id="descriptionTip"></span></td>
				<td></td>
			</tr>
			<tr>
				<td></td>
				<td colspan="3">
					<div class="cilck-tip">
							<input type="button" class="m-btn" value="保&nbsp;&nbsp;存" id="save" />
							<input type="button" class="m-btn" value="提交审核" id="submitReview"/>
						<div class="tip-main">
							<i class="save-succseed"></i><span id="message"></span>
						</div>
					</div>
				</td>
			</tr>
		</table>
	</form>
</div>
<!--end body-->
<!--start footer-->
<jsp:include page="/WEB-INF/views/include/foot.jsp"></jsp:include>
<!--end footer-->

<script type="text/javascript">
	var STATUS_DRAFT = <%= Product.STATUS_DRAFT%>;
	var STATUS_CHECK_PEND = <%= Product.STATUS_CHECK_PEND%>;
	var editvar = CKEDITOR.replace("item_description");
	//图片上传操作
	var uploadDefaultParams = {
			'auto' : true,
			'buttonImg' : '${_jsPath}/plugin/uploadify/uploadimg_btn.png',
			'cancelImg' : '${_jsPath}/plugin/uploadify/cancel.png',
			'expressInstall' : '${_jsPath}/plugin/uploadify/expressInstall.swf',
			'fileDataName'   : 'file', 
			'fileDesc' : '请选择jpg、gif、png文件',
			'fileExt' : '*.jpg;*.jpeg;*.gif;*.png',
		    'height' : 20,
		    'multi' : false,
		    'script' : '${_ctxPath}/upload/upload.htm',
		    'sizeLimit' : 2097152,    
		    'uploader' : '${_jsPath}/plugin/uploadify/uploadify.allglyphs.swf',
		    'width' : 94,
		    'scriptData'  : {'category':'product'}
	};
	 var multiUploadParams = {
			'auto' : true,
			'buttonImg' : '${_jsPath}/plugin/uploadify/uploadimg_btn.png',
			'cancelImg' : '${_jsPath}/plugin/uploadify/cancel.png',
			'expressInstall' : '${_jsPath}/plugin/uploadify/expressInstall.swf',
			'fileDataName'   : 'file', 
			'fileDesc' : '请选择jpg、gif、png文件',
			'fileExt' : '*.jpg;*.jpeg;*.gif;*.png',
		    'height' : 20,
		    'multi' : true,
		    'script' : '${_ctxPath}/upload/upload.htm',
		    'sizeLimit' : 2097152,    
		    'uploader' : '${_jsPath}/plugin/uploadify/uploadify.allglyphs.swf',
		    'width' : 94,
		    'queueSizeLimit' : 5,
		    'scriptData'  : {'category':'product'}
	};
	
	//商品图片上传
	$.each($(".no-border-table").find(":file"),function(i,obj){
		var uploadImgParams = uploadDefaultParams;
		uploadImgParams.onComplete = function(event, ID, fileObj, response, data){
			var $td = $(obj).closest("td");
			//移除原有图片
			$td.find(".default-img").find("img").remove();
			//得到缩略图url
			var suffix = response.split(".")[1];
			var url = '${_fileThumbPath}' + response + "_t84." + suffix;
			
			$td.find(".del-img").after("<img src='"+url+"'/>");
			$td.find(".imageUrl").val(response);
	     };
		 $(obj).uploadify(uploadImgParams);
	});
	
	//商品图片批量上传
	var uploadMultiImgParams = multiUploadParams;
	var index = 0;
	uploadMultiImgParams.onComplete = function(event, ID, fileObj, response, data){
    	var $td = $(".no-border-table td").eq(index++);
		$td.find(".imageUrl").val(response);
		if(index > 4){
			index = 0;
		}
	};
	uploadMultiImgParams.onAllComplete = function(event, data){
		var i = 0;
		var timer = setInterval(function(){
			if(i == 4){
				clearInterval(timer);
			}
			var $td = $(".no-border-table td").eq(i);
	    	$td.find(".default-img").find("img").remove();
	    	var url = $td.find(".imageUrl").val();
			if(url){
				var suffix = url.split(".")[1];
				var thumbUrl = '${_fileThumbPath}' + url + "_t15." + suffix;
				$td.find(".del-img").after("<img src='" + thumbUrl + "'/>");	
			}
			i++;
		},500);
	};
	$("#uploadBatch").uploadify(uploadMultiImgParams); 
	
// 	if(sellType == ""){
		$.each($('#xsfs').find('.xs'),function(index,data){
		    if(data.checked){
		    	changeTimeStatus(data.value);
		    	sellType = data.value;
		    	if(sellType=="3"){
		    		 $("#qgNum").show();
		    	}
		    	if(sellType=="2"){
		    		$("#time").show();
		    	}
		    }
		});
// 	}else{
// 		if(sellType == '1' || sellType == '3'){
// 			changeTimeStatus(sellType);
// 		}
// 	}
	// 售卖类型
	var sellTypeVal = $("#sellTypeVal").val();
	
	// 销售
	if(sellTypeVal ==3){
		$("#qgNum").show();
	}
	
	// 预售
	if(sellTypeVal==2){
		$("#time").show();
	}	
	//验证
	$.formValidator.initConfig({validatorGroup: 'gp',formID:"addForm",theme:"Default",forceValid:true,submitOnce:false,errorFocus:true,wideWord:false});
	$("#skuId").formValidator({validatorGroup: 'gp'}).inputValidator({min:1,onError: function(){alert("请选择产品");}});
	$("#name").formValidator({validatorGroup: "gp",onFocus:"请填写1-100位字数组成的商品名称"}).inputValidator({min:1,max:100,empty:{leftEmpty:false,rightEmpty:false,emptyError:"两边不能有空格"},onError:"请填写1-100位字数组成的商品名称"}).regexValidator({ regExp: "^[\u4E00-\u9FA5A-Za-z0-9/*-/(/)（）/$@/{/}%_\\s\(\)]+$", onError: "请填写1-100位字数组成的商品名称" });
	$("#aliasName").formValidator({validatorGroup: "gp",onFocus:"商品前台显示名称为1-200个字符组成"}).inputValidator({min:1,max:200,empty:{leftEmpty:false,rightEmpty:false,emptyError:"两边不能有空格"},onError:"商品前台显示名称为1-200个字符组成"});
	$("#quantity").formValidator({validatorGroup: "gp"}).inputValidator({empty:{leftEmpty:false,rightEmpty:false,emptyError:"两边不能有空格"},onError:"请输入正确的团购库存数"}).regexValidator({ regExp: "intege1", dataType:"enum", onError: "请输入正确的团购库存数" });
	$("#rushQuantity").formValidator({validatorGroup: "gp",onFocus:"限购数量最多为1-99"}).inputValidator({min:1,max:2,empty:{leftEmpty:false,rightEmpty:false,emptyError:"两边不能有空格"},onError:"限购数量最多为1-99"}).regexValidator({ regExp: "intege1", dataType:"enum", onError: "限购数量最多为1-99" });
	$("#price").formValidator({validatorGroup: "gp",onFocus:"请输入正确的金额"}).inputValidator({empty:{leftEmpty:false,rightEmpty:false,emptyError:"两边不能有空格"} }).regexValidator({ regExp: "num", dataType:"enum", onError: function(){alert("请输入正确的金额");} });
	$(".imageUrl").formValidator({validatorGroup: "gp",tipID:"imgUrlTip", onFocus: "请上传完整的商品展示图片", onCorrect: "谢谢你的合作，你的图片名正确" })
	.functionValidator({
		fun:function() {
			if($(".no-border-table .default-img img").length == 0){
				return "请上传完整的商品展示图片";
			}
		}
	});
	 
	// 查询首字母对应品牌商品
	var queryProduct = function(brandNo){
		$("#firstChar").val(brandNo);
		zid = $("#zoneId").val();
		var urlPath = _ctxPath+"/seller/product/group/gp-listSku.htm";
		var brand_temp = "p-list";
		$.ajax({
			url : urlPath,
			type : "POST",
			data :  {'firstChar' : brandNo},
			dataType : "html",
			success : function(res) {
				if(res!='' && res!=null){
					var data="<div id=\""+brand_temp+"\" class=\"seller_list cf\">"+res+"</div>";
					$("#prolist").html("");
					$("#qzBox").html("");
					$("#prolist").append($(data));
					
					//预览价格和规格
					$(".J_msg").hover(function(){
						$(this).find(".defaSku").show();
					},function(){
						$(this).find(".defaSku").hide();
					});
					//
					$("#prolist ul").each(function(){
						var num=$(this).find("li").length;
						$(this).find("li").each(function(i){
							$(this).css("z-index",num-i);	
						})
						
					});
					var items=$(".pid"); // 选上ID
					var arr =[];
					$.each(items,function(){
						arr.push($(this).val());
					});
					for(var i=0;i<arr.length;i++){
						$(".seller li[data-id='"+arr[i]+"']").find(".subCheck").prop("checked",true);
					}
					//
					var ohtml="";
					$("input[type=radio][class=subCheck]").click(function(){
						initSkuInfo($(this).val());
						initProductInfo($(this).val());
					});
					//$("#qzBox").append(ohtml);
					//$("#"+brand_temp).show();
				}
			},
			error : function(res) {
				alert(res.responseText);
			}
		});
	}
	
	function initSkuInfo(skuId){
		$("#skuId").val(skuId);
		$("#skuSpecification").html($("#skuSpecification_"+skuId).val());
		$("#weight").html($("#weight_"+skuId).val());
		$("#inventory").html($("#quantity_"+skuId).val());
		$("#skuCode").html($("#skuCode_"+skuId).val());
		$("#unitPrice").html($("#unitPrice_"+skuId).val());
		$("#marketPrice").html($("#marketPrice_"+skuId).val());
		 
		
	}
	
	function initProductInfo(skuId){
		$.ajax({
			url :  _ctxPath+"/seller/product/group/gp-queryProInfo.htm",
			type : "POST",
			data :  {'skuId' : skuId},
			dataType : "json",
			success : function(message) {
				var product = eval('('+message.info+')')
				 $("#brandName").val(product.brand.name);
				 $("#p_province").val(product.propsMap["area"][0].name);
				 $("#p_city").val(product.propsMap["area"][1].name);
				 $("#p_bigcatalog").val(product.propsMap["catalog"][0].name);
				 $("#p_smallcatalog").val(product.propsMap["catalog"][1].name);
				 //$("#aliasName").val(product.aliasName);
				 //$("#name").val(product.name);
				 $("#recommendedReason").val(product.recommendedReason);
				 $("#p_weitht").html(product.productSku.skuWeight);
				 $("#skuCode").html(product.productSku.sellerSkuCode);
				 $("#brandId").val(product.brand.brandId);

		

				 editvar.setData(product.description);
				
				<c:forEach items="${item.imageList }" var="imageUrl" varStatus="status">
				<c:set var="suffix" value="${fn:split(imageUrl, '.')[1]}"></c:set>
				var $del_img = $(".no-border-table .del-img").eq(${status.index});
				$del_img.after("<img src='${_fileThumbPath}${imageUrl}_t84.${suffix}'/>");
				var $td = $del_img.closest("td");
				$td.find(".imageUrl").val("${imageUrl}");
				</c:forEach>

				 
			}
		});
	}
	
	
	$("#submitReview").click(function(){
		subForm( _ctxPath + '/seller/product/group/gp-editCheck.htm');
	});
	
	$("#save").click(function(){
		subForm( _ctxPath + '/seller/product/group/gp-save.htm');
	});
	
	function subForm(url){
		var result = $.formValidator.pageIsValid('gp');
		if(!result){
			return;
		}
		var message_pand = CKEDITOR.instances.item_description.getData();
		 $("#item_description").val(message_pand);
		$.ajax({
			type:'POST',
			url:url,
			data: $("#addForm").serialize(),
			success:function(msg){
				alert(msg.info);
				if(msg.code =="true"){
				   window.location.replace(_ctxPath + '/seller/product/product-searchSellerProducts.htm');
				}
			},
			error: function(xhr){
				popupDialog(xhr.responseText);
				submitStatus = true;
	        }
		});
		
	}
	
	//如果有上传图片，显示交换按钮
	$(".default-img").hover(function(){
		if($(this).find("img")[0]){
			$(this).find("i").show();
			$(this).find(".del-img").show();
		}
	},function(){
		$(this).find("i").hide();
		$(this).find(".del-img").hide();
	});
	//图片向前排序
	$(".img-prev").on("click",function(){
		var this_td = $(this).parent().parent();
		var prev_td = $(this_td).prev("td");
		$(prev_td).before(this_td);
	});
	//图片向后排序
	$(".img-next").on("click",function(){
		var this_td = $(this).parent().parent();
		var next_td = $(this_td).next("td");
		var no_img = $(next_td).attr("id");
		if(no_img != "no_img"){
			$(next_td).after(this_td);
		}
	});
	//删除图片
	$(".del-img").on("click",function(){
		$(this).next("img").remove();
		$(this).closest("td").find(".imageUrl").val("");
	});
</script>

<script type="text/javascript">
	$(function(){
		var skuid = $("#skuId").val();
		initProductInfo(skuid);
	});

</script>
</body>
</html>