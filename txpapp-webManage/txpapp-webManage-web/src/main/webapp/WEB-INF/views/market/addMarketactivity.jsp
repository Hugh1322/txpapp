<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	%>
<%@include file="../include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新增营销活动</title>
<link href="${_cssPath }/common.css" rel="stylesheet" />
<link href="${_cssPath }/pages/arrangement.css" rel="stylesheet" />
<link href="${_cssPath }/pages/bannerManage.css" rel="stylesheet" />
<link href="${_jsPath }/plugin/artdialog/skins/ytoxl.css"
	rel="stylesheet" />
<script src="${_jsPath }/jquery/jquery.1.8.1.js" language="javascript"></script>
<script src="${_jsPath }/plugin/artdialog/jquery.artDialog.min.js"></script>
<script type="text/javascript"
	src="${_jsPath}/plugin/uploadify/swfobject.js"></script>
<script type="text/javascript"
	src="${_jsPath}/plugin/uploadify/jquery.uploadify.v2.1.4.min.js"></script>
<script src="${_jsPath}/plugin/formvalidator/formValidator-4.1.3.js"
	language="javascript"></script>
<script src="${_jsPath}/plugin/formvalidator/formValidatorRegex.js"
	language="javascript"></script>
<script src="${_jsPath}/pages/specAdv.js" language="javascript"></script>
<script type="text/javascript" src="${_jsPath }/plugin/My97DatePicker/WdatePicker.js"></script>
<!--[if IE]>
		<script src="${_jsPath}/pages/ieplaceholder.js"></script>
	<![endif]-->
<style>
.curPosition {
	height: 30px;
	line-height: 30px;
	padding-top: 20px;
}
</style>
</head>
<body>
	<jsp:include page="../include/header.jsp"></jsp:include>
	<!-- 正文内容 -->
	<div class="body m-w980p">
		<!-- 当前位置 -->
		<div class="curPosition">
			当前位置：<a href="${_ctxPath}/marketactivity/marketact-listActivities.htm">营销工具</a>-> <a href="${_ctxPath}/marketactivity/marketact-listActivities.htm">活动管理</a> -> 新增活动
		</div>
		<form method="post" id="addActivityFrom" action="${_ctxPath}/marketactivity/marketact-saveActivityRule.htm">
		<input type = "hidden" value = "0" name = "activity.status" />
			<div class="m-mt10p addBanner">
					<div class="addADV cf">
					<label><i class="red">*</i>活动代码:</label>
					<div class="infoADV">
						<input type="text" name="activity.code" id="actCode"  class="input_public" />
						<div id="actCodeTip"  ></div>
					</div>
				</div>
				
				<div class="addADV cf">
					<label><i class="red">*</i>活动名称:</label>
					<div class="infoADV">
						<input type="text" name="activity.name"  class="input_public" id="actName" /><div id="actNameTip"  ></div>
					</div>
				</div>
				
				
				<div class="addADV cf">
					<label><i class="red">*</i>活动时间:</label> 
					<div class="infoADV">
				<input id="startTime" name="activity.startTime" value="<s:date name="activity.startTime" format="yyyy-MM-dd HH:mm:ss"/>" class="Wdate"
				type="text" readonly="readonly" onFocus="WdatePicker({minDate:'%y-%M-{%d}',maxDate:'#F{$dp.$D(\'endTime\')}',dateFmt:'yyyy-MM-dd HH:mm:ss'})" />  至 
				
				
				<input id="endTime" name="activity.endTime"   
				value="<s:date name="activity.endTime" format="yyyy-MM-dd HH:mm:ss"/>" class="Wdate"
				type="text" readonly="readonly" onFocus="WdatePicker({minDate:'#F{$dp.$D(\'startTime\')}',dateFmt:'yyyy-MM-dd HH:mm:ss'})"/>
				<div id="startTimeTip"  ></div>
				<div id="endTimeTip"  ></div>
					</div>
				</div>
				
				<div class="addADV cf">
					<label>广告语:</label>
					<div class="infoADV">
						<input type="text" style = "width:300px;"  name="activity.activityDesc" class="input_public" id="activityDesc" /> 
					</div>
				</div>					
				
				
				<div class="addADV cf">
					<label><i class="red">*</i>销售类型: </label>
					<div class="infoADV">
						<input type="radio" name="activity.sellTypes" id="selltype_1" value="1" class="sellTypeCheckBox" />普通&nbsp;&nbsp;
						<!-- <input type="radio" name="activity.sellTypes" id="selltype_2" value="2" class="sellTypeCheckBox" />预售&nbsp;&nbsp; -->
						<input type="radio" name="activity.sellTypes" id="selltype_3" value="3" class="sellTypeCheckBox" />抢购&nbsp;&nbsp;
						<input type="radio" name="activity.sellTypes" id="selltype_4" value="4" class="sellTypeCheckBox" />团购&nbsp;&nbsp;
						<input type="radio" name="activity.sellTypes" id="selltype_5" value="5" class="sellTypeCheckBox" />分期送&nbsp;&nbsp;
						<input type="radio" name="activity.sellTypes" id="selltype_8" value="8" class="sellTypeCheckBox" />试吃&nbsp;&nbsp;
						<div id="sellTypesTip"  ></div>
					</div>
				</div>	
				
				<div class="addADV cf"> 
					<label>启用规则: </label>
					<div class="infoADV">
						<input type="checkbox" id="openRule"  class="sellTypeCheckBox" />&nbsp;&nbsp;
						<div id="openRuleTip"></div>
					</div>
				</div>					
				
				
				
				<div class="addADV cf" id ="ruleDiv1" style = "display:none">
					<label>&nbsp;</label>
					<label style="width: 60px;"><i class="red">*</i>规则1: </label>
					<span class="infoADV">
						<select class="m-sel" style = "width:300px;" id="rulePlusDiv1" name = "activity.actRules[0].id" disabled="disabled">
						<c:forEach items ="${marketRule2}" var = "marketRules"  varStatus="state">
							<option value="${marketRules.id}">${marketRules.name}</option>
						</c:forEach>
						</select><a href = "javascript:;"  onclick ="addRuleDiv();">&nbsp;&nbsp;+</a>
					</span>
				</div>					
				
					
				
				<div class="addADV cf" id = "rulePlus">
					<label><i class="red">*</i>优惠券规则: </label>
					<div class="infoADV">
						<input type="checkbox" name="activity.couponRule"   id="couponRule_1" value=1 class="sellTypeCheckBox" />普通优惠券&nbsp;&nbsp;
						<input type="checkbox" name="activity.couponRule"   id="couponRule_2" value=2 class="sellTypeCheckBox" />运单优惠券&nbsp;&nbsp;
						<div id="couponRuleTip"  ></div>
					</div>
				</div>							
				

				<div class="addADV cf">
					<label>&nbsp;</label>
					<div class="infoADV">
						<input type="button" id="submitFormButton" onclick="return checkForm()"
							value="保存" class="m-btn"  /> <input type="button" id="cancelForm"
							value="取消" onclick="window.history.go(-1)" class="m-btn" />
					</div>
				</div>

			</div>
		</form>
	</div>
	
	<script type="text/javascript">
	$(function(){
		 initCheck();
	});
	function initCheck(){
		$.formValidator.initConfig({validatorGroup:"activity",formID:"addActivityFrom",theme:"Default",submitOnce:false,wideWord:false,onError:function(){}});
		$("#actCode").formValidator({validatorGroup:"activity",onShow:"请输入活动代码"})
		.inputValidator({min:3,max:15,onErrorMin:"请输入大于3个字符",onErrorMax:"请输入小于15个字符",empty:{leftEmpty:false,rightEmpty:false,emptyError:"两边不能有空格"},onError:"请输入活动代码"})
		.regexValidator({ regExp: "[a-zA-z0-9]{6,15}", onError: "请填写6-15个字符不包含中文" })
		.ajaxValidator({
			type:"get",
			async:true, 
			dataType:"json",
			url:"${_ctxPath}/marketactivity/marketact-checkRepetitiveName.htm",
			success:function(data){
	            if(data.code == "true" ){
					return false;
	            }else{
	            	return true;
	            }
			},
			buttons: $("#submitFormButton"),
			error: function(jqXHR, textStatus, errorThrown){alert("服务器没有返回数据，可能服务器忙，请重试"+errorThrown);},
			onError : "该活动代码已存在" 
		}).defaultPassed();
		
		$("#actName").formValidator({validatorGroup:"activity",onShow:"请输入活动名称"})
		.inputValidator({min:4,max:30, onError:"请输入活动名称大于4个字符，小于30个字符"})
		.ajaxValidator({
			type:"get",
			async:true, 
			dataType:"json",
			url:"${_ctxPath}/marketactivity/marketact-checkRepetitiveName.htm",
			success:function(data){
	            if(data.code == "true" ){
					return false;
	            }else{
	            	return true;
	            }
			},
			buttons: $("#submitFormButton"),
			error: function(jqXHR, textStatus, errorThrown){alert("服务器没有返回数据，可能服务器忙，请重试"+errorThrown);},
			onError : "该活动名称已存在" 
	}).defaultPassed();
		
		
		$("#openRule").formValidator({validatorGroup:"activity",onShow:"规则开关",onFocus:"规则开关"})
		.inputValidator({min:0,max:1});
				
		
		$(":radio[name='activity.sellTypes']").formValidator({
			validatorGroup:"activity",
			tipID:"sellTypesTip",
			onShow:"请选择销售类型",
			onFocus:"请选择销售类型",
			onCorrect:"恭喜你,你选对了"
			}).inputValidator({min:1,max:4,onError:"你选的个数不对,必须选择1个"});		
			
			$(":checkbox[name='activity.couponRule']").formValidator({
				validatorGroup:"activity",
				tipID:"couponRuleTip",
				onShow:"请选择优惠券类型",
				onFocus:"请选择优惠券类型",
				onCorrect:"恭喜你,你选对了"
				}).inputValidator({min:0,max:2});
					
		
	 	$("#startTime").formValidator({validatorGroup:"activity",onFocus:"请选择开始时间",onShow:"请选择开始时间"})
	 	.inputValidator({min:8,max:20,onErrorMin:"请选择开始时间",onErrorMax:"请选择开始时间",onError:"请选择开始时间"});
	 	$("#endTime").formValidator({validatorGroup:"activity",onFocus:"请选择结束时间",onShow:"请选择结束时间"})
	 	.inputValidator({min:8,max:20,onErrorMin:"请选择结束时间",onErrorMax:"请选择结束时间",onError:"请选择结束时间"})
	}
	var j = 2;//初始从2开始
	function addRuleDiv(){
		 var divHtml = '<div class="addADV cf" id ="ruleDiv'+j+'">'
		 divHtml +='<label><select class="m-sel" name ="activity.actRules['+(j-1)+'].lastConnection"><option value ="&&">并且</option><option value= "||">或者</option></select></label>'
		 divHtml +='<label style="width: 60px;"><i class="red">*</i>规则'+j+': </label>'
		 divHtml += '<span class="infoADV">'
		 divHtml += '<select class="m-sel" style = "width:300px;" id="rulePlusDiv'+j+'" name = "activity.actRules['+(j-1)+'].id">'
		 divHtml +=	'<c:forEach items ="${marketRule2}" var = "marketRules"  varStatus="state">'
		 divHtml +=	'<option value="${marketRules.id}">${marketRules.name}</option>'		
		 divHtml +=	'</c:forEach>'	
		 divHtml +='</select><a href = "javascript:;" onclick ="delRuleDiv('+j+');">&nbsp;&nbsp;-</a>'	
		 divHtml +='</span>'	
		 divHtml +='</div>';
		 var ruleOneVal = $("#rulePlusDiv1").val();
		 
		 var rulePlusHtml = $("#rulePlusDiv"+j);
		  $("#rulePlus").before(divHtml);
		/*  for(var i =0;i<$("#rulePlusDiv"+j+" option").length;i++){
			 var second = $("#rulePlusDiv"+j+" option")[i].value;
			 if(second==ruleOneVal){ 
				 $("#rulePlusDiv"+j+" option")[value=(j-2)].remove();
			 }else{
				 alert("ok");
				 $("#rulePlusDiv"+j).removeAll();
			 }
		 } */
			 j+=1;//规则序号递增
	 };
	 
	function delRuleDiv(n){
		  $("#ruleDiv"+n).remove();
		  //j = 2;重置id索引
	} 
	
	//规则显示隐藏
	$("#openRule").click(function(){
		var ischecked = $(this).is(":checked");
		if(ischecked==true){
			$("#ruleDiv1").show();
			$("select[id^='rulePlusDiv']").attr("disabled",false);
		}else if(ischecked==false){
			 $("select[id^='rulePlusDiv']").attr("disabled",true);
			 $("div[id^='ruleDiv']").hide(); 
		
		}
	});
	
	function checkForm(){
		var result = $.formValidator.pageIsValid('activity');
		if(!result){
			return false;
		}
		$("#addActivityFrom").submit();
	}
	
	
	
	</script>
	<script type="text/javascript">
    var _ctxPath = '${_ctxPath}',
    		_filePath = '${_filePath}',
    		_fileThumbPath = '${_fileThumbPath }',
    		_jsPath = '${_jsPath }';
</script>
</body>
</html>