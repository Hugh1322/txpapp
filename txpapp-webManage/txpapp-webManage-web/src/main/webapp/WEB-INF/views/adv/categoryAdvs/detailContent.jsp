<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.txp.app.contants.Prop" %>
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
						<label for=""><i class="red">*</i>商品一级分类：</label>
						<div class="infoADV">
						  <c:choose >
					        <c:when test="${not empty  adv.advertisementId}">
								<input  id="bigcatalog" type="hidden" name="adv.advertisementPositionId" value="${adv.advertisementPositionId }">
								   <c:if test="${adv.advertisementPositionId == adv.p.propId }">
									    <select name="adv.advertisementPositionId"  class="m-sel two"  disabled="disabled" >
												 <option selected="selected" value="${adv.advertisementPositionId}">${adv.p.name }</option>
										</select>
										
									</c:if>
									<c:if test="${adv.advertisementPositionId == 10000 }">
										<select name="adv.advertisementPositionId"  class="m-sel two"  disabled="disabled" >
											<option value="10000"  selected="selected">区域广告</option>
										</select>
									</c:if>
							</c:when>
							<c:otherwise>
								    <select name="adv.advertisementPositionId" id="bigcatalog"  class="m-sel two" >
									</select>
									<div id="bigcatalogTip"></div>
							</c:otherwise>
							</c:choose>
							</div>
					</div>
					<div class="addADV cf">
						<label for=""><i class="red">*</i>展示位置：</label>
						<div class="infoADV"> 
						<c:choose >
							 <c:when test="${not empty  adv.advertisementId}">
								<input type="hidden" name="adv.type" value="${adv.type }">
								<select name="adv.type" id="showPosition"  disabled="disabled" class="m-sel two">
								<option <c:if test="${empty adv.type}">selected="selected"</c:if>  value="-1">请选择</option> 
								<option <c:if test="${adv.type == '10'}">selected="selected"</c:if> value="10" >内层</option>
								<option <c:if test="${adv.type == '11'}">selected="selected"</c:if> value="11" >外层</option>
								<option <c:if test="${adv.type == '12'}">selected="selected"</c:if> value="12" >品牌</option>
								</select>
							 </c:when>
							 <c:otherwise>
							 <select name="adv.type" id="showPosition"  class="m-sel two">
								<option <c:if test="${empty adv.type}">selected="selected"</c:if>  value="-1">请选择</option> 
								<option <c:if test="${adv.type == '10'}">selected="selected"</c:if> value="10"  >内层</option>
								<option <c:if test="${adv.type == '11'}">selected="selected"</c:if> value="11"  >外层</option>
								<option <c:if test="${adv.type == '12'}">selected="selected"</c:if> value="12"  >品牌</option>
								
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
							<label for=""><i class="red">*</i>顺序：</label>
							<div class="infoADV">
								<input type="text"  name="adv.rank" id="advRank" class="txt-input" value="${adv.rank}"/><span>请选择1-10之间的数字</span>
								<div id="advRankTip"></div>
							</div>
					</div>
				<%-- 	<div class="addADV cf">
							<label for=""><i class="red">*</i>广告图片：</label>
							<div class="infoADV">
			            		<input type="file" id="imgUpload" class="txt-input" name="file" />
			            		<div id="advUploadImageTip" ">
	            					<em class="c-red">*</em> 
		            				<span id="advPosition-${position.positionId}">请上传像素为${position.width}px*${position.height}px的图片</span>
				            	</div>
				            	<input type="hidden" id="uploadImageValueId" value="${adv.imageUrl}" name="adv.imageUrl" /> <img  width="${position.width}" height="${position.height}"  src="<c:if test="${not empty adv.imageUrl}"> ${_filePath}${adv.imageUrl} </c:if>" id="showImg" />
								<div id="imgTip"></div>
							</div>
					</div> --%>
					<div class="addADV cf">
						<label for="">跳转地址：</label>
						<div class="infoADV">	
						<input  type="text" name="adv.url" id="advUrl" style="width: 450px"  class="txt-input" value="${adv.url }"/>
						<div id="advUrlTip"></div>
						</div>
					</div>
				
	<script type="text/javascript">
	$(document).ready(function(){
 		if('${adv.imageUrl}'==''||'${adv.imageUrl}'==null){
 			$('#showImg').hide();
 		}
	/* 	var uploadlogoParams = {
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
		
		$('#imgUpload').uploadify(uploadlogoParams); */
		$(".one").change(function(){
	        var index = $(this).children('option:selected').val();  //弹出select的值
	        if(index<0){
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
	
	$.formValidator.initConfig({formID:"advForm",theme:"Default",submitOnce:false,wideWord:false,onError:function(){}});
	/* $("#uploadImageValueId").formValidator({tipID:"imgTip",onShow: "请输入图片名", onCorrect: "谢谢你的合作，你的图片名正确" }).inputValidator({min:1,onErrorMin:"请上传图片"}).regexValidator({ regExp: "picture", dataType: "enum", onError: "图片名格式不正确" }); */
	$("#advName").formValidator({onShow:"请输入广告名称"}).inputValidator({min:1,max:8,onErrorMin:"请输入大于1个字符",onErrorMax:"请输入小于8个中文字",empty:{leftEmpty:false,rightEmpty:false,emptyError:"广告名称两边不能有空格"},onError:"请输入广告名称"});
	$("#advUrl").formValidator({empty:false,onShow:"请输入跳转地址",onFocus:"请输入跳转地址"}).inputValidator({onError:"你输入网址格式不正确"}).regexValidator({regExp:"url",dataType:"enum",onError:"你输入网址格式不正确"});
	  $("#bigcatalog").formValidator({onShow:"请选择分类",onFocus:"请选择分类",onCorrect:"谢谢你的配合"}).inputValidator({min:1,onError: "请选择分类"});
	$("#showPosition").formValidator({onShow:"请选择展示位置",onFocus:"请选择展示位置",onCorrect:"谢谢你的配合"}).inputValidator({min:1,onError: "请选择展示位置"});
	
	 $("#advRank").formValidator({empty:false,onShow:"请输入排序号",onCorrect:"谢谢你的合作，你的排序号正确"}).inputValidator({min:0,max:2,onErrorMax:"请填写1~10之间数字"}).regexValidator({regExp:"intege1",dataType:"enum",onError:"请填写1~10之间数字"})
	.functionValidator({
                    fun: function(val, el) {
	                    if(val>10){
	                    	return "请填写1~10之间数字";
	                    }
                    }
                });
	 
	
	$(function(){
		initWaterMark("advName","如：当季商品1（最大支持8个汉字，建议使用4个汉字）");
		initWaterMark("descContent","最大支持50个中文字长度，前台图片alt属性，不显示，用于SEO抓取");
		initWaterMark("advUrl","例：http://www.yichengpin.com/item-100065-2-10060.do");
		if($.fn.placeholder){
			$('input[placeholder]').placeholder();
			$('textarea[placeholder]').placeholder();
		}
		
		loadBigCatalog();
	}); 
  
	
	function initWaterMark(id,tip){
		$("#"+id).attr("placeholder",tip);
	}
	
	
	  function loadBigCatalog(){
		$("#bigcatalog").html('<option value="-1">请选择</option>');
		$.ajax({
	        "url": "${_ctxPath}/admin/product/product-getPropInfoMsg.htm",
	        "type": 'get',
	        "dataType" : "json", 
	        "data":{"selectKey":<%=Prop.CODE_PRODUCT%>},
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
	                $("#bigcatalog").append('<option value="10000">区域广告</option>');
	            }
	        },
	        "error": function () {
	            alert('请求错误，请稍后尝试:'+url);
	        }
	    });
		$("#bigcatalog").trigger("change");
	}
	
</script>			
				
				
				
	 
	 
 