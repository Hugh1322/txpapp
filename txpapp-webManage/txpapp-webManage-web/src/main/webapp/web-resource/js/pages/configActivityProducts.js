$(function() {
	var $allSelect = $(".select-sub-sku em.sel");
	var selectLength = $allSelect.length;
	//alert(_skuList.length+"=="+selectLength)
	if(selectLength==_skuList.length){
		$("input[name='allChecks']").attr("checked","checked");
	}
	
	// 选择事件
	$(".select-all-sku").on('click', function() {
		var $this = $(this);
		var $thisEm = $this.children("em");// checkbox
		// 全选
		if ($thisEm.hasClass("sel")) {
			setProductSkuIds();
			$(".select-sub-sku em.sel").removeClass("sel");
			$thisEm.removeClass("sel");
			doFormSubmit(_ctxPath+'/marketactivity/marketact-removeAllProductInActivity.htm');
		} else {
			//判断之前已经选择了哪些，防止重复添加
			setProductSkuIds();
			//子级
			$(".select-sub-sku em").addClass("sel");
			$thisEm.addClass("sel");
			doFormSubmit($("#addAllProductForm").attr('action'));
		}
	});
	
	
	//全选判断是否有不可选的商品skuId
	$("input[name='allChecks']").click(function(){
		var $thisEm = $(this).children("em");
		var startTime = $("#activityProductStartTime_"+$thisEm.attr("productskuid"));
		var endTime = $("#activityProductEndTime_"+$thisEm.attr("productskuid"));
		var  activityId = activityId2;
		if($(this).is(":checked")){//全选中
			//判断之前已经选择了哪些，防止重复添加
			var $allSelect = $(".select-sub-sku em");
			var ids2='';
			if(typeof($allSelect)=='object'){
				if($allSelect.length>0){
					$allSelect.each(function(index,ele) {
						ids2 = $(this).attr("productskuid");
						if(checkRepeatSkuId(activityId,ids2,startTime,endTime)){
							alert("部分商品存在于其它同一活动时间发布的活动中");
							$("input[name='allChecks']").removeAttr("checked"); 
							return false;
						}
						//子级
						if(!$(".select-sub-sku em").hasClass("sel")){
							$(".select-sub-sku em").addClass("sel");
							$thisEm.addClass("sel");
							doFormSubmit($("#addAllProductForm").attr('action'));
						}
					});
					}
				}
		}else {
			//没有全选中
			setProductSkuIds();
			$(".select-sub-sku em.sel").removeClass("sel");
			$thisEm.removeClass("sel");
			doFormSubmit(_ctxPath+'/marketactivity/marketact-removeAllProductInActivity.htm');
		}
	});
	
	var doFormSubmit = function(action){
		var form = $("#addAllProductForm");
		 $.ajax({
				type: 'POST',
				url: action,
				data: form.serialize(),
				success: function(data){
					//alert(data.info);
			    },
				dataType:'json'
			});
	}
	
	var setProductSkuIds = function(){
		var $hasSelect = $(".select-sub-sku em.sel");
		var ids = '';
		if($hasSelect.length>0){
			$hasSelect.each(function(index,ele) {
				if(index>0){
					ids += ",";
				}
				ids += $(this).attr("productskuid");
			});
		}
		$("#hasSelectProductSkuIds").val(ids);
	}
	
	
	// 点选子集
	$(".select-sub-sku").on('click',function() {
		var $this = $(this);
		var $thisEm = $this.children("em");// checkbox
		var startTime = $("#activityProductStartTime_"+$thisEm.attr("productskuid"));
		var endTime = $("#activityProductEndTime_"+$thisEm.attr("productskuid"));
		var  activityId = activityId2;
		var productSkuId2 = $thisEm.attr("productskuid");
		/*console.log(startTime.val()+"===="+endTime.val()+"===="+productSkuId2+"======="+activityId);*/
		$("#activityProductSkuId").val($thisEm.attr("productskuid"));
		if ($thisEm.hasClass("sel")) {
			$thisEm.removeClass("sel");
			$('.select-all-sku em').removeClass("sel");
			$("#hasSelectProductSkuIds").val($thisEm.attr("productskuid"));
			$("input[name='allChecks']").removeAttr("checked");
			doFormSubmit(_ctxPath+'/marketactivity/marketact-removeAllProductInActivity.htm');
		} else {
			if(checkRepeatSkuId(activityId,productSkuId2,startTime,endTime)){
				alert("此商品已存在其它同一活动时间发布的活动中");
				return;
			}
			var $allSelect = $(".select-sub-sku");
			var selectLength = $allSelect.length;
			//子集全选中后,全选按钮要选中
			var pageLength = 19;
			var $allSelect2 = $(".select-sub-sku em.sel").length;
			if($allSelect2 == pageLength){
				$("input[name='allChecks']").attr("checked","checked");
			}
			$thisEm.addClass("sel");
			doFormSubmit(_ctxPath+'/marketactivity/marketact-addProductToActivity.htm');
		}
	});
	// 修改活动价
	$(".activityPrice,.startTime_edit,.endTime_edit").on('focus',function() {
		var $this = $(this);
		var skuId = $this.attr("productskuid");
		if (!$("#select-sub-sku-"+skuId).hasClass("sel")) {
			$("#select-sub-sku-"+skuId).addClass("sel");
			$("#activityProductSkuId").val(skuId);
			doFormSubmit(_ctxPath+'/marketactivity/marketact-addProductToActivity.htm');
		}
	});
	
	
	function checkRepeatSkuId(activityId,productSkuId2,startTime,endTime){
		//用来判断是否重复
		var re = false;
		$.ajax({
			url:_ctxPath+"/marketactivity/marketact-checkExistSku.htm",
			type:"POST",
			data:{
				"marketActivityProduct.activityId":activityId,
				"marketActivityProduct.productSkuId":productSkuId2,
				"marketActivityProduct.startTime":startTime.val(),
				"marketActivityProduct.endTime":endTime.val()
			},
			dataType:"json",
		    async:false,
			success:function(data){
				//alert(JSON.stringify(data));
				if(data.code =="false"){
					re=false;
				}else if(data.code =="true"){
					re=true;
				}
			},
			error:function(data){
				  alert("校验重复失败");
			}
		});
		return re;
		
		
	}
	
	
	//批量设置结算价折扣
	$("#activity_discount_but").on('click',function() {
		var $this = $(this);
		var discount = $('.activity_discount_set').val();
		if(discount==''){
			alert('请输入折扣比例！');
			return;
		}
		if(isNaN(discount)){
			alert('请输入数字');
			return;
		}
		if($("td .sel").length == 0){
			alert("请勾选商品！");
			return;
		}
		$("td .sel").each(function() {
			var productskuid = $(this).attr('productskuid');
			$("#actSettleDiscount_"+productskuid).val(discount);
			var unitPrice = $("#unitPrice_"+productskuid).val();
			$("#actSettlePrice_"+$(this).attr('productskuid')).val(parseFloat(discount)*unitPrice);
		});
		setProductSkuIds();//获取选中的skuIds
		var form = $("#addAllProductForm");
		 $.ajax({
				type: 'POST',
				url: _ctxPath+'/marketactivity/marketact-updateMarketProductInfo.htm',
				data: form.serialize(),
				success: function(data){
					if(data.code=='true'){
						alert("修改成功")
					}else if(data.code=='false'){
						alert("修改失败")
					}
			    },
				dataType:'json'
			});
	});
	
	
	//批量设置活动时间
	$("#activityTime_but").on('click',function(){
		var startTimeVal = $("#setStartTime").val();
		var endTiemVal = $("#setEndTime").val();
		if(startTimeVal ==""){
			alert("请选择开始时间");
			return;
		}
		if(endTiemVal ==""){
			alert("请选择结束时间");
			return;
		}
		if($("td .sel").length ==0){
			alert("请勾选要设置时间的活动商品！");
			return;
		}
		$("td .sel").each(function(){
			var productskuid = $(this).attr('productskuid');
			$("#activityProductStartTime_"+productskuid).val(startTimeVal);
			$("#activityProductEndTime_"+productskuid).val(endTiemVal);
		});
		setProductSkuIds();//获取选中的skuIds
		var form = $("#addAllProductForm");
		 $.ajax({
				type: 'POST',
				url: _ctxPath+'/marketactivity/marketact-updateActivityInfo.htm',
				data: form.serialize(),
				success: function(data){
					if(data.code=='true'){
						alert("修改成功")
					}else if(data.code=='false'){
						alert("修改失败")
					}
			    },
				dataType:'json'
			});
		
	});
	
	
	//批量设置活动价(一品价倍数)
	$("#activityPrice_but").on('click',function() {
		var $this = $(this);
		var discount = $('.activityPrice_set').val();
		if(discount==''){
			alert('请输入比例！');
			return;
		}
		if(isNaN(discount)){
			alert('请输入数字');
			return;
		}
		if($("td .sel").length == 0){
			alert("请勾选商品！");
			return;
		}
		$("td .sel").each(function() {
			var productskuid = $(this).attr('productskuid');
			var unitPrice = $("#unitPrice_"+productskuid).val();
			$("#activityPrice_"+$(this).attr('productskuid')).val(parseFloat(discount)*unitPrice);
		});
		setProductSkuIds();//获取选中的skuIds
		var form = $("#addAllProductForm");
		 $.ajax({
				type: 'POST',
				url: _ctxPath+'/marketactivity/marketact-updateMarketProductInfo.htm',
				data: form.serialize(),
				success: function(data){
					if(data.code=='true'){
						alert("修改成功")
					}else if(data.code=='false'){
						alert("修改失败")
					}
			    },
				dataType:'json'
			});
	});
	
	//保存修改信息
	$("#updateMarketProduct").on('click',function() {
			if($("td .sel").length ==0){
				alert("请勾选要保存的活动商品！");
				return;
			}
			setProductSkuIds();
			var form = $("#addAllProductForm");
			 $.ajax({
					type: 'POST',
					url: _ctxPath+'/marketactivity/marketact-updateMarketProductInfo.htm',
					data: form.serialize(),
					success: function(data){
						if(data.code=='true'){
							alert("修改成功")
						}else if(data.code=='false'){
							alert("修改失败")
						}
				    },
					dataType:'json'
				});
		});
	
	
	//配置活动页面保存修改信息
	$("#updateActivityInfo").on('click',function() {
			if($("td .sel").length ==0){
				alert("请勾选要保存的活动商品！");
				return;
			}
			var linkModels = $("input[name='activity.activityLinkMode']:checked").val();
			if(linkModels=='1'){
				var inputLink = $("input[name='activity.activityLink']").val();
				if(inputLink ==''){
					alert('请输入活动链接');
					$("input[name='activity.activityLink']").focus();
					return;
				}
				
			}
			setProductSkuIds();
			var form = $("#addAllProductForm");
			 $.ajax({
					type: 'POST',
					url: _ctxPath+'/marketactivity/marketact-updateMarketProductInfo.htm',
					data: form.serialize(),
					success: function(data){
						if(data.code=='true'){
							alert("保存成功!")
						}else if(data.code=='false'){
							alert("保存失败!")
						}
				    },
					dataType:'json'
				});
		});	
	
	
	
	//选择全场商品
	$("#allProductSku").on('click',function() {
		//设置全场商品时判断是否有冲突的skuId
		var startTime = ActivityStartTime;
		var endTime = ActivityEndTime;
		var  activityId = activityId2;
		if(checkRepeatSkuIdForAllProduct(activityId,startTime,endTime)){
			alert("同一时间发布的活动中存在冲突的skuId");
			return;
		}
		
		var from = $("#addForm");
		var regionurl = from.attr('action');
		from.attr({'action':_ctxPath+'/marketactivity/marketact-addAllSearchProductToActivity.htm'});
		from.submit();
		from.attr({'action':regionurl});

	});
	
	//设置全场商品时判断是否有冲突的skuId
	function checkRepeatSkuIdForAllProduct(activityId,startTime,endTime){
		//用来判断是否重复
		var re = false;
		$.ajax({
			url:_ctxPath+"/marketactivity/marketact-checkExistSku.htm",
			type:"POST",
			data:{
				"marketActivityProduct.activityId":activityId,
				"marketActivityProduct.startTime":startTime,
				"marketActivityProduct.endTime":endTime
			},
			dataType:"json",
		    async:false,
			success:function(data){
				if(data.code =="false"){
					re=false;
				}else if(data.code =="true"){
					re=true;
				}
			},
			error:function(data){
				  alert("校验重复失败");
			}
		});
		return re;
		
		
	}
	
	
	//取消所选的商品
	$("#cancelAllProductSku").on('click',function(){
		if($("td .sel").length ==0){
			alert("请勾选要取消的活动商品！");
			return;
		}
		var from = $("#addForm");
		var regionurl = from.attr('action');
		from.attr({'action':_ctxPath+'/marketactivity/marketact-cancelAllActivityProduct.htm'});
		from.submit();
		from.attr({'action':regionurl});
	});
	
	
});




	//检查商品活动库存和原库存
	function checkProductInventory(n){
		var productInventory = $("#activityProductInventory_"+n).val();
		var inventory = $("#inventory_"+n).val();
		var productLimitBuy = $("#activityProductLimitBuy_"+n).val();
		if(productInventory==""){
			alert("活动商品库存不能为空");
			return;
		}
		if(productLimitBuy==""){
			alert("活动商品限购件数不能为空");
			return;
		}
		if(isNaN(productInventory)||productInventory*1<1){
			alert("请输入有效的活动商品库存");
			$("#activityProductInventory_"+n).attr("value","");
			return;
		}
		if(productInventory*1>inventory*1){
			alert("活动商品库存不能大于原库存");
			$("#activityProductInventory_"+n).attr("value","");
			return;
		}
		if(productLimitBuy*1>productInventory*1){
			alert("活动库存不能小于限购数量");
			$("#activityProductLimitBuy_"+n).attr("value","");
			return;
		}
		
	}

	//检查限购数量不能大于活动库存
	function checkProductLimitBuy(n){
		var productInventory = $("#activityProductInventory_"+n).val();
		var productLimitBuy = $("#activityProductLimitBuy_"+n).val();
		if(checkProductLimitBuy==''){
			alert("活动商品限购件数不能为空");
			return;
		}
		if(productInventory == ''){
			alert("请先设置活动商品库存");
			$("#activityProductLimitBuy_"+n).attr("value","");
			return;
		}
		if(isNaN(productInventory)||productInventory*1<1){
			alert("请输入有效的活动商品库存");
			$("#activityProductLimitBuy_"+n).attr("value","");
			return;
		}
		if(isNaN(productLimitBuy)||productLimitBuy*1<0){
			alert("请输入有效的活动商品限购件数");
			$("#activityProductLimitBuy_"+n).attr("value","0");
			return;
		}
		if(productLimitBuy*1>productInventory*1){
			alert("限购数量不能大于活动库存");
			$("#activityProductLimitBuy_"+n).attr("value","");
			return;
		}
	}
	
	/**
	 * 单个编辑已选活动商品
	 * @param ids
	 */
	function editActivityProductSku(productSkuId,activityId){
		/*alert(productSkuId+"==="+activityId);*/
		$.ajax({
			url: _ctxPath+"/marketactivity/marketact-toEditActivityProduct.htm",
			type:"POST",
			data:{"marketActivityProduct.productSkuId":productSkuId,"activity.id":activityId},
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
				  cancel: true,
				  cancelValue:"取  消",
				  ok:function(){
		/*			  if(){
						  
					  }*/
					  $.ajax({
							type : 'POST',
							url :  _ctxPath+"/marketactivity/marketact-updateSingleActivity.htm",
							data : $("#editActivityFrom").serialize(),
							success : function(data) {
									if((data!=null) && (data.code==true)){
										$(this).dialog("close");
									}else if((data !=null) && (data.code==false)){
										alert("修改出现异常");
									}
									window.location.reload();
								},
								error:function(e,i){
									alert("错误:"+i);
								}
							});
				  },
				  okValue:"确认修改"
				});
			},
			error:function(data){
				  alert("修改失败.");
			  },
		});
		
	}
	
	
	
	