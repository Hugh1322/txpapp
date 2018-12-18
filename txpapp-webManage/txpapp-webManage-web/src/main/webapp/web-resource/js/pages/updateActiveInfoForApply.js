$(function(){
    //验证配置参数
	$.formValidator.initConfig({
 	    validatorGroup: '1', //多个表单使用窜号区分,单个表单无需使用此窜号
 	    formID: 'form1',
 	 	errorFocus:false,
 	    theme: 'Default'
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
		 $('#form1').submit();
    });
	
	//返回上一页
	$('#backList').click(function(){
		  window.location.href=_ctxPath+'/admin/active/active-manager.htm';
	});
	
	
});
