<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="java.util.Enumeration"%>
<%@include file="../include/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>${_webSiteNameManager }</title>
<link href="${_cssPath}/common.css" rel="stylesheet" />
<link href="${ _cssPath}/pages/login.css" rel="stylesheet" />

<meta http-equiv="imagetoolbar" content="no" />
<script type="text/javascript" src="${_jsPath}/jquery/jquery.1.8.1.js"></script>
<script src="${_jsPath }/plugin/formvalidator/formValidatorRegex.js" language="javascript"></script>
<script src="${_jsPath }/plugin/formvalidator/formValidator-4.1.3.js" language="javascript"></script>
<script type="text/javascript">
	//var j = jQuery.noConflict();
	var _ctxPath = '${_ctxPath}';
	var _filePath = '${_filePath}';
	var _imagesPath = '${_imagesPath}';
	var winParams = {};
</script>
<script type="text/javascript">
	function genTimestamp(){
		var time = new Date();
		return time.getTime();
	}
	var changeCaptcha=function(){
		$('#captchaImg').attr('src','${_ctxPath}/system/user/getVerifyCode.do?t='+genTimestamp());
	}

	function loginSys() {
		if($("#account_id").val()==null||$("#account_id").val()==''
		||$("#psw").val()==null||$("#psw").val()=='') {
			$("#login_v_msg").html("请输入用户名和密码");
			return false;
		}else if($("#checkcode").val()==null||$("#checkcode").val()=='') {
			$("#login_v_msg").html("请输入验证码");
			return false;
		}else {
			$("#login_v_msg").html("");
			//判断是否保存用户名
			var storage = window.localStorage;
			if($("#remb_me").is(':checked')){
				//存储到loaclStage
				storage["account_id"] = $("#account_id").val();
				storage["psw"] = $("#psw").val();
				storage["isstorename"] =  "yes";
			}else{
				storage["account_id"] = "";
				storage["psw"] = "";
				storage["isstorename"] =  "no";
			}
			return true;
		}
	}


</script>
</head>
<%
	Enumeration en = request.getParameterNames();
	if (en.hasMoreElements()) {
		String error = String.valueOf(en.nextElement());
		Object times = session.getAttribute("LOGIN_ERROR");
		request.setAttribute("error", error);
	}
%>
<body>
	<div class="head">
		<span>商家服务电话：${_telManager}</span>
	</div>
	<div class="title">
		<i class="tit-img"></i>
	</div>
	<div class="login-bg">
		<div class="login-main">
			<div class="login-left">
			</div>
			<div class="login-center rel" id="loginCen">
				<div class="logPanel">
					<ul>
						<li class="cur">登录</li>
						<li>网点首次登录</li>
					</ul>
				</div>
				<div class="logMain">
					<div class="logCon" style="display:block;">
						<form method="post" id="login_form" action="${_ctxPath}/system/user/index.do" name="login_form" autocomplete="off" onsubmit="return loginSys();">
							<ul>
								<li><span class="tit">登录名：</span> <input type="text" class="input-text"
									id="account_id" name="username"
									value="${SPRING_SECURITY_LAST_USERNAME }" maxlength="20" /> <span
									id="accountTip"></span> 
								</li>
								<div class="msgRes" id="login_v_msg"></div>
								<li><span class="tit">密码：</span> <input type="password" name="password"
									id="psw" class="input-text" maxlength="20" /> 
									 <span id="pswTip"></span> 
									 
								</li>
								<s:if test="#session.LOGIN_ERROR > 1">
								<li><span class="tit">验证码：</span> <input type="text" name="verifyCode"
									id="checkcode" class="input-img" maxlength="4" /> <img alt="验证码" src=""
									class="captchaImg" id="captchaImg"/> <a class="yzmtxt"
									style="cursor: pointer;" onclick="changeCaptcha()">看不清换一张</a> 
								</li>
								</s:if>
								<li>
									<span class="tit">&nbsp</span>
									<input checked="checked" type="checkbox" class="l-checkbox" id="remb_me"/>
									<label for="login_c">记住我</label>
									<!--<a href="#" class="l-forget">忘记密码</a> -->
								</li>
							</ul>
							<div class="postBtn">
								<input type="submit" class="btn" value="登录" />
							</div>
							<div class="msgRes">
								<c:if test="${error == 'error1'}">
										<i class="l-error"></i>该用户不存在
								</c:if> 
								<c:if test="${error == 'error4'}">
										<i class="l-error"></i>
									该用户被冻结，请联系新龙管理员
								</c:if>
								<c:if test="${error == 'error5'}">
										<i class="l-error"></i>该用户被禁用，请联系账号管理员
								</c:if>
								<c:if test="${error == 'error'}">
										<i class="l-error"></i>密码错误
								</c:if>
								<c:if test="${error == 'error2'}">
									<i class="l-error"></i>验证码错误
								</c:if>
								<c:if test="${error == 'error6'}">
										<i class="l-error"></i>
									买家不能登录
								</c:if>
							</div>
					</form>
				</div>
				<div class="logCon">
						<form action="">
							<ul>
								<li>
									<span class="tit">网点码：</span>
									<input type="text" class="input-text" id="onlineCode"/>
								</li>
								<li>
									<span class="tit">手机号：</span>
									<span id="msgTel">
										<input type="text" class="input-text" id="onlineCode3"/>
									</span>
								</li>
								<li>
									<span class="tit">激活码：</span>
									<input type="text" class="input-img" id="activateCode"/><em class="jhm" id="createSMSCode">获取短信激活码</em>
								</li>
							</ul>
							<div class="postBtn">
								<input type="button" id="onlineSub" class="btn" value="确认" />
							</div>
							<div class="msgRes" id="msgCode"></div>
						</form>
					</div>
				</div>
			</div>	
			</div>
	</div>
	<div class="login-foot">
		<p>${_footCopyrightManager }</p>
		<p>${_footAddressManager }</p>
	</div>
<jsp:include page="/WEB-INF/views/include/foot.jsp"></jsp:include>

<script type="text/javascript" src="${_jsPath}/pages/login.js"></script>
<script type="text/javascript">
$(function(){
	changeCaptcha();

	$("#onlineSub").on("click",function(){
		var code = $("#onlineCode").val();
		var activateCode = $("#activateCode").val();
		var tel = $("#tel").text();
		if(code==''||code==null||code==undefined){
			$("#msgCode").html("<i class='l-error'></i>请输入网点代码");
			return false;
		}
		if(activateCode==''||activateCode==null||activateCode==undefined){
			alert(activateCode);
			$("#msgCode").html("<i class='l-error'></i>请输入激活码");
			return false;
		}
		if(tel==''||tel==null||tel==undefined){
			$("#msgCode").html("<i class='l-error'></i>重新输入网店获得手机号码");
			return false;
		}
		//console.log(_ctxPath+"/admin/user/activeAccount.htm");
		//去后台 验证激活码
		$.ajax({
				  type: 'POST',
				  url: _ctxPath+"/admin/user/activeAccount.htm",
				  data: {'tel':tel,'smsCode':activateCode},
				  success: function(data){
					  if(data.code!='6'){
						  alert(data.info);
					  }else{
						  alert("激活成功");
						  $.ajax({
							  type: 'POST',
							  url: _ctxPath+"/admin/user/user-activePassword.htm",
							  success: function(html){
								  //修改密码 进行登陆
								  $.dialog({
									    lock: true,
									    padding: "5px",
									    title:false,
									    content:html,
									    fixed: true,
									    cancel: true,
									    cancelValue: "关  闭",
									    closed:false,
									    okValue:"保  存",
									    ok:function(){
									    	var result = $.formValidator.pageIsValid('1001');
									    	if(!result){
												return false;
											}else{
												var pwdA = $("#pswActive").val();
												$.ajax({
													 type: 'POST',
													 url: _ctxPath+"/admin/user/user-active.htm",
													 data: {'user.password':$("#pswActive").val(),'user.username':code,"smsCode":activateCode},
													 success: function(data){
														 if(data.code!='6'){
															 alert(data.info);
														 }else{
															 alert(data.info);
															 $("#account_id").val(code);
															 $("#psw").val(pwdA);
															 $("#login_form").submit();
														 }
													 },
													 dataType : 'json'
												});
											}
									    }
								  });
								  $('.d-close').remove();
							  },
							  dataType:"html"
						  })
					  }
				  },
				  error: function(XMLHttpRequest, textStatus, errorThrown) {
                      alert(XMLHttpRequest.status);
                      alert(XMLHttpRequest.readyState);
                      alert(textStatus);
                  },
				  dataType : 'json'
		})
	});
	$("#onlineCode").on("blur",function(){
		var code = $(this).val();
		if(code==''||code==null||code==undefined){
			$("#msgCode").html("<i class='l-error'></i>请输入网点代码");
		}else{
			$("#msgCode").html("");
			$.ajax({
				 type: 'POST',
				  url: _ctxPath+"/admin/user/showOnline.htm",
				  data: {'user.username':code},
				  success: function(data){
					  if(data.code!='1'){
							$("#msgCode").html("<i class='l-error'></i>"+data.info);
							$("#onlineCode").val("");
							$("#onlineCode").focus();
							$("#msgTel").html("");
					  }else{
						  $("#msgTel").html("<span class='txtNum' id='tel'>"+data.info+"</span> <em class='red' style='margin-left:8px;'>(如果不是您的手机号码请联系客服)</em><p class='red' style='padding-left:70px;'>客服电话：400-885-2700</p>");
					  }
				  },
				  dataType : 'json'
			})
		}
		
	});
	$("#createSMSCode").on("click",function(){//获取验证码
		var tel = $("#tel").text();
		if(tel==''||tel==null||tel==undefined){
			$("#msgCode").html("<i class='l-error'></i>重新输入网点获得手机号码");
			return false;
		}
		var $this = $(this);
		if($this.hasClass("disabled")) return false;
		$.ajax({
			type:'POST',
			url:_ctxPath+"/admin/user/getActiveCode.htm",
			data: {'user.tel':tel},
			success: function(data){
				alert(data.info);
			},
			dataType : 'json'
		});
//		showtime ($this);
		
	});
});
//倒计时
//function showtime (obj){
//	var $this = obj,
//		i = 60,
//		timer = setInterval(function(){
//			if(i>0){
//				var val = "重新获取（" + i + "秒）";
//				$this.text(val);
//				i--;
//			}else{
//				$this.text("获取短信激活码");
//				clearInterval(timer);
//				$this.removeClass("disabled");
//			}
//		},1000);
//	$this.addClass("disabled")
//}

//判断是否存在过用户
var storage = window.localStorage;
if("yes" == storage["isstorename"]){
	$("#remb_me").attr("checked", true);
	$("#account_id").val(storage["account_id"]);
	$("#psw").val(storage["psw"]);
}

	if('${not empty errorMsg}') {
		$("#login_v_msg").html('${errorMsg}');
	}
</script>
</body>
</html>