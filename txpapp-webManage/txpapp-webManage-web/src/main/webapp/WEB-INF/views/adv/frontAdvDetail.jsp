<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>专区文字广告</title>
 	<link href="${ _cssPath}/common.css" rel="stylesheet" />
 	<link href="${ _cssPath}/common_new.css" rel="stylesheet" />
    <link href="${ _cssPath}/pages/buyerManagement.css" rel="stylesheet" />
    <link href="${_jsPath }/plugin/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" />
    <script src="${_jsPath }/jquery/jquery.1.8.1.js"  language="javascript"></script>
    <script src="${_jsPath }/plugin/My97DatePicker/WdatePicker.js"></script>
    <script src="${_jsPath }/plugin/form/jquery.form.js"  language="javascript"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/header.jsp"  flush="true" />
	<div class="body m-w980p income_fa">
		<div class="m-f1-new">
		<form class="m-mt10p m-clear" action="${_ctxPath}/admin/adv/adv_saveFAdv.htm" id="save-form" method="post">
	         <div class="ma_bot">
	            <label><font style="color:red;font-weight: bold;">*</font>所属专区： </label>
	             <input type="hidden" name="fa.frontAdvId" value="${fa.frontAdvId}" />	 
	            <select name="frontAdvPage.params.advType" class="m-sel m-sel_new" id="frontAdvType" >	     
	                <option value="all">请选择</option>
	                <c:forEach items="${favs}" var="f" >
	                	<option value="${f.selectVal}"
	                	<c:if test="${f.selectVal eq fa.selectVal}">
	                	   selected="selected"
	                	</c:if>
	                	>${f.advSourceName}</option>
	                </c:forEach>
		        </select>
		         <span class="sein_new" style="display:none;">请选择，不能为空。</span>
	          </div>
	          <div class="ma_bot ma_bots">
		          <label><font style="color:red;font-weight: bold;">*</font>广告位置：</label>
		          <select name="fa.advPosition" class="m-sel m-sel_new" id="frontAdvPosition" >	
		                <c:choose>
		                	<c:when test="${empty fa.advPosition}">
		                		<option value="all">请选择</option>
		                	</c:when>
		                    <c:otherwise>
		                    	<c:choose>
			                        <c:when test="${fa.advType eq 1}"><%--专区 --%>
			                           <option value="all">请选择</option>
			                           <option value='0'
			                             <c:if test="${fa.advPosition eq 0 }">
			                               selected="selected"
			                             </c:if>
			                           
			                           >专区左侧图</option>
			                           <option value='1'
			                            <c:if test="${fa.advPosition eq 1 }">
			                               selected="selected"
			                             </c:if>
			                           >专区右上方</option>
			                        </c:when>
			                        <c:otherwise><%-- 广告位 --%>
			                           <option value="all">请选择</option>
			                           <option value='1' selected="selected">专区右上方</option>
			                        </c:otherwise>
		                        </c:choose>
		                    </c:otherwise>
		                </c:choose>
		          </select>  
		          <span class="sein_news" style="display:none;">请选择，不能为空。</span>        
	          </div>
	          <c:if test="${empty fa.frontAdvId}">
		           <div class="ma_botgg">
		            <div class="uid_new"> 
		             <div>
		                <label><font style="color:red;font-weight: bold;">*</font>广告名称：</label>   
		                <input type="text" name="fa.advName" class="m-sel_input m-sel_new m-sinp-ne font-hd" id="ad_name"  value="请输入1-6位的汉字、字母、数字"/>
		             </div>
		             <div><span class="span_newa" style="display:none;">请输入1-6位的汉字、字母、数字</span></div>
		            </div> 
		            <div class="uid_new"> 
		             <div>
		                <label><font style="color:red;font-weight: bold;">*</font>显示顺序：</label>   
		                <input type="text" name="fa.rank"  class="m-sel_input m-sel_new m-sinp-ne font-hd" id="ad_fond"  value="请输入1-12的数字"/>
		             </div>
		             <div><span class="span_newb" style="display:none;">请输入1-12的数字</span></div>
		            </div> 
		          </div>
		          <div> 
		             <label><font style="color:red;font-weight: bold;">*</font>指向链接：</label>   
		             <input type="text" name="fa.advUrl" class="m-sel_input m-sel_new m-sinp-nes font-hd"  id="frontAdvSrc"  value="http://"/>
		             <span class="sein_newsg" style="display:none;">&nbsp;请输入链接地址。</span>
		          </div>
	          </c:if>
	         <c:if test="${not empty fa.frontAdvId}">
	         	  <div class="ma_botgg">
		            <div class="uid_new"> 
		             <div>
		                <label><font style="color:red;font-weight: bold;">*</font>广告名称：</label>   
		                <input type="text" name="fa.advName" class="m-sel_input m-sel_new m-sinp-ne" id="ad_name" value="${fa.advName}" value="请输入1-6位的汉字、字母、数字"/>
		             </div>
		             <div><span class="span_newa" style="display:none;">请输入1-6位的汉字、字母、数字</span></div>
		            </div> 
		            <div class="uid_new"> 
		             <div>
		                <label><font style="color:red;font-weight: bold;">*</font>显示顺序：</label>   
		                <input type="text" name="fa.rank"  class="m-sel_input m-sel_new m-sinp-ne" id="ad_fond" value="${fa.rank}" value="请输入1-12的数字"/>
		             </div>
		             <div><span class="span_newb" style="display:none;">请输入1-12的数字</span></div>
		            </div> 
		          </div>
		          <div> 
		             <label><font style="color:red;font-weight: bold;">*</font>指向链接：</label>   
		             <input type="text" name="fa.advUrl" class="m-sel_input m-sel_new m-sinp-nes"  id="frontAdvSrc" value="${fa.advUrl}" value="http://"/>
		             <span class="sein_newsg" style="display:none;">&nbsp;请输入链接地址。</span>
		          </div>
	         
	         </c:if>
	          <div><%-- 保存  --%>
	            <div class="tr_new">
	            	<input type="button" class="m-btn" value="保 存 " id="saveFavBtn"/>
	            	<div style="display: none;"><input type="reset" value="" id="resetForm"/></div>
	            </div>
	          </div>
	       </form>
	       <form action="${_ctxPath}/admin/adv/adv_frontAdv.htm" id="list-form"  method="post"> 
	 	    <div class="m-fl jhe_new">
	          <label>所属专区： </label>
	          <input type="hidden" name="fa.frontAdvId" id="frontAdvId" />	 
	          <select name="frontAdvPage.params.advType" class="m-sel m-sel_new nhj_new" >	     
	                <option value="all">请选择</option>
	                <c:forEach items="${favs}" var="f" >
	                	<option value="${f.selectVal}" 
	                	<c:if test="${frontAdvPage.params.advType eq f.selectVal}">
	                		selected="selected"
	                	</c:if>
	                	>${f.advSourceName}</option>
	                </c:forEach>
	          </select>          
	          <input type="submit" class="m-btn" value="查 询" id="searcherBtn"/>
		      <input type="button" class="m-btn" value="导 出" id="exportBtn"/>
		      </div>
		      <div class="tyew_new">已生效的专区文字广告（当每个专区左侧广告超过11个时，右侧广告超过12个时，可能会影响展示效果）</div>
		  </form> 
			  </div>
			    <c:if test="${not empty frontAdvPage.result}">
				    <div class="m-fr curr-num" style="margin-top:-340px;margin-right:-2px;">
						<label>当前显示： </label> 
			       		<yp:commPageSize page="${frontAdvPage}" beanName="frontAdvPage"></yp:commPageSize>
					</div>
		      </c:if>
			<div class="m-mt10p income_dowm">
			<table width="100%">
				<thead class="tab-control">
				<tr id="income_tr">
				    <th width="10%">广告名称</th>
				    <th width="20%">广告链接</th>
				    <th width="10%">显示顺序</th>
				    <th width="10%">所属专区</th>
				    <th width="10%">广告位置</th>
				    <th width="10%">操作</th>
				    <th width="20%">最后修改时间</th>
				</tr>
				</thead>
			<tbody class="income_tbody">
				<c:forEach items="${frontAdvPage.result }" var="fa">
					<tr>
					   <td>${fa.advName}</td>
					   <td>${fa.advUrl}</td>
					   <td> 
					        <span class="J_num">${fa.rank}</span><input name="fa.rank" data-item="${fa.frontAdvId }"  style="display: none;" type="text" class="txt-input J_input"/>
					   		<a   target="_blank" class="J_edit">调整</a></td>
					   <td>${fa.advSourceName}</td>
					   <td>
					   	 <c:choose>
					   	 	<c:when test="${fa.advPosition eq 1}">专区右上方</c:when>
					   	 	<c:otherwise>专区左侧图</c:otherwise>
					   	 </c:choose>
					   </td>
					   <td>
					       <a href="javascript:void(0);" onclick ='editAdv(${fa.frontAdvId},1);'>编辑</a>
					       <a href="javascript:void(0);"  onclick='editAdv(${fa.frontAdvId},2);'>删除</a>
					   </td>
					   <td><fmt:formatDate value="${fa.updateTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				   </tr>
			   </c:forEach>
			</tbody>
			</table>
			</div>
			<!--end 买家管理table-->
				<div class="pagination pagination-right">
					<c:if test="${not empty frontAdvPage.result}">
						<yp:commPage page="${frontAdvPage}" beanName="frontAdvPage"></yp:commPage>
					</c:if>
				</div>
			</div>
			<jsp:include page="/WEB-INF/views/include/foot.jsp"></jsp:include>
</body>
 <script>
 function editAdv(frontAdvId,type){
	 if(type==1){//编辑
		 $("#frontAdvId").val(frontAdvId);
		 $("#list-form").submit();
	 }else{//删除
		 $.dialog({
			  lock: true,
			  padding: "10px",
			  title:false,
			  content:"确认删除该项吗？",
			  fixed: false,
			  cancel: true,
			  cancelValue:"取  消",
			  ok:function(){
				  $.ajax({
	    			  url:"${_ctxPath}/admin/adv/adv_delFAdv.htm",
	    			  data : {'fa.frontAdvId':frontAdvId},
	    			  type:'post',
	    			  dataType:"json",
	    			  success:function(data){
	    				  if(data.code==3){
	    					  alert("删除成功");
	    					  window.location.reload(true);
	    				  }else{
	    					  alert("删除失败");
	    				  }
	    			  }
	    		  });
			  },
			  okValue:"确  认"
	     });
	 }
 }
 $(document).ready(function(){
	 function ad_name_focus(){
		 var ad_name=document.getElementById("ad_name").value; 
		 if(ad_name=="请输入1-6位的汉字、字母、数字")
		   {$("#ad_name").val("");$("#ad_name").removeClass("font-hd");} 	 
	 } 
	 function ad_name_blur(){
		   var ad_name=document.getElementById("ad_name").value;
		   if(ad_name==""){
			   $("#ad_name").val("请输入1-6位的汉字、字母、数字");$("#ad_name").addClass("font-hd");
			   return false;
		   }else{
		      var reg1=/^[A-Z|a-z|\d|\u4e00-\u9fa5]{1,6}$/gi;
		      var bear1=reg1.test(ad_name);
		      if(bear1==true){
		    	  $(".span_newa").hide();
		    	  return true;
		      }else{
		    	  $(".span_newa").show();
		    	  return false;
		      }		  
          }
	 }   
	 function ad_fond_focus(){
		 var ad_fond=document.getElementById("ad_fond").value; 
		 if(ad_fond=="请输入1-12的数字")
		   {$("#ad_fond").val("");$("#ad_fond").removeClass("font-hd");} 	 
	 } 
	  function ad_fond_blur(){
		   var ad_fond=document.getElementById("ad_fond").value;
		   if(ad_fond==""){
			   $("#ad_fond").val("请输入1-12的数字");$("#ad_fond").addClass("font-hd");
			   return false;
		   }else{
		      var reg2=/^[1-9][0-2]*$/gi;
		      var bear2=reg2.test(ad_fond);
		      if(bear2==true){
		    	  if(ad_fond>12){
		    		  $(".span_newb").show();
		    		  return false;
		          }else{
		        	  $(".span_newb").hide();
		        	  return true;
		          } 
		      }else{
		    	  $(".span_newb").show();
		    	  return false;
		      }		  
          }
	 } 	
      function frontAdvSrc_focus(){
			 var frontAdvSrc=document.getElementById("frontAdvSrc").value; 
			 if(frontAdvSrc=="http://")
			   {$("#frontAdvSrc").val("");$("#frontAdvSrc").removeClass("font-hd");} 	 
	  }	
	  function frontAdvSrc_blur(){
		   var frontAdvSrc=document.getElementById("frontAdvSrc").value;
		   if(frontAdvSrc=="")
		     {$("#frontAdvSrc").val("http://");$("#frontAdvSrc").addClass("font-hd"); return false;} 
		   else{
		      var reg3=/^http:\/\/.+$/gi;
		      var bear3=reg3.test(frontAdvSrc);
		      if(bear3==true)
		        {
               $(".sein_newsg").hide();
               return true;
               } 		  
            else
			     {$(".sein_newsg").show(); return false;}		  
            }
	 } 	

	 function frontAdvType_blur(){
		   var frontAdvType=document.getElementById("frontAdvType").value;
		   if(frontAdvType=="all")
		     {$(".sein_new").show(); return false;}
		   else
		     {$(".sein_new").hide(); return true;}	  
	 } 	 
	 function ad_fond_focus(){
		 var ad_fond=document.getElementById("ad_fond").value; 
		 if(ad_fond=="请输入1-12的数字")
		   {$("#ad_fond").val("");$("#ad_fond").removeClass("font-hd");} 	 
	 } 	 
	 function frontAdvPosition_blur(){
		   var frontAdvPosition=document.getElementById("frontAdvPosition").value;
		   if(frontAdvPosition=="all")
		     {$(".sein_news").show();return false;}
		   else
		     {$(".sein_news").hide();return true;}	  
	 } 
	  $("#ad_name").focus(function(){ad_name_focus();});
	  $("#ad_name").blur(function(){ad_name_blur();});
	  $("#ad_fond").focus(function(){ad_fond_focus();});
	  $("#ad_fond").blur(function(){ad_fond_blur();});
	  $("#frontAdvSrc").focus(function(){frontAdvSrc_focus();});
	  $("#frontAdvSrc").blur(function(){frontAdvSrc_blur();});
	  $("#frontAdvType").blur(function(){frontAdvType_blur();});
	  $("#frontAdvPosition").blur(function(){frontAdvPosition_blur();});
      $("#saveFavBtn").click(function(){//保存广告
    	  ad_name_blur(); 
    	  ad_fond_blur();
    	  frontAdvSrc_blur();
    	  frontAdvType_blur();
    	  frontAdvPosition_blur();
    	  if(!ad_name_blur()||!ad_fond_blur()||!frontAdvSrc_blur()||!frontAdvType_blur()||!frontAdvPosition_blur()){
    		  return false;
    	  }else{
    		  var formData = $("#save-form").formSerialize();
    		  $.ajax({
    			  url:"${_ctxPath}/admin/adv/adv_saveFAdv.htm",
    			  data:formData,
    			  type:'post',
    			  dataType:"json",
    			  success:function(data){
    				  if(data.code==3){
    					  alert(data.info);
    					  window.location.href="${_ctxPath}/admin/adv/adv_frontAdv.htm";
    				  }else if(data.code==4){
    					  alert(data.info);
    					  window.location.href="${_ctxPath}/admin/adv/adv_frontAdv.htm";
    				  }else{
    					  alert("保存失败");
    				  }
    			  }
    		  });
    	  }
      });
 	  $("#frontAdvType").change(function(){
 		  var selectedVal = $(this).val();
 		  if(selectedVal=='all'){//如果为请选择
 			  $("#frontAdvPosition").html("<option value='all'>请选择</option>");
 		  }else{//判断
 			 var array = selectedVal.split("-");
 		  	 if(array[1]==0){//广告位
 	           $("#frontAdvPosition").html("<option value='all'>请选择</option><option value='1'>专区右上方</option>");
 		  	 }else{//专区
 		  	   $("#frontAdvPosition").html("<option value='all'>请选择</option><option value='0'>专区左侧图</option><option value='1'>专区右上方</option>");
 		  	 }
 		  }
 	  });
 	  
 	  $("#exportBtn").on("click",function(){
 		 if($("tbody").html().trim()==""){
				return;
		 }
 		 $("#list-form").attr("action",'${_ctxPath}/admin/adv/adv_exportFrontAdv.htm');
 		 $("#list-form").submit();
 		 $("#list-form").attr("action",'${_ctxPath}/admin/adv/adv_frontAdv.htm');
 	  });
 	//编辑排序
 		$(".J_edit").on("click",function(){
 			var $this=$(this);
 			var $input=$this.parent().find(".J_input");
 			var $num=$this.parent().find(".J_num");
 			var numVal=$num.text();
 			if($this.text()=="调整"){
 				$input.show();
 				$num.hide();
 				$this.text("确定");
 				$input.val(numVal);
 			}else{
 				var rankAd = $this.parent().find(".J_input").val();
 				if(rankAd==""){
 					alert("顺序不能为空");
 				   return;
 			   }else{
 				  var reg2=/^[1-9][0-1]*$/gi;
 			      var bear2=reg2.test(rankAd);
 			      if(bear2==true){
 			    	  if(rankAd>12){
 			    		 alert("顺序输入有误");
 			    		 return;
 			          }
 			      }else{
 			    	  alert("顺序输入有误");
 			    	  return;
 			      }		  
 	           }
 				$input.hide();
 				$num.show();
 				$this.text("调整");
 				// 获取排序序号
 				var rankId = parseInt($input.val()); 
 				var fid = $input.attr("data-item");
 				$.ajax({
 					type : 'POST',
 					url :  _ctxPath+ '/admin/adv/adv_updateFRank.htm',
 					data : {'fa.frontAdvId':fid,'fa.rank':rankId},
 					success : function(data) {
 						switch (data.code) {
 						case '2':
 							$.dialog({
 								title : false,
 								content : "顺序修改失败！",
 								time : 2000
 							});
 							$(".d-close").hide();
 							$num.text(numVal);
 							break;
 						case '3':
 							$.dialog({
 								title : false,
 								content : "顺序修改成功！",
 								time : 2000
 							});
 							$(".d-close").hide();
 							$num.text($input.val());
 							window.location.reload(true);
 							break;
 						}
 					},
 					dataType : 'json'
 				});
 			}
 		});
 })
 </script>
</html>