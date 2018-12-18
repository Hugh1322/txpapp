<!DOCTYPE html>
<%@page language="java" contentType="text/html; charset=UTF-8" import="com.txp.app.contants.Product" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>
<%@page import="com.txp.app.contants.Product" %>
<%@page import="com.txp.app.contants.Prop" %>
<%@page import="com.txp.app.contants.ProductChannel" %>
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
	if(<%=ProductChannel.TASTEOFHOMETOWN %>=='${currentChannelId}'&&'${productPage.params.province}'!=''&&'${productPage.params.province}'!=null&&'${productPage.params.province}'!=-1){
			$('#province').fillselect(_ctxPath +'/admin/product/product-getPropInfoMsgCity.htm', {
				'dataMap': {'value': 'propId', 'text': 'name'}, 
				'preValue': -1,
		        'preText': '选择省份',
		        'params': {'selectKey': ""},
		        'after': function() {
		        		var _selectedOption = $(this).find("option:selected");
		        		var productNum = '${fn:length(productPage.result)}';
		        		_selectedOption.text(_selectedOption.text()+"("+productNum+")");
			     },
		        'defaultValue': '${productPage.params.province}' || -1
			});
	}else{
		$('#province').fillselect(_ctxPath +'/admin/product/product-getPropInfoMsgCity.htm', {
			'dataMap': {'value': 'propId', 'text': 'name'}, 
	        'preValue': -1,
	        'preText': '选择省份',
	        'params': {'selectKey': ""},
	        'defaultValue': '${productPage.params.province}' || -1
		});
	}
	
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
			if(<%=ProductChannel.TASTEOFHOMETOWN %>=='${currentChannelId}'){
				//家乡频道产品必须选择省份
				if($("#province").val()=="-1"){
					$.dialog({
						"title": false,
				        "lock":true,
				        "okValue":"确定",
				        "content":"<font color='red'>请选择省份！</font>",
				        "time" : 2000
				    });	
					return;
				}
			}
			var keywords = $(".J-keywords").val();
			if(keywords == $(".J-keywords").attr("data-default")){
				$(".J-keywords").val("");
			}
			var url= _ctxPath + '/admin/online_product/productMgr-newRecommendProducts.htm';
			if(<%=ProductChannel.TASTEOFHOMETOWN %>=='${currentChannelId}'){
				url= _ctxPath + '/admin/online_product/productMgr-tasteOfHometownProducts.htm';
			}else if(<%=ProductChannel.HISTORYHOT %>=='${currentChannelId}'){
				url= _ctxPath + '/admin/online_product/productMgr-historyHotProducts.htm';
			}
			$("#subFrm").attr("action",url);
			$("#subFrm").submit();
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
        <form id="subFrm" class="sub-form m-clear m-mt10p" action="" method="post">
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
		        	<input type="button" class="m-btn m-btn-search" value="删除" id="deleteInChannel"/>
		        	<input type="button" class="m-btn m-btn-search" value="发布频道商品" id="releaseProductSort"/>
				</div>
			
			
            </aut:authorize>
            
           	<c:if test="${not empty productPage.result}">
	            <div class="m-fr curr-num" style="margin-top:10px;">
<!-- 	              <label >当前显示：</label> -->
<%-- 	              <yp:commPageSize page="${productPage}" beanName="productPage"></yp:commPageSize> --%>
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
                        <th>点击数</th>
                        <th>点赞数量</th>
                        <th>评价数量</th>
                        <th>历史销量</th>
                        <th>标签图片</th>
                        <th>排序</th>
                        <th>上架时间</th>		
                        <th>操作</th>
                    </tr>
                </thead>
				<tbody>
					<c:if test="${fn:length(productPage.result)>0 }">
							<form id="channelProductFrm" action="${_ctxPath}/admin/online_product/productMgr-deleteInChannel.htm" method="post">
								<input id="currentChannelId" type="hidden" name="currentChannelId" value="${currentChannelId }" />
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
					                    			${status.count }
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
				                         								<aut:authorize url="/admin/online_product/productMgr-setTop">
								                         					<p><a class="c-blue setTop" data-productId="${product.productId }" data-channelIdStr="${product.channelIdStr }" href="javascript:;">置顶</a></p>
							                         					</aut:authorize>
				                         								<aut:authorize url="/admin/online_product/productMgr-updateSortNum">
								                         					<p><a class="c-blue setUp" data-productId="${product.productId }" data-channelIdStr="${product.channelIdStr }" href="javascript:;">向上</a></p>
							                         					</aut:authorize>
				                         								<aut:authorize url="/admin/online_product/productMgr-updateSortNum">
									                           				<p><a class="c-blue setDown" data-productId="${product.productId }" data-channelIdStr="${product.channelIdStr }" href="javascript:;">向下</a></p>
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
		<!-- 
		<div class="table-bm-wrap cf">
			<div class="fn-right">
				<div class="pagination pagination-right">
					<c:if test="${not empty productPage.result}">
						<yp:commPage page="${productPage}" beanName="productPage"></yp:commPage>
					</c:if>
				</div>
			</div>
		</div>
		 -->
	</div>
	<jsp:include page="/WEB-INF/views/include/foot.jsp"></jsp:include>
	
</body>
<script type="text/javascript">
	//防止在一次请求 多次点击
	var isPost = true;
	var msg = $("#msg").val();
	var _frontPath;
	
	if(msg!=null && msg !=""){
		$.dialog({
	        title: false,
	        content:"<font color='red'>"+msg+"</font>",
	        time : 8000
	    });	
	}
	
	$(document).ready(function() {
		/* editCtxPath();
		//修正path路径
		function editCtxPath(){
			var nowUrl = "http://" + window.location.host + "";
			if(_ctxPath == "/manage"){
				var type = nowUrl.split("yichengpin")[1];
				if(type == undefined){
					_frontPath = "http://localhost:8080/front"//本机
				}else{
					_frontPath = nowUrl + "/";//生产或预生产
				}
			}else{
				var frontNum = _ctxPath.split("manage_")[1];
				_frontPath = nowUrl + "/front_" + frontNum//测试环境 
			}
		} */
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
		
		//设置置顶
		$(".setTop").on("click", function(e) {
			var _this=$(this);
			var channelId = _this.attr("data-channelIdStr");
			var productId = _this.attr("data-productId");
			if(isPost){
				isPost = false;
				$.ajax({
					type:'POST',
					url: _ctxPath + '/admin/online_product/productMgr-setTop.htm',
					data: {"product.channelIdStr":channelId,"product.productId":productId},
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
			/**
			$.dialog({
					"title":false,
					"lock":true,
					"content":"<P class='dialogDiv'>确定将该商品置于当前频道最前？</p>",
					"okValue":"确定",
					"cancel": true,
			        "cancelValue": "取消",
					"ok":function(){
							if(isPost){
								isPost = false;
								$.ajax({
									type:'POST',
									url: _ctxPath + '/admin/online_product/productMgr-setTop.htm',
									data: {"product.channelIdStr":channelId,"product.productId":productId},
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
			*/
		})
		  
		//设置排序上移
		$(".setUp").on("click", function(e) {
			var _this=$(this);
			var channelId = _this.attr("data-channelIdStr");
			var productId = _this.attr("data-productId");
			updateSortNum("确定将该商品频道排序向前移动1位？","1",channelId,productId);
		})
		
		//设置排序下移
		$(".setDown").on("click", function(e) {
			var _this=$(this);
			var channelId = _this.attr("data-channelIdStr");
			var productId = _this.attr("data-productId");
			updateSortNum("确定将该商品频道排序向后移动1位？","-1",channelId,productId);
		})
		
		
		//标签上传
		$("#deleteInChannel").on("click", function(e) {
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
			
			$.dialog({
					"title":false,
					"lock":true,
					"content":"<P class='dialogDiv'>确定从当前频道删除选中的商品？</p>",
					"okValue":"确定",
					"cancel": true,
			        "cancelValue": "取消",
					"ok":function(){
							if(isPost){
								isPost = false;
								$.ajax({
									type:'POST',
									url: _ctxPath + '/admin/online_product/productMgr-deleteInChannel.htm',
									data: $("#channelProductFrm").serialize(),
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
		
		//发布频道商品信息--更新redis缓存
		$("#releaseProductSort").on("click", function(e) {
			$.dialog({
				"title":false,
				"lock":true,
				"content":"<P class='dialogDiv'>确定发布新的频道商品信息吗？</p>",
				"okValue":"确定",
				"cancel": true,
		        "cancelValue": "取消",
				"ok":function(){
					if(isPost){
						isPost = false;
						$.ajax({
							type:'POST',
							url: _ctxPath + '/admin/online_product/productMgr-updateChannelProductCache.htm',
							data:{"currentChannelId":'${currentChannelId}'},
							success:function(msg){
								if(msg.code="true"){
									popupDialog(msg.info);
									isPost = true;
									//
									indexStaticPublish(${currentChannelId});
								}else if(msg.code="false"){
									popupDialog(msg.info);
									isPost = true;
								}
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
		
		//拼接请求代码
		function getIDStr(arr){
			var backStr = "";
			var leg = arr.length;
			for(var n=0;n<leg;n++){	
				var id = arr[n];
				if(id != undefined){
					if(n<(leg-1)){
						backStr = backStr + id + "_";
					}else{
						backStr = backStr + id;	
					}		
				}
			}
			return backStr;
		}
		
		//根据ID数组，批量获取数据
		function getPrdInfo(channelID,str,num,totalRow,totalPage){
			var url =  _ctxPath + "/admin/online_product/productMgr-findProductById.htm";
			if(str !== undefined){
				$.ajax({
					type : "get",
					async:false,
					url: url,
					data : {
						"channel" : channelID,
						"productIds" : str,
						"productSize" : num,
						"totalPage":totalPage,
						"totalRow":totalRow,
					},
					success : function(data){
					},
					error:function(XMLHttpRequest, textStatus, errorThrown){
					}
				});	
			}
		}
		
		
		//后台发布频道时,调用前台方法生成静态html
		function indexStaticPublish(currentChannelId){
				var prdIdArr = new Array();  //产品ID序列
				var str;
				var nowPageNum = 1;  //当前页码
				var price = "";  //价格区间
				var areaID = "";   //区域代码
				var url = _ctxPath + "/admin/online_product/productMgr-findChannelProductsAjax.htm";
				$.ajax({
					type : "get",
					async:false,
					url : url,
					data : {
						"channel" : currentChannelId,
						"province" : areaID,
						"pagenum" : nowPageNum,
						"price" : price
					},
					dataType : "jsonp",
					jsonp: "callback",//服务端用于接收callback调用的function名的参数
					jsonpCallback:"success_jsonpCallback",//callback的function名称
					success : function(json){
						var totalRow = json.totalRow;
						var totalPage = json.totalPage;
						 var ifNull = json.proIds;
						if(ifNull != undefined){
							var leg = json.proIds.length;
							for(var i=0;i<leg;i++){
								prdIdArr.push(json.proIds[i]);
							}
						} 
						//获取商品IdList里面的商品的详情
						getPrdInfo(currentChannelId,getIDStr(prdIdArr),prdIdArr.length,totalRow,totalPage);
					},
					error:function(XMLHttpRequest, textStatus, errorThrown){
						//alert(XMLHttpRequest.status);
					}
				});
			}
			
		
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
	});
	
	function updateSortNum(info,flag,channelId,productId){
		 if(isPost){
			isPost = false;
			$.ajax({
				type:'POST',
				url: _ctxPath + '/admin/online_product/productMgr-updateSortNum.htm',
				data: {"product.channelIdStr":channelId,"product.productId":productId,"flag":flag},
				success:function(msg){
					if(msg.code == "true"){
						$("#search").click();
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
		/**
		$.dialog({
			"title":false,
			"lock":true,
			"content":"<P class='dialogDiv'>"+info+"</p>",
			"okValue":"确定",
			"cancel": true,
	        "cancelValue": "取消",
			"ok":function(){
				if(isPost){
					isPost = false;
					$.ajax({
						type:'POST',
						url: _ctxPath + '/admin/online_product/productMgr-updateSortNum.htm',
						data: {"product.channelIdStr":channelId,"product.productId":productId,"flag":flag},
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
		*/
	}
</script>
</html>