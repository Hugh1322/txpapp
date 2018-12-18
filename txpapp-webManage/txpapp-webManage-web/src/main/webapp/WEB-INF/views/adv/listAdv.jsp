<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.txp.app.contants.AdvPosition"%>
<%@include file="../include/taglibs.jsp"%>
<%
	pageContext.setAttribute("ADRESS_PRODUCT",com.txp.app.contants.AdvPosition.ADRESS_PRODUCT);
	pageContext.setAttribute("PRODUCT_CATEGORY",com.txp.app.contants.AdvPosition.PRODUCT_CATEGORY);
	pageContext.setAttribute("SHUFFLING_FIGURE",com.txp.app.contants.AdvPosition.SHUFFLING_FIGURE);
	pageContext.setAttribute("CITY_SELECT",com.txp.app.contants.AdvPosition.CITY_SELECT);
	pageContext.setAttribute("HOT_PRODUCT",com.txp.app.contants.AdvPosition.HOT_PRODUCT);
	pageContext.setAttribute("EVERYDAY_RECOMMEND",com.txp.app.contants.AdvPosition.EVERYDAY_RECOMMEND);
	pageContext.setAttribute("HOME_RIGHT_ADV_185",com.txp.app.contants.AdvPosition.HOME_RIGHT_ADV_185);
	pageContext.setAttribute("HOME_RIGHT_ADV_180",com.txp.app.contants.AdvPosition.HOME_RIGHT_ADV_180);
	pageContext.setAttribute("INDEX_BANNER",com.txp.app.contants.AdvPosition.INDEX_BANNER);
	pageContext.setAttribute("INDEX_BANNER_TYPES_1",com.txp.app.contants.Advertisement.INDEX_BANNER_TYPES_1);
	pageContext.setAttribute("INDEX_BANNER_TYPES_2",com.txp.app.contants.Advertisement.INDEX_BANNER_TYPES_2);
	pageContext.setAttribute("KIND_ADVERTISEMENT","KIND_ADVERTISEMENT");
	pageContext.setAttribute("HOME_CENTER_ADV",com.txp.app.contants.AdvPosition.HOME_CENTER_ADV);
	
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
    <!--[if IE]>
		<script src="${_jsPath}/pages/ieplaceholder.js"></script>
	<![endif]-->
</head>
<body>
	<!--start header-->
	<jsp:include page="../include/header.jsp"></jsp:include> 
	<div class="body m-w980p">
	<%--  <jsp:include page="../include/pageManageMenu.jsp"  flush="true" />  --%>
		 <form class="sub-form m-clear m-mt10p" action="${_ctxPath }/admin/adv/show.htm" id="search-form" method="post">
		     <div class="m-fl"><%-- 广告类型 --%>
		     	  <div style="display: none;">
			          <select class="m-sel allSelect"  name="advPage.params.positionId">
			          		<option value="-1">全部</option>
			          	<c:forEach var="p" items="${positions}">
			          	<option value="${p.positionId }"
			          		<c:if test="${advPage.params.positionId == p.positionId}">
			          			selected="selected"
			          		</c:if>
			          		>${p.positionName}</option>
			          	</c:forEach>
			          </select>
		          </div>
		          <c:forEach var="p" items="${positions}">
		          		<c:if test="${advPage.params.positionId == p.positionId }">
		          			<c:choose>
		          			<c:when test="${p.code == EVERYDAY_RECOMMEND }">
		          			<c:if test="${empty advPage.result }">
		          		 	<input type="button" class="m-btn" value="新增${p.positionName }" onclick="addSeller('${p.code}')"/>
		          			</c:if>
		          			</c:when>
		          			<c:when test="${p.code == INDEX_BANNER }">
			          		 	<input type="button" class="m-btn" value="新增${p.positionName }" onclick="addSeller('${p.code}')"/>
		          			</c:when>
		          			<c:when test="${p.code == GROUP_PRODUCT }">
			          		 	<input type="button" class="m-btn" value="新增${p.positionName }" onclick="addSeller('${p.code}')"/>
		          			</c:when>
		          			<c:otherwise>
		          		 	<input type="button" class="m-btn" value="新增${p.positionName }" onclick="addSeller('${p.code}')"/>
		          			</c:otherwise>
		          			</c:choose>
		          		</c:if>
		          </c:forEach>
	         </div>
		     <div class="m-fr curr-num">
				  <c:if test="${not empty advPage.result}">
		                 <span class="m-fr curr-num">
		                     <label>当前显示： </label>
		                     <yp:commPageSize page="${advPage}" beanName="advPage"></yp:commPageSize>
		                 </span>
		          </c:if>
			</div>
		</form>
        <!--start 商家管理table-->
        <div class="m-mt10p business-management">
            <table class="tab-control" id="tab">
                <thead>
                    <tr>
                        <th width="40%">
                        	<c:forEach items="${advPage.result}" var="adv" end="0" varStatus="status">
                        		<c:if test="${adv.position.code eq CITY_SELECT }">城市名称</c:if>
                        		<c:if test="${adv.position.code ne CITY_SELECT }">广告名称</c:if>
                        	</c:forEach>
                       		</th>
                        <th width="15%">广告类型</th>
                        <th width="15%">预览广告</th>
                        <th width="15%">
	       					<c:choose>
								<c:when test="${not empty advPage.result and advPage.result[0].position.code eq INDEX_BANNER}">
									类型
	         					</c:when>
	         					<c:otherwise>
									   顺序
	         					</c:otherwise>
							</c:choose>                 
                     	</th>
                        <th width="15%">操作</th>
                    </tr>
                </thead>
                <tbody>
                 <c:forEach items="${advPage.result}" var="adv" varStatus="status">
                 	<tr>
						<td><c:if test="${adv.position.code eq CITY_SELECT }">${adv.cityName}</c:if>
						    <c:if test="${adv.position.code ne CITY_SELECT }">${adv.advertisementName}</c:if>
					    </td>
						<td>
							${adv.position.positionName}
						</td>
						<td>
							<div class="relative">
								<c:if test="${adv.imageUrl != '' && adv.imageUrl!= null}">
									<span style="display: none;"><yp:thumbImage originalPath='${adv.imageUrl}' imageType='t5'></yp:thumbImage></span>
									<a class="preview" style="cursor: pointer;" onclick="imgView(this)">预览</a>
									<%-- <a class="preview" style="cursor: pointer;" onclick="imgView('${adv.imageUrl}','${adv.position.width}','${adv.position.height}')">预览</a> --%>
								</c:if>
							</div>
						</td>
						<td>
							<c:choose>
								<c:when test="${adv.type eq INDEX_BANNER_TYPES_1 || adv.type eq INDEX_BANNER_TYPES_2}">
									<spring:message code="adv.index.banner.type.${adv.type}"/>
	         					</c:when>
	         					<c:otherwise>
	         						${adv.rank}
	         					</c:otherwise>
							</c:choose>
						</td>
						<td><a onclick="clickAddOrEdit('${adv.advertisementId}','${adv.position.code}')" style="cursor: pointer;">编辑</a>&nbsp;<a style="cursor: pointer;" onclick="delAdv('${adv.advertisementId}')" class="m-5">删除</a></td>
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
	function addSeller(type){//添加广告
		$("#index").val(type);
		$("#goToAddForm").submit();
	}
	function delAdv(id){//删除广告
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
						url:_ctxPath + "/admin/adv/adv_delAdv.htm",
						type:"POST",
						data:{'adv.advertisementId':id},
						dataType:"json",
						async: false,
						success:function(data){
							if(data.code==3){//删除成功
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
	
	var clickAddOrEdit=function(id,code){
		//alert(code+"----"+'${SHUFFLING_FIGURE}');
		var html = '';
		$.ajax({
			url:_ctxPath + "/admin/adv/adv_addAdv.htm",
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
					if(code=='${SHUFFLING_FIGURE}'){
						var result = $.formValidator.pageIsValid('1');
						if(!result){
							return false;
						}
						$("#advForm").submit();
					}else if(code=='${KIND_ADVERTISEMENT}'){
						var result = $.formValidator.pageIsValid('1');
						if(!result){
							return false;
						}
						$("#advForm").submit();
						
					}else if(code=='${ADRESS_PRODUCT}'){
							var result = $.formValidator.pageIsValid('1');
							if(!result){
								return false;
							}
							$("#advForm").submit();
							
					}else if(code=='${PRODUCT_CATEGORY}'){
							var result = $.formValidator.pageIsValid('1');
							if(!result){
								return false;
							}
							$("#advForm").submit();
					}else if(code=='${CITY_SELECT}'){
						var result = $.formValidator.pageIsValid('1');
						if(!result){
							return false;
						}
						$("#advForm").submit();
					}else if(code=='${HOT_PRODUCT}'){
						var result = $.formValidator.pageIsValid('1');
						if(!result){
							return false;
						}
						$("#advForm").submit();
					}else if(code=='${EVERYDAY_RECOMMEND}'){
						var result = $.formValidator.pageIsValid('1');
						if(!result){
							return false;
						}
						$("#advForm").submit();
					}else if(code=='${HOME_RIGHT_ADV_185}' || code == '${HOME_RIGHT_ADV_180}'){
						var result = $.formValidator.pageIsValid('1');
						if(!result){
							return false;
						}
						$("#advForm").submit();
					}else if(code=='${INDEX_BANNER}'){
						var result = $.formValidator.pageIsValid('1');
						if(!result){
							return false;
						}
						$("#advForm").submit();
					}
					else if(code=='${HOME_CENTER_ADV}'){
						var result = $.formValidator.pageIsValid('1');
						if(!result){
							return false;
						}
						$("#advForm").submit();
					}
				  },
				  okValue:"发  布"
				});
			},
			error:function(data){
				//alert(data.responseText);
			}
		});
	};
	function addAdv(index){
		var result = $.formValidator.pageIsValid('1');
		if(!result){
			return false;
		}
		$("#advForm").submit();
	}
//	var imgView=function(src, width, height){
//		var suffix = src.split(".")[1];
//		var url =src + "_t5." + suffix;
//		if(src!='' && src != null){
//			var html = '<img src="'+_fileThumbPath+url+'"/>';
//			  $.dialog({
//			    lock: true,
//			    padding: "5px",
//			    title:false,
//			    content:html,
//			    fixed: true,
//			    cancel: true,
//			    cancelValue: "关  闭",
//			    closed:false
//			  });
//			  $(".d-close").hide();
//		}
//
//	}
	var imgView=function(obj){
		  $.dialog({
		    lock: true,
		    padding: "5px",
		    title:false,
		    content : "<img src="+$(obj).prev().html()+"/>",
		    fixed: true,
		    cancel: true,
		    cancelValue: "关  闭",
		    closed:false
		  });
		  $(".d-close").hide();
	};
</script>
</body>
</html>