<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="aut" uri="http://www.springsecurity.org/jsp" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>海外购报文管理</title>
		<link rel="stylesheet" type="text/css" href="${_jsPath }/new/css/base.css?v=${_resVerion}"/>
        <link rel="stylesheet" href="${_jsPath }/new/calendar/kalendae.css?v=${_resVerion}" type="text/css" charset="utf-8">
        <script type="text/javascript" src="${_jsPath }/new/js/jquery-1.11.0.min.js?v=${_resVerion}"></script>
		<script src="${_jsPath }/new/calendar/kalendae.standalone.js?v=${_resVerion}" type="text/javascript" charset="utf-8"></script>
        <script type="text/javascript" src="${_jsPath }/new/js/manage_basefun.js?v=${_resVerion}"></script>
        <script type="text/javascript" src="${_jsPath}/plugin/uploadify/jquery.uploadify.v2.1.4.min.js?v=${_resVerion}"></script>
		<script type="text/javascript" src="${_jsPath}/plugin/uploadify/swfobject.js?v=${_resVerion}"></script>
	</head>
	<body>
		<jsp:include page="../include/headerNew.jsp" flush="true" />
			<!--main-->
			<div class="main">
				
				<!--面包屑-->
				<div class="crumb">
					<aut:authorize url="/admin/order/order-exportSaleOrders">
						<button class="fr export" id="export"><i></i>
			      				导出
						</button>
					</aut:authorize>
					<p>
						<a href="" class="home"><i></i></a>
						<span class="sep"></span>
						<a href="">海外购报文管理</a>
						 
					</p>
				</div>
				
				<!--查询条件-->
				<form class="m-mt10p m-clear" action="${_ctxPath}/admin/crossBorder/crossBorderMessage-getCrossBorderInfo4Manage.htm" method="get" id="subform">
				<div class="query">
					<div class="line">
						<div class="col">
							<span class="sp">订单号：</span><input type="text" name="resultPage.params.entInsideNo" id="" value="${resultPage.params.entInsideNo }" class="inputText bgcf9f"/>
						</div>
						<div class="col">
							<span class="sp">报文编号：</span><input type="text" name="resultPage.params.messageId" id="" value="${resultPage.params.messageId}" class="inputText bgcf9f"/>
						</div>
						<div class="col">
							<span class="sp">下单时间：</span>
							<div class="fl">
                              <input type="text" name="resultPage.params.beginTime" value="${resultPage.params.beginTime }" class="inputText bgcf9f calendarOne beginTime"/>
								<span class="fl">至&nbsp;&nbsp;</span>
							  <input type="text" name="resultPage.params.endTime" value="${resultPage.params.endTime }" class="inputText bgcf9f calendarOne endTime"/>
							</div>
						</div>
						
						<div class="col">
							<span class="sp" style="width:100px">报文发送时间：</span>
							<div class="fl">
                              <input type="text" name="resultPage.params.messageBeginTime" value="${resultPage.params.messageBeginTime }" class="inputText bgcf9f calendarOne beginTime"/>
								<span class="fl">至&nbsp;&nbsp;</span>
							  <input type="text" name="resultPage.params.messageEndTime" value="${resultPage.params.messageEndTime }" class="inputText bgcf9f calendarOne endTime"/>
							</div>
						</div>
					</div>

					<div class="line">
						<div class="col">
							<span class="sp">海关状态：</span>
							<div class="fl module_Select">
								<select name="resultPage.params.customsClearingStatus" class="trueMenu">
									<option value=""
										<c:if test="${resultPage.params.customsClearingStatus=='' || resultPage.params.customsClearingStatus==null}">
											selected = "selected"
										</c:if>>...ALL...</option>
									<option value="S" 
										<c:if test="${resultPage.params.customsClearingStatus=='S' }">
											selected = "selected"
										</c:if>>报送成功</option>
									<option value="F"
										<c:if test="${resultPage.params.customsClearingStatus=='F' }">
											selected = "selected"
										</c:if>>报送失败</option>
								</select>
                                <div class="newSelectCer"></div>
                            </div>
                          </div>
                          <div class="col">
							<span class="sp">国检状态：</span>
							<div class="fl module_Select">
								<select name="resultPage.params.message_bbcStatus" class="trueMenu">
									<option value=""
										<c:if test="${resultPage.params.message_bbcStatus=='' || resultPage.params.message_bbcStatus==null}">
											selected = "selected"
										</c:if>>...ALL...</option>
									<option value="S" 
										<c:if test="${resultPage.params.message_bbcStatus=='S' }">
											selected = "selected"
										</c:if>>报送成功</option>
									<option value="F"
										<c:if test="${resultPage.params.message_bbcStatus=='F' }">
											selected = "selected"
										</c:if>>报送失败</option>
								</select>
                                <div class="newSelectCer"></div>
                            </div>
                            </div>
                          <div class="col">
							<span class="sp">卓志状态：</span>
							<div class="fl module_Select">
								<select name="resultPage.params.message_status" class="trueMenu">
									<option value=""
										<c:if test="${resultPage.params.message_status=='' || resultPage.params.message_status==null}">
											selected = "selected"
										</c:if>>...ALL...</option>
									<option value="S" 
										<c:if test="${resultPage.params.message_status=='S' }">
											selected = "selected"
										</c:if>>报送成功</option>
									<option value="F"
										<c:if test="${resultPage.params.message_status=='F' }">
											selected = "selected"
										</c:if>>报送失败</option>
								</select>
                                <div class="newSelectCer"></div>
                            </div>
                            </div>
                          <div class="col">
							<span class="sp">装载状态：</span>
							<div class="fl module_Select">
								<select name="resultPage.params.isWaybillno" class="trueMenu">
									<option value=""
										<c:if test="${resultPage.params.isWaybillno =='' || resultPage.params.isWaybillno==null}">
											selected = "selected"
										</c:if>>...ALL...</option>
									<option  value="0"
										<c:if test="${resultPage.params.isWaybillno == 0 }">
											selected = "selected"
										</c:if>>已装载</option>
									<option value="1"
										<c:if test="${resultPage.params.isWaybillno == 1 }">
											selected = "selected"
										</c:if>>未装载</option>
								</select>
                                <div class="newSelectCer"></div>
                            </div>
                            </div>
                          <div class="col">
							<span class="sp">订单状态：</span>
							<div class="fl module_Select">
								<select name="resultPage.params.order_status" class="trueMenu">
									<option value=""
										<c:if test="${resultPage.params.order_status=='' || resultPage.params.order_status==null}">
											selected = "selected"
										</c:if>>...ALL...</option>
									<option value="1" 
										<c:if test="${resultPage.params.order_status==1 }">
											selected = "selected"
										</c:if>>待付款</option>
									<option value="2"
										<c:if test="${resultPage.params.order_status==2 }">
											selected = "selected"
										</c:if>>待发货</option>
									<option value="3"
										<c:if test="${resultPage.params.order_status==3 }">
											selected = "selected"
										</c:if>>已发货</option>
									<option value="4"
										<c:if test="${resultPage.params.order_status==4 }">
											selected = "selected"
										</c:if>>已完成</option>
									<option value="5"
										<c:if test="${resultPage.params.order_status==5 }">
											selected = "selected"
										</c:if>>已取消</option>
									<option value="6"
										<c:if test="${resultPage.params.order_status==6 }">
											selected = "selected"
										</c:if>>全部退货</option>
									<option value="7"
										<c:if test="${resultPage.params.order_status==7 }">
											selected = "selected"
										</c:if>>部分退货</option>
								</select>
                                <div class="newSelectCer"></div>
                            </div>
						</div>
					</div>
					
					<div class="btns">
						<input id="searchBtn" class="maageBtn_1" type="button" value="查询" />
					</div>
					
					<input type="hidden" name="resultPage.params.adminFlag" value="true" />
					<input type="hidden" name="resultPage.currentPage" value="0" />
				</div>
				
				</form>
				
				<!--查询结果-表格-->
				<div class="tableData">
					<div class="btns btns_left">
						<input id="customsBtn" class="maageBtn_1" type="button" value="海关报送成功" />
						<input id="bbcBtn" class="maageBtn_1" type="button" value="国检报送成功" />
						<input id="warehouseBtn" class="maageBtn_1" type="button" value="入仓报送成功" />
						<input id="isshipBtn" class="maageBtn_1" type="button" value="国外商家发货成功" />
					</div>
					<div class="table">
						<table border="1px" bordercolor="#cfd7dd" cellspacing="0px">
							<tr>
								<th>
									<c:if test="${isAdmin ne true }">
										<input id="checkboxAll" type="checkbox"/>
									</c:if>
									订单号
								</th>
								<th>收货人</th>
								<th>海关</th>
								<th>国检</th>
								<th>卓志 </th>
								<th>入仓</th>
								<th>进境</th>
								<th>装载</th>
								<th>海外发货</th>
								<th>订单状态</th>
								<th>下单时间</th>
								<th>最后报送时间（卓志）</th>
								<th>操作</th>
							</tr>
							<c:forEach items="${resultPage.result}" var="crossborder" varStatus="status">
								<tr <c:if test="${status.count%2 eq 0}">class="even"</c:if>>
									<td class="c-258">
									<c:if test="${isAdmin ne true }">
										<input name="checkbox" type="checkbox" value="${crossborder.message_id}"/>
									</c:if> 
										<a target="_blank" 
											href="${_ctxPath}/admin/order/orderMgr-getOrderDetail.htm?orderHead.orderId=${crossborder.order_id}">${crossborder.order_entinsideno}</a>
									</td>
									<td>${crossborder.order_receivename}</td>
									<td>
										<c:if test="${crossborder.message_customsClearingStatus == null || crossborder.message_customsClearingStatus == ''}">暂无</c:if>
										<c:if test="${crossborder.message_customsClearingStatus =='S'}">成功</c:if>
										<c:if test="${crossborder.message_customsClearingStatus eq 'F'}"><a href="javascript:;">失败</a></c:if>
									</td>
									<td>
										<c:if test="${crossborder.message_bbcStatus ==null || crossborder.message_bbcStatus ==''}">暂无</c:if>
										<c:if test="${crossborder.message_bbcStatus eq 'S'}">成功</c:if>
										<c:if test="${crossborder.message_bbcStatus eq 'F'}"><a href="javascript:;">失败</a></c:if>
									</td>
									<td>
										<c:if test="${crossborder.message_status ==null || crossborder.message_status ==''}">暂无</c:if>
										<c:if test="${crossborder.message_status eq 'S'}">成功</c:if>
										<c:if test="${crossborder.message_status eq 'F'}">
											<a href="javascript:appear('message_status_${crossborder.message_id }');">失败</a>
											<input type="hidden" id="message_status_${crossborder.message_id }" value="${crossborder.message_notes }"/>
											<input type="hidden" id="message_status_${crossborder.message_id }F" value="${crossborder.order_entinsideno}报送卓志失败"/>
											</c:if>
									</td>
									<td>
										<c:if test="${crossborder.message_warehouseStatus ==null || ccrossborder.message_warehouseStatus ==''}">暂无</c:if>
										<c:if test="${crossborder.message_warehouseStatus eq 'S'}">成功</c:if>
										<c:if test="${crossborder.message_warehouseStatus eq 'F'}"><a href="javascript:;">失败</a></c:if>
									</td>
									<td>
										<c:if test="${crossborder.entry_statusto ==null || crossborder.entry_statusto ==''}">暂无</c:if>
										<c:if test="${crossborder.entry_statusto == 10}">成功</c:if>
										<c:if test="${crossborder.entry_statusto == 20}">
											<a href="javascript:appear('entry_statusto_${crossborder.message_id }');">失败</a>
											<input type="hidden" id="entry_statusto_${crossborder.message_id }" value="${crossborder.entry_statusdesc}"/>
											<input type="hidden" id="entry_statusto_${crossborder.message_id }F" value="${crossborder.order_entinsideno}进境失败"/>
											</c:if>
									</td>
									<td>
										<c:if test="${not empty crossborder.wayBill_waybillno}">${crossborder.wayBill_waybillno}</c:if>
										<c:if test="${empty crossborder.wayBill_waybillno}">
											<a href="javascript:appear('wayBill_waybillno_${crossborder.message_id }');">失败</a>
											<input type="hidden" id="wayBill_waybillno_${crossborder.message_id }" value="暂无圆通订单号"/>
											<input type="hidden" id="wayBill_waybillno_${crossborder.message_id }F" value="${crossborder.order_entinsideno}装载失败"/>
											</c:if>
									</td>
									<td>
										<c:if test="${crossborder.message_isship==null || crossborder.message_isship ==''}">暂无</c:if>
										<c:if test="${crossborder.message_isship == 1}">已发货</c:if>
										<c:if test="${crossborder.message_isship == 0}">未发货</c:if>
									</td>
									<td>
										 <spring:message code="crossborder.order_status.${crossborder.order_status }" />
									</td>
									<td><fmt:formatDate value='${crossborder.order_createTime}' pattern='yyyy-MM-dd HH:mm:ss' /></td>
									<td><fmt:formatDate value='${crossborder.message_createTime}' pattern='yyyy-MM-dd HH:mm:ss' /></td>
									<td>
										<c:if test="${crossborder.message_status eq 'F'}">
											<c:if test="${crossborder.message_processed eq 0 || crossborder.message_processed == null || crossborder.message_processed == ''}">
												<a href="javascript:updateProcessedStatus('${crossborder.message_id}');" class="blue">处理该单</a><br/>
											</c:if>
											<c:if test="${crossborder.message_processed eq 1}">已处理</c:if>
										</c:if>
									</td>
								</tr>
							</c:forEach>
						</table>
					</div>
					
				</div>
				
				<div class="popupWrap" id="tips">
					<div class="shadeBg"></div>
					<!--失败信息-->
					<div class="popup w340 h180">
						<div  class="popTitle"><span id="pt"></span><a href="javascript:;" class="close">x</a></div>
						<div  class="popCon"><p id="pc"></p></div>
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
	</body>
<script type="text/javascript">
function appear(m){
	$("#tips").show();
	$("#pc").html($("#"+m).val());
	$("#pt").html($("#"+m+"F").val())
}
$(function(){
	$("#tips").find(".close").bind("click",function(){
		$("#tips").hide();
	})
	
	$("#searchBtn").bind("click", function() {
		if($(".beginTime").val()&&$(".endTime").val()){
			if(compareDate($(".beginTime").val(),$(".endTime").val())){
				showMsgDialog("开始时间不能大于结束时间！");
				return;
			}
		}
		$("#subform").submit();
	});	
	
	$("#customsBtn").bind("click", function() {
		var checkbox = $("input[name='checkbox']:checked");
		if(checkbox.length > 0 ){
			var message_ids = "";
			
			for (var i=0; i < checkbox.length; i++) {
				var message_id = $(checkbox[i]).attr("value");
				message_ids += message_id;
				message_ids += ",";
			}
			message_ids = message_ids.substring(0, message_ids.length - 1);
			 $.ajax({
					type : 'POST',
					url : '${_ctxPath}/admin/crossBorder/crossBorderMessage-batchCustomsStatus.htm',
					data : {'message_ids':message_ids},
					success : function(data) {
						if(data.code=='true'){
							alert(data.info);
							$('#searchBtn').click();
						}else{
							if(undefined != data.info){
								showMsgDialog(data.info);
							}
						}
					},
					error:function(data){
						if(undefined != data.info){
							showMsgDialog(data.info);
						}
					}
				}); 
		} 
	});	
	
	$("#bbcBtn").bind("click", function() {
		var checkbox = $("input[name='checkbox']:checked");
		if(checkbox.length > 0 ){
			var message_ids = "";
			
			for (var i=0; i < checkbox.length; i++) {
				var message_id = $(checkbox[i]).attr("value");
				message_ids += message_id;
				message_ids += ",";
			}
			message_ids = message_ids.substring(0, message_ids.length - 1);
			 $.ajax({
					type : 'POST',
					url : '${_ctxPath}/admin/crossBorder/crossBorderMessage-batchBBCStatus.htm',
					data : {'message_ids':message_ids},
					success : function(data) {
						if(data.code=='true'){
							alert(data.info);
							$('#searchBtn').click();
						}else{
							if(undefined != data.info){
								showMsgDialog(data.info);
							}
						}
					},
					error:function(data){
						if(undefined != data.info){
							showMsgDialog(data.info);
						}
					}
				}); 
		} 
	});	
	
	$("#warehouseBtn").bind("click", function() {
		var checkbox = $("input[name='checkbox']:checked");
		if(checkbox.length > 0 ){
			var message_ids = "";
			
			for (var i=0; i < checkbox.length; i++) {
				var message_id = $(checkbox[i]).attr("value");
				message_ids += message_id;
				message_ids += ",";
			}
			message_ids = message_ids.substring(0, message_ids.length - 1);
			 $.ajax({
					type : 'POST',
					url : '${_ctxPath}/admin/crossBorder/crossBorderMessage-batchWarehouseStatus.htm',
					data : {'message_ids':message_ids},
					success : function(data) {
						if(data.code=='true'){
							alert(data.info);
							$('#searchBtn').click();
						}else{
							if(undefined != data.info){
								showMsgDialog(data.info);
							}
						}
					},
					error:function(data){
						if(undefined != data.info){
							showMsgDialog(data.info);
						}
					}
				}); 
		} 
	});	
	
	$("#isshipBtn").bind("click", function() {
		var checkbox = $("input[name='checkbox']:checked");
		if(checkbox.length > 0 ){
			var message_ids = "";
			
			for (var i=0; i < checkbox.length; i++) {
				var message_id = $(checkbox[i]).attr("value");
				message_ids += message_id;
				message_ids += ",";
			}
			message_ids = message_ids.substring(0, message_ids.length - 1);
			 $.ajax({
					type : 'POST',
					url : '${_ctxPath}/admin/crossBorder/crossBorderMessage-batchIsshipStatus.htm',
					data : {'message_ids':message_ids},
					success : function(data) {
						if(data.code=='true'){
							alert(data.info);
							$('#searchBtn').click();
						}else{
							if(undefined != data.info){
								showMsgDialog(data.info);
							}
						}
					},
					error:function(data){
						if(undefined != data.info){
							showMsgDialog(data.info);
						}
					}
				}); 
		} 
	});	
	
})

function updateProcessedStatus(message_id){
	if(confirm('确认处理此订单吗？')){
		$.ajax({
			type : 'POST',
			url : '${_ctxPath}/admin/crossBorder/crossBorderMessage-updateProcessedStatus.htm',
			data : {'message_ids':message_id},
			success : function(data) {
				if(data.code=='true'){
					alert(data.info);
					$('#searchBtn').click();
				}else{
					if(undefined != data.info){
						showMsgDialog(data.info);
					}
				}
			},
			error:function(data){
				if(undefined != data.info){
					showMsgDialog(data.info);
				}
			}
		});
		$(".d-close").hide();
	}
}
	

</script>
</html>