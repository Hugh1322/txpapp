<%@page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@taglib prefix="aut" uri="http://www.springsecurity.org/jsp" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@page import="com.ytoxl.module.yipin.base.dataobject.resultmap.ExpressMessage" %>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>

			<!--##############################################弹出层  start####################################################-->
				<!--新建售后退货单-->
					<div class="popTitle">
					    <c:if test="${orderRefund.customerName!=null}">
					                      售后退货单详情
					    </c:if>
					    <c:if test="${orderRefund.customerName==null}">
					                      新建售后退货单
					    </c:if>
					</div>
					<div class="popCon">
						<div class="popInfo">
							<ul>
								<li><span>订单号：</span>${orderHead.orderNo}</li>
								<li>
									<span class="fl">联系人：</span>
									<input <c:if test="${orderRefund.customerName != null}">disabled="disabled" </c:if> type="text" name="customerName_rg" id="customerName_rg" value="${orderRefund.customerName}" class="inputText"/>
								</li>
								<li><span>手机号码：</span><input <c:if test="${orderRefund.customerName != null}">disabled="disabled" </c:if> type="text" name="mobile_rg" id="mobile_rg" value="${orderRefund.mobile}" class="inputText"/></li>
								<c:if test="${orderRefundExpress!=null}">
								    <li><span>退货物流单号：</span>${orderRefundExpress.expressNo}</li>
								    <li><span>退货物流公司：</span>${orderRefundExpress.expressName}</li>
								</c:if>
								<c:if test="${orderRefund!=null && orderRefund.status!=null}">
								    <li>
										<span>审核状态：</span>
										<spring:message code="order.refund.status.${orderRefund.status}" />
									</li>
								</c:if>
							</ul>
						</div>
						<div class="popTable">
							<p>选择退货商品：</p>
							<table border="1px" cellspacing="0" bordercolor="#cfd7dd" width="100%" id="returnGoodsTable">
								<tr class="linerBg">
									<th>
									   <c:if test="${orderRefund.customerName==null}">
									       <input type="checkbox" value="checkB" name="selectAll_rg" id="selectAll_rg"  onclick="selectAllCheck('selectAll_rg','orderItemIdCheckbox_rg');" />
									   </c:if>
									商品SKU
									</th>
									<th>商品名称</th>
									<th>商品规格</th>
									<th>数量</th>
									<th class="txRight">优惠金额</th>
									<th class="txRight">折扣金额</th>
									<th class="txRight">支付金额</th>
								</tr>
								<c:forEach items="${orderItemList}" var="orderItem" varStatus="sta">
								      <tr>
											<td>
												<c:if test="${orderRefund.customerName==null}">
												    <input type="checkbox" name="orderItemIdCheckbox_rg" value="${orderItem.orderItemId}" />
												</c:if>
												${orderItem.productSkuId}
											</td>
											<td><c:if test="${orderItem.type==2}"><font color="red">[赠品]</font></c:if>${orderItem.productName}</td>
											<td>${orderItem.productProp}</td>
											<td>
											   <c:choose>
											       <c:when test="${orderRefund.customerName==null}">
											            <input onmousemove="checkMaxNum('num_${orderItem.orderItemId}');" onblur="checkMaxNum('num_${orderItem.orderItemId}');" onchange="checkMaxNum('num_${orderItem.orderItemId}');" id="num_${orderItem.orderItemId}" class="inputText" type="text" maxNum="${orderItem.num}" value="${orderItem.num}" style="border-bottom:1px dashed #ccc;text-overflow:ellipsis;white-space:nowrap;"/>
											       </c:when>
											       <c:otherwise>
											              ${orderItem.num}
											       </c:otherwise>
											   </c:choose>
											</td>
											<td class="txRight">￥${orderItem.couponAmount}</td>
											<td class="txRight">￥${orderItem.totalDiscount}</td>
											<td class="txRight">￥${orderItem.payAmount}</td>
									 </tr>
								</c:forEach>
							</table>
						</div>
						<div class="popReason">
							<dl class="dl">
								<dt class="dt">退货原因：</dt>
								<dd class="dd">
									<div class="fl module_Select">
	                                    <c:choose>
	                                        <c:when test="${orderRefund.refundReasonType!=null}">
	                                             <select id="refundReasonTypeSelect" class="trueMenu">
				                                      <c:forEach items="${refundReasonTypeList}" var="refundType">
				                                           <c:if test="${orderRefund.refundReasonType==refundType}">
				                                                <option selected="selected" value="${refundType}">${refundType}</option>
				                                           </c:if>
				                                           <c:if test="${orderRefund.refundReasonType!=refundType}">
				                                                <option value="${refundType}">${refundType}</option>
				                                           </c:if>
				                                      </c:forEach>
			                                     </select>
			                                     <div class="newSelectCer"></div>
	                                        </c:when>
	                                        <c:otherwise>
	                                             <select id="refundReasonTypeSelect" class="trueMenu">
			                                           <option id="optionInit_rg" value="" selected="selected">-选择类别-</option>
			                                         <c:forEach items="${refundReasonTypeList}" var="refundType">
			                                           <option value="${refundType}">${refundType}</option>
			                                         </c:forEach>
			                                    </select>
			                                    <div class="newSelectCer"></div>
	                                        </c:otherwise>
	                                    </c:choose>
	                                </div>
								</dd>
							</dl>
							<dl class="dl">
								<dt class="dt">退货理由：</dt>
								<dd class="dd">
									<textarea <c:if test="${orderRefund.customerName != null}">disabled="disabled" </c:if> id="refundReason_rg" name="refundReason_rg" class="bdStyle1">${orderRefund.refundReason}</textarea>
									不能为空，限500字
								</dd>
							</dl>
							<c:if test="${orderRefund.imageUrls!=null && orderRefund.imageUrls!=''}"> 
								<dl id="images_dl_rg" class="dl">
									<dt class="dt">详情：</dt>
									<dd class="dd">
										<div id="images_rg" class="bdStyle1">
										    <c:forEach items="${orderRefund.imageUrlList}" var="imgUrl">
										         <a target="_blank" href="<yp:thumbImage originalPath='${imgUrl}' imageType='t103'/>"><img src="<yp:thumbImage originalPath='${imgUrl}' imageType='t84'/>"/></a>
										    </c:forEach>
										</div>
									</dd>
								</dl>
							</c:if>
							<c:if test="${orderRefund.reviewDescribe!=null}">
							     <dl class="dl">
									<dt class="dt">不通过理由：</dt>
									<dd class="dd">
										${orderRefund.reviewDescribe}
									</dd>
								</dl>
							</c:if>
						</div>
						<div class="popBtn">
						    <c:if test="${orderRefund.customerName==null}">
						       <input id="orderIdHidden" type="hidden" value="${orderHead.orderId}" />
							  <!--  <input id="addRetGoodsButton" type="button" class="maageBtn_1" onclick="addRetGoods();" value="新建" /> -->
							</c:if>
							
							<c:if test="${isAdmin!=true}">
				                    <c:if test="${orderRefund.status==itemStatuses[1]}">
				                       <aut:authorize url="/order/order-passAudit">
				                            <input type="button" class="maageBtn_1" id="passAudit${orderRefund.orderRefundId}" onclick="passAudit(${orderRefund.orderRefundId}, '${orderRefund.orderItem.orderItemId}');" value="审核通过" />
				                            <c:if test="${orderRefund.isCanReturnFreight}">
					                           &nbsp;<input id="checkboxReturnFreight_${orderRefund.orderItem.orderItemId}" type="checkbox" /><label for="checkboxIncludeFreight">退运费</label>
					                        </c:if>
									   </aut:authorize>
									   <aut:authorize url="/order/order-rejectAudit">
									         <input type="button" class="maageBtn_1" id="rejectAudit" data-orderRefundId="${orderRefund.orderRefundId}" value="审核不通过" />
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
											    <input type="button" class="maageBtn_1" id="confirmBack_${orderRefund.orderRefundId}" onclick="confirmBack('${orderRefund.orderRefundId}');" value="确认收货" />
											</aut:authorize>
									</c:if>
							        <c:if test="${orderRefund.status==itemStatuses[5]}">
										<!-- <b>待退款</b> -->
									</c:if>
									<c:if test="${orderRefund.status==itemStatuses[6]}">
										<!-- <b>已完成</b> -->
									</c:if>
					        </c:if>
						</div>
			      </div>	
			<!--####################################################弹出层  end#################################################-->

<script type="text/javascript">

//隐藏查询或添加退货信息
function hideRefund()
{
	$("#popDiv").hide();
	$("#returnGoods").hide();
}
//全选按钮
function selectAllCheck(ownId,sName)
{
	if($("#"+ownId).is(':checked')==true)
	{
		$("[name = "+sName+"]:checkbox").prop("checked",true);
	}else{
		$("[name = "+sName+"]:checkbox").prop("checked",false);
	}
}
//初始化table
function initTable()
{
	$("#customerName_rg").val("");
	$("#mobile_rg").val("");
	$("#refundReason_rg").val("");
	$("#images_rg").html("");
	$("#images_dl_rg").show();
	$("#addRetGoodsButton").show();
	$("#selectAll_rg").show();
	$("#refundReasonTypeSelect").get(0).selectedIndex=0;
}
//检查数字不能超过最大
function checkMaxNum(id)
{
	var num=$("#"+id).val();
	var maxNum=$("#"+id).attr("maxNum");
	var re = /^[1-9]+[0-9]*]*$/;
    if (!re.test(num))  
    {  
    	$("#"+id).val(maxNum);
    }else{
    	if(parseInt(num)>parseInt(maxNum)){
    		$("#"+id).val(maxNum);
    	}
    	if(parseInt(num)<=0){
    		$("#"+id).val(maxNum);
    	}
    }
}
//新建保存退货单
function addRetGoods()
{
	var customerName=$("#customerName_rg").val();
	if(customerName=="" || customerName.length==0){
		alert("联系人不能为空");return;
	}
	var mobile=$("#mobile_rg").val();
	if(mobile=="" || mobile.length==0){
		alert("手机号码不能为空");return;
	}
	var reP =/^(1[0-9]{10})$/;
	if (!reP.test(mobile))  
    {  
		alert("手机号码格式不对");return;
    }
	
	var refundReasonTypeSelect=$("#refundReasonTypeSelect").val();
	if(refundReasonTypeSelect=="" || refundReasonTypeSelect.length==0){
		alert("退款原因不能为空");return;
	}
	var refundReason=$("#refundReason_rg").val();
	if(refundReason=="" || refundReason.length==0){
		alert("退款理由不能为空");return;
	}
	if(refundReason.length>500){
		alert("退款理由长度不能大于500");return;
	}
	refundReason=refundReason.replace(/<[^>]+>/g,"");
	//获取商品列表
	var orderItemIds="";
	var nums="";
	$("[name = orderItemIdCheckbox_rg]:checkbox").each(function(){ 
		if($(this).is(':checked')==true){
			orderItemIds+=$(this).attr("value")+",";
			if(parseInt($("#num_"+$(this).attr("value")).val()==0)<=0){
				alert("退货数量必须大于0");return;
			}
			nums+=$("#num_"+$(this).attr("value")).val()+",";
		}
	});
	if(orderItemIds=="" || orderItemIds.length==0){
		alert("未选中商品");return;
	}
	
	var orderId=$("#orderIdHidden").val();
	
	//保存退款商品信息
	$.ajax({
			url:_ctxPath + "/admin/order/orderMgr-addRefundRecord.htm",
			type:"POST",
			data:{'orderRefund.orderId':orderId,'orderRefund.customerName':customerName,'orderRefund.mobile':mobile
				,'orderRefund.refundReasonType':refundReasonTypeSelect,
				'orderRefund.refundReason':refundReason,"orderItemIds":orderItemIds,"nums":nums},
			dataType:"json",
			async: false,
			success:function(data){ 
				var s="";
				for(var i=0;i<data.length;i++)
				{
				   s+="<a href=\"javascript:void(0);\" onclick=\"showRefund('"+data[i]+"','"+orderId+"');\">"+data[i]+"</a>   ";
				}
				$("#popDiv").hide();
				$("#returnGoods").hide();
				showMsgDialog("新建退货单成功，退货单号："+s);
			},
			error:function(data){
				alert("添加退货信息出错，请联系一城一品客服");
			}
		});
}


$(function(){
	
	//商家审核不通过
	$("#rejectAudit").bind("click", function() {
		
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


//退货 - 审核通过
function passAudit(id, orderItemId){
	
	$.dialog({
		title: "提示",
		lock:true,
		content: "确定退货审核通过吗？",
	    okValue: "确定",
	    ok: function(){
	    	$.ajax({
	    		type:'post',
	    		data:{'orderRefund.orderRefundId':id, 'orderRefund.returnFreight': ($("#checkboxReturnFreight_" + orderItemId).is(':checked') ? 1 : 0)},
	    		url:'${_ctxPath}/admin/order/order-passAudit.htm',
	    		success:function(data){
	    			alert("审核通过操作已成功");
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

/**确认退货*/
function confirmBack(orderRefundId)
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
