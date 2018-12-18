<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../../include/taglibs.jsp"%>
<html lang="zh">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>新增商品频道</title>
<link href="${_cssPath }/common.css" rel="stylesheet" />
<link href="${_cssPath }/pages/bannerManage.css" rel="stylesheet" />
<link href="${_cssPath }/pages/bannerManage.css" rel="stylesheet" />
<link href="${_jsPath }/plugin/artdialog/skins/ytoxl.css"
	rel="stylesheet" />
<script src="${_jsPath }/jquery/jquery.1.8.1.js"></script>
<script src="${_jsPath }/plugin/artdialog/jquery.artDialog.min.js"></script>
<script src="${_jsPath }/plugin/formvalidator/formValidatorRegex.js"></script>
<script src="${_jsPath }/plugin/formvalidator/formValidator-4.1.3.js"></script>
<script type="text/javascript"
	src="${_jsPath}/plugin/uploadify/swfobject.js"></script>
</head>
<body>
	<!-- 正文内容 -->
	<jsp:include page="../../include/header.jsp"></jsp:include>
	<div class="body m-w980p">
		<!-- 当前位置 -->
		<div class="curPosition" style = "margin-top:10px;">
			当前位置：<a href="${_ctxPath}/admin/productChannel/channel-channelManagerList.htm">商品频道管理</a>->新增商品频道
		</div>
		<!-- 买减管理内容 -->		 
		<form method="post" id="addProductChannelFrom" action="${_ctxPath}/admin/productChannel/channel-saveProductChannel.htm">
		<input type = "hidden"  value = "${channel.id}" name = "channel.id">
			<div class="m-mt10p addBanner">
				<div class="addADV cf">
					<label><i class="red">*</i>频道名称:</label>
					<div class="infoADV">
						<input type="text" name="channel.channelName"  class="input_public" id="channelName" value ="${channel.channelName}"/><div id="channelNameTip"></div>
					</div>
				</div>
				
				<div class="addADV cf">
					<label>备注:</label>
					<div class="infoADV">
						<textarea rows="3" cols="35"  name="channel.remark" id="remark" maxlength="50" >${channel.remark}</textarea>
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
})
function initCheck(){
	$.formValidator.initConfig({validatorGroup:"channel",formID:"addProductChannelFrom",theme:"Default",submitOnce:false,wideWord:false,onError:function(msg,obj,errorlist){
		/*  $("#errorlist").empty();
		 $.map(errorlist,function(msg){
			    $("#errorlist").append("<li>" + msg + "</li>")
			   });
			   alert(msg); */
			  },
		
	});
	$("#channelName").formValidator({
		validatorGroup:"channel",
		onShow:"请输入频道名称",
		onFocus:"请输入频道名称"	
	}).inputValidator({
		min:2,max:15,
		onErrorMin:"请输入大于2个字符",
		onErrorMax:"请输入小于15个字符",
		empty:{leftEmpty:false,
		rightEmpty:false,
		emptyError:"两边不能有空格"},
		onError:"请输入频道名称"
	}).ajaxValidator({
		type:"get",
		async:true, 
		dataType:"json",
		url:"${_ctxPath}/admin/productChannel/channel-checkRepetitiveName.htm",
		success:function(data){
            if(data.code == "false" ){
				return false;
            }else{
            	return true;
            }
		},
		buttons: $("#submitFormButton"),
		error: function(jqXHR, textStatus, errorThrown){alert("服务器没有返回数据，可能服务器忙，请重试"+errorThrown);},
		onError : "该频道名称已存在" 
	}).defaultPassed();
		
	$("#remark").formValidator({validatorGroup:"channel",onShow:"请输入备注名称",onFocus:"请输入备注名称"	});
}

function checkForm(){
	var result = $.formValidator.pageIsValid('channel');
	if(!result){
		return false;
	}
	$("#addProductChannelFrom").submit();
}
</script>

</body>

</html>