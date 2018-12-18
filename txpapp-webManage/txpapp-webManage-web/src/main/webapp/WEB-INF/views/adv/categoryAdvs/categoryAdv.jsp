<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="com.txp.app.contants.AdvPosition"%>
<%@include file="../../include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>首页商品分类广告</title>
    <link href="${_cssPath }/common.css" rel="stylesheet" />
    <link href="${_cssPath }/pages/arrangement.css" rel="stylesheet" />
    <link href="${_cssPath }/pages/bannerManage.css" rel="stylesheet" />
    <link href="${_jsPath }/plugin/artdialog/skins/ytoxl.css" rel="stylesheet" />
    <script src="${_jsPath }/jquery/jquery.1.8.1.js"  language="javascript"></script>
    <script src="${_jsPath}/plugin/formvalidator/formValidatorRegex.js" language="javascript"></script>
    <script src="${_jsPath}/plugin/formvalidator/formValidator-4.1.3.js" language="javascript"></script>
    <script src="${_jsPath}/pages/categoryAdv.js" language="javascript"></script>
    <!--[if IE]>
		<script src="${_jsPath}/pages/ieplaceholder.js"></script>
	<![endif]-->
</head>
<body>
	<!--start header-->
	<jsp:include page="../../include/header.jsp"></jsp:include> 
	<div class="body m-w980p">
	<%--  <jsp:include page="../include/pageManageMenu.jsp"  flush="true" />  --%>
		 <form class="sub-form m-clear m-mt10p" action="${_ctxPath }/admin/adv/categoryAdv_toAddDetail.htm" id="addForm" method="post">
		 	<div class="m-fl"><%-- 广告类型 --%>
		          		 	<input type="submit" class="m-btn" value="新增${position.positionName }" />
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
                        <th width="15%">广告名称 </th>
                        <th width="15%">广告类型</th>
                        <th width="15%">顺序</th>
                        <!-- <th width="15%">预览</th> -->
                        <th width="15%">展示位置</th>
                        <th width="15%">操作</th>
                    </tr>
                </thead>
                <tbody>
                 <c:forEach items="${advPage.result}" var="adv" varStatus="status">
                 	<tr>
						<td>${adv.advertisementName}
					    </td>
						<td>${adv.position.positionName}</td>
						<td>
							<span class="J_num">${adv.rank}</span><input name="adv.rank" data-type="${adv.advertisementId}"   type="text" class="txt-input J_input"/>
							<a href="javascript:" class="J_edit">调整</a>
						</td>
						<%-- <td>
							<div class="relative">
								<c:if test="${adv.imageUrl != '' && adv.imageUrl!= null}">
									<span style="display: none;"><yp:thumbImage originalPath='${adv.imageUrl}' imageType='t5'></yp:thumbImage></span>
									<a class="preview" style="cursor: pointer;" onclick="imgView(this)">预览</a>
								</c:if>
							</div>
						</td> --%>
						<td> 
						<c:if test="${adv.type == 10 }"> 内层</c:if>
						<c:if test="${adv.type == 11 }"> 外层</c:if>
						<c:if test="${adv.type == 12 }"> 品牌</c:if>
						</td>
						<td><a onclick="clickAddOrEdit('${adv.advertisementId}','${_ctxPath}/admin/adv/categoryAdv_toEditDetail.htm')" style="cursor: pointer;">编辑</a>&nbsp;
						<a style="cursor: pointer;" onclick="delAdv('${adv.advertisementId}','${_ctxPath}/admin/adv/categoryAdv_delDetail.htm')" class="m-5">删除</a></td>
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
	//编辑销售激励
	$(".J_edits").on("click",function(){
		var $this=$(this);
//	 	console.log($this.parent().parent().find("input[type=hidden]")[0].defaultValue);
	    var $input=$this.parent().parent().find(".J_inputs");
		var $num=$this.parent().parent().find(".J_num");
		var numVal=$.trim($num.text());
		if($this.text()=="编辑"){
			$input.show();
			$num.hide();
			$this.text("提交");
			$input.val(numVal);
		}else{
	        if(!check($input)){
	        	return;
	        }
			$input.hide();
			$num.show();
			$this.text("编辑");
			// 获取销售激励
			var sellInspire = $input.val(); 
			var skuId = $input.attr("data-item");
			$.ajax({
				type : 'POST',
				url :  _ctxPath+ '/seller/product/product-quickSaveSaleInspire.htm',
				data : {'product.productSku.productSkuId':skuId,'product.productSku.sellInspire':sellInspire},
				success : function(data) {
					$(".d-close").hide();
					$num.text($input.val());
					window.location.reload();
				},
				dataType : 'json'
			});
	 }  
		
	});
	    function check(obj){
	    	var _Price = $.trim($(obj).parent().parent().find(".unitPrice").attr("data-item"));
	    	var reg = /^\d+(\.\d+)?$/;
	        var _val = $.trim($(obj).val());
	        var _compare =  (_val - _Price).toFixed(2);
	    	if((!reg.test(_val)) || _compare > 0){
	            alert("你输入的信息不合法，请重新输入");
	            $(obj).val("");
	            return false;
	    	}
	    	return true;
	    	
	    }

	 
		//编辑排序
		$(".J_edit").on("click", function() {
			var $this = $(this);
			var $input = $this.parent().find(".J_input");
			var $num = $this.parent().find(".J_num");
			var numVal = $num.text();
			if ($this.text() == "调整") {
				$input.show();
				$num.hide();
				$this.text("确定");
				$input.val(numVal);
			} else {
				$input.hide();
				$num.show();
				$this.text("调整");

				// 获取排序序号
				var rank = $.trim($input.val());
				var reg = /^(0||[1-9]{1}[0-9]{0,4})$/;
				if (rank == "") {
					alert("顺序值不能为空");
					return false;
				} else {
					if (!reg.test(rank)) {
						alert("请输入0-99999的正整数");
						return false;
					}
				}
				var advId = $input.attr("data-type");
				$.ajax({
					type : 'POST',
					dataType : 'json',
					url : _ctxPath + '/admin/adv/adv_updateAdvRank.htm',
					data : {
						'adv.advertisementId' : advId,
						'adv.rank' : rank
					},
					success : function(msg) {
						if(msg.code == "true"){
							alert("调整顺序成功！");
							location.reload();
						}else if(msg.code == "false"){
							submitStatus = true;
							alert("调整顺序失败，请重试！");
						}
					},
					error: function(xhr){
						submitStatus = true;
						alert("调整团购件数人数失败，请重试！");
			        }
				});
			}
		});
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