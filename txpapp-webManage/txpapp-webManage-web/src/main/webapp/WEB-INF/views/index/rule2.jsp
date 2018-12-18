<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>
<html>
<head>
<meta charset="utf-8" />
	<link rel="stylesheet" href="${_treePath}/jquery.treeview.css" />
	<%--<link rel="stylesheet" href="${_treePath}/red-treeview.css" />--%>
	<link rel="stylesheet" href="${_treePath}/screen.css" />

	<script type="text/javascript" src="${_jsPath }/jquery/jquery.1.8.1.js"></script>
	<%--<script src="${_treePath}/lib/jquery.js" type="text/javascript"></script>--%>
	<script src="${_treePath}/lib/jquery.cookie.js" type="text/javascript"></script>
	<script src="${_treePath}/jquery.treeview.js" type="text/javascript"></script>

	<link href="${_cssPath }/common.css" rel="stylesheet" />
	<%--弹出框按钮配色--%>
	<link href="${_cssPath }/pages/arrangement.css" rel="stylesheet" />
	<link href="${_cssPath }/pages/bannerManage.css" rel="stylesheet" />
	<script src="${_jsPath}/plugin/formvalidator/formValidatorRegex.js" language="javascript"></script>
	<script src="${_jsPath}/plugin/formvalidator/formValidator-4.1.3.js" language="javascript"></script>


<title>我的收入</title>
<link href="${_cssPath }/common.css" rel="stylesheet" />
<%--<script type="text/javascript" src="${_jsPath }/jquery/jquery.1.8.1.js"></script>--%>

<style>
	.order-management{margin-top:10px;}
	.order-management table{border:1px solid #BFAD61;}
	.order-management table td{border-bottom:1px solid #BFAD61;padding-left:5px;}
	.custom5,.custom6{ float:left}
</style>
</head>
<script type="text/javascript">

	//定义serializeObject方法，序列化表单
	$.fn.serializeObject = function() {
		var o = {};
		var a = this.serializeArray();
		$.each(a, function() {
			if (o[this.name]) {
				if (!o[this.name].push) {
					o[this.name] = [ o[this.name] ];
				}
				o[this.name].push(this.value || '');
			} else {
				o[this.name] = this.value || '';
			}
		});
		return o;
	};
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
						var result = $.formValidator.pageIsValid('1');
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

	var ruleAdd=function(pId,actionUrl){
		var html = '';
		$.ajax({
			url: actionUrl,// + "/admin/adv/seasonal_toEditDetail.htm",
			type:"POST",
			data:{'pId':pId},
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
						var result = $.formValidator.pageIsValid('1');
						if(!result){
							return false;
						}
//						$("#advForm").submit();
						$.ajax({
							url:'${_ctxPath}/system/rule/save.do',
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
					okValue:"保  存"
				});
			},
			error:function(data){
				// alert(data.responseText);
			}
		});
	};

	var ruleDel=function(id,actionUrl){
		$.dialog({
			lock: true,
			padding: "5px",
			title:false,
			content:"确定要删除该权限吗?",
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

							window.location.reload();
//							$("#search").click();
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

	var showSupplier2 = function(ruleId,actionUrl){
		var html = '';
		$.ajax({
			url: actionUrl,// + "/admin/adv/seasonal_toEditDetail.htm",
			type:"POST",
			data:{'ruleId':ruleId},
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
						var result = $.formValidator.pageIsValid('1');
						if(!result){
							return false;
						}
//						$("#advForm").submit();
						$.ajax({
							url:'${_ctxPath}/system/rule/save.do',
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
					okValue:"保  存"
				});
			},
			error:function(data){
				// alert(data.responseText);
			}
		});
	};

</script>

<body>
	<!--start header-->
	<jsp:include page="/WEB-INF/views/include/header.jsp"></jsp:include>
	<!--end header-->
	<div class="body m-w980p custom5">
		<div class="custom5">
			<ul id="tree" class="filetree custom5" style="width: 300px;">
				<li><span class="folder" data-rid="0" style="cursor: pointer;">返回权限列表首页</span>
				<c:forEach items="${treeList}" var="treeL1">
					<li><span class="folder" data-rid="${treeL1.id}" style="cursor: pointer;">${treeL1.name}</span>
						<c:if test="${not empty treeL1.children}">
							<c:forEach items="${treeL1.children}" var="treeL2">
								<ul>
									<li><span class="folder" data-rid="${treeL2.id}" style="cursor: pointer;">${treeL2.name}</span>
										<c:if test="${not empty treeL2.children}">
											<c:forEach items="${treeL2.children}" var="treeL3">
												<ul>
													<li><span class="" data-rid="${treeL3.id}">${treeL3.name}</span></li>
												</ul>
											</c:forEach>
										</c:if>
									</li>
								</ul>
							</c:forEach>
						</c:if>
					</li>
				</c:forEach>
				<%--<li><span class="folder">系统管理</span>--%>
					<%--<ul>--%>
						<%--<li><span class="folder">部门管理</span></li>--%>
						<%--<li><span class="folder">岗位管理</span>--%>
							<%--<ul>--%>
								<%--<li><span class="">岗位添加</span></li>--%>
								<%--<li><span class="">岗位删除</span></li>--%>
							<%--</ul>--%>
						<%--</li>--%>
						<%--<li><span class="folder">用户管理</span>--%>
							<%--<ul>--%>
								<%--<li><span class="folder">添加用户</span></li>--%>
								<%--<li><span class="folder">修改用户</span></li>--%>
							<%--</ul>--%>
						<%--</li>--%>
					<%--</ul>--%>
				<%--</li>--%>
				<%--<li><span class="folder">审批流转</span></li>--%>
			</ul>

			<script type="text/javascript">
				$("#tree").treeview();

				$(".folder").on("click",function(){
//					alert("1" + $(this).html() + $(this).attr("data-rid"));
					window.location.href = '${_ctxPath}/system/user/rule2.do?pId='+$(this).attr("data-rid");
//					$('#tree').treeview('collapseAll', { silent:true });
				});

			</script>
		</div>
		<div class="custom6">
				<div  class="m-clear">
					<input type="button" id="addRule" class="m-btn" value="新增权限" onclick="ruleAdd('${pId}','${_ctxPath}/system/rule/getRuleAddPage.do')" />
					<%--<input type="button" id="addRule2" class="m-btn" value="新增权限2" onclick="showSupplier2('1','${_ctxPath}/system/rule/showSupplier2.do')" />--%>
				</div>
			<!--start 下单管理table-->
			<div class="order-management">
				<table id="order-tab22" width="100%">
					<thead class="tab-control">
						<tr>
							<th width="150px">权限代码</th>
							<th width="180px">权限名称</th>
							<th width="150px">父权限</th>
							<th width="100px">权限类型</th>
							<th width="100px">排序</th>
							<th width="170px">权限描述</th>
							<th width="120px">操作</th>
						</tr>
					</thead>

					<tbody>
					<c:forEach items="${ruleList}" var="rule">
						<tr class="tr-height">
							<td class="num-icon">${rule.ruleCode}</td>
							<td>${rule.ruleName}</td>
							<td>${rule.parent.ruleName}</td>
							<td>
								<c:choose>
									<c:when test="${rule.ruleType==1}">菜单</c:when>
									<c:otherwise>按键</c:otherwise>
								</c:choose>
							</td>
							<td>${rule.ruleOrder}</td>
							<td>${rule.ruleDesc}</td>
							<td>
								<a class="c-blue edit" onclick="clickAddOrEdit('${rule.id}','${rule.parentId}','${_ctxPath}/system/rule/getRuleEditPage.do')" style="cursor: pointer;">编辑</a>
								<a class="c-blue logicDeleteBtn" href="javascript:;" onclick="ruleDel('${rule.id}','${_ctxPath}/system/rule/deleteRule.do')">删除</a>
							</td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>

		</div>
	</div>

	<!--start footer-->
	<jsp:include page="/WEB-INF/views/include/foot.jsp"></jsp:include>
</body>
</html>