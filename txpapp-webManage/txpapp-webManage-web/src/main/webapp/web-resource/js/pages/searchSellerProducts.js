/**
 * 卖家商品列表页面js
 */
$(function(){
	
	// 商品导出
	$("#exportProduct").bind("click", function() {
		var keywords = $(".J-keywords").val();
		if(keywords == $(".J-keywords").attr("data-default")){
			$(".J-keywords").val("");
		}
		$("#subform").attr("action", _ctxPath + "/seller/product/product-exportProductsByConditions.htm");
		$("#subform").submit();
		$("#subform").attr("action", _ctxPath + "/seller/product/product-searchSellerProducts.htm");
	});	
	
	$("#search").click(function(){
		var keywords = $(".J-keywords").val();
		if(keywords == $(".J-keywords").attr("data-default")){
			$(".J-keywords").val("");
		}
		$(".sub-form").submit();
	});
	//添加商品
	$("#addProduct").click(function(){
		window.location.href = _ctxPath + "/seller/product/product-addProduct.htm";
	});
	//添加团购商品
	$("#addGroupProduct").click(function(){
		window.location.href = _ctxPath + "/seller/product/product-addGroupProduct.htm";
	});
	
	// 样品已发送
	$(".sampleSent").click(function() {
		var productId = $(this).closest("tr").attr("productId");
		$.ajax({
			type:'POST',
			url: _ctxPath + '/seller/product/product-confirmSampleSent.htm',
			data: "product.productId="+productId,
			success:function(msg){
				if(msg.info == "true"){
					$.dialog({
			            title: false,
			            content: "确认成功",
			            time : 2000
			        });	
				}
				$("#search").click();
			},
			error: function(xhr){
				popupDialog(xhr.responseText);
	        }
		});
	});
	
	//提交审核
	$(".review").click(function(){
		var productId = $(this).closest("tr").attr("productId");
		 $.dialog({
	            title: false,
	            lock: true,
	            content: "请确认提交审核？",
	            okValue: "确认",
	            ok: function(){
	    			$.ajax({
	        			type:'POST',
	        			url: _ctxPath + '/seller/product/product-doApproved.htm',
	        			data: "product.productId="+productId,
	        			success:function(msg){
	        				if(msg.info == "true"){
	        					$.dialog({
	    				            title: false,
	    				            content: "已提交审核",
	    				            time : 2000
	    				        });	
	        				}
	        				$("#search").click();
	        			},
	        			error: function(xhr){
	        				popupDialog(xhr.responseText);
	        	        }
	        		});
	            },
	            cancelValue: "取消",
	            cancel: true
	     });
		 $(".d-close").hide();
	});
	
	
	//商户请求下架
	$(".delete").click(function(){

		var dialog = $.dialog({
		    lock: true,
		    title:false,
		    okValue: "确认",
            ok: function(){
    			$.ajax({
        			type:'POST',
        			url: _ctxPath + '/seller/product/product-waitingForOffMarket.htm',
        			data: "product.productId="+productId,
        			success:function(msg){
        				if(msg.info == "true"){
        					$.dialog({
    				            title: false,
    				            content: "已提交审核",
    				            time : 2000
    				        });	
        				}
        				$("#search").click();
        			},
        			error: function(xhr){
        				popupDialog(xhr.responseText);
        	        }
        		});
            },
		    cancelValue:"取消",
		    cancel: function(){
		    },
		    visible: false
	  });		
		
		var productId = $(this).closest("tr").attr("productId");
		
		  $.ajax({
				type:'POST',
				url: _ctxPath + '/seller/product/product-showOffmarketReasonPage.htm',
				data: "product.productId=" + productId,
				success:function(html){
					dialog.visible().content(html);
				},
				error: function(xhr){
					popupDialog(xhr.responseText);
			    }
		});
		$(".d-close").hide();		
	});
	
	//编辑
	$(".edit").click(function(){
		var productId = $(this).closest("tr").attr("productId");
		window.location.href = _ctxPath + "/seller/product/product-edit.htm?product.productId="+productId;
	});

	
	//审核不通过愿意
	$(".shenhe").on({
		mouseenter:function(){
			$(this).css("z-index","1");
			$(this).find(".not-through").show();
		},
		mouseleave:function(){
			$(this).css("z-index","0");
			$(this).find(".not-through").hide();
		}
	});
	
	//>>>>>>>>>>>>分期送商品>>>>>>>>>>>>>>>>>>>
	//添加分期送商品
	$("#addProductSku").click(function(){
		window.location.href = _ctxPath + "/seller/product/buySchedule-addProductSku.htm";
	});
	//编辑分期送商品
	$(".editBuySchedule").click(function(){
		var productId = $(this).closest("tr").attr("productId");
		window.location.href = _ctxPath + "/seller/product/buySchedule-editProductSku.htm?product.productId="+productId;
	});
	//<<<<<<<<<<<分期送商品<<<<<<<<<<<<<<<<<<<<
});