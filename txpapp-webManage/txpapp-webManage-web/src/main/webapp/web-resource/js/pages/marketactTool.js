
	function addMarketivity(){
		window.location.href = _ctxPath+"/marketactivity/marketact-toAddActivity.htm"
	}

	
	
	
	//判断活动是否能发布
	function checExist(id){
		var re = false;
		var code = $("#code_"+id).val();
		var name = $("#name_"+id).val();
		var startTime = $("#startTime_"+id).val();
		var endTime = $("#endTime_"+id).val();
		$.ajax({
			url:_ctxPath+"/marketactivity/marketact-checkExistActivity.htm",
			type:"POST",
			data:{"activity.code":code,
				"activity.name":name,
				'activity.id':id,
				'activity.startTime':startTime,
				'activity.endTime':endTime
			},
			dataType:"json",
		    async:false,
			success:function(data){
				//alert(JSON.stringify(data));
				if(data.code =="false"){
					re=false;
				}
				if(data.code == "10011"){
					alert('存在冲突活动SKU:\r'+'SKUID:['+data.info+"]");
					re=true;
				}
				if(data.code == "10010"){
					alert('存在冲突活动:\r'+'活动代码:['+data.info+"]");
					re=true;
				}
			},
			error:function(data){
				  alert("校验重复名称代码失败");
			}
		});
		return re;
	}
	
	
	//发布活动
	function activActivity(id){
		var activityLabel = $("#activityLabel_"+id).val();
		if(activityLabel=='已结束'){
			alert("该活动已经结束,不能再发布");
			return;
		}
		//验证是否有绑定商品
		if(checkBindGoods(id)){
			alert("此活动未绑定任何商品,请先设置活动商品");
			return;
		}
		//验证是否有类似的活动
		if(checExist(id)){
			return ;
		}
		$.dialog({
			  lock: true,
			  padding: "5px",
			  title:false,
			  content:"确定发布该活动?",
			  fixed: false,
			  cancel: true,
			  cancelValue:"取  消",
			  ok:function(result){
				  if(changeActStat(_ctxPath+"/marketactivity/marketact-activActivity.htm",{"activity.id":id})){
					 alert("发布成功");
					 location.reload(true);
					 return true;
				  }
				  return false;
				 
			  },
			  okValue:"确   定"
			});
	}
	
	
	//删除活动
	function delActivity(id){
		$.dialog({
			lock:true,
			padding:"5px",
			title:false,
			content:"确定删除该活动?",
			fixed:false,
			cancel:true,
			cancelValue:"取 消",
			ok:function(result){
				if(changeActStat(_ctxPath+"/marketactivity/marketact-delActivity.htm",{"activity.id":id})){
					location.reload(true);
				}else{
					alert("删除失败");
				}
				return false;
			},
			okValue:"确 定"
		});
	}
	
	//发布中止
	function forbidActivity(id){
		$.dialog({
			  lock: true,
			  padding: "5px",
			  title:false,
			  content:"确定中止该活动?",
			  fixed: false,
			  cancel: true,
			  cancelValue:"取  消",
			  ok:function(result){
				  if(changeActStat(_ctxPath+"/marketactivity/marketact-forbidActivity.htm",{"activity.id":id})){
					 alert("中止成功");
					 location.reload(true);
					 return true;
				  }else{
					  alert("中止失败");
				  }
				  return false;
			  },
			  okValue:"确   定"
			});
	}
	
	
	function showActivityDetail(ids){
		var html = '';
		$.ajax({
			url: _ctxPath+"/marketactivity/marketact-viewDetail.htm",
			type:"POST",
			data:{"activity.id":ids},
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
				  fixed: false,
				  cancel: false,
				  ok:function(){
				  },
				  okValue:"确   定"
				});
			},
			error:function(data){
				  alert("访问失败");
			}
		});
	}
	
	
	//发布前判断活动是否有绑定商品
	function  checkBindGoods(id){
		 if(changeActStat(_ctxPath+"/marketactivity/marketact-checkBindGoods.htm",{"activity.id":id})){
			 return true;
		  }
	}
	
	
	
	//通用ajax处理
	function changeActStat(url,data){
		var re = false;
		$.ajax({
			url: url,
			type:"POST",
			data:data,
			dataType:"json",
			async: false,
			success:function(data){
				if(data.code == "true"){
					re =true;
				}
			},
			error:function(data){
				  alert("访问失败");
			}
		});
		return re;
	}
