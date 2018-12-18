<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" %>
<%@include file="../include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>市场活动</title>
<link href="${_cssPath }/common.css" rel="stylesheet" />
<link href="${_cssPath }/pages/arrangement.css" rel="stylesheet" />
<link href="${_cssPath }/pages/bannerManage.css" rel="stylesheet" />
<link href="${_jsPath }/plugin/artdialog/skins/ytoxl.css"
	rel="stylesheet" />
<script src="${_jsPath }/jquery/jquery.1.8.1.js" language="javascript"></script>
<script src="${_jsPath }/plugin/artdialog/jquery.artDialog.min.js"></script>
<script type="text/javascript"
	src="${_jsPath}/plugin/uploadify/swfobject.js"></script>
<script type="text/javascript"
	src="${_jsPath}/plugin/uploadify/jquery.uploadify.v2.1.4.min.js"></script>
<script src="${_jsPath}/plugin/formvalidator/formValidator-4.1.3.js"
	language="javascript"></script>
<script src="${_jsPath}/plugin/formvalidator/formValidatorRegex.js"
	language="javascript"></script>
<script src="${_jsPath}/pages/specAdv.js" language="javascript"></script>
<script type="text/javascript" src="${_jsPath }/plugin/My97DatePicker/WdatePicker.js"></script>
<!--[if IE]>
		<script src="${_jsPath}/pages/ieplaceholder.js"></script>
	<![endif]-->
<style>
.curPosition {
	height: 30px;
	line-height: 30px;
	padding-top: 20px;
}
</style>
</head>
<body>
	<!-- 正文内容 -->
	<div class="body m-w980p">
		<!-- 当前位置 -->
		<form method="post" id="addActivityFrom" action="${_ctxPath}/marketAct/marketact-saveActivity.htm">
			<div class="m-mt10p addBanner">
  					<div class="addADV cf">
					<label><i class="red">*</i> 激活状态: </label>
					<div class="infoADV"> 
					<input type="hidden"  name="activityStatuesHidden"  value="activity.status"/>
					<c:choose>
						<c:when test="${activity.status ==1 }">已发布</c:when>
						<c:when test="${activity.status ==0 }">未发布</c:when>
						<c:otherwise>未发布</c:otherwise>
					</c:choose>
					</div>
				</div>
				<div class="addADV cf">
					<label><i class="red">*</i>活动代码:</label>
					<div class="infoADV">
						<input type="text" name="activity.code" 
						<c:if test="${not empty activity.id}" >readonly="readonly"</c:if>
						value="${activity.code}" id="actCode"  class="iText" />
					</div>
				</div>
				<div class="addADV cf">
					<label><i class="red">*</i>活动名称:</label>
					<div class="infoADV">
						<input readonly="readonly" type="text" name="activity.name" value="${activity.name}" class="iText" id="actName" />
					</div>
				</div>
				<div class="addADV cf">
					<label>广告语:</label>
					<div class="infoADV">
						<input readonly="readonly"  type="text" name="activity.activityDesc" value="${activity.activityDesc}" class="iText" id="adName" /> 
					</div>
				</div>	
				<div class="addADV cf">
					<label><i class="red">*</i>活动时间:</label>
					<div class="infoADV">
						<input id="startTime"
				name="activity.startTime"
				value="<s:date name="activity.startTime" format="yyyy-MM-dd HH:mm:ss"/>" class="Wdate"
				type="text" readonly="readonly"
				 />  至 
				<input id="endTime" name="activity.endTime"
				value="<s:date name="activity.endTime" format="yyyy-MM-dd HH:mm:ss"/>" class="Wdate"
				type="text" readonly="readonly" />
					</div>
				</div>
				
				<div class="addADV cf">
					<label><i class="red">*</i>销售类型: </label>
					<div class="infoADV">
						<input disabled="disabled" type="radio" name="" id="selltype_1" value="1" <c:if test ="${fn:contains(activity.sellTypes, '1')}">checked="checked"</c:if> />普通&nbsp;&nbsp;
						<input disabled="disabled" type="radio" name="" id="selltype_3" value="3" <c:if test ="${fn:contains(activity.sellTypes, '3')}">checked="checked"</c:if> />抢购&nbsp;&nbsp;
						<input disabled="disabled" type="radio" name="" id="selltype_4" value="4"  <c:if test ="${fn:contains(activity.sellTypes, '4')}">checked="checked"</c:if> />团购&nbsp;&nbsp;
						<input disabled="disabled" type="radio" name="" id="selltype_5" value="5" <c:if test ="${fn:contains(activity.sellTypes, '5')}">checked="checked"</c:if> />分期送&nbsp;&nbsp;
						<input disabled="disabled" type="radio" name="" id="selltype_8" value="8" <c:if test ="${fn:contains(activity.sellTypes, '8')}">checked="checked"</c:if> />试吃&nbsp;&nbsp;
					</div>
				</div>

				<c:if test="${!empty marketRule2}">
					<c:forEach items ="${marketRules}" var = "marketRules"  varStatus="state">
					<div class="addADV cf" id ="ruleDiv${state.index+1}">
						<c:if test="${!state.first}">
							<label>
								<select class="m-sel" id="rulePlusDivConnection${state.index+1}" name ="activity.actRules[${state.index}].lastConnection">
									<option value ="&&" <c:if test="${marketRules.lastConnection != '||'}">selected</c:if>  >并且</option>
									<option value= "||" <c:if test="${marketRules.lastConnection == '||'}">selected</c:if>>或者</option>
								</select>
							</label>
						</c:if>
						<c:if test="${state.first}">
							<label>&nbsp;</label>
						</c:if>
						<label  style="width: 60px;"><i class="red">*</i>规则${state.index+1}: </label>
						<span class="infoADV">
							<select class="m-sel" style = "width:300px;" id="rulePlusDiv1" name = "marketactivityRuleIds" onfocus="this.defaultIndex=this.selectedIndex;" onchange="this.selectedIndex=this.defaultIndex;">
								<option value="${marketRules.id}">${marketRules.name}</option>
							</select>
						</span>
					</div>					
					</c:forEach>
				</c:if>
				

				<div class="addADV cf" id = "rulePlus">
					<label><i class="red">*</i>优惠券规则: </label>
					<div class="infoADV">
						<input type="checkbox" name="activity.couponRule"  <c:if test="${fn:contains(activity.couponRule,'1')}">checked</c:if> id="couponRule_1" value="1" class="sellTypeCheckBox" disabled="disabled" />普通优惠券&nbsp;&nbsp;
						<input type="checkbox" name="activity.couponRule" <c:if test="${fn:contains(activity.couponRule,'2')}">checked</c:if> id="couponRule_2" value="2" class="sellTypeCheckBox" disabled="disabled"/>运单优惠券&nbsp;&nbsp;
						<div id="couponRuleTip"  ></div>
					</div>
				</div>			
			</div>
		</form>
	</div>
</body>
</html>