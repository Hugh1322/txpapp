<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="aut" uri="http://www.springsecurity.org/jsp" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@page import="com.ytoxl.module.yipin.base.dataobject.resultmap.ExpressMessage" %>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>订单管理-退货单管理</title>
		<link rel="stylesheet" type="text/css" href="${_jsPath }/new/css/base.css"/>
        <link rel="stylesheet" href="${_jsPath }/new/calendar/kalendae.css" type="text/css" charset="utf-8">
        <script type="text/javascript" src="${_jsPath }/new/js/jquery-1.11.0.min.js"></script>
		<script src="${_jsPath }/new/calendar/kalendae.standalone.js" type="text/javascript" charset="utf-8"></script>
        <script type="text/javascript" src="${_jsPath }/new/js/manage_basefun.js"></script>
        <script src="${_jsPath}/plugin/select/linkage_sel.js?v=${_resVerion}"></script>
	</head>
	<body>
		<jsp:include page="../include/headerNew.jsp" flush="true" />
			<!--main start-->
			<div class="main">
				<!--面包屑-->
				<div class="crumb">
					<button class="fr export" id="export"><i></i>导出</button>
					<p>
						<a href="" class="home"><i></i></a>
						<span class="sep"></span>
						<a href="">订单管理</a>
					 	<span class="sep"></span>
					           退货单管理
					</p>
				</div>
				
				<!--查询条件-->
				<form class="m-mt10p m-clear" action="${_ctxPath}/admin/order/orderMgr-searchRefundGood.htm" method="get" id="subform">
				<div class="query">
					
					<div class="line">
						<div class="col">
							<span class="sp">订单号：</span><input type="text" name="resultPage.params.orderNo" id="" value="${resultPage.params.orderNo}" class="inputText"/>
						</div>
						<div class="col">
							<span class="sp">退货单号：</span><input type="text" name="resultPage.params.orderRefundNo" id="" value="${resultPage.params.orderRefundNo}" class="inputText"/>
						</div>
						<div class="col">
							<span class="sp">联系人：</span><input type="text" name="resultPage.params.customerName" id="" value="${resultPage.params.customerName}" class="inputText"/>
						</div>
						<div class="col">
							<span class="sp">联系方式：</span><input type="text" name="resultPage.params.mobile" id="" value="${resultPage.params.mobile}" class="inputText"/>
						</div>
					</div>
					<div class="line">
						<div class="col">
							<span class="sp">审核时间：</span><input type="text" name="resultPage.params.adminCheckTime" id="" value="${resultPage.params.adminCheckTime}" class="inputText bgcf9f auto-kal"/>
						</div>
						<div class="col">
							<span class="sp">退货单状态：</span>
							<div class="fl module_Select">
                                <select class="trueMenu" name="resultPage.params.status">
                                  <c:forEach items="${refundStatusList}" var="refundStatus">
                                      <c:choose>
                                             <c:when test="${refundStatus==resultPage.params.status}">
                                                 <option value="${refundStatus}" selected="selected"><spring:message code="order.refund.status.${refundStatus}" /></option>
                                             </c:when>
                                             <c:otherwise>
                                                 <option value="${refundStatus}"><spring:message code="order.refund.status.${refundStatus}" /></option>
                                             </c:otherwise>
                                      </c:choose>
                                  </c:forEach>
                                </select>
                                <div class="newSelectCer"></div>
                            </div>
						</div>
						<div class="col">
							<span class="sp">商品SKU：</span><input type="text" name="resultPage.params.productSkuId" id="" value="${resultPage.params.productSkuId}" class="inputText bgcf9f"/>
						</div>
						<div class="col">
							<span class="sp">退货原因：</span>
							<div class="fl module_Select">
                                  <select name="resultPage.params.refundReasonType" class="trueMenu">
                                        <option <c:if test="${resultPage.params.refundReasonType==null || resultPage.params.refundReasonType==''}">selected="selected"</c:if> value="">全部</option>
		                                <c:forEach items="${refundReasonTypeList}" var="refundType">
		                                     <c:if test="${resultPage.params.refundReasonType==refundType}">
		                                          <option selected="selected" value="${refundType}">${refundType}</option>
		                                     </c:if>
		                                     <c:if test="${resultPage.params.refundReasonType!=refundType}">
		                                          <option value="${refundType}">${refundType}</option>
		                                     </c:if>
		                                </c:forEach>
                                  </select>
                                  <div class="newSelectCer"></div>
                             </div>   
						</div>
					</div>
					<div class="line">
						<div class="col">
							<span class="sp">申请时间：</span><input type="text" name="resultPage.params.createTime" id="" value="${resultPage.params.createTime}" class="inputText bgcf9f auto-kal"/>
						</div>
					</div>
					<div class="btns">
						<input id="searchBtn" class="maageBtn_1" type="button" value="查询" />
						<input type="hidden" name="resultPage.params.adminFlag" value="true" />
					    <input type="hidden" name="resultPage.currentPage" value="0" />
					</div>
				</div>
				</form>
				
				<!--查询结果-表格-->
				<div class="tableData">
					<div class="tableTitle">
						<!-- <a href="" class="aBtn">批量确认</a>
						<a href="javascript:void(0);" class="addNew">+ 新建退货单</a> -->
					</div>
					<div class="table">
						<table border="1px" bordercolor="#cfd7dd" cellspacing="0px">
							<tr>
								<th><!-- <input type="checkbox" name="" id="" value="" class="inputCheck"/> -->退货单</th>
								<th>订单号</th>
								<th>商品SKU</th>
								<th>商品名称</th>
								<th>退货数量</th>
								<th>申请时间</th>
								<th>退货原因</th>
								<th>退货单状态 </th>
								<th>操作</th>
							</tr>
							<c:forEach items="${resultPage.result}" var="orderRefund" varStatus="sta">
							    <tr <c:if test="${status.count%2 eq 0}">class="even"</c:if>>
							        <td class="c-258">
							        <a href="javascript:void(0);" onclick="showRefund('${orderRefund.orderRefundNo}','${orderRefund.orderId}');">${orderRefund.orderRefundNo}</a></td>
							        <td><a href="${_ctxPath}/admin/order/orderMgr-getOrderDetail.htm?orderHead.orderId=${orderRefund.orderId}">${orderRefund.orderHead.orderNo}</a></td>
							        <td>${orderRefund.orderItem.productSkuId}</td>
							        <td>${orderRefund.orderItem.productName}</td>
							        <td>${orderRefund.refundNum}</td>
							        <td><fmt:formatDate value='${orderRefund.createTime}' pattern='yyyy-MM-dd HH:mm:ss' /></td>
							        <td>${orderRefund.refundReasonType}</td>
							        <td><spring:message code="order.refund.status.${orderRefund.status}" /></td>
							        <td>
							        <c:if test="${isAdmin!=true}">
						                    <c:if test="${orderRefund.status==itemStatuses[1]}">
						                       <aut:authorize url="/order/order-passAudit">
							                        <a href="javascript:void(0);" id="passAudit2${orderRefund.orderRefundId}" onclick="passAudit2(${orderRefund.orderRefundId}, '${orderRefund.orderItem.orderItemId}');" >审核通过</a>
							                        <c:if test="${orderRefund.isCanReturnFreight}">
							                            &nbsp;<input id="checkboxReturnFreight2_${orderRefund.orderRefundId}" type="checkbox" />退运费单
							                        </c:if>
											   </aut:authorize>
											   <aut:authorize url="/order/order-rejectAudit">
											         <a href="javascript:void(0);" class="rejectAudit2" data-orderRefundId="${orderRefund.orderRefundId}">审核不通过</a>
											   </aut:authorize>
											</c:if>
											<c:if test="${orderRefund.status==itemStatuses[3]}">
												<!-- <b>审核未通过</b><br/> -->
											</c:if>
											<c:if test="${orderRefund.status==itemStatuses[2]}">
												<!-- <b>待退货</b> -->
											</c:if>
									        <c:if test="${orderRefund.status==itemStatuses[4]}">
													<aut:authorize url="/admin/order/order-confirmBackProduct">
													    <a id="confirmBack2_${orderRefund.orderRefundId}" href="javascript:void(0);" onclick="confirmBack2('${orderRefund.orderRefundId}');">确认收货</a>
													</aut:authorize>
											</c:if>
									        <c:if test="${orderRefund.status==itemStatuses[5]}">
												<!-- <b>待退款</b> -->
											</c:if>
											<c:if test="${orderRefund.status==itemStatuses[6]}">
												<!-- <b>已完成</b> -->
											</c:if>
							        </c:if>
							        
							        </td>
							    </tr>
							</c:forEach>
						</table>
					</div>
				</div>
				
				<!--分页-->
				<div class="module_page" totNum="${resultPage.total}" >
					?&
					<c:forEach items="${resultPage.params}" var="map">
						resultPage.params.${map.key }=${map.value }&
					</c:forEach>
				</div>
				
			</div>
			<!--main end-->
			
			<!--##############################################弹出层  start####################################################-->
			<div id="popDiv" class="popupWrap" >
					<div class="shadeBg"></div>
					<!--新建售后退货单-->
					<div id="returnGoods" class="popup saleAfter">
						
					</div>
			</div>
			<!--####################################################弹出层  end#################################################-->
			
    </body>
<script type="text/javascript">
$(function(){
		// 绑定退货单导出按钮单击事件
		$('#export').bind('click', function() {
			if($.trim($('tbody').html())==''){
				return;
			}
			if($(".beginTime").val() && $(".endTime").val()){
				if(compareDate($(".beginTime").val(),$(".endTime").val())){
					showMsgDialog("开始时间不能大于结束时间！");
					return;
				}
			}
	
			$('#subform').attr("action","${_ctxPath}/admin/order/orderMgr-exportRefundGoods.htm");
			$('#subform').submit();
			$('#subform').attr("action","${_ctxPath}/admin/order/orderMgr-goRefundGood.htm");
		});
	
		$("#searchBtn").bind("click", function() {
			$("#subform").submit();
		});	
		
		/*计算高度*/
		var wH = $(window).height();
		$(".popup").css("height",(wH-100)+'px');
		$(".popup").css("margin-top",(-(wH-100)/2)+'px');
		
		$(window).resize(function (){
			var wH = $(window).height();
			$(".popup").css("height",(wH-100)+'px');
			$(".popup").css("margin-top",(-(wH-100)/2)+'px');
		})
		
		//商家审核不通过
		$(".rejectAudit2").bind("click", function() {
			var _this = $(this);
			var orderRefundId = _this.attr("data-orderRefundId");
			var dialogHtmlContent = '请输入审核不通过的原因：<p>'
				+'<textarea id="rejectCAR" rows="3" cols="30"}/>'
				+'</p><label style="color:red;" id="rejectCARL"/>';
			$.dialog({
				title: "提示",
				lock:true,
				content: dialogHtmlContent,
			    okValue: "确定",
			    ok: function(){
			    	var reason = $("#rejectCAR").val();
					if(!reason){
						$("#rejectCARL").html("请填写未通过原因");
						return false;
					}
					//审核原因不能超过50个字符(包含汉字)
					var ascRegexp = "/[^/x00-/xFF]/g";
					var reasonLen=reason.replace(ascRegexp, '..').length;
					if(reasonLen>50){
						$("#rejectCARL").html("审核原因不能超过50个字符(包含汉字)");
						return false;
					}
					//调用后台方法
					$.ajax({
						type:'post',
						data:{'orderRefund.orderRefundId':orderRefundId,'orderRefund.reviewDescribe':reason},
						url:'${_ctxPath}/admin/order/order-rejectAudit.htm',
						success:function(data){
							/* $("#rejectAudit"+id).parent().siblings().remove();
							$("#rejectAudit"+id).parent().parent().append("<b>审核未通过</b><br/><b>审核描述:</b>"+reason);
							$("#rejectAudit"+id).parent().remove();
							$("#cancelStatusL"+id).html("审核未通过"); */
							alert("审核未通过成功");
							window.location.reload();
						},
						error:function(data){
							alert("error:"+data);
						},
						oncomplete:function(data){
							alert("complement:"+data);
						}
					});
			    },
			    cancelValue:"取消",
			    cancel: function(){
			    }
			});
		});
});

//*******************查询或添加退货信息*****************
function showRefund(refundNo,orderId)
{
	//initTable();
	//定义商品列表
	$.ajax({
		url:_ctxPath + "/admin/order/orderMgr-showRefundGood.htm",
		type:"POST",
		data:{'orderRefund.orderRefundNo':refundNo,'orderHead.orderId':orderId},
		async: false,
		success:function(data){
			/* $("#returnGoods").html(data).ready(function (){
				var obj = $("#returnGoods");
				createModule(obj);
			}); */
			if(refundNo.length>0){
				$.dialog({
					lock:true,
					title:false,
					content: data
				});
			}
			$(".d-dialog").ready(function(){
				createModule($(".d-dialog"));
			})
		},
		error:function(data){
			alert("退货页面加载出错，请联系一城一品客服");
		}
	});
	/* $("#popDiv").show();
	$("#returnGoods").show(); */
}

//不知道方法
function onChangeOfCheckboxIncludeFreight(orderItemId) {
		/* var returnFreight = $("#checkboxReturnFreight_" + orderItemId).is(':checked');
		var result = null;
		if (returnFreight == true) {
			result = $("#refundMoney_" + orderItemId).attr("refundMoneyIncludeTotalPostage");
		} else {
			result = $("#refundMoney_" + orderItemId).attr("refundMoneyExcludeTotalPostage");
		}
		$("#refundMoney_" + orderItemId)[0].innerHTML = result; */
}

//退货 - 审核通过
function passAudit2(id, orderItemId){
	$.dialog({
		title: "提示",
		lock:true,
		content: "确定退货审核通过吗？",
	    okValue: "确定",
	    ok: function(){
	    	$.ajax({
	    		type:'post',
	    		data:{'orderRefund.orderRefundId':id, 'orderRefund.returnFreight': ($("#checkboxReturnFreight2_" + id).is(':checked') ? 1 : 0)},
	    		url:'${_ctxPath}/admin/order/order-passAudit.htm',
	    		success:function(data){
	    			/* //success 改变按钮 变成  同意退款 并添加注释  同时移除  审核通过  和  审核不通过
	    			$id = $("#passAudit"+id);
	    			$id.parent().siblings().remove();
	    			$id.parent().parent().append('<p>待发货<p>');
	    			$id.parent().remove();
	    			$id = $("#rejectAuditReasonP"+id);
	    			$id.parent().siblings().remove();
	    			$id.parent().remove(); */
	    			alert("审核通过操作成功");
	    			window.location.reload();
	    		},
	    		error:function(data){
	    			if(undefined != data.info){
	    				alert(data.info);
	    			}
	    		}
	    	});
	    },
	    cancelValue:"取消",
	    cancel: function(){
	    	
	    }
	});
	
}
//同意退款
/* function confirmPayment(orderRefundPaymentId,orderRefundId,payType,payId){
	$.ajax({
		type:'post',
		data:{
			'orderRefundPayment.orderRefundPaymentId':orderRefundPaymentId,
			'orderRefundPayment.ordeRrefundId':orderRefundId
		},
		url:'${_ctxPath}/admin/order/order-confirmPayment.htm',
		success:function(data){
			if(data.code=='true'){
				$id = $("#confirmPayment"+orderRefundPaymentId);
				var $a = $id.closest(".show-tr").prev("tr").find(".c-blue");
				$id.parent().append("已完成");
				$id.remove();
				//移除"退款"操作
				if($(".confirmPayment").length == 0){
					$a.remove();	
				}
				
				$id = $("#refundStatusL"+orderRefundId);
				$id.html("已完成");
			}else{
				if(undefined != data.info){
					alert(data.info);
				}
			}
		},
		error:function(data){
		},
		oncomplete:function(data){
		}
	});
} */

/**确认退货*/
function confirmBack2(orderRefundId)
{
	$.dialog({
		title: "提示",
		lock:true,
		content: "确定已退货吗？",
	    okValue: "确定",
	    ok: function(){
	    	$.ajax({
	    		type : 'POST',
	    		url : '${_ctxPath}/admin/order/order-confirmBackProduct.htm',
	    		data : {
	    			'orderRefundId': orderRefundId
	    		},
	    		success : function(data) {
	    			if(data.code=='true'){
	    				alert("退货操作已成功");
		    			window.location.reload();
	    			}else{
	    				alert(data.info);
	    			}
	    		},
	    		error:function(data){
	    			if(undefined != data.info){
	    				alert(data.info);
	    			}
	    			//后台出错时，恢复按钮事件
	    		}
	    	});
	    },
	    cancelValue:"取消",
	    cancel: function(){
	    	
	    }
	});
}


</script>
</html>
