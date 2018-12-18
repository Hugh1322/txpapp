<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>角色管理</title>
	<link rel="stylesheet" href="${_treePath}/jquery.treeview.css" />
	<link rel="stylesheet" href="${_treePath}/screen.css" />

	<script type="text/javascript" src="${_jsPath }/jquery/jquery.1.8.1.js"></script>
	<script src="${_treePath}/lib/jquery.cookie.js" type="text/javascript"></script>
	<script src="${_treePath}/jquery.treeview.js" type="text/javascript"></script>
	<%--弹出框按钮配色--%>
	<link href="${_cssPath }/common.css" rel="stylesheet" />
	<link href="${_cssPath}/pages/orderManagement.css" rel="stylesheet" />
	<%--弹出框按钮配色--%>
	<link href="${_cssPath }/pages/arrangement.css" rel="stylesheet" />
	<link href="${_cssPath }/pages/bannerManage.css" rel="stylesheet" />
	<script src="${_jsPath}/plugin/formvalidator/formValidatorRegex.js" language="javascript"></script>
	<script src="${_jsPath}/plugin/formvalidator/formValidator-4.1.3.js" language="javascript"></script>

<script type="text/javascript">
	$(function() {
		// 查询按钮绑定事件
		$("#search").on("click", function () {
//			var url = _ctxPath + '/admin/product/product-searchProducts.htm';
//			$("sub-form").attr("action", url);
			$(".sub-form").submit();
		});
	});

	var roleAdd=function(actionUrl){
		// alert(code+"----"+${SHUFFLING_FIGURE});
		var html = '';
		$.ajax({
			url: actionUrl,// + "/admin/adv/seasonal_toEditDetail.htm",
			type:"POST",
			dataType:"html",
			async: false,
			disable:false,
			success:function(data){
				html=data;
				$.dialog({
					lock: true,
					padding: "5px",
					title:"角色权限",
					content:html,
					fixed: false,
					cancel: true,
					cancelValue:"取  消",
					ok:function(){
//						$("#advForm").submit();
						$.ajax({
							url:'${_ctxPath}/system/role/save.do',
							type:"POST",
//							data:JSON.stringify($('#advForm').serializeObject()),
							data:$('#advForm').serialize(),
							dataType:"json",
							async: false,
							success:function(data){
								if(data.code==200){// 保存成功
									window.location.reload();
								}else{
									document.documentElement.scrollTop=document.body.scrollTop=0;
									$.dialog({
										title : false,
										content : data.msg,
										time : 2000
									});
									$(".d-close").hide();
								}
							}
						});
					},
					cancel: function(){
//						window.location.reload();
						document.documentElement.scrollTop=document.body.scrollTop=0;
					},
					okValue:"保  存"
				});
//				document.documentElement.scrollTop=document.body.scrollTop=100;
			},
			error:function(data){
				// alert(data.responseText);
			}
		});
	};

	var roleEdit=function(id,pId,actionUrl){
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
					title:"角色权限",
					content:html,
					fixed: false,
					cancel: true,
					cancelValue:"取  消",
					ok:function(){
//						var result = $.formValidator.pageIsValid('1');
//						if(!result){
//							return false;
//						}
//						$("#advForm").submit();
						$.ajax({
							url:'${_ctxPath}/system/role/update.do',
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
									document.documentElement.scrollTop=document.body.scrollTop=0;
									$.dialog({
										title : false,
										content : data.msg,
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
					cancel: function(){
//						window.location.reload();
						document.documentElement.scrollTop=document.body.scrollTop=0;
					},
					okValue:"保  存"
				});
//				document.documentElement.scrollTop=document.body.scrollTop=100;
			},
			error:function(data){
				// alert(data.responseText);
			}
		});
	};

	var roleDel=function(id,actionUrl){
		$.dialog({
			lock: true,
			padding: "5px",
			title:false,
			content:"确定要删除角色吗?",
			fixed: false,
			cancel: true,
			cancelValue:"取 消",
			ok:function(){
				$.ajax({
					type:'POST',
					url: actionUrl,
					data:{'id':id},
					dataType:"json",
					contentType: "application/x-www-form-urlencoded; charset=utf-8",
//				data: "product.productId="+productId,
					success:function(msg){
						if(msg.code == 200){
							$.dialog({
								title : false,
								content : "成功！",
								time : 2000
							});

//							window.location.reload();
							$("#search").click();
						}else {
							$.dialog({
								title : false,
//								content : "删除失败！",
								content : msg.msg,
								time : 2000
							});
							$(".d-close").hide();
						}
					}
				});
			},
			okValue:"删除"
		});
//		$(".d-close").hide();
	};

</script>
	<style>
		.order-management{margin-top:10px;}
		.order-management table{border:1px solid #BFAD61;}
		.order-management table td{border-bottom:1px solid #BFAD61;padding-left:5px;}
		.custom5,.custom6{ float:left}
	</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
	<div class="body m-w980p">
	 <!--start form-->
        <form id="subFrm" class="sub-form m-clear m-mt10p" action="${_ctxPath}/system/role/findsByPageNew.do" method="post">
        <input type="hidden" value="${uploadMessage}" id = "msg"/>
            <div class="m-mt10p">
              <input type="button" class="m-btn m-btn-search" value="查 询" id="search"/>
              <input type="button" id="addRole" class="m-btn" value="新增角色" onclick="roleAdd('${_ctxPath}/system/role/toAdd.do')" />
              <!-- <input type="button" id="export" class="m-btn" value="导出" /> -->
            </div>
           	<c:if test="${not empty rolePage.result}">
	            <div class="m-fr curr-num">
	              <label >当前显示：</label>
	              <yp:commPageSize page="${rolePage}" beanName="rolePage"></yp:commPageSize>
	            </div>
           	</c:if>
        </form>
		<!--start 商品管理table-->
		<div class="order-management">
			<table width="100%" id="order-tab22">
				<thead class="tab-control">
                    <tr>
                        <th width="10%">角色编号</th>
                        <th width="15%">角色名称</th>
                        <th width="20%">角色描述</th>
                        <th width="10%">操作</th>
                    </tr>
                </thead>
				<tbody>
					<c:if test="${fn:length(rolePage.result)>0 }">
						<c:forEach items="${rolePage.result}" var="role">
							<tr class="tr-height">
								<td class="num-icon">${role.roleCode }</td>
								<td>${role.roleName}</td>
								<td>${role.roleDesc}</td>
								<td>
									<a class="c-blue edit" onclick="roleEdit('${role.id}','${role.id}','${_ctxPath}/system/rule/getRoleEditPage.do')" style="cursor: pointer;">编辑</a>
									<a class="c-blue logicDeleteBtn" onclick="roleDel('${role.id}','${_ctxPath}/system/role/deleteNew.do')" style="cursor: pointer;">删除</a>
								</td>
							</tr>
						</c:forEach>
					</c:if>
					<c:if test="${fn:length(rolePage.result)==0 }">
						<tr class="list-tr">
							<td colspan="4" class="td-nobor" align="center">
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
					<c:if test="${not empty rolePage.result}">
						<yp:commPage page="${rolePage}" beanName="rolePage"></yp:commPage>
					</c:if>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/include/foot.jsp"></jsp:include>
</body>
<script type="text/javascript">

</script>
</html>