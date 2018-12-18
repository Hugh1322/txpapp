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
				if(changeActStat(_ctxPath+"/marketAct/marketact-delActivity.htm",{"activity.id":id})){
					location.reload(true);
				}else{
					alert("删除失败");
				}
				return false;
			},
			okValue:"确 定"
		});
	}
	
	function checExist(id){
		var re = false;
		var code = $("#code_"+id).val();
		var name = $("#name_"+id).val();
		var type =  $("#name_"+id).parent().find(".actType").val();
		var forAllProduct  = $("#forAllProduct_"+id).val();
		var activityScope  = $("#activityScope_"+id).val();
		var overrideFullCourt = $("#overrideFullCourt_"+id).val();
		var startTime = $("#startTime_"+id).val();
		var endTime = $("#endTime_"+id).val();
		$.ajax({
			url:_ctxPath+"/marketAct/marketact-checkExistActivity.htm",
			type:"POST",
			data:{"activity.code":code,
				"activity.name":name,
				'activity.type':type,
				'activity.forAllProduct':forAllProduct,
				'activity.overrideFullCourt':overrideFullCourt,
				'activity.activityScope':activityScope,
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
				}else{
					re=true;
				}
			},
			error:function(data){
				  alert("校验重复名称代码失败");
			}
		});
		return re;
	}
	
	
	/*买送发布时到后台验证重复性  */
	function checExistMaiSong(id){
		var re = false;
		var code = $("#code_"+id).val();
		var name = $("#name_"+id).val();
		var type =  $("#name_"+id).parent().find(".actType").val();
		var forAllProduct  = $("#forAllProduct_"+id).val();
		var activityScope  = $("#activityScope_"+id).val();
		$.ajax({
			url:_ctxPath+"/maiSong/marketact-checkExistActivityMaiSong.htm",
			type:"POST",
			data:{"activity.code":code,
				"activity.name":name,
				'activity.type':type,
				'activity.forAllProduct':forAllProduct,
				'activity.activityScope':activityScope
			},
			dataType:"json",
		    async:false,
			success:function(data){
				//alert(JSON.stringify(data));
				if(data.code =="false"){
					re=false;
				}else{
					re=true;
				}
			},
			error:function(data){
				  alert("校验重复名称代码失败");
			}
		});
		return re;
	}


	/*发布买送活动  */
	function activityMarketMaiSong(id,ctrlId){
		var activityLabel = $("#activityLabel_"+id).val();
		if(activityLabel=='已结束'){
			alert("该活动已经结束,不能再发布");
			return;
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
				  if(changeActStat(_ctxPath+"/maiSong/marketact-activActivityMaiSong.htm",{"activity.id":id})){
					 alert("发布成功");
					 location.reload(true);
					 return true;
				  }
				  return false;
				 
			  },
			  okValue:"确   定"
			});
		
	}
	
	//激活发布买减满减
	function activityMaiJian(id,ctrlId){
		var activityLabel = $("#activityLabel_"+id).val();
		if(activityLabel=='已结束'){
			alert("该活动已经结束,不能再发布");
			return;
		}
		if(checExistManJian(id)){
			alert("已发布类似活动!");
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
				  if(changeActStat(_ctxPath+"/marketAct/marketact-activActivity.htm",{"activity.id":id})){
					 alert("发布成功");
					 location.reload(true);
					 return true;
				  }
				  return false;
				 
			  },
			  okValue:"确   定"
			});
	}
	
	//发布前检验是否有重复的买减和满减活动
	function checExistManJian(id){
		var re = false;
		var code = $("#code_"+id).val();
		var name = $("#name_"+id).val();
		var type =  $("#name_"+id).parent().find(".actType").val();
		var forAllProduct  = $("#forAllProduct_"+id).val();
		var startTime = $("#startTime_"+id).val();
		var endTime = $("#endTime_"+id).val();
		$.ajax({
			url:_ctxPath+"/fullReduction/fullReduction-ifOtherManJian.htm",
			type:"POST",
			data:{"marketActivity.code":code,
				"marketActivity.name":name,
				"marketActivity.id":id,
				'marketActivity.type':type,
				'marketActivity.forAllProduct':forAllProduct,
				'marketActivity.startTime':startTime,
				'marketActivity.endTime':endTime
			},
			dataType:"json",
		    async:false,
			success:function(data){
				//alert(JSON.stringify(data));
				if(data.code =="false"){
					re=false;
				}else{
					re=true;
				}
			},
			error:function(data){
				  alert("校验重复名称代码失败");
			}
		});
		return re;
	}	
	
	
	//激活发布刷卡活动
	function activityMarketDiscount(id,ctrlId){
		var activityLabel = $("#activityLabel_"+id).val();
		if(activityLabel=='已结束'){
			alert("该活动已经结束,不能再发布");
			return;
		}
		if(checExistOtherMarket(id)){
			alert("已发布相同刷卡活动!");
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
				  if(changeActStat(_ctxPath+"/marketAct/marketact-activActivity.htm",{"activity.id":id})){
					 alert("发布成功");
					 location.reload(true);
					 return true;
				  }
				  return false;
				 
			  },
			  okValue:"确   定"
			});
	}
	//发布前检验是否有重复的刷卡活动
	function checExistOtherMarket(id){
		var re = false;
		var code = $("#code_"+id).val();
		var name = $("#name_"+id).val();
		var type =  $("#name_"+id).parent().find(".actType").val();
		var activityScope  = $("#activityScope_"+id).val();
		var startTime = $("#startTime_"+id).val();
		var endTime = $("#endTime_"+id).val();
		var forAllProduct  = $("#forAllProduct_"+id).val();
		var marketBank = $("#marketBank_"+id).val();
		$.ajax({
			url:_ctxPath+"/marketBank/marketact-checkPublishMarketBankActivity.htm",
			type:"POST",
			data:{"activity.code":code,
				"activity.name":name,
				'activity.type':type,
				'activity.id':id, 
				'activity.forAllProduct':forAllProduct,
				'activity.marketBank':marketBank, 
				'activity.activityScope':activityScope,
				'activity.startTime':startTime,
				'activity.endTime':endTime
			},
			dataType:"json",
		    async:false,
			success:function(data){
				//alert(JSON.stringify(data));
				if(data.code =="false"){
					re=false;
				}else{
					re=true;
				}
			},
			error:function(data){
				  alert("校验重复名称代码失败");
				  return;
			}
		});
		return re;
	}
	//发布包邮
		function activActivity(id,ctrlId){
			var activityLabel = $("#activityLabel_"+id).val();
			if(activityLabel=='已结束'){
				alert("该活动已经结束,不能再发布");
				return;
			}
			if(checExist(id)){
				alert("已发布类似包邮活动!");
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
					  if(changeActStat(_ctxPath+"/marketAct/marketact-activActivity.htm",{"activity.id":id})){
						 alert("发布成功");
						 location.reload(true);
						 return true;
					  }
					  return false;
					 
				  },
				  okValue:"确   定"
				});
		}
		function forbidActivity(id,ctrl){
			$.dialog({
				  lock: true,
				  padding: "5px",
				  title:false,
				  content:"确定中止该活动?",
				  fixed: false,
				  cancel: true,
				  cancelValue:"取  消",
				  ok:function(result){
					  if(changeActStat(_ctxPath+"/marketAct/marketact-forbidActivity.htm",{"activity.id":id})){
						 alert("中止成功");
						/* changStatusLabel("#"+ctrl,"发布","发布中止","javascript:activActivity("+id+",'"+ctrl+"')");
						 showEdit(false,ctrl);  */
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
		//作废
		function cancellationActivity(id){
			$.dialog({
				  lock: true,
				  padding: "5px",
				  title:false,
				  content:"确定作废该活动?",
				  fixed: false,
				  cancel: true,
				  cancelValue:"取  消",
				  ok:function(result){
					  if(changeActStat(_ctxPath+"/marketAct/marketact-cancellationActivity.htm",{"activity.id":id})){
						 alert("作废成功");
						 location.reload(true);
						 return true;
					  }else{
						  alert("作废失败");
					  }
					  return false;
				  },
				  okValue:"确   定"
				});
		}
		
		
		
		function changeActStat(url,data){
			var re = false;
			$.ajax({
				url: url,// + "/admin/adv/seasonal_toEditDetail.htm",
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
		
		
		function changStatusLabel(ctrl,html,label,toUrl){
			$(ctrl).html(html);
			$(ctrl).parent().parent().find(".statusLabel").html(label);
			$(ctrl).attr("href",toUrl);
		}
		
		function showEdit(isActive,ctrl){
			if(isActive ){
				 $("#"+ctrl).parent().find(".editActivity").hide();
			}else{
				 $("#"+ctrl).parent().find(".editActivity").show();
			} 
			
		}
		
		
		/*查看买送活动详情*/
		function showMarketMaiSongDetail(id){
			var html = '';
			$.ajax({
				url: _ctxPath+"/maiSong/marketact-viewMaiSongDetail.htm",
				type:"POST",
				data:{"activity.id":id},
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
		
		function showMarketBankDetail(ids,ruleId){
			
			var html = '';
			$.ajax({
				url: _ctxPath+"/marketBank/marketact-viewMarketBankDetail.htm",
				type:"POST",
				data:{"activity.id":ids,"activity.ruleId":ruleId},
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
		
		
		function showManJianDetail(ids,ruleId){
			
			var html = '';
			$.ajax({
				url: _ctxPath+"/maiJian/marketact-viewDetail.htm",
				type:"POST",
				data:{"activity.id":ids,"activity.ruleId":ruleId},
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
		
		
		
		
		function showDetail(ids,ruleId){
			
			var html = '';
			$.ajax({
				url: _ctxPath+"/marketAct/marketact-viewDetail.htm",
				type:"POST",
				data:{"activity.id":ids,"activity.ruleId":ruleId},
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
		function showPosageDetail(ids){
			var html = '';
			$.ajax({
				url: _ctxPath+"/marketAct/marketact-viewDetail.htm",// + "/admin/adv/seasonal_toEditDetail.htm",
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
		
