<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html xmlns="http://www.w3.org/1999/xhtml">

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>信息发送</title>
<link href="${ _cssPath}/common.css" rel="stylesheet" />
<script src="${_jsPath }/jquery/jquery.1.8.1.js" language="javascript"></script>
<script type="text/javascript" src="${_jsPath }/plugin/ckeditor/ckeditor.js"></script>

<style>
.tab-control th {
	text-align: center;
}

.message_main {
	height: 500px;
}

.message_left {
	width: 120px;
	height:444px;
	float: right;
	overflow:hidden;
	margin-right:158px;
}

.jsobj {
	display: block;
	font-size: 12px;
	height: 28px;
	line-height: 28px;
	letter-spacing: 1px;
	width: 120px;
}

.jsobj_show {
	color: #FF0000;
}

.sxnz_show {
	color: #FF0000;
}

.message_left p {
	font-size: 12px;
	height: 28px;
	line-height: 28px;
	letter-spacing: 1px;
}

#message_send {
	width: 114px;
	height:260px;
}

.message_right {
	width: 702px;
	height: 200px;
	float: right;
}

.sxnz {
	font-size: 12px;
	height: 28px;
	line-height: 28px;
	letter-spacing: 1px;
	display: block;
	width: 570px;
}

#message_pand {
	width: 570px;
}

.fs {
	display: block;
	width: 63px;
	float: right;
	margin-top: 10px;
}

.sx {
	margin-left: 80px;
}
</style>
<script>

	function message_send_blur() {
		var message_send = document.getElementById("message_send").value;
		if (message_send == ("" | null)) {
			$(".jsobj_show").show();
			return false;
		} else {
			$(".jsobj_show").hide();
			//message_send = message_send.toUpperCase();
			message_send = message_send.replace(/\r\n/g, "/");
			message_send = message_send.replace(/\n/g, "/");
			message_send = message_send.replace(/\//g, ",");
			$("#input_message").val(message_send);
			var arr1 = message_send.split(",").length;
			$(".message_send_value").text(arr1);
		}
		return true;
	}
	function message_pand_blur() {
		var message_pand = CKEDITOR.instances.message_pand.getData();
		if (message_pand == ("" | null) || (message_pand.length > 500)) {
			$(".sxnz_show").show();
			return false;
		} else {
			$(".sxnz_show").hide();
		}
		return true;
	}
	$(document).ready(function() {
		if('${tipMessage}'){
			alert('${tipMessage}');
		}
		
		$("#message_send").blur(function() {
			message_send_blur();
		});
		$("#message_pand").blur(function() {
			message_pand_blur();
		});
		$("#message_butfs").click(function() {	
			if(message_send_blur() && message_pand_blur()){
				$("#messageSendForm").submit();
			}
		})

	})
	
	function jumpUrl(){
		location.href='${_ctxPath}/admin/accounts/messageCenter-messageList.htm';
	}
	
</script>

</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp" flush="true" />
	<div class="body m-w980p income_fa">
		<aut:authorize url="${_ctxPath}/admin/accounts/messageCenter-messageList">
			<form class="m-mt10p m-clear"
				action="${_ctxPath}/admin/accounts/messageCenter-messageList.htm"
				id="search-form" method="post">
				<div class="m-fl"></div>
				<c:if test="${not empty messagePage.result}">
					<div class="m-fr curr-num">
						<label>当前显示： </label>
						<yp:commPageSize page="${messagePage}" beanName="messagePage"
						actionUrl="${_ctxPath}/admin/accounts/messageCenter-messageList.htm"></yp:commPageSize>
					</div>
				</c:if>
			</form>
		</aut:authorize>

		<!--start 买家管理table-->
		<div class="message_main">
			<!--补充内容 start-->
			<form action="${_ctxPath}/admin/accounts/messageCenter-sendMessage.htm" id="messageSendForm" method="post">
				<div class="message_right">
					<!--消息内容 start-->
					<div class="sxnz">
						<span>消息内容：</span><span class="sxnz_show" style="display: none;">请输入1-500字的消息内容</span>
					</div>
					<textarea class="edit-textarea" maxlength="1000" name="messageInfo" id="message_pand">${messageInfo}</textarea>
					<!-- <textarea id="message_pand" name="messageInfo"></textarea> -->
					<span class="fs"><input type="button" class="m-btn"
						value="发 送" id="message_butfs" /> </span>
				</div>
				<!--消息内容 end-->
				<div class="message_left">
					<!--接收对象 start-->
					<div class="jsobj">
						<span class="jsobj_font">接收对象(登录名)：</span> 
					</div>
					<textarea id="message_send" name="tempTeceivers">${tempTeceivers}</textarea>
					<p>
						已输入<span class="message_send_value">0</span>人<input type="hidden"
							id="input_message" name="receivers"/>
					</p>
				    <span class="jsobj_show" style="display:none;">请输入1-200个用户登</br>录名，每行代表一个</br>用户。</span>
				</div>
				<!--接收对象 end-->
			</form>
			<div class="message_change">
				<span class="sxnz">发送记录：</span><span class="sx"><input
					type="button" class="m-btn"  value="刷 新" onclick="jumpUrl()"/> </span>
			</div>
		</div>
		<!--补充内容 end-->
		<div class="m-mt10p income_dowm">
			<table width="100%">
				<thead class="tab-control">
					<tr id="income_tr">
						<th width="20%">登录名</th>
						<th width="15%">姓名</th>
						<th width="15%">手机号码</th>
						<th width="35%">消息内容</th>
						<th width="15%">消息发送时间</th>
					</tr>
				</thead>
				<tbody class="income_tbody">
					<c:forEach items="${messagePage.result}" var="messgecnter">
						<tr>
							<td>${messgecnter.username}</td>
							<td>${messgecnter.realname}</td>
							<td>${messgecnter.mobile}</td>
							<td>${messgecnter.messageTemplate.message}</td>
							<td><fmt:formatDate value='${messgecnter.sendtime}'
									pattern='yyyy-MM-dd HH:mm:ss' />
							</td>
						</tr>
					</c:forEach>

				</tbody>
			</table>
		</div>
		<!--end 买家管理table-->
		<div class="pagination pagination-right" style="position:relative;">
			<c:if test="${not empty messagePage.result}">
				<yp:commPage actionUrl="${_ctxPath}/admin/accounts/messageCenter-messageList.htm" 
				page="${messagePage}" beanName="messagePage"></yp:commPage>
			</c:if>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/foot.jsp"></jsp:include>

<script type="text/javascript">
	var editor = CKEDITOR.replace("message_pand");
</script>
</body>
</html>