﻿//图片上传空间实例化
$(function(){
	CKEDITOR.replace("brandDescription");
	CKEDITOR.on('dialogDefinition', function( ev ){
	    var dialogName = ev.data.name;
	    var dialogDefinition = ev.data.definition;
	    if ( dialogName == 'image' ){
	        var infoTab = dialogDefinition.getContents('info');
	        infoTab.add({
	            type : 'button',
	            id : 'upload_image',
	            align : 'center',
	            label : '添加图片',
	            onClick : function( evt ){
	                var thisDialog = this.getDialog();
	                var txtUrlObj = thisDialog.getContentElement('info', 'txtUrl');
	                var txtUrlId = txtUrlObj.getInputElement().$.id;
	                addUploadImage(txtUrlId);
	            }
	        },"txtAlt");
	    }
	});
	function addUploadImage(theURLElementId){
	    var uploadUrl = _ctxPath + "/upload/image-upload.htm";
	    var imgUrl = window.showModalDialog(uploadUrl,'title',
				'resizable=no;help=no;status=no;dialogWidth=400px;dialogHeight=300px'); 
	    var urlObj = document.getElementById(theURLElementId);
	    if(imgUrl){
		    urlObj.value = imgUrl;
		    onchangeFun(urlObj);
	    }
	}
	function onchangeFun(obj){
		if (document.all) {
			obj.fireEvent("onchange");
		} else {
			var evt = document.createEvent('HTMLEvents');
			evt.initEvent('change', true, true);
			obj.dispatchEvent(evt);
		} 
	}
  //进入该页面的时候初始化文本域的值
  var uploadDefaultParams = {
		'auto' : true,
		'buttonImg' : _jsPath+'/plugin/uploadify/uploadimg_btn.png',
		'cancelImg' : _jsPath+'/plugin/uploadify/cancel.png',
		'expressInstall' : _jsPath+'/plugin/uploadify/expressInstall.swf',
		'fileDataName'   : 'file',
		'fileDesc' : '请选择jpg、gif、png文件',
		'fileExt' : '*.jpg;*.jpeg;*.gif;*.png',
	    'height' : 1000,
	    'multi' : false,
	    'script' : _ctxPath+'/upload/upload.htm',
	    'uploader' : _jsPath+'/plugin/uploadify/uploadify.allglyphs.swf',
	    'width' : 1000,
	    'scriptData' : {'category':'brand'}
	};
    var uploadLogoImgParams = uploadDefaultParams;
    uploadLogoImgParams.onComplete = function(event, ID, fileObj, response, data){
		$('#logoImageUrl').val(response);
		$('#logoImg').attr('src', _filePath+response);
		$('#logoImg').show();
   };
   $('#logoImgUpload').uploadify(uploadLogoImgParams);

  var uploadBrandImgParams = uploadDefaultParams;
  uploadBrandImgParams.onComplete = function(event, ID, fileObj, response, data){
		$('#brandImageUrl').val(response);
		$('#brandImage').attr('src', _filePath+response);
		$('#brandImage').show();
   };
   $('#brandImageUpload').uploadify(uploadBrandImgParams);
   
   var uploadBrandListPictureParams = uploadDefaultParams;
   uploadBrandListPictureParams.onComplete = function(event, ID, fileObj, response, data){
 		$('#brandListPictureUrl').val(response);
 		$('#brandListPicture').attr('src', _filePath+response);
 		$('#brandListPicture').show();
    };
    $('#brandListPictureUpload').uploadify(uploadBrandListPictureParams);
    
    var uploadBrandbrandRecommendPictureParams = uploadDefaultParams;
    uploadBrandbrandRecommendPictureParams.onComplete = function(event, ID, fileObj, response, data){
  		$('#brandRecommendPictureUrl').val(response);
  		$('#brandRecommendPicture').attr('src', _filePath+response);
  		$('#brandRecommendPicture').show();
     };
     $('#brandRecommendPictureUpload').uploadify(uploadBrandbrandRecommendPictureParams);

   var uploadBannerImgParams = uploadDefaultParams;
   uploadBannerImgParams.onComplete = function(event, ID, fileObj, response, data){
		$('#bannerImageUrl').val(response);
		$('#bannerImg').attr('src', _filePath+response);
		$('#bannerImg').show();
     };
	 $('#bannerImgUpload').uploadify(uploadBannerImgParams);
	 //选择精选推荐
	 $("#brandIsRecommend").change(function(){ 
		if($(this).attr("checked") == "checked"){
			$("#isRecommend").val("1");
		}else{
			$("#isRecommend").val("0");
		}
	 });
	 
	//选择品牌地区
	 $(".select_area").live('change',function(){ 
		 var areaId = $(this).val();
		 var num = parseInt($(this).attr("num"));
		 getChangeSelects(num,"areaSelect","area");
		 changeArea(areaId,$(this).next("select"));
		 $("#areaId").val(areaId);
		 cleanNoChildernSelect("area");
		 if("-1" == areaId && "1" != $(this).attr("num")){
			 $("#areaId").val($(this).prev("select").val());
		 }
	 });
	//选择所属类目
	 $(".select_productType").live('change',function(){ 
		 var productTypeId = $(this).val();
		 var num = parseInt($(this).attr("num"));
		 getChangeSelects(num,"productTypeSelect","productType");
		 changeArea(productTypeId,$(this).next("select"));
		 $("#productTypeId").val(productTypeId);
		 cleanNoChildernSelect("productType");
		 if("-1" == areaId && "1" != $(this).attr("num")){
			 $("#productTypeId").val($(this).prev("select").val());
		 }
	 });
	 //选择活动商品
	 $("#skuToActivity").change(function(){ 
		 if($(this).attr("checked") == "checked"){
			 $("#brandProductSkuIdDiv tbody tr").each(function(){
				 var activityId = $(this).attr("title");
				 if(activityId == ""){
					 $(this).hide();
				 }
			 });
		 }else{
			 $("#brandProductSkuIdDiv tbody tr").each(function(){
				 var activityId = $(this).attr("title");
				 if(activityId == ""){
					 $(this).show();
				 }
			 });
		 }
	 });
	 $("#brandProductSkuIdButton").click(function(){
		 $("#brandProductSkuIdDiv").show();
	 });
	 $("#cancle-btn").click(function(){
		 history.go(-1);
	 });

	 // 公布品牌
	 $('#publishBrand-btn').click(function(){
		 $("#publishBrand-btn").attr("disabled",true);
		 $('#isPublish').val(1);
		 $('#addBrand-btn').trigger("click");
		 $('#isPublish').val(0);
		 $("#publishBrand-btn").attr("disabled",false);
	   });
	 // 保存品牌
	 $('#addBrand-btn').click(function(){
		 $("#addBrand-btn").attr("disabled",true);
		 var result = $.formValidator.pageIsValid('1');
		 var formBrand = $('#addBrand-form');
		 $("#brandDescription").val(CKEDITOR.instances.brandDescription.getData());
//		 var brandDescription = $.trim($("#brandDescription").val());
//		 if(brandDescription==''){
//			 alert("品牌简介不能为空！");
//			 $("#addBrand-btn").attr("disabled",false);
//			 return;
//		 }
		 $('#describeInput').val($('#describArea').val());
		 if(result){
			 $.ajax({
				 type: 'POST',
				 url: _ctxPath+'/admin/brand/brand-singleBrandSset.htm',
				 data: formBrand.serialize(),
				 success: function(data){
					 switch(data.info){
					 case '0':
					 case '1':
						 $.dialog({
							 title: false,
							 content: data.code,
							 time: 2000
						 });
						 $(".d-close").hide();
						 $("#addBrand-btn").attr("disabled",false);
						 break;
					 case '2':
						 $.dialog({
							 title: false,
							 content: data.code,
							 time: 2000
						 });
						 $(".d-close").hide();
						 var recommendEdit = $("#recommendEdit").val();
						 if(recommendEdit == 'ok'){
							 window.location=_ctxPath+'/admin/brand/brand-listRecommend.htm';
						 }else{
							 window.location=_ctxPath+'/admin/brand/brand-listUserBrans.htm';
						 }
						 break;
					 }
					 
				 },
				 dataType:'json'
			 });
		 }else{
			 $("#addBrand-btn").attr("disabled",false);
		 }
		 
	 });
});
	$.formValidator.initConfig({formID:"addBrand-form",theme:"Default",validatorGroup: '1',submitOnce:false,wideWord:false,onError:function(){}});
	function allEmpty(val,elem){
		var name = $("#brandName").val();
		var englishName = $("#brandEnglishName").val();
		return ($.trim(name).length == 0 && $.trim(englishName).length == 0) ? '请至少填写一种品牌名字！' : true;
	}
	
	$("#brandName").formValidator({validatorGroup:'1',tipID:"brandNameTip",onShow:"请输入中文名",onFocus:"请输入中文名",oncorrect:"输入正确！"}).inputValidator({min:1,max:12,onErrorMax:"请输入不大于12个字符",empty:{leftEmpty:false,rightEmpty:false,emptyError:"品牌名称两边不能有空格"},onError:"输入值不能为空"}).functionValidator({fun:allEmpty});
	$("#brandEnglishName").formValidator({validatorGroup: '1',tipID:"brandEnglishNameTip",empty:true,onShow:"请输入英文名",onFocus:"请输入英文名",oncorrect:"输入正确！"}).inputValidator({min:1,max:36,onErrorMax:"请输入不大于36个字节",empty:{leftEmpty:false,rightEmpty:false,emptyError:"品牌名称两边不能有空格"},onError:"输入值不能为空"}).regexValidator({ regExp: "^[a-zA-Z]+$",dataType: "string",onError: "只能输入英文字母" }).functionValidator({fun:allEmpty});
	$("#brandFirstChar").formValidator({validatorGroup: '1',tipID:"brandFirstCharTip"}).inputValidator({min:1,max:1,onErrorMin:"只能输入一个字符(26个英文字母)",onErrorMax:"只能输入一个字符(26个英文字母)",onError:"只能输入一个字符(26个英文字母)"}).regexValidator({ regExp: "^[a-zA-Z]+$",dataType: "string",onError: "只能输入英文字母" });
	$("#brandKeyWord").formValidator({validatorGroup:'1',tipID:"brandKeyWordTip",empty:true,onShow:"请输入品牌关键词",onFocus:"请输入品牌关键词",oncorrect:"输入正确！"}).inputValidator({min:1,max:50,onErrorMax:"请输入不大于50个字符",empty:{leftEmpty:false,rightEmpty:false,emptyError:"品牌关键词两边不能有空格"},onError:"输入值不能为空"});
	$("#areaId").formValidator({validatorGroup:'1',tipID:"brandAreaTip",onShow:"请选择品牌地区",onFocus:"请选择品牌地区",oncorrect:"选择成功！"}).inputValidator({min:1,max:50,onErrorMax:"请输入不大于50个字符",empty:{leftEmpty:false,rightEmpty:false,emptyError:"品牌地区两边不能有空格"},onError:"选择不能为空"});
	$("#productTypeId").formValidator({validatorGroup:'1',tipID:"brandProductTypeTip",onShow:"请选择所属类目",onFocus:"请选择所属类目",oncorrect:"选择成功！"}).inputValidator({min:1,max:50,onErrorMax:"请输入不大于50个字符",empty:{leftEmpty:false,rightEmpty:false,emptyError:"所属类目两边不能有空格"},onError:"选择不能为空"});
	/*（保留字段请勿删除 2014-12-12）$("#brandSellerId").formValidator({validatorGroup:'1',tipID:"brandSellerIdTip",onShow:"请输入商家ID",onFocus:"请输入商家ID",oncorrect:"输入正确！"}).inputValidator({min:1,max:11,onErrorMax:"请输入不大于11个字符",empty:{leftEmpty:false,rightEmpty:false,emptyError:"商家ID两边不能有空格"},onError:"输入值不能为空"}).regexValidator({ regExp: "^[0-9]+$",dataType: "string",onError: "只能输入数字" });*/
	$("#brandFeature").formValidator({validatorGroup: '1',tipID:"brandFeatureTip",empty:true,onShow:"请输入品牌特色"}).inputValidator({min:1,max:60,onErrorMax:"请输入小于60个字符",empty:{leftEmpty:false,rightEmpty:false,emptyError:"品牌特色两边不能有空格"},onError:"你的输入错误不能为空"});
	$("#brandImageUrl").formValidator({validatorGroup: '1',tipID:"brandImageTip", empty:true,onShow:"请上传形象图",onFocus:"请上传形象图",onCorrect: "谢谢你的合作，你的形象图名正确" }).inputValidator({min:1,onErrorMin:"请上传形象图"}).regexValidator({ regExp: "picture", dataType: "enum", onError: "形象图名格式不正确" });
	$("#brandRecommendReason").formValidator({validatorGroup: '1',tipID:"brandRecommendReasonTip",empty:true,onShow:"请输入推荐理由"}).inputValidator({min:1,max:50,onErrorMax:"请输入小于50个字符",empty:{leftEmpty:false,rightEmpty:false,emptyError:"品牌推荐理由两边不能有空格"},onError:"你的输入错误"});
	$("#brandListPictureUrl").formValidator({validatorGroup: '1',tipID:"brandListPictureTip",empty:true, onShow:"请上传列表图",onFocus:"请上传列表图",onCorrect: "谢谢你的合作，你的列表图名正确" }).inputValidator({min:1,onErrorMin:"请上传列表图"}).regexValidator({ regExp: "picture", dataType: "enum", onError: "列表图名格式不正确" });
	$("#brandRecommendPictureUrl").formValidator({validatorGroup: '1',tipID:"brandRecommendPictureTip",empty:true, onShow:"请上传推荐图",onFocus:"请上传推荐图",onCorrect: "谢谢你的合作，你的推荐图名正确" }).inputValidator({min:1,onErrorMin:"请上传推荐图"}).regexValidator({ regExp: "picture", dataType: "enum", onError: "推荐图名格式不正确" });
	$("#brandProductSkuId").formValidator({validatorGroup: '1',tipID:"brandProductSkuIdTip",empty:true,onShow:"请选择商品ID"}).inputValidator({min:1,max:11,onErrorMax:"ID小于11个字符",empty:{leftEmpty:false,rightEmpty:false,emptyError:"商品ID两边不能有空格"},onError:"你的ID错误"}).regexValidator({ regExp: "^[0-9]+$",dataType: "string",onError: "只能输入数字" });
	$("#brandProductSkuShowName").formValidator({validatorGroup: '1',tipID:"brandProductSkuShowNameTip",empty:true,onShow:"请输入商品促销名",onFocus:"请输入商品促销名",onCorrect:"商品促销名正确"}).inputValidator({min:1,max:15,onErrorMax:"请输入不大于15个字符",empty:{leftEmpty:false,rightEmpty:false,emptyError:"商品促销名两边不能有空格"},onError:"输入值不能为空"});
	function addSkuId(skuId){
		 $("#brandProductSkuId").val(skuId);
		 cancleDiv();
	 }
	function cancleDiv(){
		$("#brandProductSkuIdDiv").hide();
	}
	
	$(document).ready(function(){
		var areaId = $("#areaId").val();
		getSelects(1000,areaId,"areaSelect","area");
		var productTypeId = $("#productTypeId").val();
		getSelects(1002,productTypeId,"productTypeSelect","productType");
	});
	
	function getSelects(id,propId,tdId,type){
		var tdHtml = "";
		if(propId != "" && propId != "-1"){
			$.ajax({
				type: "POST",
				dataType : 'text',
				async:false,
			    url: _ctxPath + "/admin/propinfo/propinfo-getRootProp.htm",
			    data:{"propinfo.propId":propId},
			    success: function(data){
			    	var propinfos = data.split(",");
			    	var size = propinfos.length+1;
			    	for(var i=0;i<size;i++){
			    		if(i == size -1){
			    			tdHtml += "<select id='"+type+(i+1)+"' class='select_"+type+"' num='"+(i+1)+"'></select>";
			    			$("#"+type).val(i+1);
			    		}else{
			    			tdHtml += "<select id='"+type+(i+1)+"' class='select_"+type+"' num='"+(i+1)+"'></select>";
			    		}
			    	}
			    	$("#"+tdId).append(tdHtml);
			    	for(var i=0;i<size;i++){
			    		if(i==0){
			    			changeArea(id,$("#"+type+(i+1)));
			    		}
			    		if(i == size -1){
			    			locateArea($("#"+type+(i+1)),propinfos[propinfos.length -1-i]);
			    		}else{
			    			locateArea($("#"+type+(i+1)),propinfos[propinfos.length -1-i]);
					    	changeArea($("#"+type+(i+1)).val(),$("#"+type+(i+2)));
			    		}
			    	}
			    }
			});
		}else{
			tdHtml += "<select id='"+type+1+"' class='select_"+type+"' num='"+1+"'></select>";
			$("#"+type).val(1);
			$("#"+tdId).append(tdHtml);
			changeArea(id,$("#"+type+1));
		}
		cleanNoChildernSelect(type);
	}
	
	function getChangeSelects(num,tdId,type){
		var selectNum = parseInt($("#"+type).val());
		if(num < selectNum){
			$("#"+type).val(num);
			for(var i=selectNum;i>num;i--){
				$("#"+type+i).remove();
			}
			if($("#"+type+num).val() != "-1"){
				getChangeSelects(num,tdId,type);
			}
		}else{
	    	$("#"+type).val(num+1);
	    	var tdHtml = "<select id='"+type+(num+1)+"' class='select_"+type+"' num='"+(num+1)+"'></select>";
	    	$("#"+tdId).append(tdHtml);
		}
	}
	
	function cleanNoChildernSelect(type){
		var selectNum = parseInt($("#"+type).val());
		var select = $("#"+type+selectNum);
		if(select.children().length <=1){
			select.remove();
			$("#"+type).val(selectNum-1)
		}
	}
	
	/*$("#describArea").formValidator({validatorGroup: '1',onShow:"请输入品牌简介",onFocus:"请输入品牌简介"}).inputValidator({min:10,max:10000,onErrorMin:"请输入大于10个字符",onErrorMax:"请输入小于10000个字符",onError:"你的输入错误"}).functionValidator({fun:function(val){
			return $.trim(val).length == 0? '请输入品牌简介' : true;
	 		 }});*/
