$(function(){
	$("#activityType").change(function(){
		var selectVal = $(this).val();
		switch(selectVal){
		case "1":
			$("#postageArea").show();
			$("#activitybankArea").hide();
			$("#maisongArea").hide();
			$("#maijianArea").hide();
			break;
		case "2":
			$("#maijianArea").show();
			$("#postageArea").hide();
			$("#maisongArea").hide();
			$("#activitybankArea").hide();
			break;
		case "3":
			$("#maijianArea").show();
			$("#postageArea").hide();
			$("#maisongArea").hide();
			$("#maijianArea").hide();
			break;	
		case "4":
			$("#activitybankArea").show();
			$("#postageArea").hide();
			$("#maisongArea").hide();
			$("#maijianArea").hide();
			break;	
		case "5":
			$("#maisongArea").show();
			$("#activitybankArea").hide();
			$("#postageArea").hide();
			$("#maijianArea").hide();
			break;				
		}
	});
	
	
});



function showDialog(config) {
	var html = '';
	$.ajax({
		url: config.url,
		type:"POST",
		data:config.data,
		dataType:"html",
		async: false,
		disable:false,
		success:function(data){
			html=data;
			$.dialog({
			  lock: true,
			  padding: "5px",
			  title:false,
			  content:html,
			  width:config.width,
			  fixed: false,
			  cancel: true,
			  cancelValue:"取  消",
			  ok:function(){
				  if(config.callback){
					  config.callback();
				  }
			  },
			  okValue:"确   定"
			});
		},
		error:function(data){
			  alert("访问失败");
		}
	});
}



function clearProInfo(){
	$("#skuIds").val("");
	$("#proType").val('');
	$("#propnames").html('');
	$("#productNames").html('');
	
}


function toSelectProType(){
	var startTimeVar = $("#startTime").val();
	if(startTimeVar == null || startTimeVar == "") {
		alert("请选择包邮开始日期！");
		return;
	}
	var endTimeVar = $("#endTime").val();
	if(endTimeVar == null || endTimeVar == "") {
		alert("请选择包邮结束日期！");
		return;
	}
	if($("#sellTypes").val() == null || $("#sellTypes").val() ==""){
		alert("请选择销售类型！");
		return;
	}
	var toUrlType= $(".proType:checked").val();
	var url ="";
	if(toUrlType == '2'){
		url ="${_ctxPath}/marketAct/marketact-listProKind.htm";
	showDialog({
		url:url,
		callback:function(data){
			clearProInfo();
			$("#proType").val(getResult());
			$("#propnames").html(getName());
		}
	});
	}else if(toUrlType == '3'){
		url ="${_ctxPath}/marketAct/marketact-toListProSku.htm?activity_id=${activity.id}";
	   showDialog({
		url:url,
		width:900,
		callback:function(data){
			clearProInfo();
			$("#skuIds").val(getProInfo());
			$("#productNames").html(getProNames());
		}
	  });
	}
};


function toShowAreaInfo(){
	if($("input[name='activity.areaInfo']:checked").val()== undefined){
		return;
	}
	 showDialog({
			url:"${_ctxPath}/marketAct/marketact-listAreaInfo.htm",
			callback:function(data){
			 	$("#areaInfo").val(getAreaResult());
			 	$("#selectedArea").html(getAreaName());
			}
	});
}



function selectedId(idstrs,selectS,selectE){
	var sv = $("#"+idstrs).val()
	 var ids = sv.split(",");
	 var i =0;
	 for(i=0;i<ids.length;i++){
		 $(selectS+ids[i]+selectE).attr("checked","checked");
	 }
}


$("#goumai").change(function(){
	var select_val = $(this).children('option:selected').val();
		$("div[id*='jianDiv']").hide();
	switch(select_val){
	case '1':
		$('#danjianDiv').show();
		$("input[id^='danjian']").attr("disabled",false);
		break;
	case '2':
		$("input[id^='leijian']").attr("disabled",false);
		$('#leijianDiv').show();
		$("input[id^='danjian']").attr("disabled",true);
		 break;
	case '3':
		$("input[id^='jietijian']").attr("disabled",false);
		$('#jietijianDiv').show();
		$('#jietijianDiv1').show();
		$("input[id^='danjian']").attr("disabled",true);
		 break;		  
	case '4':
		$("input[id^='zhekoujian']").attr("disabled",false);
		$('#zhekoujianDiv').show();
		$("input[id^='danjian']").attr("disabled",true);
	   break;	
	default:
		$('#danjianDiv').show();
}
});


//选择每天时需要每天都选中
$("#selectAll").click(function(){
		if($("#selectAll").is(":checked")){
		 $("input[name='activity.timeRule']").each(function(){
			   $(this).attr("checked",true);
		 });  
		}else{
			 $("input[name='activity.timeRule']").each(function(){
				   $(this).attr("checked",false);
			 });  
		}
});


//子复选框的事件
function setSelectAll(all){
	//当没有选中某个子复选框时，SelectAll取消选中
	if (!$(all).is(":checked")) {
		$("#selectAll").attr("checked", false);
	}
	var chsub = $("input[type='checkbox'][name='activity.timeRule']").length; //获取subcheck的个数
	var checkedsub = $("input[type='checkbox'][name='activity.timeRule']:checked").length; //获取选中的subcheck的个数
	if (checkedsub*1 == chsub*1) {
		$("#selectAll").attr("checked", true);
	}
}