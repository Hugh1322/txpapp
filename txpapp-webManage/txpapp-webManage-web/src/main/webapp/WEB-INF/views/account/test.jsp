<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="com.txp.app.contants.Prop"%>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<meta charset="utf-8" />
<title>我的收入</title>
<link href="${_cssPath }/common.css" rel="stylesheet" />
<script type="text/javascript" src="${_jsPath }/jquery/jquery.1.8.1.js"></script>

<style>
	.order-management{margin-top:10px;}
	.order-management table{border:1px solid #BFAD61;}
	.order-management table td{border-bottom:1px solid #BFAD61;padding-left:5px;}
</style>
	<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
<script>
		function test(){
			$.ajax({
    			type:'POST',
    			url: _ctxPath + '/admin/accounts/test-create.htm',
    			data: "date="+$('#date').val(),
    			success:function(msg){
    				var messageObj = eval("(" + msg.info + ")")
    				alert(messageObj.message);
    			},
    			error: function(xhr){
    				popupDialog(xhr.responseText);
    	        }
    		});
		}
</script>
<body>
	<div align="center">
	<form action="{_ctxPath}/admin/accounts/test-create.htm">
		<input name="date" id="date"/>
		<input type="button" value="生成" onclick="test()" />
	</form>
	</div>
</body>
<jsp:include page="/WEB-INF/views/include/foot.jsp"></jsp:include>
</html>