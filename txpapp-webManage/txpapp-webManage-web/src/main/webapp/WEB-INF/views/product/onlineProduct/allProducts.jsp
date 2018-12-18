<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8" import="com.txp.app.contants.Product" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>
<%@page import="com.txp.app.contants.Product" %>
<%@page import="com.txp.app.contants.Prop" %>
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
<script type="text/javascript" src="${_jsPath }/pages/jquery.select.js"></script>
<script type="text/javascript">

$(function(){
	var firstKind = <%=Prop.CODE_FIRST %>;
	var place = <%=Prop.CODE_PLACE %>;
	var code_product = <%=Prop.CODE_PRODUCT %>
	//初始化省份下拉框
	$('#province').fillselect(_ctxPath +'/admin/product/product-getPropInfoMsgCity.htm', {
			'dataMap': {'value': 'propId', 'text': 'name'}, 
	        'preValue': -1,
	        'preText': '选择省份',
	        'params': {'selectKey': ""},
	        'defaultValue': '${productPage.params.province}' || -1
	});
	//alert('${productPage.params.firstcatalog}');
	//alert('${productPage.params.big}');
	//alert('${productPage.params.small}');
	//回显/加载类目
	$('#firstcatalog').fillselect(_ctxPath +'/admin/product/product-getPropInfoMsg.htm', {
		'dataMap': {'value': 'propId', 'text': 'name'}, 
        'preValue': -1,
        'preText': '选择类目',
        'params': {'selectKey': firstKind},
        'defaultValue': '${productPage.params.firstcatalog}' || -1
    });
	//回显/加载
	$('#firstcatalog').chainselect('#bigcatalog', _ctxPath + '/admin/product/product-getPropInfoMsg.htm', {
        'dataMap': {'value': 'propId', 'text': 'name'}, 
        'preValue': -1,
        'preText': '选择大分类',
        'defaultValue': '${productPage.params.big}' || -1
    });
	//初始化一级类目
	$('#bigcatalog').fillselect(_ctxPath +'/admin/product/product-getPropInfoMsg.htm', {
		'dataMap': {'value': 'propId', 'text': 'name'}, 
        'preValue': -1,
        'preText': '选择大分类',
        'params': {'selectKey': '${productPage.params.firstcatalog}'},
        'defaultValue': '${productPage.params.big}' || -1
    });
	//初始化二级类目
	$('#bigcatalog').chainselect('#smallcatalog', _ctxPath +'/admin/product/product-getPropInfoMsg.htm', {
        'dataMap': {'value': 'propId', 'text': 'name'}, 
        'preValue': -1,
        'preText': '选择小分类',
        'defaultValue': '${productPage.params.small}' || -1
    });
	
	
	// 查询按钮绑定事件
	$("#search").on("click",function(){
			var keywords = $(".J-keywords").val();
			if(keywords == $(".J-keywords").attr("data-default")){
				$(".J-keywords").val("");
			}
			var url= _ctxPath + '/admin/online_product/productMgr-allProducts.htm';
			$("sub-form").attr("action",url);
			$(".sub-form").submit();
		});
	//查看
	$(".view").click(function(){
		var productId = $(this).closest("tr").attr("productId");
		window.location.href = _ctxPath +"/admin/product/product-view.htm?product.productId="+productId+"&mark=1";
	});
	
	//编辑
	$(".edit").click(function(){
		var productId = $(this).closest("tr").attr("productId");
		window.location.href = _ctxPath + "/admin/online_product/productMgr-editOnlineProduct.htm?product.productId="+productId;
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
	<jsp:include page="../../include/header.jsp" flush="true" />
	<div class="body m-w980p">
	 <!--start form-->
        <form id="subFrm" class="sub-form m-clear m-mt10p" action="${_ctxPath}/admin/online_product/productMgr-allProducts.htm" method="post">
        <input type="hidden" value="${msgInfo}" id = "msg"/>
    		<aut:authorize url="/admin/online_product/productMgr-allProducts">
    			<div class="m-search" style="margin-top: 10px;">
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
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <input  type="text" data-default="输入品牌名称，商品名称，商户名称" name="productPage.params.name" value="${productPage.params.name }" class="J-keywords txt-input input-marks" />
                	
               	</div>
               	<div class="m-search" style="margin-top: 10px;">
	               	商品类目：
	               	<select name="productPage.params.firstcatalog" class="m-sel" id="firstcatalog">
	                </select>
	                <select name="productPage.params.big" class="m-sel" id="bigcatalog">
	                </select>
	                <select name="productPage.params.small" class="m-sel" id="smallcatalog">
	                </select>
	                 
	                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                 </div>
				<div class="m-search" style="margin-top: 10px;">
					省份：
					<select name="productPage.params.province" class="m-sel" id="province">
						
					</select>
	                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		        	<input type="button" class="m-btn m-btn-search" value="查 询" id="search"/>
		        	<input type="button" class="m-btn m-btn-search" value="标签上传" id="setProductsLabel"/>
		        	<input type="button" class="m-btn m-btn-search" value="发布频道商品" id="releaseProductSort"/>
		        	<!-- 排序 -->
		        	<input type="hidden" id="input_sortHit" name="productPage.params.sortHit" value="${productPage.params.sortHit }" />
		        	<input type="hidden" id="input_sortPraiseClick" name="productPage.params.sortPraiseClick" value="${productPage.params.sortPraiseClick }" />
		        	<input type="hidden" id="input_sortComment" name="productPage.params.sortComment" value="${productPage.params.sortComment }" />
		        	<input type="hidden" id="input_sortSaleHistory" name="productPage.params.sortSaleHistory" value="${productPage.params.sortSaleHistory }" />
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
				<colgroup>
						<col width="2%"/>
						<col width="6%"/>
						<col width="10%"/>
						<col width="12%"/>
						<col width="8%"/>
						<col width="8%"/>
						<col width="5%" align="center"/>
						<col width="5%" align="center"/>
						<col width="5%" align="center"/>
						<col width="5%" align="center"/>
						<col width="8%" align="center"/>
						<col width="9%"/>
						<col width="9%"/>		
						<col/>
				</colgroup>
				<thead class="tab-control">
                    <tr>
                    	<th><input type="checkbox" class="selectAll" /></th>
                        <th>品牌</th>
                        <th>商品名称</th>
                        <th>商品显示名称</th>
                        <th>商家名称</th>
                        <th>图片</th>
                        <th data-sort-id="sortHit" data-sort="${productPage.params.sortHit }"  class="sortTh">点击数&nbsp;&nbsp;
                        	<span id="sortHit">
	                        	<c:choose>
	                        		<c:when test="${productPage.params.sortHit eq 'ASC' }">
	                        			△
	                        		</c:when>
	                        		<c:when test="${productPage.params.sortHit eq 'DESC' }">
	                        			▽
	                        		</c:when>
	                        		<c:otherwise>
	                        			△▽
	                        		</c:otherwise>
	                        	</c:choose>
                        	</span>
                        </th>
                        <th data-sort-id="sortPraiseClick" data-sort="${productPage.params.sortPraiseClick }" class="sortTh">点赞数量
                        	<span id="sortPraiseClick">
	                        	<c:choose>
	                        		<c:when test="${productPage.params.sortPraiseClick eq 'ASC' }">
	                        			△
	                        		</c:when>
	                        		<c:when test="${productPage.params.sortPraiseClick eq 'DESC' }">
	                        			▽
	                        		</c:when>
	                        		<c:otherwise>
	                        			△▽
	                        		</c:otherwise>
	                        	</c:choose>
	                        </span>
                        </th>
                        <th data-sort-id="sortComment"  data-sort="${productPage.params.sortComment }" class="sortTh">评价数量
                        	<span id="sortComment">
								<c:choose>
	                        		<c:when test="${productPage.params.sortComment eq 'ASC' }">
	                        			△
	                        		</c:when>
	                        		<c:when test="${productPage.params.sortComment eq 'DESC' }">
	                        			▽
	                        		</c:when>
	                        		<c:otherwise>
	                        			△▽
	                        		</c:otherwise>
	                        	</c:choose>
	                        </span>
						</th>
                        <th  data-sort-id="sortSaleHistory"  data-sort="${productPage.params.sortSaleHistory }"  class="sortTh">历史销量
                        	<span id="sortSaleHistory">
	                        	<c:choose>
	                        		<c:when test="${productPage.params.sortSaleHistory eq 'ASC' }">
	                        			△
	                        		</c:when>
	                        		<c:when test="${productPage.params.sortSaleHistory eq 'DESC' }">
	                        			▽
	                        		</c:when>
	                        		<c:otherwise>
	                        			△▽
	                        		</c:otherwise>
	                        	</c:choose>
                        	</span>
                        </th>
                        <th>标签图片</th>
                        <th>商品所属频道</th>
                        <th>上架时间</th>		
                        <th>操作</th>
                    </tr>
                </thead>
				<tbody>
					<c:if test="${fn:length(productPage.result)>0 }">
							<form id="setProductsLabelFrm" action="${_ctxPath}/admin/online_product/productMgr-setProductsLabel.htm" method="post">
								<input id="selectLabelId" type="hidden" name="selectLabelId" value="" />
							<c:forEach items="${productPage.result}"  var="product" varStatus="status">
								<tr class="list-tr">
									<td colspan="14" class="td-nobor">
										<table class="tab-control">
											<colgroup>
													<col width="2%"/>
													<col width="6%"/>
							                        <col width="10%"/>
							                        <col width="12%"/>
							                        <col width="8%"/>
							                        <col width="8%"/>
							                        <col width="5%" align="center"/>
							                        <col width="5%" align="center"/>
							                        <col width="5%" align="center"/>
							                        <col width="5%" align="center"/>
							                        <col width="8%" align="center"/>
							                        <col width="9%"/>
							                        <col width="9%"/>		
							                        <col/>
											</colgroup>
											<tr class="tr-height" productId="${product.productId }">
												<td><input name="productIdAry" type="checkbox" data-labelid="${prodcut.productLabelId }" value="${product.productId }" class="checkbox" /></td>
												<td class="num-icon" ><input id="sellType_${product.productId }" type="hidden" value="${product.sellType }">
													<i></i><label><a>${product.brand.name }</a></label>
												</td>
												<td>${product.name}</td>
												<td>${product.aliasName}</td>
												<td>${product.sellerName }</td>
												<td>
													<c:choose>
														<c:when test="${product.coverPicture == null}">
															-													
														</c:when>
														<c:otherwise>
															<img src="<yp:thumbImage originalPath='${product.coverPicture}' imageType='t84'></yp:thumbImage>" />
														</c:otherwise>
													</c:choose>
												</td>
												<td>
													${product.hits }
												</td>
												<td>
													${product.productShowProp.praiseClickNum }
												</td>
												<td>
													${product.productShowProp.commentNum }
												</td>
												<td>
													${product.productShowProp.saleHistoryNum }
												</td>
												<td>
													<c:choose>
														<c:when test="${product.productShowProp.productLabel.labelImgUrl == null}">
															-													
														</c:when>
														<c:otherwise>
															<img src="<yp:thumbImage originalPath='${product.productShowProp.productLabel.labelImgUrl}' imageType='t84'></yp:thumbImage>" />
														</c:otherwise>
													</c:choose>
												</td>
												<td>
					                    			${product.channelNameStr }
												</td>
												<td>
													<fmt:formatDate value='${product.checkTime}' pattern='yyyy-MM-dd HH:mm' />
												</td>												
												<td>
													<p>
														<!-- 分期送商品 alter by 徐国飞 start  -->
				                        				 <c:choose>
				                         						<c:when test="${product.sellType eq SELLTYPE_US }">
								                         				<aut:authorize url="/admin/product/buySchedule-queryProductDetail">
								                         					<p><a class="c-blue" href="${_ctxPath }/admin/product/buySchedule-queryProductDetail.htm?product.productId=${product.productId}" target="_blank">查看</a></p>
								                         				</aut:authorize>
				                         						</c:when>
				                         						<c:otherwise>
				                         								<aut:authorize url="/admin/online_product/productMgr-setChannel">
								                         					<p><a class="c-blue setChannel" data-productId="${product.productId }" data-channelIdStr="${product.channelIdStr }" href="javascript:;">频道设置</a></p>
							                         					</aut:authorize>
				                         								<aut:authorize url="/admin/online_product/productMgr-editOnlineProduct">
								                         					<p><a class="c-blue edit" href="javascript:;">编辑</a></p>
							                         					</aut:authorize>
				                         								<aut:authorize url="/admin/online_product/productMgr-previewOnlineProduct">
									                           				<p><a class="c-blue" href="${_ctxPath }/admin/online_product/productMgr-previewOnlineProduct.htm?product.productId=${product.productId }" target="_blank">预览</a></p>
									                       		 		</aut:authorize>
									                       		 		
				                         						</c:otherwise>
				                         				  </c:choose>
				                        			</p>
												</td>						
											</tr>
										</table>
									</td>
								</tr>
							</c:forEach>
							</form>
					</c:if>
					<c:if test="${fn:length(productPage.result)==0 }">
						<tr class="list-tr">
							<td colspan="13" class="td-nobor" align="center">
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
	
	<!-- 频道数据隐藏div -->
	<div id="channelForm" style="display: none;">
		<c:forEach items="${channelList }" var="channel" >
			<br><input type="checkbox" class="channelIds" id="channel-id-${channel.id}" name="channelIds" value="${channel.id}" />${channel.channelName};
		</c:forEach>
	</div>
	
	<!-- 标签数据隐藏div -->
	<div id="labelForm" style="display: none;">
		<c:choose>
			<c:when test="${not empty productLabelList }">
				<c:forEach items="${productLabelList }" var="label" >
					<br>
					<input type="radio" class="labels" id="label-id-${label.id}" name="labels" value="${label.id}" />&nbsp;${label.labelName}&nbsp;
					<c:choose>
						<c:when test="${label.labelImgUrl == null}">
								-													
						</c:when>
						<c:otherwise>
								<img src="<yp:thumbImage originalPath='${label.labelImgUrl}' imageType='t84'></yp:thumbImage>" />
						</c:otherwise>
					</c:choose>
					
				</c:forEach>
			</c:when>
			<c:otherwise>
				请先添加<a href="${_ctxPath }/admin/productLabel/label-labelManageList.htm">商品标签！</a>
			</c:otherwise>
		</c:choose>
		
	</div>
</body>
<script type="text/javascript">
	//防止在一次请求 多次点击
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
		
		//全选
		$('.selectAll').live("click",function(){
			var _this = $(this);
			//先判断自己
			if(_this.is(":checked")){
				$('.selectAll').prop("checked",true);
				$('.checkbox').each(function(){
					var _childThis = $(this);
					_childThis.prop("checked",true);
				});
			}else{
				$('.selectAll').prop("checked",false);
				$('.checkbox:checked').each(function(){
					var _childThis = $(this);
					_childThis.prop("checked",false);
				});
			}
		});
		//单选促发全选的改变
		$('.checkbox').live('click',function(){
			var _this = $(this),
				sumLen = $('.checkbox').length,
				checkLen = $('.checkbox:checked').length;
			//_this.prop("checked",true);
			if(sumLen === checkLen){
				$('.selectAll').prop("checked",true);
			}else{
				$('.selectAll').prop("checked",false);
			}
		})
		
		//频道设置
		$(".setChannel").on("click", function(e) {
			var _this=$(this);
			var channelIdStr = _this.attr("data-channelIdStr");
			var productId = _this.attr("data-productId");
			var channelHtml = '<input type="hidden" name="product.productId" value='+productId+' />';
			//初始化未选中状态
			$('.channelIds').each(function(index,data){
				$(this).attr("checked",false);
			}) 
			//选中
			if($.trim(channelIdStr)!=""&&channelIdStr.length>0){
				var idAry = channelIdStr.split(",");
				for(var i=0;i<idAry.length;i++){
					$("#channel-id-"+idAry[i]).attr("checked",true);
				}
			}
			channelHtml+=$("#channelForm").html();
			$.dialog({
					"title":false,
					"lock":true,
					"content":"<P class='dialogDiv'><form id='setChannelForm' action='"+_ctxPath+"/admin/online_product/productMgr-setChannel.htm' method='post'>"+channelHtml+"</form></p>",
					"okValue":"确定",
					"cancel": true,
			        "cancelValue": "取消",
					"ok":function(){
							if(isPost){
								isPost = false;
								$.ajax({
									type:'POST',
									url: _ctxPath + '/admin/online_product/productMgr-setChannel.htm',
									data: $("#setChannelForm").serialize(),
									success:function(msg){
										if(msg.code == "true"){
											window.location.reload();
										}else if(msg.code == "false"){
											popupDialog(msg.info);
										}
										isPost = true;
									},
									error: function(xhr){
										popupDialog(xhr.responseText);
										isPost = true;
							        }
								});
							}
						}
					});
				$(".d-titleBar").remove();
			
		})
		  
		
		//标签上传
		$("#setProductsLabel").on("click", function(e) {
			//检查复选框是否选中商品
			var selectProFlag = false;
			$('.checkbox').each(function(){
				if($(this).attr("checked")=="checked"){
					selectProFlag = true;
				}
			});
			if(!selectProFlag){
				$.dialog({
					"title": false,
			        "lock":true,
			        "okValue":"确定",
			        "content":"<font color='red'>请选择商品！</font>",
			        "time" : 2000
			    });	
				return;
			}
			var _this=$(this);
			var channelHtml = '';
			//初始化未选中状态
			$("#selectLabelId").attr("value",'');
			$('.labels').each(function(index,data){
				$(this).attr("checked",false);
			}) 
			channelHtml+=$("#labelForm").html();
			$.dialog({
					"title":false,
					"lock":true,
					"content":"<P class='dialogDiv'>"+channelHtml+"</p>",
					"okValue":"确定",
					"cancel": true,
			        "cancelValue": "取消",
					"ok":function(){
							//判断是否选中
							var selectLabelId = $("input[name='labels']:checked").val();
							if(!selectLabelId){
								popupDialog('请选择标签！');
							}else{
								$("#selectLabelId").attr("value",selectLabelId);
								if(isPost){
									isPost = false;
									$.ajax({
										type:'POST',
										url: _ctxPath + '/admin/online_product/productMgr-setProductsLabel.htm',
										data: $("#setProductsLabelFrm").serialize(),
										success:function(msg){
											if(msg.code == "true"){
												window.location.reload();
											}else if(msg.code == "false"){
												popupDialog(msg.info);
											}
											isPost = true;
										},
										error: function(xhr){
											popupDialog(xhr.responseText);
											isPost = true;
								        }
									});
								}
							}
							
						}
					});
				$(".d-titleBar").remove();
			
		})
		
		//发布频道商品信息--更新redis缓存
		$("#releaseProductSort").on("click", function(e) {
			var channelHtml = '';
			//初始化未选中状态
			$('.channelIds').each(function(index,data){
				$(this).attr("checked",false);
			}) 
			channelHtml+=$("#channelForm").html();
			
			$.dialog({
				"title":false,
				"lock":true,
				"content":"<P class='dialogDiv'> <form id='releaseChannelForm' action='"+_ctxPath+"/admin/online_product/productMgr-updateChannelProductCache.htm' method='post'>"+channelHtml+"<br/><span style='color:red'>请选择需要发布的频道</span></form></p>",
				"okValue":"确定",
				"cancel": true,
		        "cancelValue": "取消",
				"ok":function(){
					if(isPost){
						isPost = false;
						$.ajax({
							type:'POST',
							url: _ctxPath + '/admin/online_product/productMgr-updateChannelProductCache.htm',
							data: $("#releaseChannelForm").serialize(),
							success:function(msg){
								popupDialog(msg.info);
								isPost = true;
							},
							error: function(xhr){
								popupDialog(xhr.responseText);
								isPost = true;
					        }
						});
					}
					}
			});
			$(".d-titleBar").remove();
		})
		
		// -- 列表行单击绑定时间 beginning
		$(".tr-height").on("click", function(e) {
			var $this = $(this),
				evt = $(e.target);
			if(!evt.is('a')){
				var productId = $this.attr('productId');
				if (!$(this).next(".show-tr")[0]) {
					if( isPost == false) return;
					isPost = false;
					$.ajax({
						type : 'POST',
						url : '${_ctxPath}/admin/online_product/productMgr-listProductSkuOnlineDetail.htm',
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
		
		//单击点击数,点赞数,历史销量,评价数排序
		
		$(".sortTh").on("click", function(e) {
			var $this = $(this);
			var sortBy = $this.attr("data-sort-id");
			var sort = $this.attr("data-sort");
			if(sort=="ASC"){
				//改为不排序
				$("#input_"+sortBy).attr("value","");
				$("#"+sortBy).text("△▽");
			}else if(sort=="DESC"){
				//改为升序
				$("#input_"+sortBy).attr("value","ASC");
				$("#"+sortBy).text("△");
			}else{
				//默认为降序排列
				$("#input_"+sortBy).attr("value","DESC");
				$("#"+sortBy).text("▽");
			}
			$("#search").click();
		});
	});
</script>
</html>