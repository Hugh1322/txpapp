<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript" src="${_jsPath}/plugin/uploadify/swfobject.js"></script>
<script type="text/javascript" src="${_jsPath}/plugin/uploadify/jquery.uploadify.v2.1.4.min.js"></script>


<script type="text/javascript">

//	$(function(){
//		$("[name=chkbox]").click(function(){
//
//			//当选中或取消一个权限时，也同时选中或取消所有的下级权限
//			$(this).siblings("ul").find("input").attr("checked",this.checked);
//
//			//当选中一个权限时，也要选中所有的直接上级权限
//			if(this.checked ==true){
//				$(this).parents("li").children("input").attr("checked",true);
//			}
//
//			//当某一个父权限下的子权限都不选中时，该父权限也不选中
//			var elements=$(this).parent("li").parent("ul").find("input");
//			var num=elements.length;
//			/*alert(num);*/
//			var a=0;
//			for(var i=0;i<num;i++){
//				if(elements[i].checked==false){
//					a++;
//				}
//			}
//			if(a==num){
//				$(this).parent("li").parent("ul").siblings("input").attr("checked",false);
//			}
//
//		});
//
//	});
</script>
<div class="m-mt10p addBanner2">
	<form action="${_ctxPath}/test/user/save/locSpecList.do" method="post"
		id="advForm">
		<c:if test="${not empty role}">
			<input type="hidden" id="roleId" name="roleId" value="${role.id}" />
		</c:if>
	 <jsp:include page="editRoleContent.jsp"></jsp:include>

	</form>

</div>