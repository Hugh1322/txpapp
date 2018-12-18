<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8" import="com.txp.app.contants.Product" pageEncoding="UTF-8"%>
<%@include file="../include/taglibs.jsp"%>
<%@page import="com.txp.app.contants.Product" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>商品管理</title>
<link href="${_jsPath }/plugin/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" />
<link href="${_cssPath}/common.css" rel="stylesheet" />
<link href="${_cssPath}/pages/orderManagement.css" rel="stylesheet" />
<script src="${_jsPath }/jquery/jquery.1.8.1.js"  type="text/javascript"></script>
<script src="${_jsPath }/plugin/My97DatePicker/WdatePicker.js"></script>

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
		window.location.href = _ctxPath +"/admin/product/product-view.htm?product.productId="+productId+"&mark=1";
	});
	//审核
	$(".review").click(function(){
		var productId = $(this).closest("tr").attr("productId");
		window.location.href = _ctxPath + "/admin/product/product-review.htm?product.productId="+productId+"&mark=2";
	});
	
	$(".editManager").click(function(){
		var productId = $(this).closest("tr").attr("productId");
		window.location.href = _ctxPath + "/seller/product/product-editManager.htm?product.productId="+productId;
	});
	
	// -- 模版下载  beginning
	$("#exportUploadModel").click(function(){
		var url= _ctxPath + '/seller/product/product-exportUploadModel.htm';
		$("#subFrm").attr("action",url);
		$("#subFrm").submit();
	});
	// end
	
	//-- 商品批量导入 beginning
	$("#importProduct").click(function(){
		var fileName;
		var url = _ctxPath + '/seller/product/product-importProduct.htm';
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
			url: _ctxPath + '/seller/product/product-confirmSample1.htm',
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
	
});
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
        <form id="subFrm" class="sub-form m-clear m-mt10p" action="${_ctxPath}/admin/product/product-searchProducts.htm" method="post">
        <input type="hidden" value="${uploadMessage}" id = "msg"/>
    <aut:authorize url="/admin/product/product-search">
            <div class="m-fl">
                <select name="productPage.params.brandId" id="brand" class="m-sel">
                   <option value="">全部品牌</option>
                           	<c:forEach items="${brands }" var="brand">
								<option value="${brand.brandId }"
								<c:if test="${productPage.params.brandId==brand.brandId }">
								selected = "selected"
								</c:if>
								>${brand.name }</option>
							</c:forEach>
                </select>
                <select name="productPage.params.status" class="m-sel">
                	<option value="">选择商品状态</option>
							<c:forEach items="${statuses }" var="obj">
							<option value="${obj }"
								<c:if test="${productPage.params.status==obj }">
								selected = "selected"
								</c:if>
								><spring:message code="product.status.${obj}"/></option>
							</c:forEach>
                 </select>
                  <select name="productPage.params.reviewStatus" class="m-sel">
                       <option value="">选择审核状态</option>
							<c:forEach items="${reviewStatuses }" var="obj">
								<option value="${obj }"
								<c:if test="${productPage.params.reviewStatus==obj }">
								selected = "selected"
								</c:if>
								><spring:message code="product.check.${obj}"/></option>
							</c:forEach>
                        </select>
              <input type="text" data-default="输入品牌名称，商品名称，商户名称" name="productPage.params.name" value="${productPage.params.name }" class="J-keywords txt-input input-marks" />
	        </div>
            <div class="m-mt10p">
              <input type="button" class="m-btn m-btn-search" value="查 询" id="search"/>
              <input type="button" id="importProduct" class="m-btn" value="批量导入" />
              <input type="button" id="exportUploadModel" class="m-btn" value="下载模版" />
              <!-- <input type="button" id="export" class="m-btn" value="导出" /> -->
            </div>
            </aut:authorize>
           	<c:if test="${not empty productPage.result}">
	            <div class="m-fr curr-num">
	              <label >当前显示：</label>
	              <yp:commPageSize page="${productPage}" beanName="productPage"></yp:commPageSize>
	            </div>
           	</c:if>
        </form>
		<!--start 商品管理table-->
		<div class="order-management">
			<table width="100%" id="order-tab">
				<thead class="tab-control">
                    <tr>
                        <th width="12%">品牌</th>
                        <th width="20%">商品名称</th>
                        <th width="8%">商品编码</th>
                        <th width="8%">图片</th>
                        <th width="10%">商品状态</th>
                        <th width="8%">审核状态</th>
                        <th width="8%">提报人</th>
                        <th width="12%">提报时间</th>
                        <th width="12%">操作</th>
                    </tr>
                </thead>
				<tbody>
				<tr class="list-tr">
					<td colspan="10" class="td-nobor">
						<table class="tab-control">
							<tr class="tr-height" productId="100">
								<td class="num-icon" width="12%"><input id="sellType_100" type="hidden" value="1">
									<i></i><label><a>手机</a></label>
								</td>
								<td width="20%">手机2</td>
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
									<p>
										<p><a class="c-blue" href="${_ctxPath }/admin/product/buySchedule-queryProductDetail.htm?product.productId=${product.productId}" target="_blank">查看</a></p>
										<a class="c-blue view" href="javascript:;">查看</a>
									</p>
									<p>
										<%--<p><a class="c-blue" href="${_ctxPath }/admin/product/buySchedule-reviewScheduleProduct.htm?product.productId=${product.productId}&mark=2" target="_blank">审核</a></p>--%>
										<a class="c-blue review" href="javascript:;">审核</a>
									</p>
									<p><a class="c-blue sampleConfirm" href="javascript:;">样品确认</a></p>
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
					<c:if test="${fn:length(productPage.result)>0 }">
							<c:forEach items="${productPage.result}"  var="product" varStatus="status">
								<tr class="list-tr">
									<td colspan="10" class="td-nobor">
										<table class="tab-control">
											<tr class="tr-height" productId="${product.productId }">
												<td class="num-icon" width="12%"><input id="sellType_${product.productId }" type="hidden" value="${product.sellType }">
													<i></i><label><a>${product.brand.name }</a></label>
												</td>
												<td width="20%">${product.aliasName}</td>
												<td width="8%">${product.productId }</td>
												<td width="8%">
													<c:choose>
														<c:when test="${product.coverPicture == null || product.coverPicture == ''}">
															<c:choose>
																<c:when test="${product.imageUrls == null}">
															-
																</c:when>
																<c:otherwise>
																	<img src="<yp:thumbImage originalPath='${fn:substring( product.imageUrls ,0,fn:indexOf(product.imageUrls, ","))}' imageType='t84'></yp:thumbImage>" />
																</c:otherwise>
															</c:choose>			
														</c:when>
														<c:otherwise>
															<img src="<yp:thumbImage originalPath='${product.coverPicture}' imageType='t84'></yp:thumbImage>" />
														</c:otherwise>
													</c:choose>
													
													
												</td>
												<td width="10%">
													<spring:message code="product.status.${product.sellStatus}"/>
												</td>
												<td width="8%">
													<c:if test="${product.status != STATUS_DRAFT }">
					                    				<spring:message code="product.check.${product.status}"/>
					                    			</c:if>
												</td>
												<td width="8%">
													${product.applicantName}
												</td>
												<td width="12%">
													<fmt:formatDate value='${product.applicationTime}' pattern='yyyy-MM-dd HH:mm' /></td>
												<td width="12%">
													<p>
														<!-- 分期送商品 alter by 徐国飞 start  -->
				                        				 <c:choose>
				                         						<c:when test="${product.sellType eq SELLTYPE_US }">
								                         				<aut:authorize url="/admin/product/buySchedule-queryProductDetail">
								                         					<p><a class="c-blue" href="${_ctxPath }/admin/product/buySchedule-queryProductDetail.htm?product.productId=${product.productId}" target="_blank">查看</a></p>
								                         				</aut:authorize>
				                         						</c:when>
				                         						<c:otherwise>
				                         								<aut:authorize url="/admin/product/product-view">
									                           				<a class="c-blue view" href="javascript:;">查看</a>
									                       		 		</aut:authorize>
				                         						</c:otherwise>
				                         				  </c:choose>
				                         				<!-- 分期送商品 alter by 徐国飞 end  -->
					                     				<!--<aut:authorize url="/admin/product/product-view">
					                           				<a class="c-blue view" href="javascript:;">查看</a>
					                       		 		</aut:authorize> -->
				                        			</p>
				                       				 <c:if test="${product.status == CHECK_PEND}">
				                           				<p>
				                           					<!-- 分期送商品 alter by 徐国飞 start  -->
				                           					<c:choose>
				                         						<c:when test="${product.sellType eq SELLTYPE_US }">
				                         							<aut:authorize url="/admin/product/buySchedule-reviewScheduleProduct">
								                         					<p><a class="c-blue" href="${_ctxPath }/admin/product/buySchedule-reviewScheduleProduct.htm?product.productId=${product.productId}&mark=2" target="_blank">审核</a></p>
								                         			</aut:authorize>
				                         						</c:when>
				                         						<c:otherwise>
				                         							<aut:authorize url="/admin/product/product-review">
							                           					<a class="c-blue review" href="javascript:;">审核</a>
							                        				</aut:authorize>
				                         						</c:otherwise>
				                         				    </c:choose>
				                           					<!-- 分期送商品 alter by 徐国飞 end  -->
					                       					<!--<aut:authorize url="/admin/product/product-review">
					                           					<a class="c-blue review" href="javascript:;">审核</a>
					                        				</aut:authorize>-->
				                           				</p>
				                        			</c:if>
				                        			<%----%>
			                         				<aut:authorize url="/seller/product/product-confirmSample"> 
			                         					<c:if test="${product.status == STATUS_WAITING_REVIEW}">
			                         						<p><a class="c-blue sampleConfirm" href="javascript:;">样品确认</a></p>
			                         						<p><a class="c-blue sampleRefused" href="javascript:;">样品拒绝</a></p>
			                         					</c:if>
			                         					<%----%>
			                         				</aut:authorize>
			                         				<%----%>
			                         				<%-- <aut:authorize url="/seller/product/product-makingSample"> --%>
			                         					<c:if test="${product.status == STATUS_WAINTING_MAKING}">
			                         						<p><a class="c-blue inService" href="javascript:;">制作确认</a></p>
			                         					</c:if>		
			                         					<%--	 --%>                        				
			                         				<%-- </aut:authorize> --%>
			                         				<aut:authorize url="/admin/product/product-edit4zhizuo">
			                         					<c:if test="${(product.status == STATUS_IN_SERVICE || product.status == STATUS_PASS) && product.sellType != 4 && product.sellType != 5}">
			                         						<p><a class="c-blue edit" href="javascript:;">编辑</a></p>
			                         						<%--
			                         						<p><a class="c-blue edit_online" href="javascript:;">在线编辑</a></p>
			                         						 --%>
			                         					</c:if>
			                         				</aut:authorize>
			                         				<%----%>
			                         				<aut:authorize url="/seller/product/product-publish">
			                         					<c:if test="${product.status == STATUS_IN_SERVICE and product.coverPicture != ''}">
			                         						<p><a class="c-blue publish" href="javascript:;">发布</a></p> 
			                         					</c:if>
			                         					<%----%>
			                         				</aut:authorize>
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
							</c:forEach>
					</c:if>
					<c:if test="${fn:length(productPage.result)==0 }">
						<tr class="list-tr">
							<td colspan="7" class="td-nobor" align="center">
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
					<c:if test="${not empty productPage.result}">
						<yp:commPage page="${productPage}" beanName="productPage"></yp:commPage>
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
				var productId = $this.attr('productId');
//				alert(productId);
				if (!$(this).next(".show-tr")[0]) {
					if( isPost == false) return;
					isPost = false;
					$.ajax({
						type : 'POST',
						url : '${_ctxPath}/product/listProductSkuDetailOnline.do',
						data : {
							"product.productId" : productId,
							"product.sellType" : $("#sellType_"+productId).val(),
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