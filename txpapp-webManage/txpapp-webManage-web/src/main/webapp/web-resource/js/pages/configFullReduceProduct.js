$(function() {
	// 选择事件
	$(".select-all-sku").on('click', function() {
		var $this = $(this);
		var $thisEm = $this.children("em");// checkbox
		// 全选
		if ($thisEm.hasClass("sel")) {
			setProductSkuIds();
			$(".select-sub-sku em.sel").removeClass("sel");
			$thisEm.removeClass("sel");
			
			 doFormSubmit(_ctxPath+'/fullReduction/fullReduction-removeAllProductInActivity.htm');
			 
		} else {
			//判断之前已经选择了哪些，防止重复添加
			setProductSkuIds();
			//子级
			$(".select-sub-sku em").addClass("sel");
			$thisEm.addClass("sel");
			doFormSubmit($("#addAllProductForm").attr('action'));
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
		$("#activityProductSkuId").val($thisEm.attr("productskuid"));
		if ($thisEm.hasClass("sel")) {
			$thisEm.removeClass("sel");
			$('.select-all-sku em').removeClass("sel");
			
			$("#hasSelectProductSkuIds").val($thisEm.attr("productskuid"));
			doFormSubmit(_ctxPath+'/fullReduction/fullReduction-removeAllProductInActivity.htm');
		} else {
			$thisEm.addClass("sel");
			doFormSubmit(_ctxPath+'/fullReduction/fullReduction-addProductToActivity.htm');
		}
	});
	// 修改活动价
	$(".activityPrice").on('focus',function() {
		var $this = $(this);
		var skuId = $this.attr("productskuid");
		if (!$("#select-sub-sku-"+skuId).hasClass("sel")) {
			$("#select-sub-sku-"+skuId).addClass("sel");
			$("#activityProductSkuId").val(skuId);
			doFormSubmit(_ctxPath+'/fullReduction/fullReduction-addProductToActivity.htm');
		}
	});
	$(".activityPrice").on('blur',function() {
		var $this = $(this);
		$("#activityProductSkuId").val($this.attr("productskuid"));
		doFormSubmit(_ctxPath+'/fullReduction/fullReduction-updateProductSettlementPrice.htm');
	});
	
	
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
		setProductSkuIds();
		doFormSubmit(_ctxPath+'/fullReduction/fullReduction-updateAllProductSettlementPrice.htm');
	});
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
		setProductSkuIds();
		doFormSubmit(_ctxPath+'/fullReduction/fullReduction-updateAllProductSettlementPrice.htm');
	});
	
	
	
});
