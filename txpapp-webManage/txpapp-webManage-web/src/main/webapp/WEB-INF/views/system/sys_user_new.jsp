<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8" import="com.txp.app.contants.Product" pageEncoding="UTF-8"%>
<%@include file="../include/taglibs.jsp"%>
<%@page import="com.txp.app.contants.Product" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>用户管理</title>
<link href="${_jsPath }/plugin/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" />
<link href="${_cssPath}/common.css" rel="stylesheet" />
<link href="${_cssPath}/pages/orderManagement.css" rel="stylesheet" />
<!-- 预览框按键样式 时间选择框样式-->
	<link href="${_cssPath }/pages/arrangement.css" rel="stylesheet" />
	<link href="${_cssPath }/pages/bannerManage.css" rel="stylesheet" />

<script src="${_jsPath }/jquery/jquery.1.8.1.js"  type="text/javascript"></script>
<script src="${_jsPath }/plugin/My97DatePicker/WdatePicker.js"></script>

	<script src="${_jsPath}/plugin/formvalidator/formValidatorRegex.js" language="javascript"></script>
	<script src="${_jsPath}/plugin/formvalidator/formValidator-4.1.3.js" language="javascript"></script>

<script type="text/javascript">

$(function(){
	// 查询按钮绑定事件
	$("#search").on("click",function(){
			var keywords = $(".J-keywords").val();
			if(keywords == $(".J-keywords").attr("data-default")){
				$(".J-keywords").val("");
			}
			var url= _ctxPath + '/admin/product/product-searchProducts.htm';
			$("sub-form").attr("action",url);
			$(".sub-form").submit();
		});
	//查看
	$(".view").click(function(){
		var productId = $(this).closest("tr").attr("productId");
		window.location.href = _ctxPath +"/test/user/product2/view.do?productId="+productId+"&mark=1";
	});
	//审核
	$(".review").click(function(){
		var productId = $(this).closest("tr").attr("productId");
		window.location.href = _ctxPath + "/test/user/product2/review.do?productId="+productId+"&mark=2";
	});
	
	$(".editManager").click(function(){
		var productId = $(this).closest("tr").attr("productId");
		window.location.href = _ctxPath + "/seller/product/product-editManager.htm?product.productId="+productId;
	});
	
	// -- 模版下载  beginning
	$("#exportUploadModel").click(function(){
		var url= _ctxPath + '/test/user/product2/exportUploadModel.do';
		$("#subFrm").attr("action",url);
		$("#subFrm").submit();
	});
	// end
	
	//-- 商品批量导入 beginning
	$("#importProduct").click(function(){
		var fileName;
		var url = _ctxPath + '/test/user/product2/importProduct.do';
		$.dialog({
            title: false,
            content: "<form id='upFrm' method='post' enctype='multipart/form-data' action='"+url+"'><input id='upload' type='file' name='upload'/></form>",
            okValue: "上传",
	        ok: function(){
	        	// 文件检验，判断文件是否为Excel文件
	        	fileName = $('#upload').val();
        		var m=parseInt(fileName.toString().lastIndexOf("."))+1;  
        		var extVal=fileName.toString().substr(m);  
        		if(fileName=="" || fileName == null){
        			$.dialog({
			            title: false,
			            content: "请选择导入文件",
			            time : 1500
			        });	
        			return false;
        		}
        		var val = $.trim(extVal).toUpperCase();
        		if(val!="XLS" && val!="XLSX"){
        			$.dialog({
			            title: false,
			            content: "文件格式不正确,请选择Excel文件",
			            time : 1500
			        });	
        			return false;
        		}
     
	        	// 后台执行
        		$("#upFrm").submit();
            },
            cancelValue: "取消",
            cancel: true
        });
	});
	//-- end
	
	// 样品确认
	$(".sampleConfirm").click(function() {
		var productId = $(this).closest("tr").attr("productId");
		$.ajax({
			type:'POST',
			url: _ctxPath + '/test/user/product2/confirmSample1.do',
			data: "product.productId="+productId,
			dataType: "json",
			success:function(msg){
				if(msg.info){
					$.dialog({
			            title: false,
			            content: "确认成功",
			            time : 2000
			        });	
				}
				$("#search").click();
			},
			error: function(xhr){
				popupDialog(xhr.responseText);
	        }
		});
	});	
	
	// 样品拒绝 
	$(".sampleRefused").click(function() {
		var productId = $(this).closest("tr").attr("productId");
		$.ajax({
			type:'POST',
			url: _ctxPath + '/seller/product/product-refusedSample.htm',
			data: "product.productId="+productId,
			success:function(msg){
				if(msg.info == "true"){
					$.dialog({
			            title: false,
			            content: "样品被拒绝",
			            time : 2000
			        });	
				}
				$("#search").click();
			},
			error: function(xhr){
				popupDialog(xhr.responseText);
	        }
		});
	});		
	
	// 制作确认
	$(".inService").click(function() {
		var productId = $(this).closest("tr").attr("productId");
		$.ajax({
			type:'POST',
			url: _ctxPath + '/seller/product/product-makingSample1.htm',
			data: "product.productId="+productId,
			success:function(msg){
				if(msg.info == "true"){
					$.dialog({
			            title: false,
			            content: "确认成功",
			            time : 2000
			        });	
				}
				$("#search").click();
			},
			error: function(xhr){
				popupDialog(xhr.responseText);
	        }
		});
	});	

	//编辑
	$(".edit").click(function(){
		var productId = $(this).closest("tr").attr("productId");
		window.location.href = _ctxPath + "/admin/product/product-edit4zhizuo.htm?product.productId="+productId;
	});	
	//在线编辑
	//$(".edit_online").click(function(){
		//var productId = $(this).closest("tr").attr("productId");
		//window.location.href = _ctxPath + "/admin/product/product-edit4zhizuoOnline.htm?product.productId="+productId;
	//});	
	//同步
	$(".sych_online").click(function(){
		var productId = $(this).closest("tr").attr("productId");
		$.ajax({
			type:'POST',
			url: _ctxPath + '/seller/product/product-sychronizeProduct.htm',
			data: "product.productId="+productId,
			success:function(msg){
				if(msg.info == "true"){
					$.dialog({
			            title: false,
			            content: "同步成功",
			            time : 2000
			        });	
				}
				$("#search").click();
			},
			error: function(xhr){
				popupDialog(xhr.responseText);
	        }
		});
	});	
	
	//发布
	$(".publish").click(function() {
		var productId = $(this).closest("tr").attr("productId");
		$.ajax({
			type:'POST',
			url: _ctxPath + '/seller/product/product-publish1.htm',
			data: "product.productId="+productId,
			success:function(msg){
				if(msg.info == "true"){
					$.dialog({
			            title: false,
			            content: "确认成功",
			            time : 2000
			        });	
				}
				$("#search").click();
			},
			error: function(xhr){
				popupDialog(xhr.responseText);
	        }
		});
	});	
	
	// 下架审核
	$(".offmarketConfirm").click(function() {
		var productId = $(this).closest("tr").attr("productId");
		$.ajax({
			type:'POST',
			url: _ctxPath + '/seller/product/product-offmarketConfirm.htm',
			data: "product.productId="+productId,
			success:function(msg){
				if(msg.info == "审核通过"){
					$.dialog({
			            title: false,
			            content: "下架成功",
			            time : 2000
			        });	
				} else {
					$.dialog({
			            title: false,
			            content: "存在待发货订单和已发货待签收订单, 不能下架",
			            time : 2000
			        });						
				}
				$("#search").click();
			},
			error: function(xhr){
				popupDialog(xhr.responseText);
	        }
		});
	});

	// 逻辑删除
	$(".logicDeleteBtn").click(function() {
		if(confirm("确定要删除商品吗？")){
			var productId = $(this).closest("tr").attr("productId");
			$.ajax({
				type:'POST',
				url: _ctxPath + '/seller/product/product-logicDeleteProduct.htm',
				data: "product.productId="+productId,
				success:function(msg){
					if(msg.code == "true"){
						alert(msg.info);
					}
					$("#search").click();
				}
			});
		}
	});

	// 商品导出
	$("#export").bind("click", function() {
		//如果是默认值则给空值
		var keywords = $(".J-keywords").val();
		if(keywords == $(".J-keywords").attr("data-default")){
			$(".J-keywords").val("");
		}
		$("#subFrm").attr("action", _ctxPath + "/test/user/product2/exportProductsByConditions.do");
		$("#subFrm").submit();
		$("#subFrm").attr("action", _ctxPath + "/system/user/findUserByCriteriaAndPage.do");
	});
});

var clickAddOrEdit=function(id,pId,actionUrl){
	// alert(code+"----"+${SHUFFLING_FIGURE});
	var html = '';
	$.ajax({
		url: actionUrl,// + "/admin/adv/seasonal_toEditDetail.htm",
		type:"POST",
		data:{'id':id,'pId':pId},
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
					var result = $.formValidator.pageIsValid('curGroup');
					if(!result){
						return false;
					}
//						$("#advForm").submit();
					$.ajax({
						url:'${_ctxPath}/system/rule/update.do',
						type:"POST",
//							data:JSON.stringify($('#advForm').serializeObject()),
						data:$('#advForm').serialize(),
						dataType:"json",
						async: false,
						success:function(data){
							if(data.code==200){// 保存成功
								//$.dialog({
								//	title : false,
								//	content : "删除成功",
								//	time : 2000
								//});
								//$(".d-close").hide();
								window.location.reload();
							}else{
								$.dialog({
									title : false,
									content : "编辑保存失败",
									time : 2000
								});
								//$.dialog({
								//	title : "删除失败",
								//	content : "删除失败!!!!!",
								//	time : 2000
								//});
								$(".d-close").hide();
							}
						}
					});
				},
				okValue:"保  存"
			});
		},
		error:function(data){
			// alert(data.responseText);
		}
	});
};

var imgView=function(obj){
	$.dialog({
		lock: true,
		padding: "5px",
//		title:false,
		title:"测试一下",
		content : "<img src="+$(obj).prev().html()+" width='200'/>",
		fixed: true,
		cancel: true,
		cancelValue: "关  闭",
		//defaul value is true
		drag : false,
		closed:false
	});
	$(".d-close").hide();
};

function testDialog2() {
	$.dialog({
		title : false,
		content : "时间越来越少",
		time : 2000,
		esc : true,
		initialize : function () {
			alert("对话框初始化后执行的函数");
		},
		beforeunload : function () {
			alert("对话框关闭前执行的函数");
		}
	});


//	var timer;
//	$.dialog({
//		content: '时间越来越少，越来越少..',
//		init: function () {
//			var that = this, i = 5;
//			var fn = function () {
//				that.title(i + '秒后关闭');
//				!i && that.close();
//				i --;
//			};
//			timer = setInterval(fn, 1000);
//			fn();
//		},
//		close: function () {
//			clearInterval(timer);
//		}
//	});
}

function succusTip(content){
	$.dialog({
		lock: true,
		padding: "5px",
		title:false,
		content:content,
		fixed: false,
		cancel: false,
		okValue:"确定"
		//,
		//	ok:function(){
		//
		//	}
	});
}
</script>
</head>
    <c:set var="STATUS_PASS" value="<%=Product.STATUS_PASS %>"></c:set>
    <c:set var="STATUS_DRAFT" value="<%=Product.STATUS_DRAFT %>"></c:set>
    <c:set var="CHECK_PEND" value="<%=Product.STATUS_CHECK_PEND %>"></c:set>
    <c:set var="status_no_pass" value="<%=Product.STATUS_NO_PASS %>"></c:set>
           <c:set var="SELLTYPE_US" value="<%= Product.SELLTYPE_US %>"></c:set>
    <c:set var="STATUS_WAITING_REVIEW" value="<%=Product.STATUS_WAITING_REVIEW %>"></c:set>
    <c:set var="STATUS_WAINTING_MAKING" value="<%=Product.STATUS_WAINTING_MAKING %>"></c:set>
    <c:set var="STATUS_IN_SERVICE" value="<%=Product.STATUS_IN_SERVICE %>"></c:set>
    <c:set var="STATUS_VALID" value="<%=Product.STATUS_VALID %>"></c:set>
    <c:set var="STATUS_WAINTING_INVALID" value="<%=Product.STATUS_WAINTING_INVALID %>"></c:set>
<body>
	<jsp:include page="../include/header.jsp" flush="true" />
	<div class="body m-w980p">
	 <!--start form-->
        <form id="subFrm" class="sub-form m-clear m-mt10p" action="${_ctxPath}/system/user/findUserByCriteriaAndPage.do" method="post">
        <input type="hidden" value="${uploadMessage}" id = "msg"/>
    <aut:authorize url="/admin/product/product-search">
            <div class="m-fl">
				姓名：
				<input type="text" data-default="输入用户姓名" name="realName" value="${userPage.params.realName }" class="J-keywords txt-input input-marks" />
                <select name="status" class="m-sel">
                	<option value="">选择状态</option>
					<option value="0" <c:if test="${userPage.params.status==0 }">selected = "selected"</c:if>>禁用</option>
					<option value="1" <c:if test="${userPage.params.status==1 }">selected = "selected"</c:if>>启用</option>
				</select>
				<label>注册时间：</label>
				<input type="text" name="beginTime" value="${userPage.params.beginTime}" class="Wdate"
					   id="beginTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endTime\',{d:-1});}',minDate:'#F{$dp.$D(\'endTime\',{d:-92});}',readOnly:true})" />

				<label>至 </label>
				<input type="text" name="endTime" value="${userPage.params.endTime}" class="Wdate"
					   id="endTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'beginTime\',{d:+92});}',maxDate:'%y-%M-%d',minDate:'#F{$dp.$D(\'beginTime\')}',readOnly:true})" />
	        </div>
            <div class="m-mt10p">
              <input type="button" class="m-btn m-btn-search" value="查 询" id="search"/>
              <input type="button" id="importProduct" class="m-btn" value="批量导入" />
              <input type="button" id="exportUploadModel" class="m-btn" value="下载模版" />
				<span style="display: none;">
					http://we-mall.oss-cn-shanghai.aliyuncs.com/beadwalletmallImg/upload/cms/2018-06-12/57b3af8531c840489b556b4a48ae130f.jpg
				</span>
				<input type="button" id="" class="m-btn" onclick="imgView(this)" value="预览弹出" />
				<input type="button" id="" class="m-btn" onclick="succusTip('测试一下')" value="模态弹出" />
				<input type="button" id="" class="m-btn" onclick="testDialog2()" value="弹出2" />
				<%--<a class="preview" style="cursor: pointer;" onclick="imgView(this)">预览</a>--%>
				<%--<a class="preview" style="cursor: pointer;" onclick="succusTip('测试一下')">测试</a>--%>
              <input type="button" id="export" class="m-btn" value="导出" />
              <input type="button" id="export" class="m-btn" value="新增" onclick="clickAddOrEdit('${rule.id}','${rule.parentId}','${_ctxPath}/test/user/product2/toUpload.do')"/>
            </div>
            </aut:authorize>
           	<c:if test="${not empty userPage.result}">
	            <div class="m-fr curr-num">
	              <label >当前显示：</label>
	              <yp:commPageSize page="${userPage}" beanName="userPage"></yp:commPageSize>
	            </div>
           	</c:if>
        </form>
		<!--start 商品管理table-->
		<div class="order-management">
			<table width="100%" id="order-tab">
				<thead class="tab-control">
                    <tr>
                        <th width="10%">登录用户名</th>
                        <th width="10%">姓名</th>
                        <th width="8%">性别</th>
                        <th width="8%">联系方式</th>
                        <th width="10%">邮箱</th>
                        <th width="8%">状态</th>
                        <th width="8%">角色</th>
                        <th width="12%">创建时间</th>
                        <th width="12%">更新时间</th>
                        <th width="20%">操作</th>
                    </tr>
                </thead>
				<tbody>
				<tr class="list-tr">
					<td colspan="10" class="td-nobor">
						<table class="tab-control">
							<tr class="tr-height" productId="100">
								<td class="num-icon" width="10%"><input id="sellType_100" type="hidden" value="1">
									<i></i><label><a>手机</a></label>
								</td>
								<td width="10%">手机2</td>
								<td width="8%">100</td>
								<td width="8%">
									<img src="http://we-mall.oss-cn-shanghai.aliyuncs.com/beadwalletmallImg/upload/cms/2018-06-12/57b3af8531c840489b556b4a48ae130f.jpg" width="100" />
								</td>
								<td width="10%">
									上架
								</td>
								<td width="8%">
									1
								</td>
								<td width="8%">
									qktq
								</td>
								<td width="12%">
									2018-06-12 12:44
								</td>
								<td width="12%">
									2018-06-12 12:44
								</td>
								<td width="20%">
									<p>
										<a class="c-blue view" href="javascript:;">查看-点我</a>
									</p>
									<p>
										<%--<p><a class="c-blue" href="${_ctxPath }/admin/product/buySchedule-reviewScheduleProduct.htm?product.productId=${product.productId}&mark=2" target="_blank">审核</a></p>--%>
										<a class="c-blue review" href="javascript:;">审核-点我</a>
									</p>
									<p><a class="c-blue sampleConfirm" href="javascript:;">样品确认-点我</a></p>
									<p><a class="c-blue sampleRefused" href="javascript:;">样品拒绝</a></p>
									<p><a class="c-blue inService" href="javascript:;">制作确认</a></p>
											<p><a class="c-blue edit" href="javascript:;">编辑</a></p>
											<%--
                                            <p><a class="c-blue edit_online" href="javascript:;">在线编辑</a></p>
                                             --%>
										<c:if test="${product.status == STATUS_IN_SERVICE and product.coverPicture != ''}">
											<p><a class="c-blue publish" href="javascript:;">发布</a></p>
										</c:if>
										<%----%>
									<c:if test="${product.status == STATUS_PASS  and product.coverPicture != ''}">
										<c:if test="${product.isEdit == 1}"><p><a class="c-blue sych_online" href="javascript:;">同步在线商品</a></p></c:if>
										<p><a class="c-blue" href="${_ctxPath }/seller/product/product-previewOnline.htm?product.productId=${product.productId}&productOnline.productId=${product.productId}" target="_blank">同步后浏览</a></p>
									</c:if>
									<aut:authorize url="/seller/product/product-offmarketConfirm">
										<c:if test="${product.status == STATUS_WAINTING_INVALID}">
											<p><a class="c-blue offmarketConfirm" href="javascript:;">下架审核</a></p>
										</c:if>
									</aut:authorize>
									<c:if test="${product.sellStatus == 8}">
										<p><a class="c-blue logicDeleteBtn" href="javascript:;">删除</a></p>
									</c:if>
									<aut:authorize url="/admin/product/product-preview">
										<c:if test="${product.productId != null }">
											<p><a class="c-blue" href="${_ctxPath }/admin/product/product-preview.htm?product.productId=${product.productId}" target="_blank">预览</a></p>
										</c:if>
									</aut:authorize>
								</td>
							</tr>
						</table>
					</td>
				</tr>
					<c:if test="${fn:length(userPage.result)>0 }">
							<c:forEach items="${userPage.result}"  var="user" varStatus="status">
								<tr class="list-tr">
									<td colspan="10" class="td-nobor">
										<table class="tab-control">
											<tr class="tr-height" productId="${user.id }">
												<td class="num-icon" width="10%"><input id="sellType_${user.id }" type="hidden" value="${user.id }">
													<i></i><label><a>${user.loginName }</a></label>
												</td>
												<td width="10%">${user.realName}</td>
												<td width="8%">${user.sex}</td>
												<td width="8%">${user.phone}</td>
												<td width="10%">${user.email}</td>
												<td width="8%">
													<c:if test="${user.status eq 1}">启用</c:if>
													<c:if test="${user.status eq 0}">禁用</c:if>
												</td>
												<td width="8%">
													${user.password}
												</td>
												<td width="12%">
													<fmt:formatDate value='${user.createTime}'
																	pattern='yyyy-MM-dd HH:mm:ss' />
												</td>
												<td width="12%">
													<fmt:formatDate value='${user.updateTime}'
																	pattern='yyyy-MM-dd HH:mm:ss' />
												</td>
												<td width="20%">
													<p><a class="c-blue edit" href="javascript:;">跳转编辑</a></p>
													<p><a class="c-blue edit" href="javascript:;">弹出编辑</a></p>
													<p><a class="c-blue del" href="javascript:;">删除</a></p>
												</td>						
											</tr>
										</table>
									</td>
								</tr>
							</c:forEach>
					</c:if>
					<c:if test="${fn:length(userPage.result)==0 }">
						<tr class="list-tr">
							<td colspan="10" class="td-nobor" align="center">
								对不起，没有找到相关商品信息，请重新选择查询条件
							</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
		<div class="table-bm-wrap cf">
			<!--S 右功能区-->
			<div class="fn-right">
				<!--S 分页-->
				<div class="pagination pagination-right">
					<c:if test="${not empty userPage.result}">
						<yp:commPage page="${userPage}" beanName="userPage"></yp:commPage>
					</c:if>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/foot.jsp"></jsp:include>
</body>
<script type="text/javascript">
	var isPost = true;
	var msg = $("#msg").val();
//	msg = "数据不完事！";
	if(msg!=null && msg !=""){
		$.dialog({
	        title: false,
	        content:"<font color='red'>"+msg+"</font>",
	        time : 8000
	    });	
	}
	$(document).ready(function() {
		// -- 列表行单击绑定时间 beginning
		$(".tr-height").on("click", function(e) {
			var $this = $(this),
				evt = $(e.target);
			console.log(evt);
			if(!evt.is('a')){
				var userId = $this.attr('userId');
				console.log("userId:"+userId);
				if (!$(this).next(".show-tr")[0]) {
					if( isPost == false) return;
					isPost = false;
					$.ajax({
						type : 'POST',
						url : '${_ctxPath}/product/listProductSkuDetailOnline.do',
						data : {
							"product.productId" : userId,
							"product.sellType" : $("#sellType_"+userId).val(),
							"mark" : 2
						},
						success : function(html) {
							isPost = true;
							var content;
							if (typeof html == "object") {
								data = eval(html);
								content = data.info;
							} else {
								content = html;
							}
							$($this).after($(content));
							$this.addClass("change");
						},
						error:function(){
							isPost = true;
						}
					});
				}
			}
		});
		//-- end
	});
</script>
</html>