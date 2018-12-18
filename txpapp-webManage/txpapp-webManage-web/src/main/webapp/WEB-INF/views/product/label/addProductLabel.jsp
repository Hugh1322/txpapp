<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../../include/taglibs.jsp"%>
<html lang="zh">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>新增商品标签</title>
<link href="${_cssPath }/common.css" rel="stylesheet" />
<link href="${_cssPath }/pages/bannerManage.css" rel="stylesheet" />
<link href="${_cssPath }/pages/bannerManage.css" rel="stylesheet" />
<link href="${_jsPath }/plugin/artdialog/skins/ytoxl.css"
	rel="stylesheet" />
<script src="${_jsPath }/jquery/jquery.1.8.1.js"></script>
<script src="${_jsPath }/plugin/artdialog/jquery.artDialog.min.js"></script>
<script type="text/javascript" src="${_jsPath}/plugin/uploadify/swfobject.js"></script>
<script type="text/javascript" src="${_jsPath}/plugin/uploadify/jquery.uploadify.v2.1.4.min.js"></script>
<script src="${_jsPath }/plugin/formvalidator/formValidatorRegex.js"></script>
<script src="${_jsPath }/plugin/formvalidator/formValidator-4.1.3.js"></script>
<script type="text/javascript" src="${_jsPath}/plugin/uploadify/swfobject.js"></script>
</head>
<body>
	<!-- 正文内容 -->
	<jsp:include page="../../include/header.jsp"></jsp:include>
	<div class="body m-w980p">
		<!-- 当前位置 -->
		<div class="curPosition" style = "margin-top:20px;">
			当前位置：<a href="${_ctxPath}/admin/productLabel/label-labelManageList.htm">商品标签管理</a>-> 新增商品标签
		</div>
		<!-- 买减管理内容 -->		 
		<form method="post" id="addProductLabelFrom" action="${_ctxPath}/admin/productLabel/label-saveProductLabel.htm">
		<input type = "hidden"  value = "${productLabel.id}" name = "productLabel.id">
			<div class="m-mt10p addBanner">
				<div class="addADV cf">
					<label><i class="red">*</i>标签名称:</label>
					<div class="infoADV">
						<input type="text" name="productLabel.labelName"  class="input_public" id="labelName" value ="${productLabel.labelName}"/><div id="labelNameTip"></div>
					</div>
				</div>
				
				<div class="rel cf">
					<label for="" class="fl"><i class="red">*</i>标签图标：</label>
					<div class="fl pNone" style="position: relative;">
						<div class="pNone rel imgBox60">
							<div class="del"></div>
							<img alt="" src="${_filePath}/${productLabel.labelImgUrl}" id="labelIcoUploadImg" style="width:100px;height: 100px;">
						</div>
						<label for="" class="fl" style="position: absolute;left:85px;"><i class="red">*</i>上传图片只能是.PNG格式</label>
						<input type="file" id="labelIcoUpload" class="txt-input" name="file" />
						<input type="hidden" id="labelImgUrl" name="productLabel.labelImgUrl" value="${productLabel.labelImgUrl}">						
						<span id="labelImgUrlTip"></span>						
					</div>
				</div>	
				<div class="addADV cf">
					<label>备注:</label>
					<div class="infoADV">
						<textarea rows="3" cols="35"  name="productLabel.remark" id="remark" maxlength="50" >${productLabel.remark}</textarea>
						<p><i class="red">*</i>最长50个字符</p>
						<div id="remarkTip"  ></div>
					</div>
				</div>				
				
				<div class="addADV cf">
					<label>&nbsp;</label>
					<div class="infoADV">
						<input type="button" id="submitFormButton" onclick="return checkForm()"value="保存" class="m-btn"/> 
							<input type="button" id="cancelForm" value="取消" onclick="window.history.go(-1)" class="m-btn" />
					</div>
				</div>

			</div>
		</form>
	</div>
<script type="text/javascript">
$(function(){
	 initCheck();
	 //图片上传
 if('${productLabel.labelImgUrl}'==''||'${productLabel.labelImgUrl}'==null){
		$('#labelIcoUploadImg').hide();
	} 
	 
 var uploadLabelIco = {
			'auto' : true,
			'buttonImg' : '${_jsPath}/plugin/uploadify/uploadimg_btn.png',
			'cancelImg' : '${_jsPath}/plugin/uploadify/cancel.png',
			'expressInstall' : '${_jsPath}/plugin/uploadify/expressInstall.swf',
			'fileDataName' : 'file',
			'fileDesc' : '请选择png文件',
			'fileExt' : '*.png',
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
	 
})
function initCheck(){
	$.formValidator.initConfig({validatorGroup:"Label",formID:"addProductLabelFrom",theme:"Default",submitOnce:false,wideWord:false,onError:function(msg,obj,errorlist){
	/* 	 $("#errorlist").empty();
		 $.map(errorlist,function(msg){
			    $("#errorlist").append("<li>" + msg + "</li>")
			   });
			   alert(msg); */
			  },
		
	});
	$("#labelName").formValidator({
		validatorGroup:"Label",
		onShow:"请输入标签名称",
		onFocus:"请输入标签名称"
		}).inputValidator({
			min:2,max:15,
			onErrorMin:"请输入标签名称大于2个字符",
			onErrorMax:"请输入标签名称小于15个字符",
			empty:{leftEmpty:false,
			rightEmpty:false,
			emptyError:"两边不能有空格"},
			onError:"请输入标签名称"
		}).ajaxValidator({
			type:"get",
			async:true, 
			dataType:"json",
			url:"${_ctxPath}/admin/productLabel/label-checkRepetitiveName.htm",
			success:function(data){
	            if(data.code == "false" ){
					return false;
	            }else{
	            	return true;
	            }
			},
			buttons: $("#submitFormButton"),
			error: function(jqXHR, textStatus, errorThrown){alert("服务器没有返回数据，可能服务器忙，请重试"+errorThrown);},
			onError : "该标签名称已存在" 
	}).defaultPassed();
		
	$("#labelImgUrl").formValidator({validatorGroup:"Label",onShow:"请上传图片",onFocus:"请上传图片"
		}).inputValidator({
			min:1,onErrorMin:"请上传图片"
		}).regexValidator({ regExp: "picture", 
		dataType: "enum", 
		onError: "图片名格式不正确" });
		
	$("#remark").formValidator({validatorGroup:"Label",onShow:"请输入备注名称",onFocus:"请输入备注名称"})
}

function checkForm(){
	var result = $.formValidator.pageIsValid('Label');
	if(!result){
		return false;
	}
	$("#addProductLabelFrom").submit();
}
</script>

</body>

</html>