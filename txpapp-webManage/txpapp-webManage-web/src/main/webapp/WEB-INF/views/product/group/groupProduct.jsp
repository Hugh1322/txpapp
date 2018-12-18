<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>
<html lang="zh">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>新增抢购专区</title>
<link href="${_cssPath }/common.css" rel="stylesheet" />
<link href="${_cssPath }/pages/bannerManage.css" rel="stylesheet" />
<script src="${_jsPath }/jquery/jquery.1.8.1.js"></script>
<script src="${_jsPath }/plugin/artdialog/jquery.artDialog.min.js"></script>
<script src="${_jsPath }/plugin/formvalidator/formValidatorRegex.js"></script>
<script src="${_jsPath }/plugin/formvalidator/formValidator-4.1.3.js"></script>
<script type="text/javascript" src="${_jsPath}/plugin/uploadify/swfobject.js"></script>
<script type="text/javascript" src="${_jsPath}/plugin/uploadify/jquery.uploadify.v2.1.4.min.js"></script>
<script src="${_jsPath }/plugin/My97DatePicker/WdatePicker.js"></script>
</head>
<body>
<jsp:include page="../../include/header.jsp"></jsp:include> 
	<div class="body m-w980p">
		<!--start 商家管理table-->
		<div class="m-mt10p addsanpUp">
			<form id="addSpecialZoneFrm">
				<div class="rel cf">
					<label for="" class="fl">专区列表大图：</label> 
					 
				</div>
				 
				<div>
					<label for=""><i class="red">*</i>可销售品牌：</label> 
					<a href="javascript:void(0);" onclick="queryProduct('A')">A</a> 
					<a href="javascript:void(0);" onclick="queryProduct('B')">B</a> 
					<a href="javascript:void(0);" onclick="queryProduct('C')">C</a> 
					<a href="javascript:void(0);" onclick="queryProduct('D')">D</a> 
					<a href="javascript:void(0);" onclick="queryProduct('E')">E</a> 
					<a href="javascript:void(0);" onclick="queryProduct('F')">F</a> 
					<a href="javascript:void(0);" onclick="queryProduct('G')">G</a> 
					<a href="javascript:void(0);" onclick="queryProduct('H')">H</a> 
					<a href="javascript:void(0);" onclick="queryProduct('I')">I</a> 
					<a href="javascript:void(0);" onclick="queryProduct('J')">J</a> 
					<a href="javascript:void(0);" onclick="queryProduct('K')">K</a> 
					<a href="javascript:void(0);" onclick="queryProduct('L')">L</a> 
					<a href="javascript:void(0);" onclick="queryProduct('M')">M</a> 
					<a href="javascript:void(0);" onclick="queryProduct('A')">N</a> 
					<a href="javascript:void(0);" onclick="queryProduct('O')">O</a> 
					<a href="javascript:void(0);" onclick="queryProduct('P')">P</a>
					<a href="javascript:void(0);" onclick="queryProduct('Q')">Q</a> 
					<a href="javascript:void(0);" onclick="queryProduct('R')">R</a> 
					<a href="javascript:void(0);" onclick="queryProduct('S')">S</a> 
					<a href="javascript:void(0);" onclick="queryProduct('T')">T</a> 
					<a href="javascript:void(0);" onclick="queryProduct('U')">U</a> 
					<a href="javascript:void(0);" onclick="queryProduct('V')">V</a> 
					<a href="javascript:void(0);" onclick="queryProduct('W')">W</a> 
					<a href="javascript:void(0);" onclick="queryProduct('X')">X</a> 
					<a href="javascript:void(0);" onclick="queryProduct('Y')">Y</a> 
					<a href="javascript:void(0);" onclick="queryProduct('Z')">Z</a>
				</div>
				<div class="cf seller" id="prolist"></div>
				<div class="qz_th">
					<label for=""><b>商品权重：(1-10)</b></label>
				</div>
				<div class="rel">
					<label for="">批量设置抢购时间：</label> 
					<input class="txt-input Wdate" id="startTime" /> 
					<span  class="m5">至</span>
					<input class="txt-input Wdate" id="endTime" />
					<input type="button" id="selectTime" value="确认" class="m-btn">
					<span id="dateTip"></span> 
				</div>
				<ul class="cf qzBox" id="qzBox">
				</ul>
				<div class="rel" style="margin-left:49px;">
					<input type="checkbox" id="isShow" name="zone.isShow" value="0" <c:if test="${zone.isShow eq 0 }">checked="checked"</c:if>/>
					该专区不在首页显示
				</div>
				<div>
					<label for=""></label> 
						<input type="button" id="submitForm" value="保存" class="m-btn"> 
						<input type="button" id="cancelForm" value="取消" class="m-btn">
						<input type="hidden" id="zoneId" name="zone.zoneId" value="${zone.zoneId}"/>
						<input type="hidden" id="rank" name="zone.rank" value="${zone.rank}"/>
						<input type="hidden" id="status" name="zone.status" value="${zone.status}"/>
						<input type="hidden" id="firstChar" name="zone.brandFirstChar" value="${zone.brandFirstChar}"/>
				</div>
				<c:if test="${zone.zoneSaleList!=null}">
					<c:forEach items="${zone.zoneSaleList}" var="zoneSale">
						<input type="hidden" value="${zoneSale.productSkuId}" class="pid"/>
						<input type="hidden" value="${zoneSale.zoneSaleId}" name="zsId"/>
					</c:forEach>
				</c:if>
				</form>
		</div>
	</div>
	<!--end 商家管理table-->
	<jsp:include page="/WEB-INF/views/include/foot.jsp"></jsp:include>
	<script type="text/javascript" src="${_jsPath }/pages/addsnapUp.js"></script>
</body>

<script>
$("#isShow").click(function(){
	var $this = $(this);
	if($this.attr("checked")){
		$.dialog({
			lock: true,
			title : false,
			content : "勾选此项时，该专区将不在首页出现，但不影响专区内已发布商品的正常展示！是否仍然使用该功能？",
		    okValue: "使用",
            ok: function(){},
            cancelValue:"不使用",
		    cancel: function(){
		    	$this.removeAttr("checked");
		    }
		});
		$(".d-close").hide();
	}
});

$(document).ready(function(){
	 	if('${zone.zonePic}'==''||'${zone.zonePic}'==null){
			$('#zonePicUploadImg').hide();
		}
		if('${zone.zoneLeftPic}'==''||'${zone.zoneLeftPic}'==null){
			$('#zoneLeftPicUploadImg').hide();
		}
		if('${zone.zoneListPic}'==''||'${zone.zoneListPic}'==null){
			$('#zoneListPicUploadImg').hide();
		} 
		//定义图片上传插件
		//upload插件 init数据
		var uploadZonePic = {//专区图片 280 60
				'auto' : true,
				'buttonImg' : '${_jsPath}/plugin/uploadify/uploadimg_btn.png',
				'cancelImg' : '${_jsPath}/plugin/uploadify/cancel.png',
				'expressInstall' : '${_jsPath}/plugin/uploadify/expressInstall.swf',
				'fileDataName' : 'file',
				'fileDesc' : '请选择jpg、gif、png文件',
				'fileExt' : '*.jpg;*.jpeg;*.gif;*.png',
				'multi' : false,
				'script' : '${_ctxPath}/upload/upload.htm',
				'sizeLimit' : 2097152,
				'uploader' : '${_jsPath}/plugin/uploadify/uploadify.allglyphs.swf'
		};
		var uploadZoneLeftPic = {//专区左侧图片 255 520 
				'auto' : true,
				'buttonImg' : '${_jsPath}/plugin/uploadify/uploadimg_btn.png',
				'cancelImg' : '${_jsPath}/plugin/uploadify/cancel.png',
				'expressInstall' : '${_jsPath}/plugin/uploadify/expressInstall.swf',
				'fileDataName' : 'file',
				'fileDesc' : '请选择jpg、gif、png文件',
				'fileExt' : '*.jpg;*.jpeg;*.gif;*.png',
				'multi' : false,
				'script' : '${_ctxPath}/upload/upload.htm',
				'sizeLimit' : 2097152,
				'uploader' : '${_jsPath}/plugin/uploadify/uploadify.allglyphs.swf'
		};
		var uploadZoneListPic = {//专区列表图片 1200 280 
				'auto' : true,
				'buttonImg' : '${_jsPath}/plugin/uploadify/uploadimg_btn.png',
				'cancelImg' : '${_jsPath}/plugin/uploadify/cancel.png',
				'expressInstall' : '${_jsPath}/plugin/uploadify/expressInstall.swf',
				'fileDataName' : 'file',
				'fileDesc' : '请选择jpg、gif、png文件',
				'fileExt' : '*.jpg;*.jpeg;*.gif;*.png',
				'multi' : false,
				'script' : '${_ctxPath}/upload/upload.htm',
				'sizeLimit' : 2097152,
				'uploader' : '${_jsPath}/plugin/uploadify/uploadify.allglyphs.swf'
		};
		uploadZonePic.scriptData = {'category' : 'zonePic'}; //目录名字 可以是多级  logo/2013/02/26
		uploadZonePic.onComplete = function(event, ID, fileObj, response, data) {
			$('#zonePic').val(response);
			var url = '${_filePath}' + response;
			$('#zonePicUploadImg').attr({src: url, width: 280/2 + "px", height:60/2 + "px"});
			$('#zonePicUploadImg').show();
		};
		uploadZoneLeftPic.scriptData = {'category' : 'zoneLeftPic'}; //目录名字 可以是多级  logo/2013/02/26
		uploadZoneLeftPic.onComplete = function(event, ID, fileObj, response, data) {
			$('#zoneLeftPic').val(response);
			var url = '${_filePath}' + response;
			$('#zoneLeftPicUploadImg').attr({src: url, width: 255/2 + "px", height: 520/2 + "px"});
			$('#zoneLeftPicUploadImg').show();
		};
		uploadZoneListPic.scriptData = {'category' : 'zoneListPic'}; //目录名字 可以是多级  logo/2013/02/26
		uploadZoneListPic.onComplete = function(event, ID, fileObj, response, data) {
			$('#zoneListPic').val(response);
			var url = '${_filePath}' + response;
			$('#zoneListPicUploadImg').attr({src: url, width: 1200/2 + "px", height: 280/2 + "px"});
			$('#zoneListPicUploadImg').show();
		};
	$('#zonePicUpload').uploadify(uploadZonePic);
	$('#zoneLeftPicUpload').uploadify(uploadZoneLeftPic);
	$('#zoneListPicUpload').uploadify(uploadZoneListPic);
	//删除上传图片
	$('#J_zqImg').on({
		'mouseenter': function(){
			$(this).find('.del').show();
			$(this).find('.del').on('click',function(){
				$(this).closest('#J_zqImg').find('img').attr('src','').hide();
				$("#zoneListPic").val("");
			})
		},
		'mouseleave': function(){
			$(this).find('.del').hide();
		}
	})
})

</script>
</html>