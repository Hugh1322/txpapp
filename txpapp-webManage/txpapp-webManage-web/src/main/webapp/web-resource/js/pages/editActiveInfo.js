$(function(){
	//初始化ckeditor编辑器
    var activeContentEditor = CKEDITOR.replace("activeInfo.activeContent");
    //验证配置参数
	$.formValidator.initConfig({
 	    validatorGroup: '1', //多个表单使用窜号区分,单个表单无需使用此窜号
 	    formID: 'form1',
 	 	errorFocus:false,
 	    theme: 'Default'
 	});
	
    //活动编码
	$("#activeInfo_Id").formValidator({
		onShow:"请输入1~11位的活动编码",
		onFocus:"请输入1~11位的活动编码",
		tipID:"activeInfo_IdTip"
	}).inputValidator({
		min:1,
		max:11,
		empty:{leftEmpty:false,rightEmpty:false,emptyError:"两边不能有空格"},
		onError:"请输入1~11位的活动编码"
	});
	
	//活动名称
	$("#activeName_id").formValidator({
		onShow:"请输入1~100位的活动名称",
		onFocus:"请输入1~100位的活动名称",
		tipID:"activeName_idTip"
	}).inputValidator({
		min:1,
		max:100,
		empty:{leftEmpty:false,rightEmpty:false,emptyError:"两边不能有空格"},
		onError:"请输入1~100位的活动编码"
	});
	
	//活动内容
    $('#activeContent_id').formValidator({
    	tipID : "activeContent_idTip",
		onShow : "请输入1~5000位的活动内容",
		onFocus : "活动内容必须填写",
		onCorrect : "谢谢您的配合"
	}).functionValidator({
		fun : function() {
			var describe = activeContentEditor.getData();
			if(describe.length == 0 || describe.length > 5000){
				return "请输入1~5000位的活动内容";
			}
		}
	});
    
    //折扣
    $('#discount').formValidator({
		tipID : "discountTip",
		onShow : "请输入0-1直接的数值，例如0.1,0.25",
		onFocus : "折扣必须填写",
		onCorrect : "谢谢您的配合"
	}).functionValidator({
		fun : function() {
			var discount = $("#discount").val();
			if(isNaN(discount)){
				return "请输入0-1直接的数值，例如0.1,0.25。";
			}
			if(discount<= 0 || discount>1 || discount==""){
				return "请输入0-1直接的数值，例如0.1,0.25。";
			}
		}
	});
    
    //申请日期
    $("#applyTime").formValidator({
    	tipID : "applyTimeTip",
		onShow:"请选择申请日期",
		onFocus:"申请日期必须选择",
		onCorrect:"申请日期正确"
	}).inputValidator({
		min:1,
		max:100,
		empty:{leftEmpty:false,rightEmpty:false,emptyError:"两边不能有空格"},
		onError:"请选择申请日期"
	});
    
	//提交表单
	$('#submitForm').bind('click',function(){
		//活动开始日期
	    var startTime = $('#startTime'),
	    	endTime = $('#endTime'),
	    	dateTip = $('#dateTip'),
	    checkRangeDate = rangeDate(startTime.val(), endTime.val());
		if (startTime.val() !== "" && endTime.val() !== "") {
		    if (!checkRangeDate) {
		    	showIcon.error(dateTip, '起始日期不能大于结束日期');
		    	return false;
		    }else{
		    	$('#form1').submit();
		    }
		}else{
			showIcon.error(dateTip, '开始或者结束日期不能为空');
	    	return false;
		}
    });
	
	//返回上一页
	$('#backList').click(function(){
		  window.location.href=_ctxPath+'/admin/active/active-manager.htm';
	});
	
	/*============ 图片上传操作 s============*/
	var uploadDefaultParams = {
		'auto' : true,
		'buttonImg' :_jsPath+'/plugin/uploadify/uploadimg_btn.png',
		'cancelImg' : _jsPath+'/plugin/uploadify/cancel.png',
		'expressInstall' : _jsPath+'/plugin/uploadify/expressInstall.swf',
		'fileDataName' : 'file',
		'fileDesc' : '请选择jpg、gif、png文件',
		'fileExt' : '*.jpg;*.jpeg;*.gif;*.png',
		'height' : 20,
		'multi' : false,
		'script' : _ctxPath+'/upload/upload.htm',
		'sizeLimit' : 2097152,
		'uploader' : _jsPath+'/plugin/uploadify/uploadify.allglyphs.swf',
		'width' : 94
	};
	
	var uploadImgParams = uploadDefaultParams;
	uploadImgParams.scriptData = {'category' : 'active'};
	uploadImgParams.onComplete = function(event, ID, fileObj, response, data) {
		$('#uploadImageValueId').val(response);
		//得到缩略图url
		var suffix = response.split(".")[1];
		var url = _fileThumbPath + response + "_t24." + suffix;
		$(".license").empty();
		$(".license").append("<img src='"+url+"'/>");
	};
	$('#imgUpload').uploadify(uploadImgParams);
	/*============ 图片上传操作 e============*/
	
	//验证日历
	function rangeDate(startVal, endVal) {
	       if (startVal != '') {
	           var startUTC = (Date.parse(startVal.replace(/-/g, '/')) / 1000),
	               formatUTC = (Date.parse(endVal.replace(/-/g, '/')) / 1000),
	               dateGap = parseInt(formatUTC - startUTC);
	           // return 这里写验证条件
	           return (dateGap >= 0);
	       }
	}
	
	var showIcon={
	        correct: function (el, text) {
	            el.show().html('<span class="yto_onCorrect">' + text + '</span>');
	        },
	        error: function (el, text) {
	            el.show().html('<span class="onError_top">' + text + '</span>');
	        },
	        show: function (el, text) {
	            el.show().html('<span class="yto_onShow">' + text + '</span>');
	        }
	}
});
