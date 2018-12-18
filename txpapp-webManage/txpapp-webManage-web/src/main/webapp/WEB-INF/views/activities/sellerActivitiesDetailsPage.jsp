<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>活动报名详细</title>
    <link href="${_cssPath }/common.css" rel="stylesheet" />
    <link href="${_cssPath }/pages/arrangement.css" rel="stylesheet" />
    <link href="${_jsPath }/plugin/artdialog/skins/ytoxl.css" rel="stylesheet" />
    <script src="${_jsPath }/jquery/jquery.1.8.1.js"  language="javascript"></script>
    <script src="${_jsPath }/plugin/artdialog/jquery.artDialog.min.js"></script>
    <script src="${_jsPath }/pages/roles.js"></script>
</head>

<body>
	<!--start header-->
	<jsp:include page="../include/header.jsp"></jsp:include> 
    <!--end header-->
    <!--start body-->
       <div class="body m-w980p">
       	<div>
       		<form class="sub-form m-clear m-mt10p" action="${_ctxPath}/seller/activities/activities-showActivitiesDetailsPage.htm?activityListPage4Sellers.params.type=1" id="search-form" method="post">
       			<input type="hidden" value="${activityListPage4Sellers.params.activeId }" name="activityListPage4Sellers.params.activeId"/>
       			品牌名称：<select name="activityListPage4Sellers.params.brandId" id="brand" class="m-sel">
                   <option value="">全部品牌</option>
                   	<c:forEach items="${sellerBrands }" var="brand">
						<option value="${brand.brandId }"
							<c:if test="${activityListPage4Sellers.params.brandId==brand.brandId }">
								selected = "selected"
							</c:if>
						>${brand.name }</option>
					</c:forEach>
                </select>
                                                 商品名称：
              <input type="text" data-default="输入商品名称" name="activityListPage4Sellers.params.productName" value="${activityListPage4Sellers.params.productName}" class="J-keywords txt-input input-marks" />
              <input type="button" class="m-btn m-btn-search" value="查 询" id="search"/>                                   
       		</form>
       	</div>
        <div class="body-nav m-mt10p">
			<ul class="m-clear">
				<li><a class="current-chose" href="${_ctxPath}/seller/activities/activities-showActivitiesDetailsPage.htm?activityListPage4Sellers.params.type=1&activeId=${activityListPage4Sellers.params.activeId }">已报名商品</a></li>
				<li><a href="${_ctxPath}/seller/activities/activities-showActivitiesDetailsPage.htm?activityListPage4Sellers.params.type=2&activeId=${activityListPage4Sellers.params.activeId }">未报名商品</a></li>
			</ul>
		</div>
      	<!--start -->
        <div class="m-mt10p arrange-management">
            <table class="tab-control" id="tab">
                <thead>
                    <tr>
                        <th width="15%">品牌</th>
                        <th width="20%">商品名称</th>
                        <th width="10%">商品规格</th>
                        <th width="10%">结算价</th>
                        <th width="10%">活动结算价</th>
                        <th width="10%">活动库存</th>
                        <th width="10%">处理状态</th>
                        <th width="15">操作</th>
                    </tr>
                </thead>
                <tbody>
                <c:forEach items="${activityListPage4Sellers.result}" var="active" varStatus="status">
						<tr class="list-tr">
							<td>${active.brandName }</td>
							<td>${active.productName }</td>
							<td>${active.skuSpecification}</td>
							<td>${active.settlementPrice}</td>
							<td>${active.price}</td>
							<td>${active.amount}</td>
							<td><spring:message code="activity.status.${active.applyStatus }"/></td>
							<td>
							<c:if test="${active.applyStatus == 1}">
								<a href="${_ctxPath}/seller/activities/activities-confirmJoinActivity.htm?applyId=${active.applyId}&skuId=${active.skuId}&activityListPage4Sellers.params.activeId=${activityListPage4Sellers.params.activeId}">确认</a>
							</c:if>
							</td>
						</tr>
					</c:forEach>
                </tbody>
            </table>
        </div>
      	<!--end -->
    </div>
    <!--end body-->
    <!--start footer-->
    <jsp:include page="/WEB-INF/views/include/foot.jsp"></jsp:include>
    <!--end footer-->
    <script language="javascript">
	$(function(){
		$("#search").click(function(){
				var keywords = $(".J-keywords").val();
				if(keywords == $(".J-keywords").attr("data-default")){
					$(".J-keywords").val("");
				}
				$(".sub-form").submit();
			});
	});
	</script>
</body>
</html>