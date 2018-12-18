<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@include file="../include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div id="locSubInput">
	<div class="addADV cf">
		<label for=""><i class="red">*</i>父权限：</label>
		<div class="infoADV leftFloat"    >
			${parentName}
			<input type="hidden" id="parentId"
				   name="parentId" value="${rule.parentId}">
			<div id="labelTextTip2" ></div>
		</div>
	</div>
	<div class="addADV cf">
		<label for=""><i class="red">*</i>权限代码：</label>
		<div class="infoADV leftFloat">
			<input type="text"  style="width: 150px ;"  name="ruleCode" value="${rule.ruleCode}" readonly id="originalPrice2" class="locSubInput"/>
			<div id="originalPriceTip2"  ></div>
		</div>
	</div>
	<div class="addADV cf">
		<label for=""><i class="red">*</i>权限名称：</label>
		<div class="infoADV leftFloat">

			<input type="text"  style="width: 150px"  name="ruleName" value="${rule.ruleName}" id="currentPrice2" class="locSubInput"/>
			<div id="currentPriceTip2"></div>
		</div>
	</div>
	<div class="addADV cf">
		<label for=""><i class="red">*</i>权限类型：</label>
		<div class="infoADV leftFloat">
			<input type="text"  style="width: 150px"  name="ruleType" value="${rule.ruleType}" id="specification2" class="locSubInput"/>
			<div id="specificationTip2"></div>
		</div>
	</div>
	<div class="addADV cf">
		<label for=""><i class="red">*</i>权限排序：</label>
		<div class="infoADV leftFloat"    >
			<input  type="text"  style="width: 150px"  name="ruleOrder" value="${rule.ruleOrder}" id="labelText" class="locSubInput"/>
			<div id="labelTextTip" ></div>
		</div>
	</div>
	<div class="addADV cf">
		<label for=""><i class="red">*</i>权限URL：</label>
		<div class="infoADV leftFloat">
			<input type="text"  style="width: 250px ;"  name="ruleUrl" value="${rule.ruleUrl}" id="originalPrice" class="locSubInput"/>
			<div id="originalPriceTip"  ></div>
		</div>
	</div>
	<div class="addADV cf">
		<label for=""><i class="red">*</i>权限图标：</label>
		<div class="infoADV leftFloat">

			<input type="text"  style="width: 250px"  name="rulePicture" value="${rule.rulePicture}" id="currentPrice" class="locSubInput"/>
			<div id="currentPriceTip"></div>
		</div>
	</div>
	<div class="addADV cf">
		<label for=""><i class="red">*</i>权限扩展：</label>
		<div class="infoADV leftFloat">
			<input type="text"  style="width: 250px"  name="ruleExt" value="${rule.ruleExt}" id="specification" class="locSubInput"/>
			<div id="specificationTip"></div>
		</div>
	</div>
</div>
<div class="addADV cf">
	<label for=""><i class="red">*</i>权限描述：</label>
	<div class="infoADV">
						<textarea name="ruleDesc" id="descContent"
								  style="width: 450px; height: 70px;">${rule.ruleDesc}</textarea>
		<span>最大支持50个中文字长度</span>
		<div id="descContentTip"></div>
	</div>
</div>


<style type="text/css">
	.leftFloat *{
		float: left;
	}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		if('${adv.imageUrl}'==''||'${adv.imageUrl}'==null){
			$('#showImg').hide();
		}
		if('${adv.productImageUrl}'==''||'${adv.productImageUrl}'==null){
			$('#showImg1').hide();
		}
	});

	$(function(){
		var p = $("#showPosition").val();
		if(p == '1' || p == '5'){
			initCheck(false);
		}else{
			initCheck(true);
		}

	});

	function initCheck(isLabel){

		$.formValidator.initConfig({formID:"advForm",theme:"Default",submitOnce:true,wideWord:false,onError:function(){}});
		$("#advName").formValidator({onShow:"请输入广告名称"}).inputValidator({min:1,max:10,onErrorMin:"请输入大于1个字符",onErrorMax:"请输入小于10个中文字",empty:{leftEmpty:false,rightEmpty:false,emptyError:"广告名称两边不能有空格"},onError:"请输入广告名称"});
		//$("#uploadImageValueId").formValidator({tipID:"imgTip",onShow: "请输入图片名", onCorrect: "谢谢你的合作，你的图片名正确" }).inputValidator({min:1,onErrorMin:"请上传图片"}).regexValidator({ regExp: "picture", dataType: "enum", onError: "图片名格式不正确" });
		$("#advUrl").formValidator({empty:false,onShow:"请输入跳转地址",onFocus:"请输入跳转地址"}).inputValidator({onError:"你输入网址格式不正确"}).regexValidator({regExp:"url",dataType:"enum",onError:"你输入网址格式不正确"});
		//$("#uploadImageValueId1").formValidator({tipID:"imgTip",onShow: "请输入图片名", onCorrect: "谢谢你的合作，你的图片名正确" }).inputValidator({min:1,onErrorMin:"请上传图片"}).regexValidator({ regExp: "picture", dataType: "enum", onError: "图片名格式不正确" });
		//$("#productUrl").formValidator({empty:true,onShow:"请输入跳转地址",onFocus:"请输入跳转地址"}).inputValidator({onError:"你输入网址格式不正确"}).regexValidator({regExp:"url",dataType:"enum",onError:"你输入网址格式不正确"});
		//$("#imgType").formValidator({onShow:"请选择图片类型",onFocus:"请选择图片类型",onCorrect:"谢谢你的配合"}).inputValidator({min:1,onError: "请选择图片类型"});
		$("#showPosition").formValidator({onShow:"请选择展示位置",onFocus:"请选择展示位置",onCorrect:"谢谢你的配合"}).inputValidator({min:0,onError: "请选择展示位置"});
		$("#descContent").formValidator({onShow:"请输入广告说明",onFocus:"请输入广告说明",onCorrect:"谢谢你的配合"}).inputValidator({min:1,max:50,onErrorMax:"请输入小于50个中文字",onError: "请输入广告说明"});

		if(isLabel){
			$("#locSubInput").find("input").removeAttr("disabled");
			$("#locSubInput").show();
			$("#imgSize").html("290px*290px");
//			$("#specification").formValidator({onShow:"请输入规格",onFocus:"请输入规格",onCorrect:"谢谢你的配合"}).inputValidator({min:1,max:8,onErrorMax:"请输入1-8位的汉字、字母、数字",onError: "请输入规格"});
//			$("#originalPrice").formValidator({onShow:"请输入原价",onFocus:"请输入原价",onCorrect:"谢谢你的配合"})
//					.inputValidator({min:1,onErrorMax:"请输入正确的价格",onError: "请输入原价"})
//					.regexValidator({ regExp: "^\\d+(\\.\\d{2}){0,1}$", onError: "请填写正确的价格" });
//			$("#currentPrice")
//					.formValidator({onShow:"请输入现价",onFocus:"请输入现价",onCorrect:"谢谢你的配合"})
//					.inputValidator({min:1,onErrorMax:"请输入正确的价格",onError: "请输入现价"})
//					.regexValidator({ regExp: "^\\d+(\\.\\d{2}){0,1}$", onError: "请填写正确的价格" });
			$("#labelText").formValidator({onShow:"请输入标签文字",onFocus:"请输入标签文字",onCorrect:"谢谢你的配合"}).inputValidator({min:1,max:4,onErrorMax:"请输入1-4个汉字",onError: "请输入标签文字"}).regexValidator({ regExp: "^[\u4E00-\u9FA5A-Za-z0-9_\\s\(\)]+$", onError: "请填写1-4个汉字" });
		}else{
			$("#locSubInput").find("input").attr("disabled","disabled");
			$("#locSubInput").hide();
			if($("#showPosition").val() == 5){
				$("#imgSize").html("22px*23px");
			}else{
				$("#imgSize").html("294px*424px");
			}
		}



	}


	$(function(){
		initWaterMark("advName","如：当季商品1（最大支持10个汉字，建议使用4个汉字）");
		initWaterMark("descContent","最大支持50个中文字长度，前台图片alt属性，不显示，用于SEO抓取");
		initWaterMark("advUrl","例：http://www.yichengpin.com/item-100065-2-10060.do");
		if($.fn.placeholder){
			$('input[placeholder]').placeholder();
			$('textarea[placeholder]').placeholder();
		}
	});


	function initWaterMark(id,tip){
		$("#"+id).attr("placeholder",tip);
	}

	function whenSelectType(){
		var p = $("#showPosition").val();
		if(p == '1' || p == '5'){
			initCheck(false);
		}else{
			initCheck(true);
		}
	}

</script>
				
				
				
	 
	 
 