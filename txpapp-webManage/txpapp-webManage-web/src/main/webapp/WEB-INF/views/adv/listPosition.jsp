<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.txp.app.contants.AdvPosition"%>
<%@include file="../include/taglibs.jsp"%>
<%
	pageContext.setAttribute("ADRESS_PRODUCT",com.txp.app.contants.AdvPosition.ADRESS_PRODUCT);
	pageContext.setAttribute("PRODUCT_CATEGORY",com.txp.app.contants.AdvPosition.PRODUCT_CATEGORY);
	pageContext.setAttribute("SHUFFLING_FIGURE",com.txp.app.contants.AdvPosition.SHUFFLING_FIGURE);
	pageContext.setAttribute("CITY_SELECT",com.txp.app.contants.AdvPosition.CITY_SELECT);
	pageContext.setAttribute("HOT_PRODUCT",com.txp.app.contants.AdvPosition.HOT_PRODUCT);
%>
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
</head>
<body>
	<!--start header-->
	<jsp:include page="../include/header.jsp"></jsp:include> 
	<div class="body m-w980p">
	    <!--start 商家管理table-->
        <div class="m-mt10p business-management">
            <table class="tab-control" id="tab">
                <thead>
                    <tr>
                        <th width="60%">广告类型</th>
                        <th width="40%">操作</th>
                    </tr>
                </thead>
                <tbody>
                	<c:forEach var="p" items="${positions}">
                		<tr >
		          			<td align="center">${p.positionName}</td>
                 			<td align="center"><a href="${_ctxPath }/admin/adv/showAdv.htm?advPage.params.positionId=${p.positionId }">查看</a>
                 			<c:if test="${p.code ==  'LOCAL_SPECIALITY' or p.code =='SEASONAL_GOODS'}">
                 			<c:if test="${p.hidden == 1}">
                 			 <p>
	                 			<a  style="cursor: pointer;" onclick="clickAction('${p.positionId}',this)" >显示</a>
                 			 </p>
                 			</c:if>
                 			<c:if test="${p.hidden !=1 }">
                 			 <p>
	                 			<a style="cursor: pointer;" onclick="clickAction('${p.positionId}',this)" >隐藏</a>
                 			 </p>
                 			</c:if>
                 			</c:if>
                 			</td>
                 		</tr>
		          	</c:forEach>
		          	<tr>
		          	<td align="center">首页通告栏</td>
                 			<%--<td  align="center"><a href="${_ctxPath }/admin/adv/dailyBanner_listDetail.htm">查看</a></td>--%>
                 			<td  align="center"><a href="http://localhost:8209/txpapp/system/user/income.do">查看</a></td>
		          	</tr>
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
	</div>
	 <script type="text/javascript">
	 function clickAction(id,ctr){
		 var t =$(ctr).text();
		 if(t=="隐藏"){
			 updatePosiHidden(id,ctr);
		 }else if(t=="显示"){
			 showPosion(id,ctr);
		 }
		  
		 
		 
	 }
	 
	 
	 function showPosion(id,ctr){
		 var url ="${_ctxPath }/admin/adv/adv_updatePostionShow.htm";
		 $.ajax({
				url: url, 
				type:"POST",
				data:{'position.positionId':id},
				dataType:"json",
				async: false,
				disable:false,
				success:function(data){
					if(data.code==3){//
					 $(ctr).text("隐藏");
					 succusTip("显示成功，刷新首页看看效果吧！");
					}else{
					 alert("操作失败");
					}
				},
				error:function(data){
					 alert("操作失败");
				}
			});
	 }
	 
	 function updatePosiHidden(id,ctr){// 删除广告
	 	var content = content="你正在使用广告隐藏功能，确认后该广告类型将&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<br>不在首页出现，但不影响广告链接的着陆页正常展示！<br>  是否仍然使用该功能？"
			$.dialog({
				  lock: true,
				  padding: "5px",
				  title:false,
				  content:content,
				  fixed: false,
				  cancel: true,
				  cancelValue:"取 消",
				  ok:function(){
					  $.ajax({
							url:"${_ctxPath }/admin/adv/adv_updatePositionHidden.htm",
							type:"POST",
							data:{'position.positionId':id},
							dataType:"json",
							async: false,
							success:function(data){
								if(data.code==3){//  
									 $(ctr).text("显示");
									 succusTip("隐藏成功，刷新首页看看效果吧！");
								}else{
									alert("隐藏失败");
								}
							}
						});
				  },
				  okValue:"隐藏"
			});
		}
	 
	 
	 function succusTip(content){
		 $.dialog({
			  lock: true,
			  padding: "5px",
			  title:false,
			  content:content,
			  fixed: false,
			  cancel: false,
			  okValue:"确定",
			  ok:function(){
				 
			  }}
			 ); 
	 }

	 
	 </script>
	
	<!--end foot-->
	<jsp:include page="/WEB-INF/views/include/foot.jsp"></jsp:include>
</body>
</html>