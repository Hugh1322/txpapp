<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.txp.app.contants.AdvPosition"%>
<%@include file="../../include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>广告位</title>
    <link href="${_cssPath }/common.css" rel="stylesheet" />
    <link href="${_cssPath }/pages/arrangement.css" rel="stylesheet" />
    <link href="${_cssPath }/pages/bannerManage.css" rel="stylesheet" />
    <script src="${_jsPath }/jquery/jquery.1.8.1.js"  language="javascript"></script>
    <script src="${_jsPath}/plugin/formvalidator/formValidatorRegex.js" language="javascript"></script>
    <script src="${_jsPath}/plugin/formvalidator/formValidator-4.1.3.js" language="javascript"></script>
    <script src="${_jsPath}/pages/specAdv.js" language="javascript"></script>
    <!--[if IE]>
		<script src="${_jsPath}/pages/ieplaceholder.js"></script>
	<![endif]-->
</head>
<body>
	<!--start header-->
	<jsp:include page="../../include/header.jsp"></jsp:include> 
	<div class="body m-w980p">
	<%--  <jsp:include page="../include/pageManageMenu.jsp"  flush="true" />  --%>
		 <form class="sub-form m-clear m-mt10p" action="${_ctxPath }/admin/adv/groupProductAdv_toAddDetail.htm" id="addForm" method="post">
		 	<div class="m-fl"><%-- 广告类型 --%>
		          		 	<input type="submit" class="m-btn" value="新增团购广告" />
	         </div>
	         
		</form>
		
        <!--start 商家管理table-->
        <div class="m-mt10p business-management">
            <table class="tab-control" id="tab">
                <thead>
                    <tr>
                        <th width="15%">广告名称 </th>
                        <th width="15%">广告类型</th>
                        <th width="15%">预览广告</th>
                        <th width="15%">展示位置</th>
                        <th width="15%">操作</th>
                    </tr>
                </thead>
                <tbody>
                 <c:forEach items="${advPage.result}" var="adv" varStatus="status">
                 	<tr>
						
						<td>团购广告</td>
						<td>${adv.position.positionName}</td>
						
						<td>
							<div class="relative">
								<c:if test="${adv.imageUrl != '' && adv.imageUrl!= null}">
									<span style="display: none;"><yp:thumbImage originalPath='${adv.imageUrl}' imageType='t5'></yp:thumbImage></span>
									<a class="preview" style="cursor: pointer;" onclick="imgView(this)">预览</a>
									<%-- <a class="preview" style="cursor: pointer;" onclick="imgView('${adv.picUrl}','${adv.position.width}','${adv.position.height}')">预览</a> --%>
								</c:if>
							</div>
						</td>
						<td>团购广告位</td>
						<td><a onclick="clickAddOrEditGroupAdv('${adv.advertisementId}','${_ctxPath}/admin/adv/groupProductAdv_toEditDetail.htm')" style="cursor: pointer;">编辑</a>&nbsp;
						<a style="cursor: pointer;" onclick="delGroupAdv('${adv.advertisementId}','${_ctxPath}/admin/adv/groupProductAdv_delDetail.htm')" class="m-5">删除</a></td>
					</tr>
                 </c:forEach>
                </tbody>
            </table>
        </div>
        <div class="table-bm-wrap cf">
			<!--S 右功能区-->
			<div class="fn-right">
				<!--S 分页-->
				<div class="pagination pagination-right">
					<c:if test="${not empty advPage.result}">
						<yp:commPage page="${advPage}" beanName="advPage"></yp:commPage>
					</c:if>
				</div>
				<!--E 分页-->
			</div>
			<!--E 右功能区-->
		</div>
       <!--end 商家管理table-->
	 </div>
	 <form action="${_ctxPath }/admin/adv/adv_goToAdd.htm"  id="goToAddForm">
	 	<input name="index" value="" id="index" type="hidden"/>
	 </form>
	<!--end foot-->
	<jsp:include page="/WEB-INF/views/include/foot.jsp"></jsp:include>
	<script language="javascript">
	function clickAddOrEditGroupAdv (id,actionUrl){
		// alert(code+"----"+${SHUFFLING_FIGURE});
		var html = '';
		$.ajax({
			url: actionUrl,// + "/admin/adv/seasonal_toEditDetail.htm",
			type:"POST",
			data:{'adv.advertisementId':id},
			dataType:"html",
			async: false,
			disable:false,
			success:function(data){
				html=data;
				$.dialog({
				  lock: true,
				  padding: "5px",
				  title:false,
				  content:html,
				  fixed: false,
				  cancel: true,
				  cancelValue:"取  消",
				  ok:function(){
					  var result = $.formValidator.pageIsValid('1');
					  if(!result){
					  	return false;
					  }
					 $("#advForm").submit();
				  },
				  okValue:"发  布"
				});
			},
			error:function(data){
				// alert(data.responseText);
			}
		});
	};
	function delGroupAdv(id,url){// 删除广告
		$.dialog({
			  lock: true,
			  padding: "5px",
			  title:false,
			  content:"确认删除该项吗?",
			  fixed: false,
			  cancel: true,
			  cancelValue:"取 消",
			  ok:function(){
				  $.ajax({
						url:url,
						type:"POST",
						data:{'adv.advertisementId':id},
						dataType:"json",
						async: false,
						success:function(data){
							if(data.code==3){// 删除成功
								window.location.reload();
							}else{
								alert("删除失败!");
							}
						}
					});
			  },
			  okValue:"删除"
		});
	}
</script>
</body>
</html>