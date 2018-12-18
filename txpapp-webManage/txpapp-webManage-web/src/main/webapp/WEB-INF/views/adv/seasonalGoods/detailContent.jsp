<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../../include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
   <s:hidden name="adv.advertisementId"></s:hidden>
				 <div class="addADV cf">
						<label for=""><i class="red">*</i>位置：</label>
						<div style="display:none;">
						</div>
						<div class="infoADV">
						<input  name="adv.positionId" value="${adv.position.positionId}" type="hidden"/>
						<c:out value="${position.positionName}"></c:out>
						</div>
					</div>
					<div class="addADV cf">
						<label for=""><i class="red">*</i>展示位置：</label>
						<div class="infoADV">
					 
						<c:choose >
							 <c:when test="${not empty  adv.advertisementId}">
								<input type="hidden" name="adv.rank" value="${adv.rank }">
								 <select name="adv.rank" id="showPosition"  disabled="disabled" class="m-sel two" >
								<option value="-1">请选择-${adv.rank}</option>
								<c:forEach items="${advType}" var="t">
									<option value="${t.key }"
									<c:if test="${adv.rank == t.key }">
									selected = "selected"
									</c:if>
									> ${t.value}</option>
								</c:forEach>
								</select>
							 </c:when>
							 <c:otherwise>
							 <select name="adv.rank" id="showPosition"  onchange="whenSelectType()"  class="m-sel two" >
								<option value="-1">请选择-${adv.rank}</option>
								<c:forEach items="${advType}" var="t">
									<option value="${t.key }"
									<c:if test="${adv.rank == t.key }">
									selected = "selected"
									</c:if>
									> ${t.value}</option>
								</c:forEach>
							</select>
							 </c:otherwise>
						</c:choose>
							<div id="showPositionTip"></div>
						</div>
				</div>
					 <div class="addADV cf">
						<label for=""><i class="red">*</i>广告名称：</label>
						<div class="infoADV">
						 
							<input type="text"  style="width: 450px"  name="adv.advertisementName" value="${adv.advertisementName}" id="advName" class="txt-input"/>
							<div id="advNameTip"></div>
						</div>
					</div>
				<div class="addADV cf">
					<label for=""><i class="red">*</i>广告说明：</label>
					<div class="infoADV">
						<textarea name="adv.advDescription" id="descContent"
							style="width: 450px; height: 70px;">${adv.advDescription}</textarea>
						<span>最大支持50个中文字长度</span>
						<div id="descContentTip"></div>
					</div>
				</div>
					<div class="addADV cf">
						<label for=""><i class="red">*</i>广告图片：</label>
						<div class="infoADV">
	            					<input type="file" id="imgUpload" name="file" />
	            					<div id="advUploadImageTip">
		            					<em class="c-red">*</em> 
		            					请上传像素为<span id="imgSize">290px*290px</span>的图片
		            				</div>
		            				<input type="hidden" id="uploadImageValueId" name="adv.imageUrl" value="${adv.imageUrl}"/>
									<c:if test="${adv.imageUrl != '' && adv.imageUrl!= null}">
										<img src="${_filePath}${adv.imageUrl}" id="showImg" 
										     <c:if test="${not empty position.width}">
										     width="${position.width}" 
										     </c:if>
										     <c:if test="${not empty position.height}">
										     height="${position.height}" 
										     </c:if>
										     />
									</c:if>
									<c:if test="${adv.imageUrl == '' || adv.imageUrl==null}">
										<img src="" id="showImg" />
									</c:if>
									<div id="imgTip"></div>
						</div>
					</div>
					
					<div class="addADV cf">
						<label for="">跳转地址：</label>
						<div class="infoADV">	
						<input  type="text" name="adv.productUrl" id="advUrl" style="width: 450px"  class="txt-input" value="${adv.productUrl }"/>
						<div id="advUrlTip"></div>
						</div>
					</div>
					<div id="locSubInput">
					
					 <div class="addADV cf">
						<label for=""><i class="red">*</i>标签文字：</label>
						<div class="infoADV leftFloat"    >
							<input  type="text"  style="width: 100px"  name="adv.labelText" value="${adv.labelText}" id="labelText" class="locSubInput"/>
							<div id="labelTextTip" ></div>
						</div>
					</div>
					 <div class="addADV cf">
						<label for=""><i class="red">*</i>原价：</label>
						<div class="infoADV leftFloat">
							<input type="text"  style="width: 100px ;"  name="adv.originalPrice" value="${adv.originalPrice}" id="originalPrice" class="locSubInput"/>
							<div id="originalPriceTip"  ></div>
						</div>
					</div>
					 <div class="addADV cf">
						<label for=""><i class="red">*</i>现价：</label>
						<div class="infoADV leftFloat">
						 
							<input type="text"  style="width: 100px"  name="adv.currentPrice" value="${adv.currentPrice}" id="currentPrice" class="locSubInput"/>
							<div id="currentPriceTip"></div>
						</div>
					</div>
					 <div class="addADV cf">
						<label for=""><i class="red">*</i>规格：</label>
						<div class="infoADV leftFloat">
							<input type="text"  style="width: 100px"  name="adv.specification" value="${adv.specification}" id="specification" class="locSubInput"/>
							<div id="specificationTip"></div>
						</div>
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
		var uploadlogoParams = {
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
		uploadlogoParams.scriptData = {'category' : 'adv'}; //目录名字 可以是多级  logo/2013/02/26
		uploadlogoParams.onComplete = function(event, ID, fileObj, response, data) {
			$('#uploadImageValueId').val(response);
			var url = '${_filePath}' + response;
			$('#showImg').attr({src: url});
			$('#showImg').show();
		};
		
		var uploadCityPro = {
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
		uploadCityPro.scriptData = {'category' : 'adv'}; //目录名字 可以是多级  logo/2013/02/26
		uploadCityPro.onComplete = function(event, ID, fileObj, response, data) {
			$('#uploadImageValueId1').val(response);
			var url = '${_filePath}' + response;
			$('#showImg1').attr({src: url, width: 25+ "px", height:25 + "px"});
			$('#showImg1').show();
		};
		
		$('#imgUpload').uploadify(uploadlogoParams);
		$('#imgUpload1').uploadify(uploadCityPro);
		$(".one").change(function(){
	        var index = $(this).children('option:selected').val();  //弹出select的值
	        if(index<0){
	        	//alert("aaa");
	        	$(".two").html("<option value=\"-1\">请选择</option>");
	        }else{//ajax 请求后台
	        	$.ajax({
	    			url:_ctxPath + "/admin/adv/showCategory.htm",
	    			type:"POST",
	    			data:{'adv.advertisementPositionId':index},
	    			dataType:"json",
	    			async: false,
	    			success:function(data){
	    				var html = "<option value=\"-1\">请选择</option>";
	    				if(data.info!=null&&data.info!=undefined){//不等于
	    					var array =  eval('(' + data.info + ')');   
	    					for(var i=0;i<array.length;i++){
	    						//alert(array[i].propId+""+array[i].name);
	    						html +="<option value='"+array[i].propId+"'>"+array[i].name+"</option>";;
	    					}
	    				}
	    				$(".two").html(html);
	    			}
	    		});
	        }
	    });
		 
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
		$("#uploadImageValueId").formValidator({tipID:"imgTip",onShow: "请输入图片名", onCorrect: "谢谢你的合作，你的图片名正确" }).inputValidator({min:1,onErrorMin:"请上传图片"}).regexValidator({ regExp: "picture", dataType: "enum", onError: "图片名格式不正确" });
		$("#advUrl").formValidator({empty:false,onShow:"请输入跳转地址",onFocus:"请输入跳转地址"}).inputValidator({onError:"你输入网址格式不正确"}).regexValidator({regExp:"url",dataType:"enum",onError:"你输入网址格式不正确"});
		//$("#uploadImageValueId1").formValidator({tipID:"imgTip",onShow: "请输入图片名", onCorrect: "谢谢你的合作，你的图片名正确" }).inputValidator({min:1,onErrorMin:"请上传图片"}).regexValidator({ regExp: "picture", dataType: "enum", onError: "图片名格式不正确" });
		//$("#productUrl").formValidator({empty:true,onShow:"请输入跳转地址",onFocus:"请输入跳转地址"}).inputValidator({onError:"你输入网址格式不正确"}).regexValidator({regExp:"url",dataType:"enum",onError:"你输入网址格式不正确"});
		//$("#imgType").formValidator({onShow:"请选择图片类型",onFocus:"请选择图片类型",onCorrect:"谢谢你的配合"}).inputValidator({min:1,onError: "请选择图片类型"});
		$("#showPosition").formValidator({onShow:"请选择展示位置",onFocus:"请选择展示位置",onCorrect:"谢谢你的配合"}).inputValidator({min:1,onError: "请选择展示位置"});
		$("#descContent").formValidator({onShow:"请输入广告说明",onFocus:"请输入广告说明",onCorrect:"谢谢你的配合"}).inputValidator({min:1,max:50,onErrorMax:"请输入小于50个中文字",onError: "请输入广告说明"});
		
		if(isLabel){
		$("#locSubInput").find("input").removeAttr("disabled");
		$("#locSubInput").show();
		$("#imgSize").html("290px*290px");
		$("#specification").formValidator({onShow:"请输入规格",onFocus:"请输入规格",onCorrect:"谢谢你的配合"}).inputValidator({min:1,max:8,onErrorMax:"请输入1-8位的汉字、字母、数字",onError: "请输入规格"});
		$("#originalPrice").formValidator({onShow:"请输入原价",onFocus:"请输入原价",onCorrect:"谢谢你的配合"})
			.inputValidator({min:1,onErrorMax:"请输入正确的价格",onError: "请输入原价"})
	 		.regexValidator({ regExp: "^\\d+(\\.\\d{2}){0,1}$", onError: "请填写正确的价格" });
	 	$("#currentPrice")
	 		.formValidator({onShow:"请输入现价",onFocus:"请输入现价",onCorrect:"谢谢你的配合"})
	 		.inputValidator({min:1,onErrorMax:"请输入正确的价格",onError: "请输入现价"})
	 		.regexValidator({ regExp: "^\\d+(\\.\\d{2}){0,1}$", onError: "请填写正确的价格" });
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
				
				
				
	 
	 
 