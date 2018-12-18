<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<title>买家管理</title>
 	<link href="${ _cssPath}/common.css" rel="stylesheet" />
    <link href="${ _cssPath}/pages/buyerManagement.css" rel="stylesheet" />
    <link href="${_jsPath }/plugin/My97DatePicker/skin/WdatePicker.css" rel="stylesheet" />
    <script src="${_jsPath }/jquery/jquery.1.8.1.js"  language="javascript"></script>
    <script src="${_jsPath }/plugin/My97DatePicker/WdatePicker.js"></script>
  <script>
  //选中全选按钮，下面的checkbox全部选中
  var selAll = document.getElementById("selAll");
  function selectAll()
  {
   // var obj = document.getElementsByName("checkAll");
    var obj=$(".checkAll")
   if(document.getElementById("selAll").checked == false)
    {
    for(var i=0; i<obj.length; i++)
    {
      obj[i].checked=false;
    }
    }else
    {
    for(var i=0; i<obj.length; i++)
    {  
      obj[i].checked=true;
    }
    }
   
  }
  //当选中所有的时候，全选按钮会勾上
  function setSelectAll()
  {
  //var obj=document.getElementsByName("checkAll");
  var obj=$(".checkAll")
  var count = obj.length;
  var selectCount = 0;

  for(var i = 0; i < count; i++)
  {
  if(obj[i].checked == true)
  {
  selectCount++;
  }
  }
  if(count == selectCount)
  {
  document.all.selAll.checked = true;
  }
  else
  {
  document.all.selAll.checked = false;
  }
  }
  //反选按钮
  function inverse() {
  //var checkboxs=document.getElementsByName("checkAll");
  var obj=$(".checkAll")
  for (var i=0;i<checkboxs.length;i++) {
    var e=checkboxs[i];
    e.checked=!e.checked;
    setSelectAll();
  }
  }
	 
 	 


  $(document).ready(function(){
	 $("#inc_sel").click(function(){
	   var startTime_val=$("#startTime").val();
	   var endTime_val=$("#endTime").val();
	   if(startTime_val==""|endTime_val=="")
	   {alert("请输入开始时间或者是结束时间");}

	   
	 }); 
	 $("#incom_click").click(function(){$(".income_up").show();})	 
	 $(".inup_bu").click(function(){$(".income_up").hide();})	 
	 $(".income_close").click(function(){$(".income_up").hide();})
     $(".icn_la").click(function(){setSelectAll();})
     $("#selAll").click(function(){selectAll();}) 
     

  });

  </script>

</head>
<body>
<jsp:include page="/WEB-INF/views/include/header.jsp" flush="true" />
<div class="body m-w980p income_fa">
<aut:authorize url="/admin/user/buyer-search">
	<form class="m-mt10p m-clear" action="${_ctxPath}/admin/user/user-searchBuyers.htm" id="search-form" method="post">
	    <div class="m-fl">
          <label>商家：</label>
          <input type="button" class="m-btn" value="请 选 择" id="incom_click"/>
          <label>注册时间：</label>
          <input type="text" name="buyerPage.params.startTime" value="${buyerPage.params.startTime}" class="Wdate" 
          id="startTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endTime\',{d:-1});}',minDate:'#F{$dp.$D(\'endTime\',{d:-92});}',readOnly:true})" /> 
          
          <label>至 </label>
           <input type="text" name="buyerPage.params.endTime" value="${buyerPage.params.endTime}" class="Wdate" 
          id="endTime" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'startTime\',{d:+92});}',maxDate:'%y-%M-%d',minDate:'#F{$dp.$D(\'startTime\')}',readOnly:true})" />
          <input type="button" class="m-btn" id="inc_sel" value="查 询"/>
	      <input type="button" class="m-btn" value="导 出"/>
	    </div>
	    <div class="m-fr curr-num">
	      <label class="income_label">当前显示：</label>
	      <select onchange="window.location = '?buyerPage.params.startTime=2014-04-03&amp;buyerPage.params.endTime=2014-04-09&amp;buyerPage.total=5&amp;buyerPage.sort=u.createTime&amp;buyerPage.dir=desc&amp;buyerPage.limit=' + this.value;" class="m-sel" name="buyerPage.limit">	     
	         <option selected="selected" value="20">每页20条</option>	     
	         <option value="50">每页50条</option>	     
	         <option value="100">每页100条</option>	     
	         <option value="200">每页200条</option>     
	         <option value="500">每页500条</option>
	     </select>
	    </div>
	   	<c:if test="${not empty buyerPage.result}">
		    <div class="m-fr curr-num">
					<label>当前显示： </label> 
	        <yp:commPageSize page="${buyerPage}" beanName="buyerPage"></yp:commPageSize>
				</div>
      </c:if>
	</form>
</aut:authorize> 
	    <!--<div class="buyer-form-fl m-mt10p">
	        <ul class="m-clear">
	        		<li>消费总额
	        			<a href="${_ctxPath}/admin/user/user-searchBuyers.htm?buyerPage.params.startTime=${buyerPage.params.startTime}&buyerPage.params.endTime=${buyerPage.params.endTime}&buyerPage.total=${buyerPage.total}&buyerPage.limit=${buyerPage.limit}&buyerPage.sort=totalPrice&buyerPage.dir=asc&buyerPage.currentPage=${buyerPage.currentPage}"><span><i></i></span></a>
	        			<a href="${_ctxPath}/admin/user/user-searchBuyers.htm?buyerPage.params.startTime=${buyerPage.params.startTime}&buyerPage.params.endTime=${buyerPage.params.endTime}&buyerPage.total=${buyerPage.total}&buyerPage.limit=${buyerPage.limit}&buyerPage.sort=totalPrice&buyerPage.dir=desc&buyerPage.currentPage=${buyerPage.currentPage}"><span><i class="down"></i></span></a>
	        		</li>
	        	
	        		<li>消费次数
	        			<a href="${_ctxPath}/admin/user/user-searchBuyers.htm?buyerPage.params.startTime=${buyerPage.params.startTime}&buyerPage.params.endTime=${buyerPage.params.endTime}&buyerPage.total=${buyerPage.total}&buyerPage.limit=${buyerPage.limit}&buyerPage.sort=orderCount&buyerPage.dir=asc&buyerPage.currentPage=${buyerPage.currentPage}"><span><i></i></span></a>
	        			<a href="${_ctxPath}/admin/user/user-searchBuyers.htm?buyerPage.params.startTime=${buyerPage.params.startTime}&buyerPage.params.endTime=${buyerPage.params.endTime}&buyerPage.total=${buyerPage.total}&buyerPage.limit=${buyerPage.limit}&buyerPage.sort=orderCount&buyerPage.dir=desc&buyerPage.currentPage=${buyerPage.currentPage}"><span><i class="down"></i></span></a>
	        		</li>
	            
	             	<li>注册时间
	             		<a href="${_ctxPath}/admin/user/user-searchBuyers.htm?buyerPage.params.startTime=${buyerPage.params.startTime}&buyerPage.params.endTime=${buyerPage.params.endTime}&buyerPage.total=${buyerPage.total}&buyerPage.limit=${buyerPage.limit}&buyerPage.sort=u.createTime&buyerPage.dir=asc&buyerPage.currentPage=${buyerPage.currentPage}"><span><i></i></span></a>
	        			<a href="${_ctxPath}/admin/user/user-searchBuyers.htm?buyerPage.params.startTime=${buyerPage.params.startTime}&buyerPage.params.endTime=${buyerPage.params.endTime}&buyerPage.total=${buyerPage.total}&buyerPage.limit=${buyerPage.limit}&buyerPage.sort=u.createTime&buyerPage.dir=desc&buyerPage.currentPage=${buyerPage.currentPage}"><span><i class="down"></i></span></a>
	             	</li>
	            
	            	<li>最后登录时间
	            		<a href="${_ctxPath}/admin/user/user-searchBuyers.htm?buyerPage.params.startTime=${buyerPage.params.startTime}&buyerPage.params.endTime=${buyerPage.params.endTime}&buyerPage.total=${buyerPage.total}&buyerPage.limit=${buyerPage.limit}&buyerPage.sort=lastLoginTime&buyerPage.dir=asc&buyerPage.currentPage=${buyerPage.currentPage}"><span><i></i></span></a>
	        			<a href="${_ctxPath}/admin/user/user-searchBuyers.htm?buyerPage.params.startTime=${buyerPage.params.startTime}&buyerPage.params.endTime=${buyerPage.params.endTime}&buyerPage.total=${buyerPage.total}&buyerPage.limit=${buyerPage.limit}&buyerPage.sort=lastLoginTime&buyerPage.dir=desc&buyerPage.currentPage=${buyerPage.currentPage}"><span><i class="down"></i></span></a>
	            	</li>
	           
	        </ul>
	    </div>-->
<!-- 	    <div class="pagination pagination-right"> -->
<%-- 				<c:if test="${not empty buyerPage.result}"> --%>
<%-- 					<yp:commPage page="${buyerPage}" beanName="buyerPage"></yp:commPage> --%>
<%-- 				</c:if> --%>
<!-- 			</div> -->
	<!--start 买家管理table-->
<div class="m-mt10p income_dowm">
<table width="100%">
	<thead class="tab-control">
	<tr id="income_tr">
	    <th width="7%">商家名称</th>
	    <th width="6%">商品销售数量</th>
	    <th width="6%">商品销售收入</th>
	    <th width="6%">退款</th>
	    <th width="6%">退货</th>
	    <th width="7%">退款退货后收入</th>
	    <th width="6%">应付运费</th>
	    <th width="6%">服务费率</th>
	    <th width="6%">应收服务费</th>
	    <th width="8%">应付其他代垫款项</th>
	    <th width="6%">应付销售激励</th>	
	    <th width="6%">应付账款合计</th>	
	    <th width="7%">已结算账款合计</th>	
	    <th width="6%">交易手续费</th>		
	    <th width="6%">净收入</th>	
	    <th width="5%">操作</th>	 
	</tr>
	</thead>
<tbody class="income_tbody">
	<tr><td>新龙公司</td><td>&yen;1</td><td>&yen;500</td><td>&yen;0</td><td>&yen;200</td><td>&yen;200</td><td>&yen;30</td><td>&yen;210</td><td>&yen;200</td><td>&yen;130</td><td>&yen;160</td><td>&yen;700</td><td>&yen;10</td><td>&yen;100</td><td>&yen;200</td><td><a href="">查看</a></td></tr>
	<tr><td>新龙公司</td><td>&yen;1</td><td>&yen;500</td><td>&yen;0</td><td>&yen;200</td><td>&yen;200</td><td>&yen;30</td><td>&yen;210</td><td>&yen;200</td><td>&yen;130</td><td>&yen;160</td><td>&yen;700</td><td>&yen;10</td><td>&yen;100</td><td>&yen;200</td><td><a href="">查看</a></td></tr>
	<tr><td>新龙公司</td><td>&yen;1</td><td>&yen;500</td><td>&yen;0</td><td>&yen;200</td><td>&yen;200</td><td>&yen;30</td><td>&yen;210</td><td>&yen;200</td><td>&yen;130</td><td>&yen;160</td><td>&yen;700</td><td>&yen;10</td><td>&yen;100</td><td>&yen;200</td><td><a href="">查看</a></td></tr>

</tbody>

</table>
</div>
<div class="income_up" style="display:none;">
  <div class="jebh"><span class="income_h">商家名称：</span><span class="income_close"></span></div>
  <p class="inup_p"><span class="all_jh">全部</span><span>a</span><span>b</span><span>c</span><span>d</span></p>
  <div class="inup_div">
      <label class="icn_la"><input type="checkbox" name="checkAll" class="checkAll"/>&nbsp;新龙1&nbsp;</label>
      <label class="icn_la"><input type="checkbox" name="checkAll" class="checkAll"/>&nbsp;新龙2&nbsp;</label>
      <label><input type="checkbox" id="selAll" />&nbsp;全选&nbsp;</label>
  </div> 
  <div class="m-btn inup_bu">确认</div>
</div>
<!--end 买家管理table-->
	<div class="pagination pagination-right">
		<c:if test="${not empty buyerPage.result}">
			<yp:commPage page="${buyerPage}" beanName="buyerPage"></yp:commPage>
		</c:if>
	</div>
</div>
<jsp:include page="/WEB-INF/views/include/foot.jsp"></jsp:include>

</body>
</html>