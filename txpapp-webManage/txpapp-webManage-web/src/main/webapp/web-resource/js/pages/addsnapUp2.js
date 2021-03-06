﻿$(function(){	
	
	var yipin = yipin || {};
	
	// 初始化页面加载
	 yipin.initContent = function(){
		var firstChar = $("#firstChar").val();
		if($.trim(firstChar)!=null && firstChar!=undefined){
			queryProduct(firstChar);
		}
	};
	
	yipin.init = (function() {
		yipin.initContent();
	})();
	
	//全选和反选
	$(".seller").on("click",".allCheck",function(){
		var $sub=$(this).parent().next().find(".subCheck");
		var html="";
		if($(this).is(":checked")){
			 $sub.prop("checked",true);
			 $(this).parent().next().find("li").each(function(){
				var $this=$(this);
				var Id=$this.attr("data-id");
				var imgSrc=$this.find("img").attr("src");
				if($("#qzBox").find("#goods"+Id).length<=0){
					 html+='<li class="cf" id="goods'+Id+'">'+
						'<img src="'+imgSrc+'" alt="" class="fl" width="58" height="66"/>'+
						'<div class="fl qz_time">'+
							"<p>商品权重：<input name='rankId' class='txt-input W50' onkeyup='javascript:replaceRankText(this);'/>"+
						'</div>'+
					'</li>';
				}
			 });
			 $("#qzBox").append(html);
			 textClip();
				//预览价格和规格
				$(".J_msg").hover(function(){
					$(this).find(".defaSku").show();
				},function(){
					$(this).find(".defaSku").hide();
				});
		}else{
			 $sub.prop("checked",false);
			 $(this).parent().next().find("li").each(function(){
					var $this=$(this);
					var Id=$this.attr("data-id");
					$("#qzBox").find("#goods"+Id).remove();
			});
		}
	});
	
	//单个订单全选
	$(".seller").on("click",".subCheck",function(){
		var $this=$(this);
		var $parent=$this.parents("ul");
		var $li=$this.parents("li");
		var Id=$li.attr("data-id");
		var imgSrc=$li.find("img").attr("src");
		var subBoo=$parent.find(".subCheck").length==$parent.find(".subCheck:checked").length?true:false;
		$parent.prev().find(".allCheck").prop("checked",subBoo);
		if($(this).is(":checked")){
			var html='<li class="cf" id="goods'+Id+'">'+
					'<img src="'+imgSrc+'" alt="" class="fl" width="58" height="66"/>'+
					'<div class="fl qz_time">'+
						"<p>商品权重：<input name='rankId' class='txt-input W50' onkeyup='javascript:replaceRankText(this);'/>"+
					'</div>'+
				'</li>';
				$("#qzBox").append(html);
				textClip();
				//预览价格和规格
				$(".J_msg").hover(function(){
					$(this).find(".defaSku").show();
				},function(){
					$(this).find(".defaSku").hide();
				});
		}else{
			 $("#qzBox").find("#goods"+Id).remove();
		}
	});
	
	function textClip(){
		if ($('textarea').size()) {
			//textarea 截取文字
			$("textarea").each(function(){
				if($(this).attr("maxlength")!=null){
					$(this).on('keydown',function(e){
						if(e.keyCode!=46&&e.keyCode!=8){//判断不能delete键
						   // var length=$(this).attr("maxlength");
						   // $(this).val($(this).val().substring(0,length-1));
						}
					});
					$(this).on('blur',function(){
						var length=$(this).attr("maxlength");
						$(this).val($(this).val().substring(0,length));
					});
				}
			});
		}
	};

	// 取消
	$("#cancelForm").on("click",function() {
		$('#addDetailzoneFrm')[0].reset();
		window.location = _ctxPath+ '/admin/zone/zone-searchZone.htm';
	});

	// 提交
	$("#submitForm").on("click",function() {
		var formZone = $('#addDetailzoneFrm');
		var result = $.formValidator.pageIsValid('1');
		if(result){
			$("#submitForm").attr("disabled",true);
			$.ajax({
				type : 'POST',
				url : _ctxPath+ "/admin/zone/zone-saveZone.htm",
				data : formZone.serialize(),
				error:function (XMLHttpRequest, textStatus, errorThrown) {
				},
				success : function(data) {
					switch (data.info) {
						case '2':
							if (confirm("保存成功！")) {
								window.location = _ctxPath+ '/admin/zone/zone-searchZone.htm';
							}
							break;
						default:
	//						alert(data.info);
							$.dialog({
								title : false,
								content : data.info,
								time : 2000
							});
							$("#submitForm").attr("disabled",false);
							$(".d-close").hide();
						break;
					}
				},
				dataType : 'json'
			});
		}else{
			
		}
	});

});
$.formValidator.initConfig({formID:"addDetailzoneFrm",theme:"Default",validatorGroup: '1',submitOnce:false,wideWord:false,onError:function(){}});
$('#zonename').formValidator({
    "onShow": '请输入4-10个中英文字符',
    "onFocus": '请输入4-10个中英文字符',
    "onCorrect": ''
}).inputValidator({
        "min": 4,
        "max": 10,
        "onError": '请输入4-10个中英文字符'
    }).functionValidator({
        fun: function (val, el) {
            val = $.trim(val);
            var regText =  /[A-Za-z\u4E00-\u9FA5\uF900-\uFA2D]/;
            if (!regText.test(val)) {
                return '请输入4-10个中英文字符'
            }
        }
    });
/*$('#lineno').formValidator({
    "onShow": '请输入专区排数',
    "onFocus": '请输入专区排数',
    "onCorrect": ''
}).inputValidator({
        "min": 1,
        "onError": '请输入专区排数'
});*/
/*
 * $("#zonePic").formValidator({tipID:"zonePicTip",onShow: "请输入图片名", onCorrect: "谢谢你的合作，你的图片名正确" }).inputValidator({min:1,onErrorMin:"请上传图片"}).regexValidator({ regExp: "picture", dataType: "enum", onError: "图片名格式不正确" });
*/
$("#zoneLeftPic").formValidator({tipID:"zoneLeftPicTip",onShow: "请输入图片名", onCorrect: "谢谢你的合作，你的图片名正确" }).inputValidator({min:1,onErrorMin:"请上传图片"}).regexValidator({ regExp: "picture", dataType: "enum", onError: "图片名格式不正确" });
$("#zoneListPic").formValidator({empty:true,tipID:"zoneListPicTip",onShow: "请输入图片名", onCorrect: "谢谢你的合作，你的图片名正确" }).inputValidator({min:1,onErrorMin:"请上传图片"}).regexValidator({ regExp: "picture", dataType: "enum", onError: "图片名格式不正确" });
$("#zoneUrl").formValidator({empty:false,onShow:"请输入跳转地址",onFocus:"请输入跳转地址"}).inputValidator({min:3,onError:"你输入网址格式不正确"}).regexValidator({regExp:"url",dataType:"enum",onError:"你输入网址格式不正确"});
$("#zoneListUrl").formValidator({empty:true,onShow:"请输入跳转地址",onFocus:"请输入跳转地址"}).inputValidator({min:3,onError:"你输入网址格式不正确"}).regexValidator({regExp:"url",dataType:"enum",onError:"你输入网址格式不正确"});

    // 文本框只能输入1-10的限制
	function replaceRankText(input){
		var value = $(input).val();
		$(input).val($(input).val().replace(/[^0-9]/g,''));
		if($(input).val()>10){
			$(input).val(10);
		}
		if($(input).val()==0){
			$(input).val("");
		}
	}
	// 文本框只能输入1-4的限制
	var replaceLineText = function(input){
		var value = $(input).val();
		$(input).val($(input).val().replace(/[^0-4]/g,''));
		if($(input).val()>4){
			$(input).val(4);
		}
		if($(input).val()<1){
			$(input).val("");
		}
	}
	
	// 查询首字母对应品牌商品
	var queryProduct = function(brandNo){
		$("#firstChar").val(brandNo);
		zid = $("#zoneId").val();
		var urlPath = _ctxPath+"/admin/product/product-listProducts.htm";
		var brand_temp = "p-list";
		$.ajax({
			url : urlPath,
			type : "POST",
			data :  {'firstChar' : brandNo,'saleType':1,'zoneId':zid},
			dataType : "html",
			success : function(res) {
				if(res!='' && res!=null){
					var data="<div id=\""+brand_temp+"\" class=\"seller_list cf\">"+res+"</div>";
					$("#prolist").html("");
					$("#qzBox").html("");
					$("#prolist").append($(data));
					
					//预览价格和规格
					$(".J_msg").hover(function(){
						$(this).find(".defaSku").show();
					},function(){
						$(this).find(".defaSku").hide();
					});
					//
					$("#prolist ul").each(function(){
						var num=$(this).find("li").length;
						$(this).find("li").each(function(i){
							$(this).css("z-index",num-i);	
						})
						
					});
					var items=$(".pid"); // 选上ID
					var arr =[];
					$.each(items,function(){
						arr.push($(this).val());
					});
					for(var i=0;i<arr.length;i++){
						$(".seller li[data-id='"+arr[i]+"']").find(".subCheck").prop("checked",true);
					}
					//
					var ohtml="";
					$(".seller .subCheck:checked").each(function(){
						var $this=$(this);
						var $li=$this.parents("li");
						var Id=$li.attr("data-id");
						var rankValue=$li.attr("data-rank");
						var imgSrc=$li.find("img").attr("src");
						if($("#qzBox").find("#goods"+Id).length<=0){
							ohtml+='<li class="cf" id="goods'+Id+'">'+
								'<img src="'+imgSrc+'" alt="" class="fl" width="58" height="66"/>'+
								'<div class="fl qz_time">'+
								"<p>商品权重：<input type='input' name='rankId' class='txt-input W50' value='"+rankValue+"' onkeyup='javascript:replaceRankText(this);'/>"+
								'</div>'+
							'</li>';
						}
					});
					$("#qzBox").append(ohtml);
					$("#"+brand_temp).show();
				}
			},
			error : function(res) {
				alert(res.responseText);
			}
		});
	}
	