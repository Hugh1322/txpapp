<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="../include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript" src="${_jsPath}/plugin/uploadify/swfobject.js"></script>
<script type="text/javascript" src="${_jsPath}/plugin/uploadify/jquery.uploadify.v2.1.4.min.js"></script>


<div class="m-mt10p addBanner">
	<div class="body m-w480p">
		<!--start form-->
		<form id="subFrm" class="sub-form m-clear m-mt10p" action="${_ctxPath}/system/rule/showSupplier.do" method="post">
			<input type="hidden" value="${uploadMessage}" id = "msg"/>
			<div class="m-mt10p">
				<input type="button" class="m-btn m-btn-search" value="查 询" id="search"/>
				<!-- <input type="button" id="export" class="m-btn" value="导出" /> -->
			</div>
			<%--<c:if test="${not empty suppPage.result}">--%>
				<%--<div class="m-fr curr-num">--%>
					<%--<label >当前显示：</label>--%>
					<%--<yp:commPageSize page="${suppPage}" beanName="page" actionUrl="${_ctxPath}/system/rule/showSupplier.do"></yp:commPageSize>--%>
				<%--</div>--%>
			<%--</c:if>--%>
		</form>
		<!--start 商品管理table-->
		<div class="order-management">
			<table width="100%" id="order-tab28">
				<thead class="tab-control">
				<tr>
					<th width="10%">序号</th>
					<th width="10%">角色编号</th>
					<th width="15%">角色名称</th>
				</tr>
				</thead>
				<tbody>
				<c:if test="${fn:length(suppPage.result)>0 }">
					<c:forEach items="${suppPage.result}" var="role">
						<tr class="tr-height">
							<td>
								<input type="checkbox" class="curCheckbox"/>
							</td>
							<td class="num-icon">${role.id }</td>
							<td>${role.companyName}</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${fn:length(suppPage.result)==0 }">
					<tr class="list-tr">
						<td colspan="4" class="td-nobor" align="center">
							对不起，没有找到相关商品信息，请重新选择查询条件
						</td>
					</tr>
				</c:if>
				</tbody>
			</table>
		</div>
		<%--<div class="table-bm-wrap cf">--%>
			<%--<!--S 右功能区-->--%>
			<%--<div class="fn-right">--%>
				<%--<!--S 分页-->--%>
				<%--<div class="pagination pagination-right">--%>
					<%--<c:if test="${not empty suppPage.result}">--%>
						<%--<yp:commPage page="${suppPage}" beanName="page"></yp:commPage>--%>
					<%--</c:if>--%>
				<%--</div>--%>
			<%--</div>--%>
		<%--</div>--%>
	</div>
	<jsp:include page="curPage.jsp"></jsp:include>

	<div class="order-management">
		<table width="100%" id="order-tab29">
			<thead class="tab-control">
			<tr>
				<th width="100">角色编号</th>
				<th width="200">角色名称</th>
				<th width="80">排序</th>
			</tr>
			</thead>
			<tbody class="ushowCls">
			<%--<tr class="tr-height">--%>
				<%--<td>1</td>--%>
				<%--<td>测试</td>--%>
				<%--<td>--%>
					<%--<input type="text"/>--%>
				<%--</td>--%>
			<%--</tr>--%>
			</tbody>
		</table>
	</div>
</div>
<script>
	$(function() {
		// 查询按钮绑定事件
//		$("#search").on("click", function () {
//			var url = _ctxPath + '/admin/product/product-searchProducts.htm';
//			$("sub-form").attr("action", url);
//			$(".sub-form").submit();
//		});
		$(".curCheckbox").on("change",function() {
			if(this.checked){
				//选中行的各个列。。
				var v1_ = $(this).parent().next("td").text();
				var v2_ = $(this).parent().next("td").next("td").text();
				$(".ushowCls").append("<tr class=\"tr-height\">" +
										"<td>"+v1_+"</td>" +
										"<td>"+v2_+"</td>" +
										"<td>" +
										"<input type=\"text\"/>" +
										"		</td>" +
										"		</tr>");
			}else{
//				alert("取消选中");
				var selectId_ = $(this).parent().next("td").text();
//				alert($(this).parent().next("td").text());
				$(".ushowCls").children().each(function() {
//					alert($(this).find("td").eq(0).text());
					if($(this).find("td").eq(0).text()==selectId_) {
						$(this).remove();
					}
				})
			}
		})
	});
	//初始化一共有多少页: pageCount_
	var pageCount_;
	//下一页
	var nextPage = 0;
	if('${suppPage.total}' > 0) {
		pageCount_ = Math.ceil('${suppPage.total}' / '${suppPage.limit}');
		<%--var pageCount = Math.ceil('${suppPage.total}' / 4);--%>
//		console.log(pageCount_);
	}else {
		pageCount_ = 0;
	}
	$(".tcdPageCode").createPage({
		pageCount:pageCount_,
		//1表示 第1页
		current:1,
		backFn:function(p){
			//p是行数
//			console.log(p);

			//所有复选框取消选择
			$(".curCheckbox").each(function () {
				$(this).attr("checked",false);
			});

			//异步加载数据以及动态修改table
			nextPage = p-1;
			$.ajax({
				type:'POST',
				url: _ctxPath + '/system/rule/showSupplierLimit.do',
				data: "total=${suppPage.total}&limit=${suppPage.limit}&currentPage=" + nextPage,
				dataType: "json",
				success:function(msg){
//					console.log(msg.suppPage.result.length);
//					alert(msg.suppPage.result);
					var $trs = $("#order-tab28").find(".tr-height");
					for ( var i = 0; i <msg.suppPage.result.length; i++){
						console.log(msg.suppPage.result[i].companyName);

						if(msg.suppPage.result.length>0) {
							$(msg.suppPage.result).each(function (i, o) {
								$trs.eq(i).find("td").eq(1).text(o.id);
								$trs.eq(i).find("td").eq(2).text(o.companyName);
								$trs.eq(i).show();
							});
							var re_ = $trs.length - msg.suppPage.result.length;
							console.log('相减' + re_);
							for(var i=msg.suppPage.result.length;i<=$trs.length;i++) {
								$trs.eq(i).hide();
							}
						}
					}

					//分页加载后对复选框进行自动选中
					$(".ushowCls").children().each(function() {
//					alert($(this).find("td").eq(0).text());
						var id2_ = $(this).find("td").eq(0).text();
						var $trs = $("#order-tab28").find(".tr-height");
						$trs.each(function() {
							console.log($(this).find("td").eq(1).text() + '-' + id2_);
							if($(this).find("td").eq(1).text() == id2_) {
								$(this).find("td").find(".curCheckbox").attr("checked",true);
							}
						})
					})
//					if(msg.info){
//						$.dialog({
//							title: false,
//							content: "确认成功",
//							time : 2000
//						});
//					}
//					$("#search").click();
				},
				error: function(xhr){
					alert(2);
					popupDialog(xhr.responseText);
				}
			});

//			var json = "[{code:'a1',name:'名称1'},{code:'a12',name:'名称12'},{code:'a13',name:'名称13'},{code:'a14',name:'名称14'}]";
//			var jsonObj = eval("(" + json + ")");
//
//			var $trs = $("#order-tab28").find(".tr-height");
//			console.log($trs.length + '-' + jsonObj.length);
//			if(jsonObj.length>0) {
//				$(jsonObj).each(function (i, o) {
////				console.log(i+'-'+o.value);
//					$trs.eq(i).find("td").eq(1).text(o.code);
//					$trs.eq(i).find("td").eq(2).text(o.name);
//				});
//				var re_ = $trs.length-jsonObj.length;
//				console.log('相减' + re_);
//				for(var i=jsonObj.length;i<=$trs.length;i++) {
//					$trs.eq(i).remove();
//				}
//			}


//			var $tds = $("#order-tab28").find("td");
////			console.log($tds.length);
//			$(jsonObj).each(function (i, o) {
////				console.log(i+'-'+o.value);
//				$tds.eq(i).text(o.code);
//			});
		}
	});
</script>