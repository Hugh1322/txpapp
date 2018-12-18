var $tr_productSku,$td_color,$td_size;
var $input_productSkuId,$input_color,$input_size,$input_color_override,$input_size_override;
var data = new Array();
var tablenum = 1;
var shfz = false;
var submitStatus = true;
//ckeditor操作
CKEDITOR.on('dialogDefinition', function( ev ){
    var dialogName = ev.data.name;
    var dialogDefinition = ev.data.definition;
    if ( dialogName == 'image' ){
        var infoTab = dialogDefinition.getContents('info');
        infoTab.add({
            type : 'button',
            id : 'upload_image',
            align : 'center',
            label : '添加图片',
            onClick : function( evt ){
                var thisDialog = this.getDialog();
                var txtUrlObj = thisDialog.getContentElement('info', 'txtUrl');
                var txtUrlId = txtUrlObj.getInputElement().$.id;
                addUploadImage(txtUrlId);
            }
        },"txtAlt");
    }
});
function changeTimeStatus(value){
	if(value == '2'){
		$('#time').attr('style','display:');
		sellType = '2';
	}else{
		$('#time').attr('style','display:none');
		sellType = value;
		$('#perDeliveryTime').val('');
	}
}


function addUploadImage(theURLElementId){
    var uploadUrl = _ctxPath + "/upload/image-upload.htm";
    var imgUrl = window.showModalDialog(uploadUrl,'title',
			'resizable=no;help=no;status=no;dialogWidth=400px;dialogHeight=300px'); 
    var urlObj = document.getElementById(theURLElementId);
    if(imgUrl){
	    urlObj.value = imgUrl;
	    onchangeFun(urlObj);
    }
}
function onchangeFun(obj){
	if (document.all) {
		obj.fireEvent("onchange");
	} else {
		var evt = document.createEvent('HTMLEvents');
		evt.initEvent('change', true, true);
		obj.dispatchEvent(evt);
	} 
}
function skuValid(){
	var b = true;
	$.each($(".weight"),function(index,data){
		if(b == false ) return b;
	    if($.trim(data.value) == ""){
	    	alert("请输入商品重量");
	    	b = false;
	    }
	});
	$.each($(".inventory"),function(index,data){
		if(b == false ) return b;
	    if($.trim(data.value) == ""){
	    	alert("请输入库存数");
	    	b = false;
	    }
	});
	$.each($(".skuCode"),function(index,data){
		if(b == false ) return b;
	    if($.trim(data.value) == ""){
	    	alert("请输入商品标识");
	    	b = false;
	    }
	});
	$.each($(".unitPrice"),function(index,data){
		if(b == false ) return b;
		
	    if($.trim(data.value) == ""){
	    	alert("请输入商品售卖价格");
	    	b = false;
	    } 
	});
	$.each($(".marketPrice"),function(index,data){
		if(b == false ) return b;
	    if($.trim(data.value) == ""){
	    	alert("请输入商品原价");
	    	b = false;
	    }
	});
	$.each($(".settlementPrice"),function(index,data){
		if(b == false ) return b;
	    if($.trim(data.value) == ""){
	    	alert("请输入结算价");
	    	b = false;
	    }
	});
	$.each($('.repertories tr'),function(index,dom){
		if(b == false ) return b;
	    if(index != 0){
	        var unitPrice = $(dom).find('.unitPrice').val();
	        var marketPrice = $(dom).find('.marketPrice').val();
	        var settlementPrice = $(dom).find('.settlementPrice').val();
	        
	        b = Number(unitPrice) <= Number(marketPrice);
	        if(b == false){
	        	alert('售卖价格不能大于商品原价');
	        	return b;
	        }
	    }
	})
	return b;
}
$(document).ready(function(){
	//验证配置项
	$.formValidator.initConfig({
		validatorGroup: '1',
		formID: 'addForm',
		theme: 'Default',
		errorFocus: false
	});

	$(".xs").on("click",function(){
		 var radioVal = $(this).val();
		 if(radioVal == "3"){
			 $("#qgNum").show();
			 // 下面校验请前端修改下，只能输入数字，长度99以内	 
		 }else{
			 $("#qgNum").hide();
		 }
		 if(radioVal=='2'){
			 $("#time").show();
		 }else{
			 $("#time").hide();
		 }
	});
	
	//保存按扭操作
	$("#save").click(function(){
		//控件只读属性解禁
		document.getElementById("province").disabled=false;
		document.getElementById("city").disabled=false;
		document.getElementById("bigcatalog").disabled=false;
		document.getElementById("smallcatalog").disabled=false;
		document.getElementById("brandId").disabled=false;
		document.getElementById("name").disabled=false;
		document.getElementById("description").disabled=false;
		
		
		var resultFlag = false;
		$("#city").formValidator({onShow:"请选择所在地区",onFocus:"请选择所在地区",onCorrect:"谢谢你的配合"}).inputValidator({min:1,onError: "请选择所在地区"});
		$("#smallcatalog").formValidator({onShow:"请选择分类",onFocus:"请选择分类",onCorrect:"谢谢你的配合"}).inputValidator({min:1,onError: "请选择分类"});
		if((sellType == '' || sellType == '2') && $("#perDeliveryTime").val() == ""){
			$("#perDeliveryTime").formValidator({onShow:"请选择时间",onFocus:"请选择时间",onCorrect:"谢谢你的配合"}).inputValidator({min:1,onError: "请选择时间"});
		}
		if(sellType == '3'){
			//抢购数量
			var rushQuantity = $("#rushQuantity").val();
			 if(parseInt(rushQuantity)>99){
				 resultFlag = true;
			 }			
			 $('.inventory').each(function(){
				 if(parseInt($(this).val())< parseInt(rushQuantity)){
					 $.dialog({
						 title: false,
						 content: '抢购数量不能大于库存数量',
						 time: 1500
					 });
					 resultFlag = true;
				 }
			 });
		}
		
		var checkFlag = false;
		
		$('.input-checkbox').each(function(){
			 if(this.checked){
				 checkFlag = true;
			 }
		 });
		
		if(!checkFlag){
			$.dialog({
				 title: false,
				 content: '请选择规格',
				 time: 1500
			 });
			return ;
		}
		var len = $('.default-img').find('img').length;
		if(!len){
			$.dialog({
				title: false,
				content: '<span style="color:#f63c30">请选择图片</span>',
				time: 3000
			});
			$('.d-close').remove();
			return;
		}
		var result = $.formValidator.pageIsValid('1');
		var valid = skuValid();
		if(!result || resultFlag) return;
		if(valid == false || submitStatus == false) return;
		var $this = $(this);
		submitStatus = false
		//$("#status").val(STATUS_DRAFT);
		handleFormData();
		var weightData = "";
		$.each($('.repertories').find(".weight"),function(index,data){
			weightData += "&product.productSkus["+index+"].skuWeight="+data.value
		}) 
		$.ajax({
			type:'POST',
			url: _ctxPath + '/admin/online_product/productMgr-saveOnlineProduct.htm',
			data:$("#addForm").serialize()+weightData,
			success:function(msg){
				if(msg.code == "true"){
					$("#message").text("保存成功");
					$(".tip-main").show();
					setTimeout("window.location.replace(_ctxPath + '/admin/online_product/productMgr-allProducts.htm')", 2000);
				}else if(msg.code == "false"){
					submitStatus = true;
					popupDialog(msg.info);
				}
			},
			error: function(xhr){
				submitStatus = true;
				popupDialog(xhr.responseText);
	        }
		});
		submitStatus = true;
	});
	$(function(){
		var province,city,big,small,nation,firstcatalog
//		var people='';
		if(productProp != ''){
			productProp = $.parseJSON(productProp);
			nation = productProp.area[0].nation;
			province = productProp.area[0].province;
			city = productProp.area[0].city;
			firstcatalog = productProp.catalog[0].firstcatalog;
			big = productProp.catalog[0].big;
			small = productProp.catalog[0].small;
//			people = productProp.adaptPeople[0].people;
			$('#city').fillselect(_ctxPath +'/admin/product/product-getPropInfoMsg.htm', {
				'dataMap': {'value': 'propId', 'text': 'name'}, 
		        'params': {'selectKey': province}
		    });
			$('#smallcatalog').fillselect(_ctxPath +'/admin/product/product-getPropInfoMsg.htm', {
				'dataMap': {'value': 'propId', 'text': 'name'}, 
		        'params': {'selectKey': big}
		    });
		}
		//回显/加载国家
		$('#nation').fillselect(_ctxPath +'/admin/product/product-getPropInfoMsg.htm', {
			'dataMap': {'value': 'propId', 'text': 'name'}, 
	        'preValue': -1,
	        'preText': '选择国家',
	        'params': {'selectKey': bigPlace},
	        'defaultValue': nation || -1
	    });
		//回显/加载
		$('#nation').chainselect('#province', _ctxPath +'/admin/product/product-getPropInfoMsg.htm', {
            'dataMap': {'value': 'propId', 'text': 'name'}, 
            'preValue': -1,
            'preText': '选择省份',
            'defaultValue': province || -1
        });
		//回显/加载一级区域
		$('#province').fillselect(_ctxPath +'/admin/product/product-getPropInfoMsg.htm', {
			'dataMap': {'value': 'propId', 'text': 'name'}, 
	        'preValue': -1,
	        'preText': '选择省份',
	        'params': {'selectKey': nation},
	        'defaultValue': province || -1
	    });
		//回显/加载二级区域
		$('#province').chainselect('#city', _ctxPath +'/admin/product/product-getPropInfoMsg.htm', {
            'dataMap': {'value': 'propId', 'text': 'name'}, 
            'preValue': -1,
            'preText': '选择城市',
            'defaultValue': city || -1
        });
		//-------------------------------类目-----------------------
		//回显/加载类目
		$('#firstcatalog').fillselect(_ctxPath +'/admin/product/product-getPropInfoMsg.htm', {
			'dataMap': {'value': 'propId', 'text': 'name'}, 
	        'preValue': -1,
	        'preText': '选择类目',
	        'params': {'selectKey': firstKind},
	        'defaultValue': firstcatalog || -1
	    });
		//回显/加载
		$('#firstcatalog').chainselect('#bigcatalog', _ctxPath +'/admin/product/product-getPropInfoMsg.htm', {
            'dataMap': {'value': 'propId', 'text': 'name'}, 
            'preValue': -1,
            'preText': '选择大分类',
            'defaultValue': big || -1
        });
		$('#bigcatalog').fillselect(_ctxPath +'/admin/product/product-getPropInfoMsg.htm', {
			'dataMap': {'value': 'propId', 'text': 'name'}, 
	        'preValue': -1,
	        'preText': '选择大分类',
	        'params': {'selectKey': firstcatalog},
	        'defaultValue': big || -1
	    });
		$('#bigcatalog').chainselect('#smallcatalog', _ctxPath +'/admin/product/product-getPropInfoMsg.htm', {
            'dataMap': {'value': 'propId', 'text': 'name'}, 
            'preValue': -1,
            'preText': '选择小分类',
            'defaultValue': small || -1
        });
//		var data = {'selectKey': code_people,'level': '1'}
//		$.post('product-getPropMsg.htm',data,function(item){
//			 var value = eval("("+item.info+")");
//			 var str = "";
//			 if(value.status == '200') {
//            	 for(var i=0;i<value.data.length;i++){
//            		 var people1 = people.split(",");
//            		 var checked = false;
//            		 for(var j=0;j<people1.length;j++){
//            			 if($.trim(people1[j]) == value.data[i].propId){
//            				 checked = true;
//            			 }
//            		 }
//            		 if(checked){
//            			 str += "<input type='checkbox' class='adaptPeople' name='adaptPeople' checked='checked' value='"+value.data[i].propId+"'>"+value.data[i].name;
//            		 }else{
//            			 str += "<input type='checkbox' class='adaptPeople' name='adaptPeople'  value='"+value.data[i].propId+"'>"+value.data[i].name;
//            		 }
//            		 
//            	 }
//             }
//            $('#people').html(str);
//		});
	});
	//提交审核按扭操作
	$("#submitReview").click(function(){
		$("#city").formValidator({onShow:"请选择所在地区",onFocus:"请选择所在地区",onCorrect:"谢谢你的配合"}).inputValidator({min:1,onError: "请选择所在地区"});
		$("#smallcatalog").formValidator({onShow:"请选择分类",onFocus:"请选择分类",onCorrect:"谢谢你的配合"}).inputValidator({min:1,onError: "请选择分类"});
		if((sellType == '' || sellType == '2') && $("#perDeliveryTime").val() == ""){
			$("#perDeliveryTime").formValidator({onShow:"请选择时间",onFocus:"请选择时间",onCorrect:"谢谢你的配合"}).inputValidator({min:1,onError: "请选择时间"});
		}
		var resultFlag = false;
		if(sellType == '3'){
			//抢购数量
			var rushQuantity = $("#rushQuantity").val();
			 if(parseInt(rushQuantity)>99){
				 resultFlag = true;
			 }
			 $('.inventory').each(function(){
				 if(parseInt($(this).val())< parseInt(rushQuantity)){
					 $.dialog({
						 title: false,
						 content: '抢购数量不能大于库存数量',
						 time: 1500
					 });
					 resultFlag = true;
				 }
			 });
		}		
		var checkFlag = false;
		$('.input-checkbox').each(function(){
			 if(this.checked){
				 checkFlag = true;
			 }
		 });
		if(!checkFlag){
			$.dialog({
				 title: false,
				 content: '请选择规格',
				 time: 1500
			 });
			return ;
		}
		var result = $.formValidator.pageIsValid('1');
		var valid = skuValid();
		if(!result || resultFlag) return;
		if(valid == false || submitStatus == false) return;
		var $this = $(this);
		submitStatus = false
		$("#status").val(STATUS_CHECK_PEND);
		var weightData = "";
		$.each($('.repertories').find(".weight"),function(index,data){
			weightData += "&product.productSkus["+index+"].skuWeight="+data.value
		}) 
		handleFormData();
		$.ajax({
			type:'POST',
			url: _ctxPath + '/seller/product/product-submitReview.htm',
			data: $("#addForm").serialize()+weightData,
			success:function(msg){
				if(msg.info == "true"){
					$("#productId").val(msg.infoValues[1]);
					$("#message").text(msg.infoValues[0]);
					$(".tip-main").show();
					if(shfz){
						$("#addForm").attr("action", _ctxPath + "/seller/product/product-submitReviewAndCopy.htm");
						$("#addForm").submit();
						shfz = false;
					}
					//3秒钟后跳转到商品列表页面
					setTimeout("window.location.replace(_ctxPath + '/seller/product/product-searchSellerProducts.htm')", 3000);							
				}else if(msg.code == "false"){
					submitStatus = true;
					popupDialog(msg.info);
				}
			},
			error: function(xhr){
				popupDialog(xhr.responseText);
				submitStatus = true;
	        }
		});
		
	});
	
	//预览按扭操作
	$("#preview").click(function(){
		var result = $.formValidator.pageIsValid('1');
		if(!result){
			return;
		}
		handleFormData();
		$("#addForm").attr("action", _ctxPath + "/seller/product/product-preview.htm");
		$("#addForm").submit();
	});
	
	//提交审核并复制操作
	$("#submitReviewAndCopy").click(function(){
		shfz = true
		$("#submitReview").click();
		
	});
	
	//新增关键字
	/*$("#newKeyWord").click(function(){
		var $key = $(this).parents("tr").next().find(".keyWords");
		$key.after("<input type='text' maxLength='20' class='c-input' value='' onchange='checkSkuInput(this)'/><div id='delmg' class='del-img' style='display:block'></div>");
		
	});
	*/
	//sku选项值复选框事件
	$(".input-checkbox").click(function(){
		$.each($(".repertories").find("tr:gt(0)"), function(i,tr){
			var $tr = $(tr);
			var value = {
				"id" : $tr.attr("id"),
				"productSkuId" : $tr.find(".productSkuId").val(),
				"weight" : $tr.find(".weight").val(),
				"inventory" : $tr.find(".inventory").val(),
				"skuCode" : $tr.find(".skuCode").val(),
				"unitPrice" : $tr.find(".unitPrice").val(),
				"marketPrice" : $tr.find(".marketPrice").val(),
				"settlementPrice" : $tr.find(".settlementPrice").val(),
			};
			data.push(value);
		});
		createRepertoriesTable();
		var $dd = $(this).closest("dd");
		var $span = $dd.find("span");
		if($(this).attr("checked") != "checked" ){
			$dd.find(".c-input").remove();
			$span.show();
			return;
		}
		$span.hide().after("<input type='text' maxLength='20' class='c-input' value='"+$span.text()+"' onchange='checkSkuInput(this)'/>");
	});
	
	//如果有上传图片，显示交换按钮
	$(".default-img").hover(function(){
		if($(this).find("img")[0]){
			$(this).find("i").show();
			$(this).find(".del-img").show();
		}
	},function(){
		$(this).find("i").hide();
		$(this).find(".del-img").hide();
	});
	//图片向前排序
	$(".img-prev").on("click",function(){
		var this_td = $(this).parent().parent();
		var prev_td = $(this_td).prev("td");
		$(prev_td).before(this_td);
	});
	//图片向后排序
	$(".img-next").on("click",function(){
		var this_td = $(this).parent().parent();
		var next_td = $(this_td).next("td");
		var no_img = $(next_td).attr("id");
		if(no_img != "no_img"){
			$(next_td).after(this_td);
		}
	});
	//删除图片
	$(".del-img").on("click",function(){
		$(this).next("img").remove();
		$(this).closest("td").find(".imageUrl").val("");
	});
	//删除商品封面图片
	$("#del-img").on("click",function(){
		$(this).next("img").remove();
		$(this).closest("td").find(".coverimageUrl").val("");
	});
});

function handleFormData(){
	//设置商品图片url
	var imageUrls = "";
	$.each($(".no-border-table .imageUrl"),function(i,obj){
		var url = $(obj).val();
		if(url){
			imageUrls += url + ",";	
		}
	});
	if(imageUrls.length > 0){
		imageUrls = imageUrls.substring(0, imageUrls.length-1);
	}
	$("#imageUrls").val(imageUrls);
	//关键词
	/*var keyWord = $("#brandId option:selected").text() + "," + $("#name").val();
	$("#keyWord").val(keyWord);*/
	//商品描述
	$("#description").val(CKEDITOR.instances.description.getData());
}

//变量初始化设置
function variableInit(){
	$tr_productSku = $("<tr><td><input type='radio' value='1'>默认</td></tr>");
	$input_productSkuId = $("<input style='display:none;' type='text' class='productSkuId'/>");
//	$input_color = $("<input style='display:none;' type='text' />");
	$input_size = $("<input style='display:none;' type='text' />");
//	$input_color_override = $("<input style='display:none;' type='text' />");
	$input_size_override = $("<input style='display:none;' type='text' />");
//	$td_color = $("<td></td>");
	$td_size = $("<td></td>");
}

//库存表格js操作
function createRepertoriesTable(){
	$(".repertories").find("tr:gt(0)").remove();
	//已选尺寸
	var $sizes = $("#size input:checked");
	
	//没勾选一个选项时
	if($sizes.length == 0){
		variableInit();
		$tr_productSku.attr("id", "_");
		var strList = "<td><input type='text' disabled='disabled' class='repertories-num weight' maxlength='6' name='product.productSkus[0].productSkuOptionValues[1].overrideSkuOptionValue' onchange='checkWeight(this)'/></td>"
					+ "<td><input type='text' disabled='disabled' class='repertories-num inventory' maxlength='64' name='product.productSkus[0].inventory' onchange='checkInventory(this)'/></td>"
					+ "<td><input type='text' disabled='disabled' class='repertories-num repertories-width skuCode' maxlength='64' name='product.productSkus[0].sellerSkuCode' onblur='checkSkuCode(this,0)'/></td>"
					+ "<td><input type='text' disabled='disabled' class='repertories-num unitPrice' maxlength='11' name='product.productSkus[0].unitPrice' onchange='checkUnitPrice(this)'/></td>" 
					+ "<td><input type='text' disabled='disabled' class='repertories-num marketPrice' maxlength='11' name='product.productSkus[0].marketPrice' onchange='checkUnitPrice(this)'/></td>"
					+ "<td><input type='text' disabled='disabled' class='repertories-num settlementPrice' maxlength='11' name='product.productSkus[0].settlementPrice' onchange='checkUnitPrice(this)'/></td>";
		$tr_productSku.find('input[type=radio]').attr("name","product.productSkus[0].isDefault");
		$tr_productSku.find('input[type=radio]').attr("checked","true");
		$input_productSkuId.attr("name", "product.productSkus[0].productSkuId");
		//将隐藏文本框放入尺寸单元格中
		$td_size.append($input_productSkuId);
		
		$tr_productSku.append($td_size).append(strList);
		$(".repertories").append($tr_productSku);
	}
	//仅勾选了尺寸时
	else if($sizes.length > 0){
		var index = 0;
		$.each($sizes, function(i,size){
			variableInit();
			$tr_productSku.attr("id", $(size).val() + "_");
			var strList = "<td><input type='text' disabled='disabled' class='repertories-num weight' maxlength='6' name='product.productSkus["+index+"].productSkuOptionValues[1].overrideSkuOptionValue' onchange='checkWeight(this)'/></td>"
				+ "<td><input type='text' disabled='disabled' class='repertories-num inventory' maxlength='5' name='product.productSkus["+index+"].inventory' onchange='checkInventory(this)'/></td>"
				+ "<td><input type='text' disabled='disabled' class='repertories-num repertories-width skuCode' maxlength='30' name='product.productSkus["+index+"].sellerSkuCode' onblur='checkSkuCode(this,"+index+")'/></td>"
				+ "<td><input type='text' disabled='disabled' class='repertories-num unitPrice' maxlength='11' name='product.productSkus["+index+"].unitPrice' onchange='checkUnitPrice(this)'/></td>" 
				+ "<td><input type='text' disabled='disabled' class='repertories-num marketPrice' maxlength='11' name='product.productSkus["+index+"].marketPrice' onchange='checkUnitPrice(this)'/></td>"
				+ "<td><input type='text' disabled='disabled' class='repertories-num settlementPrice' maxlength='11' name='product.productSkus["+index+"].settlementPrice' onchange='checkUnitPrice(this)'/></td>";
			$tr_productSku.find('input[type=radio]').attr("name","product.productSkus[0].isDefault");
			if(index == 0){
				$tr_productSku.find('input[type=radio]').attr("checked","true");
				$tr_productSku.find('input[type=radio]').attr("value","1");
			}else{
				$tr_productSku.find('input[type=radio]').attr("value",index+1);
			}
			$input_productSkuId.attr("name", "product.productSkus["+index+"].productSkuId");
			$input_size.attr("name", "product.productSkus["+index+"].productSkuOptionValues[0].skuOptionValueId");
			$input_size.val($(size).val());
			$input_size_override.attr("name", "product.productSkus["+index+"].productSkuOptionValues[0].overrideSkuOptionValue");
			$td_size.text($(size).closest("dd").find("span").text());
			//将隐藏文本框放入尺寸单元格中
			$td_size.append($input_productSkuId).append($input_size);
			if($(size).attr("overrideFlag") == "1"){
				$input_size_override.val($(size).closest("dd").find("span").text());
				$td_size.append($input_size_override);
			}
			var weight = '<input type="hidden"  name="product.productSkus['+index+'].productSkuOptionValues[1].skuOptionValueId" value="'+$("#wt").val()+'"/>'
			$tr_productSku.append($td_color).append($td_size).append(strList).append(weight);
			$(".repertories").append($tr_productSku);
			index++;
		});
	}
	//刷新库存表格时恢复已保存的sku数据
	if(data.length>0){
		$.each(data,function(i,obj){
			var id = obj.id;
			
			//为只有一个sku属性的商品增加另一个sku属性
			if(id.indexOf("_") == id.length-1){
				var skuOptValueId = id.substring(0,id.length-1);
				var $color = $("#color input:checked");
				if($color.length == 1 && $color.val() != skuOptValueId){
					id = $color.val() + "_" + skuOptValueId;
				}else{
					var $size = $("#size input:checked");
					if($size.length == 1 && $size.val() != skuOptValueId){
						id = skuOptValueId + "_" + $size.val();
					}
				}
			}
			if(obj.isDefault != ""){
				$.each($('.repertories').find('input[type=radio]'),function(index,data){
				    if(data.value == obj.isDefault){
				        $(this).attr('checked',"checked");
				    } 
				}) 
			}
			var $productSku_tr = $("#"+id);
//			if(data.length == 1){
//				$productSku_tr = $(".repertories").find("tr:eq(1)");
//			}
			if($productSku_tr.length == 0){
				return;
			}

			//设置productSkuId
			var $input_productSkuId = $productSku_tr.find(".productSkuId");
			$input_productSkuId.val(obj.productSkuId);
			//设置重量
			var $input_weight = $productSku_tr.find(".weight");
			$input_weight.val(obj.weight);
			//设置inventory
			var $input_inventory = $productSku_tr.find(".inventory");
			$input_inventory.val(obj.inventory);
//			//设置internationalCode
//			var $input_internationalCode = $productSku_tr.find(".internationalCode");
//			$input_internationalCode.val(obj.internationalCode);
			//设置skuCode
			var $input_skuCode = $productSku_tr.find(".skuCode");
			$input_skuCode.val(obj.skuCode);
			//设置unitPrice
			var $input_unitPrice = $productSku_tr.find(".unitPrice");
			$input_unitPrice.val(obj.unitPrice);
			//设置市场价
			var $input_unitPrice = $productSku_tr.find(".marketPrice");
			$input_unitPrice.val(obj.marketPrice);
			//设置结算价
			var $input_settlementPrice = $productSku_tr.find(".settlementPrice");
			$input_settlementPrice.val(obj.settlementPrice);
		});
	}
	
	data.splice(0,data.length);
	$.each($(".repertories").find("tr:gt(0)"), function(i,tr){
		var $tr = $(tr);
		var value = {
			"id" : $tr.attr("id"),
			"productSkuId" : $tr.find(".productSkuId").val(),
			"weight" : $tr.find(".weight").val(),
			"inventory" : $tr.find(".inventory").val(),
			"skuCode" : $tr.find(".skuCode").val(),
			"unitPrice" : $tr.find(".unitPrice").val(),
			"marketPrice" : $tr.find(".marketPrice").val(),
			"settlementPrice" : $tr.find(".settlementPrice").val(),
		};
		data.push(value);
	});
}
function checkSkuInput(obj){
	
	var $this = $(obj);
	var $dd = $this.closest("dd");
	var $input_checkbox = $dd.find(".input-checkbox");
	var overrideFlag = $input_checkbox.attr("overrideFlag");
	var temp = $this.val();
//	var regFn1 =/^[A-Za-z0-9\.\*]+$/;
//	if(!regFn1.test(temp)){
//		alert('规格由数字,字母、小数点组成');
////		$this.val("");
//		$this.focus();
//		return ;
//	}
	$.each($(".repertories").find("tr:gt(0)"), function(i,tr){
		var $tr = $(tr);
		var value = {
			"id" : $tr.attr("id"),
			"productSkuId" : $tr.find(".productSkuId").val(),
			"weight" : $tr.find(".weight").val(),
			"inventory" : $tr.find(".inventory").val(),
			"skuCode" : $tr.find(".skuCode").val(),
			"unitPrice" : $tr.find(".unitPrice").val(),
			"marketPrice" : $tr.find(".marketPrice").val(),
			"settlementPrice" : $tr.find(".settlementPrice").val(),
		};
		data.push(value);
	});
	var flag = true;	
	var tdId = $dd.closest("td").attr("id");
	if(tdId == "color"){
		flag = checkColor(temp);
	}else if(tdId == "size"){
		flag = checkSize(temp);
	}
	if(!flag){
		temp = $dd.find("span").text();
		$this.val(temp);
	}else if(overrideFlag != "1"){
		$input_checkbox.attr("overrideFlag", "1"); //标志被修改过
	}
	$this.closest("dd").find("span").text(temp);
	createRepertoriesTable();
}
function checkColor(value){
	var regFn = /^[\u4E00-\u9FA5]{1,4}$/;
	return regFn.test(value);
}
function checkSize(value){
//	var regFn = /^\d+\.?\d+$/;
	var regFn = /^([1-9]{1}\d*|0)\.?\d{1,2}$/
//	if(!regFn.test(value) || value.replace('.', '').length > 5){
//		return false;
//	}
	return true;
}
function checkWeight(domObj){
	var regFn = /^(0|[1-9]\d{0,6})$/ ;
	if(!regFn.test(domObj.value)){
//		alert('重量最大支持5位整数');
		domObj.value = "";
		domObj.focus();
	}
	var $this = $(domObj);
	var id = $this.closest("tr").attr("id");
	$.each(data, function(i,obj){
		if(id == obj.id){
			obj.inventory = $this.val();
		}
	});
}
function checkInventory(domObj){
	var regFn = /^(0|[1-9]\d{0,4})$/;
	if(!regFn.test(domObj.value)){
//		alert('库存最大支持5位整数');
		domObj.value = "";
		domObj.focus();
	}
	var $this = $(domObj);
	var id = $this.closest("tr").attr("id");
	$.each(data, function(i,obj){
		if(id == obj.id){
			obj.inventory = $this.val();
		}
	});
}
function checkInternationalCode(domObj){
	var $this = $(domObj);
	var id = $this.closest("tr").attr("id");
	$.each(data, function(i,obj){
		if(id == obj.id){
			obj.internationalCode = $this.val();
		}
	});
}
function checkSkuCode(domObj,num){
	var $this = $(domObj);
	$.each($(".skuCode"),function(index,data){
	    if($.trim(data.value) != "" && $.trim(data.value) == $this.val() && num != index){
	    	alert("商品skuCode："+$this.val()+" 已占用");
	    	$this.val("");
	    }
	});
//	var id = $this.closest("tr").attr("id");
//	$.each(data, function(i,obj){
//		if(id == obj.id){
//			obj.skuCode = $this.val();
//		}
//	});
}
function checkUnitPrice(domObj){
	var regFn1 = /^[0-9]{1}\d{0,4}([\.]\d{1,2})?$/;
	var	regFn2 = /^0.(\d[1-9]|[1-9]\d?){1}$/;
	if(!regFn1.test(domObj.value) && !regFn2.test(domObj.value)){
		domObj.value = "";
		domObj.focus();
	}
	var $this = $(domObj);
	var id = $this.closest("tr").attr("id");
	$.each(data, function(i,obj){
		if(id == obj.id){
			obj.unitPrice = $this.val();
		}
	});
}