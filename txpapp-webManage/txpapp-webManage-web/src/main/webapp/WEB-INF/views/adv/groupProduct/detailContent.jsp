<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../../include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
   <s:hidden name="adv.advertisementId"></s:hidden>
				<div class="addADV cf">
					<label for=""><i class="red">*</i>位置：</label>
					<div class="infoADV">
						<div style="display: none;">
						</div>
						团购频道页广告 
					</div>
				</div>
				
				<div class="addADV cf">
						<label for=""><i class="red">*</i>展示位置：</label>
						
						
						
						<div class="infoADV"> 
					
						<!--<c:choose >
							 <c:when test="${not empty  adv.advertisementId}">
								<input type="hidden" name="adv.rank" value="${adv.rank }">
								<select name="adv.rank" id="showPosition"  disabled="disabled" class="m-sel two">
								<option <c:if test="${empty adv.rank}">selected="selected"</c:if>  value="-1">请选择</option> 
								<option  value="1"  <c:if test="${empty adv.rank}">selected="selected"</c:if> >团购广告大图</option>
								
								</select>
							 </c:when>
							 <c:otherwise>
							 <select name="adv.rank" id="showPosition"  class="m-sel two">
								<option <c:if test="${empty adv.rank}">selected="selected"</c:if>  value="-1">请选择</option> 
								<option  value="1"  >团购广告大图</option>
								
							</select>
							 </c:otherwise>
						</c:choose>-->
						<c:choose >
							 <c:when test="${not empty  adv.advertisementId}">
								<input type="hidden" name="adv.rank" value="${adv.rank }">
								<select name="adv.rank" id="showPosition"  disabled="disabled" class="m-sel two">
								<option <c:if test="${empty adv.rank}">selected="selected"</c:if>  value="-1">请选择</option> 
								<option <c:if test="${adv.rank == '1'}">selected="selected"</c:if> value="1"  >团购广告大图</option>
								</select>
							 </c:when>
							 <c:otherwise>
							 <select name="adv.rank" id="showPosition"  class="m-sel two">
								<option <c:if test="${empty adv.rank}">selected="selected"</c:if>  value="-1">请选择</option> 
								<option <c:if test="${adv.rank == '1'}">selected="selected"</c:if> value="1"  >团购广告大图</option>
								
							</select>
							 </c:otherwise>
						</c:choose>
						
							<div id="showPositionTip"></div>
						</div>
				</div>
				 <div class="addADV cf">
						<label for=""><i class="red">*</i>广告名称：</label>
						<div class="infoADV">
						 
							<input style="width: 450px"   type="text"  name="adv.advertisementName" value="${adv.advertisementName}" id="advName" class="txt-input "/>
							<div id="advNameTip"></div>
						</div>
					</div>
				<div class="addADV cf">
					<label for=""><i class="red">*</i>广告说明：</label>
					<div class="infoADV">
						<textarea   name="adv.advDescription" id="descContent"
							style="width: 450px; height: 70px;">${adv.advDescription}</textarea>
						<span>最大支持50个中文字长度</span>
						<div id="descContentTip"></div>
					</div>
				</div>
				<div class="addADV cf">
					<label for=""><i class="red">*</i>广告图片：</label>
					<div class="infoADV">
						<input type="file" id="imgUpload" class="txt-input" name="file" />
						<div id="advUploadImageTip">
							<em class="c-red">*</em> <span
								id="advPosition-${position.positionId}">请上传像素为900px*270px的图片</span>
						</div>
						<input type="hidden" id="uploadImageValueId" value="${adv.imageUrl}" name="adv.imageUrl" /> <img  width=400  src="<c:if test="${not empty adv.imageUrl}"> ${_filePath}${adv.imageUrl} </c:if>" id="showImg" />
						<div id="imgTip"></div> 
					</div>
				</div>
				<div class="addADV cf">
					<label for=""><i class="red">*</i>指向链接：</label>
					<div class="infoADV">
						<input style="width: 450px" type="text" name="adv.productUrl" id="productUrl"  value="${adv.productUrl}"
							class="txt-input" />
						<div id="productUrlTip"></div>
					</div>
				</div>
				
				
	 	
 <script type="text/javascript">
 $(document).ready(function(){
		if('${adv.imageUrl}'==''||'${adv.imageUrl}'==null){
			$('#showImg').hide();
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
			var typeValue=$("#imgType").val();
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
 


 $.formValidator.initConfig({formID:"advForm",theme:"Default",submitOnce:true,wideWord:false,onError:function(){}});
	$("#uploadImageValueId").formValidator({tipID:"imgTip",onShow: "请输入图片名", onCorrect: "谢谢你的合作，你的图片名正确" }).inputValidator({min:1,onErrorMin:"请上传图片"}).regexValidator({ regExp: "picture", dataType: "enum", onError: "图片名格式不正确" });
	//$("#advUrl").formValidator({empty:false,onShow:"请输入跳转地址",onFocus:"请输入跳转地址"}).inputValidator({onError:"你输入网址格式不正确"}).regexValidator({regExp:"url",dataType:"enum",onError:"你输入网址格式不正确"});
	//$("#uploadImageValueId1").formValidator({tipID:"imgTip",onShow: "请输入图片名", onCorrect: "谢谢你的合作，你的图片名正确" }).inputValidator({min:1,onErrorMin:"请上传图片"}).regexValidator({ regExp: "picture", dataType: "enum", onError: "图片名格式不正确" });
	$("#productUrl").formValidator({onShow:"请输入跳转地址",onFocus:"请输入跳转地址"}).inputValidator({onError:"你输入网址格式不正确"}).regexValidator({regExp:"url",dataType:"enum",onError:"你输入网址格式不正确"});
	//$("#imgType").formValidator({onShow:"请选择图片类型",onFocus:"请选择图片类型",onCorrect:"谢谢你的配合"}).inputValidator({min:1,onError: "请选择图片类型"});
	$("#showPosition").formValidator({onShow:"请选择展示位置",onFocus:"请选择展示位置",onCorrect:"谢谢你的配合"}).inputValidator({min:1,onError: "请选择展示位置"});
	$("#descContent").formValidator({onShow:"请输入广告说明",onFocus:"请输入广告说明",onCorrect:"谢谢你的配合"}).inputValidator({min:1,max:50,onErrorMax:"请输入小于50个中文字",onError: "请输入广告说明"});

	
 function changeType(){
	var info =$("#showPosition").val().split('_');
	 $("#currentPid").val(info[0]);
	 $("#currentType").val(info[1]);
	 
 }
 
	$(function(){
		initPlaceHolder();
	}); 
	
	function initPlaceHolder(){
		initWaterMark("advName","如：当季商品1（最大支持10个汉字，建议使用4个汉字）");
		initWaterMark("descContent","最大支持50个中文字长度，前台图片alt属性，不显示，用于SEO抓取");
		initWaterMark("productUrl","例：http://www.yichengpin.com/item-100065-2-10060.do");
		if($.fn.placeholder){
			$('input[placeholder]').placeholder();
			$('textarea[placeholder]').placeholder();
		}
	}
  
	
	function initWaterMark(id,tip){
		$("#"+id).attr("placeholder",tip);
	}
</script>			
				
				
	 
	 
 