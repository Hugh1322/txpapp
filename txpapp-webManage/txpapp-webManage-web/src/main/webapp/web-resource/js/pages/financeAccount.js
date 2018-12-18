  //去某指定商家去看明细
  function details(sellerId){
	  window.location = _ctxPath+'/admin/accounts/accounts-showSellerReportDetail.htm?faPage.params.userId='+sellerId+"&faPage.params.status="+-1;
  }
  //选中全选按钮，下面的checkbox全部选中
  var selAll = document.getElementById("selAll");
  
  function selectAll(){
    var obj = $(".checkAll");
    if(document.getElementById("selAll").checked == false)
    {
    	for(var i=0; i<obj.length; i++){
      obj[i].checked=false;
    }
    }else{
    	for(var i=0; i<obj.length; i++){  
    		obj[i].checked=true;
    	}
    }
  }
  
  //当选中所有的时候，全选按钮会勾上
  function setSelectAll()
  {
	  //var obj=document.getElementById("checkAll");
	  var obj=$(".checkAll");
	  var count = obj.length;
	  var selectCount = 0;
	
	  for(var i = 0; i < count; i++)
	  {
	  	if(obj[i].checked == true){
	  		selectCount++;
	  	}
	  }
	  if(count == selectCount){
	 		document.all.selAll.checked = true;
	  }else{
	  		document.all.selAll.checked = false;
	  }
  }
  
  //反选按钮
  function inverse() {
	  var checkboxs=$(".checkAll");
	  for (var i=0;i<checkboxs.length;i++) {
	    var e=checkboxs[i];
	    e.checked=!e.checked;
	    setSelectAll();
	  }
  }
  
  function searcherSellert(currentPage){
	  $.ajax({
			url:_ctxPath + "/admin/accounts/accounts-userList.htm?data="+new Date(),
			data:{"fs.limit":50,"fs.currentPage":currentPage},//默认每页显示50
			dataType:"json",
			async: false,
			success:function(data){
				if(data.code=='true'){
					var info = eval(data.info);
					var userList = info[0].users;
					var html = "";
					var userIds = $("#userList").val();//商家
					var array = null;
					if(userIds!=null&&userIds!=undefined){
						array = userIds.split("-");
					}
					
					for(var i=0;i<userList.length;i++){
						html += "<label class='icn_la'><input type='checkbox' name='userIds["+i+"]'  class='checkAll' ";
						if(userIds!=null&&userIds!=undefined){
							var array = userIds.split("-");
							if(array!=null){
								for(var j=0;j<array.length;j++){
									//alert(userList[i].userId+"---"+array[j]);
									if(userList[i].userId==array[j]){
										html +=" checked='checked' ";
									}
								}
							}
						}
						html += "value='"+userList[i].userId+"'/>"+userList[i].username+"</label> ";
						if((i+1)%4==0){
							html+="<br>";
						}
					}
					$("#sellerInfo").html(html);
					var result = false;
					$(".checkAll").each(function(){
						if(!$(this).is(":checked")){
							result = true;
						}
					});
					if(result){
						$("#selAll").attr("checked",false);
					}else{
						$("#selAll").attr("checked",true);
					}
					//当前页是首页则不显示上一页 当前页是最后一页则不显示下一页
					var pageHtml = "<span style='display:block;text-align:center;'>";
					if(info[0].currentPage==0){//乳沟
							pageHtml +="<a href='#'style='color:#cccccc;' >上一页</a>";
					}else{
							pageHtml +="<a href='#' onclick='searcherSellert("+(info[0].currentPage-1)+")'>上一页</a>";
					}
					pageHtml +="&nbsp;";
					if(info[0].currentPage==info[0].totalPage-1){
							pageHtml +="<a href='#' style='color:#cccccc;' >下一页</a>";
					}else{
							pageHtml +="<a href='#' onclick='searcherSellert("+(info[0].currentPage+1)+")' >下一页</a>";
					}
					pageHtml +="</span>";
					$("#pageInfo").html(pageHtml);
				}
			}
		});
  }