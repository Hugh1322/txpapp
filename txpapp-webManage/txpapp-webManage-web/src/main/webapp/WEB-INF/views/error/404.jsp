<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglibs.jsp"%>
<!DOCTYPE HTML>
<html lang="en-US">
<head>
    <meta charset="UTF-8">
    <title>404</title>
	<style type="text/css">
	*{margin:0;padding:0;}
	.box_404{background:url('${_imagesPath}/mBj_404.jpg') 0 175px no-repeat;width:600px;height:350px;position:absolute;margin:150px 0 0 -300px;left:50%;}
	.box_404 h1,.box_404 h2{font-family:Microsoft Yahei;font-weight:normal;}
	.box_404 h1{font-size:38px;}
	.box_404 h2{font-size:24px;}
	.msg_404{border:1px solid #ccc;padding:20px;}
	.msg_404 p{margin-top:10px;}
	.msg_404 p a{color:#000;}
	</style>
</head>
<body>
	<div class="box_404">
		<div class="msg_404">
			<h1>出错了</h1>
			<h2>您要找的内容不存在~~</h2>
			<p><a href="${_ctxPath }/">回到首页</a></p>
		</div>
	</div>
</body>
</html>