<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>
<form action="${_ctxPath}/admin/adv/hotWord_saveAdv.htm" method="post" id="hotWordsAddFrom">
<input name="adv.advertisementId" value="${adv.advertisementId}" type="hidden"/>
<div class="m-mt10p addBanner">
	<div  class="addADV cf">
		<label for=""><i class="red">*</i>位置：</label>
		<div class="infoADV">
		<input name="adv.positionId" value="${position.positionId}" type="hidden"/>
		<c:out value="${position.positionName}"></c:out>
		</div>		
	</div>
	<input name="adv.type" value="${adv.type}" type="hidden"/>
	<div class="addADV cf">
		<label for=""><i class="red">*</i>广告名称：</label>
		<div class="infoADV">
			<input type="text" name="adv.advertisementName" placeholder="如：大枣（最大支持6个汉字)" style="width: 251px" id="hotWorldAdvName" class="J-keywords txt-input input-marks" value="${adv.advertisementName }" maxlength="6"  />
			<div id="hotWorldAdvNameTip"></div>
		</div>
	</div>
	<div class="addADV cf">
		<label for=""><i class="red">*</i>顺序：</label>
		<div class="infoADV">
		<input type="text" name="adv.rank" id="hotWorldAdvRank" class="J-keywords txt-input input-marks" placeholder="请输入1-10的数字"  value="${adv.rank }"/>
		<div id="hotWorldAdvRankTip"></div>
		</div>
	</div>
	<div class="addADV cf">
		<label for=""><i class="red">*</i>跳转地址：</label>
		<div class="infoADV">
			<input type="text" name="adv.url" id="hotWorldadvUrl" class="J-keywords txt-input input-marks" placeholder="http://" value="${adv.url }"  style="width: 251px"/>
			<div id="hotWorldadvUrlTip"></div>
		</div>
	</div>
	<c:if test="${empty adv.advertisementId}">
		<div class="addADV cf">
			<label>&nbsp;</label>
			<div class="infoADV">
				<input type="button" id="submitForm"  onclick="submittCheck()" value="保存" class="m-btn"/>
				<input type="button" id="cancelForm" value="取消" onclick="window.history.go(-1)" class="m-btn"/>
			</div>
		</div>
	</c:if>
</div>
</form>
 <script type="text/javascript">
var initData = $.formValidator.initConfig({validatorGroup:"hotWords_vg",formID:"hotWordsAddFrom",theme:"Default",forceValid:true,submitOnce:true,wideWord:false,onError:function(){}});
		$("#hotWorldAdvName").formValidator({validatorGroup:"hotWords_vg",onShow:"请输入名称"}).inputValidator({min:1,max:6,onErrorMin:"请输入大于1个字符",onErrorMax:"请输入小于6个中文字",empty:{leftEmpty:false,rightEmpty:false,emptyError:"广告名称两边不能有空格"},onError:"请输入广告名称"});
		$("#hotWorldadvUrl").formValidator({validatorGroup:"hotWords_vg",empty:false,onShow:"请输入跳转地址",onFocus:"请输入跳转地址"}).inputValidator({onError:"你输入网址格式不正确"}).regexValidator({regExp:"url",dataType:"enum",onError:"你输入网址格式不正确"});
		$("#hotWorldAdvRank").formValidator({validatorGroup:"hotWords_vg",onShow:"请输入1-10的数字"}).functionValidator({ fun: isRightRank ,onError:"请输入1-10的数字"});;
 $(function(){
	if($.fn.placeholder){
		$('input[placeholder]').placeholder();
		$('textarea[placeholder]').placeholder();
	}
}); 
function isRightRank(val){
	
	  var reg2=/^\d{1,2}$/;
	   
	  if(reg2.test(val)){
	   var num =parseInt(val);
	   if(num<=10 && num >0)
		  return true;
	  }
	return false;
}

function submittCheck(){
	var result = $.formValidator.pageIsValid('hotWords_vg');
	if(!result){
		return false;
	}
	var mxV =$("#maxSize").val();
	if(mxV){
		if(parseInt(mxV) >=7){
			alert("警告，热搜词广告已经超过7个，可能会影响展示效果！");
		} 
	} 
	$("#hotWordsAddFrom").submit();
}
 
 </script>