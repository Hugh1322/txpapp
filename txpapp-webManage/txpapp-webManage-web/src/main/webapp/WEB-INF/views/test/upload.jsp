<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="../common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<title>Insert title here</title>
</head>
<body>
<form name="serForm" action="<%=basePath%>/upload/v1/fileUpload.do" method="post"  enctype="multipart/form-data">
	<h1>采用流的方式上传文件</h1>
	<input type="file" name="files">
	<input type="submit" value="upload"/>
</form>

<form name="Form2" action="<%=basePath%>/upload/v1/fileUpload2.do" method="post"  enctype="multipart/form-data">
	<h1>采用multipart提供的file.transfer方法上传文件</h1>
	<input type="file" name="files">
	<input type="submit" value="upload"/>
</form>

<form name="Form2" action="<%=basePath%>/upload/v1/springUpload.do" method="post"  enctype="multipart/form-data">
	<h1>使用spring mvc提供的类的方法上传文件</h1>
	<input type="file" name="files">
	<input type="submit" value="upload"/>
</form>
</body>
</html>