<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="aut" uri="http://www.springsecurity.org/jsp" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>
<style>
<!--
.d-buttons {
	margin-right: 660px;
}
-->
</style>
	<div class="popupOuter">
		<form class="m-mt10p m-clear" action="${_ctxPath}/admin/order/orderMgr-saveOrderCancel.htm" method="post" id="orderCancelForm">
				<div class="popTitle">新建<c:if test="${orderCancel.refundType eq 0 }">售前</c:if><c:if test="${orderCancel.refundType eq 1 }">售后</c:if>退款单</div>
				<div class="popCon">
					<div class="popInfo">
						<ul>
							<li><span>订单号：</span>${orderHead.orderNo }</li>
							<li>
								<span class="fl">申请人：</span>
								<div class="fl module_Select">
                                    <select id="test_1" name="orderCancel.createPresonRole" class="trueMenu">
                                      <option value="客服" selected="selected">客服</option>
                                      <option value="财务">财务</option>
                                      <option value="运营">运营</option>
                                    </select>
                                    <div class="newSelectCer"></div>
                                </div>
							</li>
						</ul>
					</div>
					<div class="popTable">
						<table border="1px" cellspacing="0" bordercolor="#cfd7dd" width="100%">
							<tr class="linerBg">
								<th>商品SKU</th>
								<th>商品名称</th>
								<th>商品重量</th>
								<th>数量</th>
								<th class="txRight">运费</th>
								<th class="txRight">优惠金额</th>
								<th class="txRight">折扣金额</th>
								<th>使用积分</th>
								<th class="txRight">支付金额</th>
							</tr>
							<c:forEach items="${orderHead.items}" var="orderItem" varStatus="status">
								<tr <c:if test="${status.count%2 eq 0}">class="even"</c:if>>
									<td>${orderItem.productSku.sellerSkuCode }</td>
									<td>${orderItem.productName }</td>
									<td>${orderItem.productProp}</td>
									<td>${orderItem.num }</td>
									<td class="txRight">￥${orderHead.totalPostage }</td>
									<td class="txRight">￥${orderItem.couponAmount}</td>
									<td class="txRight">￥${orderItem.totalDiscount}</td>
									<td>0</td>
									<td class="c-ff4400 txRight">￥${orderItem.payAmount}</td>
								</tr>
							</c:forEach>
						</table>
					</div>
					<div class="popReason">
						<dl class="dl">
							<dt class="dt">退款原因：</dt>
							<dd class="dd">
								<div class="fl module_Select">
                                    <select name="orderCancel.refundReasonType" class="trueMenu">
	                                  <option value="0" selected="selected">
	                                  	<spring:message code="orderCancel.refundReasonType.0"/>
	                                  </option>
	                                  <option value="1">
	                                  	<spring:message code="orderCancel.refundReasonType.1"/>
	                                  </option>
	                                  <option value="2">
	                                  	<spring:message code="orderCancel.refundReasonType.2"/>
	                                  </option>
	                                  <option value="3">
	                                  	<spring:message code="orderCancel.refundReasonType.3"/>
	                                  </option>
	                                </select>
                                    <div class="newSelectCer"></div>
                                </div>
							</dd>
						</dl>
						<dl class="dl">
							<dt class="dt">退款类型：</dt>
							<dd class="dd">
								<div class="module_Select">
                                    <select name="orderCancel.refundType" class="trueMenu">
	                                  <option value="0" <c:if test="${orderCancel.refundType eq 0 }">
													selected = "selected"
												</c:if>
												<c:if test="${orderCancel.refundType==null}">
													selected = "selected"
												</c:if>>
	                                  	<spring:message code="orderCancel.refundType.0"/>
	                                  </option>
	                                  <option value="1" <c:if test="${orderCancel.refundType eq 1 }">
													selected = "selected"
												</c:if>>
	                                  	<spring:message code="orderCancel.refundType.1"/>
	                                  </option>
	                                </select>
                                    <div class="newSelectCer"></div>
                                </div>
							</dd>
						</dl>
						<dl class="dl">
							<dt class="dt">退款通道：</dt>
							<dd class="dd">
								<ul class="inputRadios">
									<li><input type="radio" name="orderCancel.cancelItem.refundPayType" checked="checked" class="refundPayType" value="1" /><label for="">银行卡</label></li>
									<li><input type="radio" name="orderCancel.cancelItem.refundPayType" class="refundPayType" value="0" /><label for="">支付宝</label></li>
								</ul>
							</dd>
						</dl>
						<dl class="dl">
							<dt class="dt">退款金额：</dt>
							<dd class="dd">
								<input type="text" onblur="javascript:return checkRefundAmount(this);"  name="orderCancel.refundAmount" id="refundAmount" value="" class="inputText2"/>
								<span class="tips"><i></i><span id="refundAmountErr"></span></span>
							</dd>
						</dl>
						<dl class="dl">
							<dt class="dt" id="personNameDt">开户名：</dt>
							<dd class="dd">
							<input type="text" onblur="javascript:return checkPersonName(this);" name="orderCancel.cancelItem.personName" id="personName" value="" class="inputText2" />
							<span class="tips"><i></i><span id="personNameErr"></span></span>
						</dd>
						</dl>
						<dl class="dl" id="bankOfDepositDl">
							<dt class="dt">开户行：</dt>
							<dd class="dd">
								<input type="text" onblur="javascript:return checkBankOfDeposit(this);"  name="orderCancel.cancelItem.bankOfDeposit" id="bankOfDeposit" value="" class="inputText2"/>
								<span class="tips"><i></i><span id="bankOfDepositErr"></span></span>
							</dd>
						</dl>
						<dl class="dl">
							<dt class="dt" id="bankAccountNoDt">开户银行卡号：</dt>
							<dd class="dd">
								<input type="text" onblur="javascript:return checkBankNo(this);" onkeyup="javascript:replaceBankNo(this);"  name="orderCancel.cancelItem.refundAccountNo" id="refundAccountNo" value="" class="inputText2"/>
								<span class="tips"><i></i><span id="bankNoErr"></span></span>
							</dd>
						</dl>
						<dl class="dl">
							<dt class="dt">客服备  注：</dt>
							<dd class="dd">
								<div class="bdStyle1"><textarea name="orderCancel.refundReason"></textarea></div>
							</dd>
						</dl>
					</div>
				</div>
				<input type="hidden" name="orderCancel.orderId" value="${orderHead.orderId }" />
				<input type="hidden" name="andCancelOrderFlag" value="${andCancelOrderFlag}" />
			</form>
	</div>
			
<script type="text/javascript">
	function replaceBankNo(obj) {
// 		$(obj).parent().removeClass("error");
		obj.value = obj.value.replace(/\D/g,'').replace(/....( !$)/g,'$& ').replace(/(\d{4})(?=\d)/g,'$1 ');
	};
	function checkBankNo(obj) {
		if(!checkTrim(obj.value)){
			$(obj).parent().addClass("error");
			$(obj).parent().removeClass("right");
			$("#bankNoErr").html("开户账号/支付宝账号不能为空");
			return false;
		}else if(obj.value.length>25){
			$(obj).parent().addClass("error");
			$(obj).parent().removeClass("right");
			$("#bankNoErr").html("开户账号/支付宝账号不能超过25个字符");
			return false;
		}else{
			$("#bankNoErr").html("");
			$(obj).parent().removeClass("error");
			$(obj).parent().addClass("right");
			return true;		
		}
	};
	function checkRefundAmount(obj){
		if(checkTrim(obj.value)){
			var a=/^[0-9]*(\.[0-9]{1,2})?$/;
			if(!a.test(obj.value))
			{
				$(obj).parent().addClass("error");
//	 			$(obj).parent().removeClass("right");
				$("#refundAmountErr").html("退款金额格式不正确(如'5'或'5.00')");
				return false;
			}
		}
		$("#refundAmountErr").html("");
		$(obj).parent().removeClass("error");
//	 	$(obj).parent().addClass("right");
		return true;		
	}
	
	function checkRefundAmountValue(amount){
		if(checkTrim(amount)){
			var a=/^[0-9]*(\.[0-9]{1,2})?$/;
			if(!a.test(amount))
			{
				return false;
			}
		}
		return true;		
	}
	
	function checkBankOfDeposit(obj) {
		if(!checkTrim(obj.value)){
			$(obj).parent().addClass("error");
			$(obj).parent().removeClass("right");
			$("#bankOfDepositErr").html("开户行不能为空");
			return false;
		}else if(obj.value.length>25){
			$(obj).parent().addClass("error");
			$(obj).parent().removeClass("right");
			$("#bankOfDepositErr").html("开户行不能超过25个字符");
			return false;
		}else{
			$("#bankOfDepositErr").html("");
			$(obj).parent().removeClass("error");
			$(obj).parent().addClass("right");
			return true;		
		}
	};
	function checkPersonName(obj) {
		if(!checkTrim(obj.value)){
			$(obj).parent().addClass("error");
			$(obj).parent().removeClass("right");
			$("#personNameErr").html("开户名/支付宝姓名不能为空");
			return false;
		}else if(obj.value.length>25){
			$(obj).parent().addClass("error");
			$(obj).parent().removeClass("right");
			$("#personNameErr").html("开户名/支付宝姓名不能超过25个字符");
			return false;
		}else{
			$("#personNameErr").html("");
			$(obj).parent().removeClass("error");
			$(obj).parent().addClass("right");
			return true;		
		}
	};
	
	
	$(function(){
		$(".refundPayType").bind("click", function() {
			var payType = $(this).val();
			if(payType==0){
				$("#personNameDt").html("支付宝姓名:");
				$("#bankAccountNoDt").html("支付宝账号:");
				$("#refundAccountNo").attr("onkeyup","");
				$("#bankOfDepositDl").css("display","none");
				
			}else{
				$("#personNameDt").html("开户名:");
				$("#bankAccountNoDt").html("开户银行卡号:");
				$("#refundAccountNo").attr("onkeyup","javascript:replaceBankNo(this);");
				$("#bankOfDepositDl").css("display","block");
			}
		});
	})
	
</script>