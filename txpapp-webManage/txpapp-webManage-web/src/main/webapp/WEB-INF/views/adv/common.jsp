<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>
<form action="${_ctxPath}/admin/adv/adv_saveAdv.htm" method="post" id="advForm">
<input name="adv.advertisementId" value="${adv.advertisementId}" type="hidden"/>
<div class="m-mt10p addBanner">
	<div  class="addADV cf">
		<label for=""><i class="red">*</i>位置：</label>
		<div class="infoADV">
		<input name="adv.positionId" value="${position.positionId}" type="hidden"/>
		<c:out value="${position.positionName}"></c:out>
		</div>		
	</div>
	<div class="addADV cf">
		<label for=""><i class="red">*</i>广告名称：</label>
		<div class="infoADV">
			<input type="text" name="adv.advertisementName" id="advName" class="txt-input" value="${adv.advertisementName }"/>
			<div id="advNameTip"></div>
		</div>
	</div>
	<div class="addADV cf">
		<label for=""><i class="red">*</i>广告图片：</label>
		<div class="infoADV">
       		<input type="file" id="common_imgUpload" class="txt-input" name="file" />
       		<div id="advUploadImageTip">
				<em class="c-red">*</em> 
				<span>请上传像素为<span>${position.width }px*${position.height }px</span>的图片</span>
       		</div>
          	<input type="hidden" id="uploadImageValueId" id="img" name="adv.imageUrl" value="${adv.imageUrl }"/>
		<img src="${_filePath }${adv.imageUrl}" id="showImg" width="${position.width }px" height="${position.height }px"/>
		<div id="imgTip"></div>
		</div>
	</div>
	<div class="addADV cf">
		<label for=""><i class="red">*</i>顺序：</label>
		<div class="infoADV">
		<input type="text" name="adv.rank" id="advRank" class="txt-input" value="${adv.rank }"/><span>请选择1-10之间的数字</span>
		<div id="advRankTip"></div>
		</div>
	</div>
	<div class="addADV cf">
		<label for=""><i class="red">*</i>跳转地址：</label>
		<div class="infoADV">
			<input type="text" name="adv.url" id="advUrl" class="txt-input" value="${adv.url }"/>
			<div id="advUrlTip"></div>
		</div>
	</div>
	<c:if test="${empty adv.advertisementId}">
		<div class="addADV cf">
			<label>&nbsp;</label>
			<div class="infoADV">
				<input type="button" id="submitForm"  onclick="addAdv('2')" value="保存" class="m-btn"/>
				<input type="button" id="cancelForm" value="取消" onclick="window.history.go(-1)" class="m-btn"/>
			</div>
		</div>
	</c:if>
</div>
</form>