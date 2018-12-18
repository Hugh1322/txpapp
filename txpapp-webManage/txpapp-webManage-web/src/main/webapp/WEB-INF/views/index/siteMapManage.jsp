<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../include/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<link href="${_cssPath}/common.css" rel="stylesheet" />
<link href="${_jsPath }/plugin/artdialog/skins/ytoxl.css" rel="stylesheet" />
<link href="${_cssPath }/pages/arrangement.css" rel="stylesheet" />
<link href="${_cssPath }/pages/bannerManage.css" rel="stylesheet" />
<script src="${_jsPath }/jquery/jquery.1.8.1.js" language="javascript"></script>
<script src="${_jsPath}/plugin/formvalidator/formValidator-4.1.3.js" language="javascript"></script>
<jsp:include page="../include/header.jsp"></jsp:include> 
<title>siteMap生成管理</title>

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
		<div class="curPosition">
			当前位置：<a href=" ">siteMap生成管理</a>
		</div>
		<form method="post" id="addSiteMapFrom" action="">
			<div class="m-mt10p addBanner">
				<div class="addADV cf">
					<label><i class="red">*</i>更新优先级: </label>
					<div class="infoADV">
						<select class="m-sel" style = "width:100px;" name = "sitemap.updatePriority">
							<option value = "1.0" >1.0</option>
							<option value = "0.9" >0.9</option>
							<option value = "0.8" >0.8</option>
							<option value = "0.7" >0.7</option>
							<option value = "0.6" >0.6</option>
							<option value = "0.5" >0.5</option>
						</select>
					</div>
				</div>
				
				
				
				<div class="addADV cf">
					<label><i class="red">*</i>更新频率: </label>
					<div class="infoADV">
						<select class="m-sel" style = "width:50px;" name = "sitemap.updateFrequency">
							<option value = "1" >周</option>
							<option value = "0" >日</option>
							<option value = "2" >月</option>
							<option value = "3" >年</option>
						</select>
						<input type="checkbox" name = "sitemap.ifAutoGeneration" value = "1" />&nbsp;自动生成						
					</div>
				</div>					
						
		
		
				<div class="addADV cf">
					<label><i class="red">*</i>生成数量:</label>
					<div class="infoADV">
						<input type="text" name="sitemap.generateCount"  id="generateCount" />
						<div id="generateCountTip"></div>
					</div>
				</div>
				<div class="addADV cf">
					<label><i class="red">*</i>数量来源:</label>
					<div class="infoADV">
						<input type="checkbox" name = "sitemap.dataSource" value = "<s:property value='@com.ytoxl.module.yipin.base.dataobject.SiteMap@DATA_SOURCE_GATEGORY'/>"/>&nbsp;类目列表
						<input type="checkbox" name = "sitemap.dataSource" value = "<s:property value='@com.ytoxl.module.yipin.base.dataobject.SiteMap@DATA_SOURCE_PRODUCT'/>"/>&nbsp;商品数据<br/>
						<input type="checkbox" name = "sitemap.dataSource" value = "<s:property value='@com.ytoxl.module.yipin.base.dataobject.SiteMap@DATA_SOURCE_SEARCHKEY'/>"/>&nbsp;搜索长尾词
						<input type="checkbox" name = "sitemap.dataSource" value = "<s:property value='@com.ytoxl.module.yipin.base.dataobject.SiteMap@DATA_SOURCE_ACTIVITY'/>"/>&nbsp;品牌数据<br/>
						<input type="checkbox" name = "sitemap.dataSource" value = "<s:property value='@com.ytoxl.module.yipin.base.dataobject.SiteMap@DATA_SOURCE_BRAND'/>"/>&nbsp;主题列表
						<input type="checkbox" name = "sitemap.dataSource" value = "<s:property value='@com.ytoxl.module.yipin.base.dataobject.SiteMap@DATA_SOURCE_TOPIC'/>"/>&nbsp;文章数据<br/>
						<input type="checkbox" name = "sitemap.dataSource" value = "<s:property value='@com.ytoxl.module.yipin.base.dataobject.SiteMap@DATA_SOURCE_ARTICLE'/>"/>&nbsp;活动列表
						<div id="dataSourceTip"></div>
					</div>
				</div>
				<div class="addADV cf">
					<label><i class="red">*</i>文件名称:</label>
					<div class="infoADV">
						<input type="checkbox" name = "sitemap.documentName" value = "0" />&nbsp;sitemap.xml<br />
						<div id="documentNameTip"></div>
					</div>
				</div>
				
				<div class="addADV cf" id = "saveOrCacelDiv">
					<label>&nbsp;</label>
					<div class="infoADV">
						<input type="button" id="submitFormButton" onclick="return checkForm()" value="开始生成" class="m-btn"  /> 
							 <input type="button" id="cancelForm" value="取消" onclick="window.history.go(-1)" class="m-btn" />
					</div>
				</div>
			 </div>
			</form>
		</div>
	<script>
	 $(function(){
		 initCheck();
	 })
	 function initCheck(){
		 $.formValidator.initConfig({validatorGroup:"sitemap",formID:"addSiteMapFrom",theme:"Default",submitOnce:false,wideWord:false,onError:function(){}});
		 $("#generateCount").formValidator({validatorGroup:"sitemap",onShow:"请输入生成数量",onFocus:"请输入生成数量"})
			.inputValidator({min:1,max:6,onErrorMin:"请输入大于1个字符",onErrorMax:"请输入小于6个字符",empty:{leftEmpty:false,rightEmpty:false,emptyError:"两边不能有空格"},onError:"请输入生成数量"})
			.regexValidator({ regExp: "^[1-9]*[1-9][0-9]*$", onError: "请填写1-6位正整数" });
		 
		 $(":checkbox[name='sitemap.dataSource']").formValidator({validatorGroup:"sitemap",onShow:"请勾选数量来源",onFocus:"请勾选数量来源",tipID:"dataSourceTip"})
			.inputValidator({min:1,onErrorMin:"请至少勾选一个数量来源",onError:"请勾选数量来源"});
		 
		 $(":checkbox[name='sitemap.documentName']").formValidator({validatorGroup:"sitemap",onShow:"请勾选文件名称",onFocus:"请勾选文件名称",tipID:"documentNameTip"})
			.inputValidator({min:1,onErrorMin:"请勾选文件名称",onError:"请勾选文件名称"});
	 }
	
	
		//新增站点地图
		function checkForm(){
			//是否通过验证
			var result = $.formValidator.pageIsValid('sitemap');
			if(!result){
				return false;
			}
			var url = "${_ctxPath}/admin/sitemap/sitemap-saveSiteMap.htm";
			$.post
			(
				url,$("#addSiteMapFrom").serialize(),function(data){
					try{
						if(data !=null) {
							if(data.code!=null){
								alert(data.info);
							}else{
								alert("添加出现异常");
							}
						}
					}
					catch(e){
						alert(e.name+""+e.message);
					}
			
				}
			);
			
		}
	</script>

</body>
</html>