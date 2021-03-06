$(function(){
	
	//验证配置参数
	$.formValidator.initConfig({
 	    validatorGroup: '1', //多个表单使用窜号区分,单个表单无需使用此窜号
 	    formID: 'form1',
 	 	errorFocus:false,
 	    theme: 'Default'
 	});
	
	//三级联动地址公用验证函数
	function validatorSelect(cssName,id,isValid){
		$(cssName).formValidator({
			empty:isValid,
	        onShow:"请选择地区",
	        onFocus:"请选择具体地区",
	        onCorrect:"",
	        tipID:id
	    }).inputValidator({min:1,onError: "请选择具体地区!"});
	}
	//验证三级联动地址
 	validatorSelect(".company","regionTips1",true);
 	validatorSelect(".shiper","regionTips2",false);
 	validatorSelect(".receiver","regionTips3",false);
	var prov = $("#company_area_prov").val(), city = $("#company_area_city").val(), district = $("#company_area_region").val();
	var linkage = new linkageSelect();
	 linkage.init({
	     "oneSel":['#company_province','请选择',prov],
		 "twoSel":['#company_city', '请选择',city],
		 "threeSel":['#company_region', '请选择',district]
	 });
     var prov1 = $("#shiper_area_prov").val(), city1 = $("#shiper_area_city").val(), district1 = $("#shiper_area_region").val();
	 var linkage1 = new linkageSelect();
     linkage1.init({
         "oneSel":['#shiper_province','请选择',prov1],
         "twoSel":['#shiper_city', '请选择',city1],
         "threeSel":['#shiper_region', '请选择',district1]
     });
     var prov2 = $("#receiver_area_prov").val(), city2 = $("#receiver_area_city").val(), district2 = $("#receiver_area_region").val();
	 var linkage2 = new linkageSelect();
     linkage2.init({
         "oneSel":['#receiver_province','请选择',prov2],
         "twoSel":['#receiver_city', '请选择',city2],
         "threeSel":['#receiver_region', '请选择',district2]
     });
	//linkageSel1.changeValues([$("#shiper_area_prov").val(), $("#shiper_area_city").val(), $("#shiper_area_region").val()]);
	//linkageSel2.changeValues([$("#receiver_area_prov").val(), $("#receiver_area_city").val(), $("#receiver_area_region").val()]);
   //发货地址详细地址
	 $("#addr-info-f").formValidator({
		onShow:"请输入1~30位的详细地址",
		onFocus:"请输入1~30位的详细地址",
		tipID:"addr-info-fTip"
	}).inputValidator({
		min:1,
		max:30,
		empty:{leftEmpty:false,rightEmpty:false,emptyError:"两边不能有空格"},
		onError:"请输入1~30位的详细地址"
	});
	//退货地址详细地址
	$("#addr-info-t").formValidator({
		onShow:"请输入1~30位的详细地址",
		onFocus:"请输入1~30位的详细地址",
		tipID:"addr-info-tTip"
	}).inputValidator({
		min:1,
		max:30,
		empty:{leftEmpty:false,rightEmpty:false,emptyError:"两边不能有空格"},
		onError:"请输入1~30位的详细地址"
	});
 	//登录名
    $("#business-name").formValidator({
		onShow:"由6~30位，英文，中文，数字和下划线组成",
		onFocus:"由6~30位，英文，中文，数字和下划线组成",
		onCorrect:"登陆名可以使用"})
  	.regexValidator({
  		regExp:"^[a-zA-Z0-9_\\u4E00-\\u9FA5]{6,30}$",
  		dataType:"string",
  		onError:"由6~30位，英文，中文，数字和下划线组成"})
  	.inputValidator({
  		min:6,max:30,
  		onErrorMin:"请输入大于6个字符的登陆名",
  		onErrorMax:"请输入不大于30个字符的登陆名",
  		empty:{
  			leftEmpty:false,
  			rightEmpty:false,
  			emptyError:"登陆名两边不能有空格"
  			},
  		onError:"你输入的品牌名称格式错误"})
  	.ajaxValidator({ 
		dataType : 'json',              
		async : true,   
		url : _ctxPath+'/admin/user/user-validLoginName.htm',             
		success : function(data){  
			if(data.info==1){
				return false;
			}
			return true;              
		},              
		buttons: $("#submitForm"),              
		error: function(jqXHR, textStatus, errorThrown){
		alert("服务器没有返回数据，可能服务器忙，请重试"+errorThrown);},              
		onError : "该登录名已经存在",              
		onWait : "正在对登录名进行合法性校验，请稍候..."          
	});
    //业务联系人
    $("#linkman").formValidator({
		onShow:"请输入2~20位英文或中文姓名",
		onFocus:"请输入2~20位英文或中文姓名"
	}).inputValidator({
		min:2,
		max:20,
		empty:{
			leftEmpty:false,
			rightEmpty:false,
			emptyError:"业务联系人两边不能有空格"
			},
		onError:"请输入2~20位英文或中文姓名"
	}).functionValidator({
		fun: function(val, el){
			var val= $.trim(val),
				reg=/^[a-zA-Z\u4e00-\u9fa5]+$/;
			if(!reg.test(val)){
				return '请输入2~20位英文或中文姓名'
			}
		}
	});
    //手机号码
    $("#tel-text").formValidator({
		onShow:"请输入手机号码",
		onFocus:"请输入手机号",
		onCorrect:"谢谢你的合作"
	}).inputValidator({
		min:11,
		max:11,
		onError:"手机号码必须是11位数字,请确认"
	}).regexValidator({
		regExp:"mobile",
		dataType:"enum",
		onError:"手机号码必须是11位数字,请确认"
	});
    //固定电话
    $("#dh").formValidator({
		empty:true,
		onShow:"请输入固定电话",
		onFocus:"例如：021-88888888或省略区号88888888",
		onCorrect:"谢谢你的合作，你的固定电话正确"
	}).regexValidator({
		regExp:"tel",
		dataType:"enum",
		onError:"国内电话格式不正确"
	});
    //电子邮箱
    $("#email").formValidator({
		onShow : "请输入邮箱",
		onFocus : "邮箱6-100个字符,输入正确了才能离开焦点",
		onCorrect : "恭喜你,你输对了"
	}).inputValidator({
		min : 6,
		max : 100,
		onError : "邮箱格式错误"
	}).regexValidator({
		regExp:"email",
		dataType:"enum",
		onError:"邮箱格式不正确"
	}).ajaxValidator({
		type : 'GET',
		url : _ctxPath+'/admin/user/user-validateEmailIsRepate.htm',
		data : {
			"userId" : function(){return $("#sellerUserId").val();},
			"email" : function(){return $("#email").val();}
		},
		datatype : "json",
		async : "true",
		success : function(data) {
			var json = $.parseJSON(data);
			if (json.code == "false") {
				return false;
			}
			return true;
		},
		buttons: $("#submitForm"),
		error : function(jqXHR, textStatus, errorThrown) {
			alert("服务器没有返回数据，可能服务器忙，请重试" + errorThrown);
		},
		onError : "该邮箱已被使用，请更换邮箱",
		onWait : "正在对邮箱进行合法性校验，请稍候..."
	});
    //QQ
    $("#QQ").formValidator({
		empty:true,
		onShow:"请输入QQ号码",
		onFocus:"请输入QQ号码",
		onCorrect:"谢谢你的合作，你的QQ号码正确"
	}).inputValidator({
		min:5,
		max:10
	}).regexValidator({
		regExp:"qq",
		dataType:"enum",
		onError:"QQ号码格式不正确"
	});
    //传真
    $("#fax").formValidator({
		empty:true,
		onShow:"请输入你的传真号码",
		onFocus:"请输入正确的传真号码",
		onCorrect:"谢谢你的合作"
	}).inputValidator({
		min:10,
		max:12,
		onError:"传真号码不正确，请确认"
	}).regexValidator({
		regExp:"tel",
		dataType:"enum",
		onError:"你输入的传真号码格式不正确"
	});
    //公司名称
    $("#company-name").formValidator({
  		onShow:"由6~30个字符组成",
  		onFocus:"由6~30个字符组成",
  		onCorrect:"公司名称可以使用"
  	}).inputValidator({
  		min:6,
  		max:30,
  		empty:{
  			leftEmpty:false,
  			rightEmpty:false,
  			emptyError:"公司名称两边不能有空格"
  			},
  		onError:"你输入的公司名称格式错误"
  	});
    //公司类型
    $("#company-type").formValidator({
  		empty:true,
  		onShow:"请填写3~20个字符",
  		onFocus:"请填写3~20个字符",
  		onCorrect:"公司类型可以使用"
  	}).inputValidator({
  		min:3,
  		max:20,
  		empty:{
  			leftEmpty:false,
  			rightEmpty:false,
  			emptyError:"公司类型两边不能有空格"
  			},
  		onError:"请填写3~20个字符"
  	});
    //成立日期
    $("#rq").formValidator({
		empty:true,
		onShow:"请输入成立日期",
		onFocus:"例如：2012-01",
		onCorrect:"成立日期正确"
	}).regexValidator({
		regExp:"^\\d{4}(\\-|\\/|\.)\\d{1,2}$",
		dataType:"string",
		onError:"日期格式不正确"
	});
    //注册资本
    $("#regdit-zb").formValidator({
		empty:true,
		onShow:"请填写0~8位数字",
		onFocus:"请填写0~8位数字",
		onCorrect:"谢谢你的合作，你的实收资本数正确"
	}).inputValidator({
		min:0,
		max:8
	}).regexValidator({
		regExp:"intege1",
		dataType:"enum",
		onError:"请填写0~8位数字"
	});
    $("#ss-zb").formValidator({
		empty:true,
		onShow:"请填写0~8位数字",
		onFocus:"请填写0~8位数字",
		onCorrect:"谢谢你的合作，你的实收资本数正确"
	}).inputValidator({
		min:0,
		max:8
	}).regexValidator({
		regExp:"intege1",
		dataType:"enum",
		onError:"请填写0~8位数字"
	});
    //经营范围
    $('#businessScope').formValidator({
		empty:true,
		tipId : "businessScopeTip",
		onShow : "请填写经营范围",
		onFocus : "经营范围必须填写",
		onCorrect : "谢谢您的配合"
	}).functionValidator({
		fun : function() {
			var describe = businessScopeEditor.getData();
			if(describe.length == 0){
				return "请输入经营范围";
			}
//				else if(describe.length > 100 || describe.length<3){
//					return "请输入请输入3~100个字符个字符";
//				}
		}
	});
    //公司简介
    $('#remark').formValidator({
		tipId : "remarkTip",
		onShow : "请填写公司简介",
		onFocus : "公司简介必须填写",
		onCorrect : "谢谢您的配合"
	}).functionValidator({
		fun : function() {
			var remark = remarkEditor.getData();
			if(remark.length == 0){
				return "请输入公司简介";
			}
//				else if(remark.length > 200 ||　remark.length<3){
//					return "请输入3~200个字符";
//				}
		}
	});
    //公司网址
    $("#url").formValidator({
		empty:true,
		defaultValue:""
	}).inputValidator({
		min:3,
		max:100,
		onError:"你输入公司网站格式不正确"
	}).regexValidator({
		regExp:"url",
		dataType:"enum",
		onError:"你输入公司网站格式不正确"
	});
    //选择城市
    
    //可售品牌
    
    //法人代表
    $("#juridicalPperson").formValidator({
		empty:true,
		onShow:"请输入2~20位英文或中文姓名",
		onFocus:"请输入2~20位英文或中文姓名"
	}).inputValidator({
		min:2,
		max:20,
		empty:{
			leftEmpty:false,
			rightEmpty:false,
			emptyError:"两边不能有空格"
			},
		onError:"请输入2~20位英文或中文姓名"
	});
    //税务登记号
    $("#registration").formValidator({
		empty:true,
		onShow:"请输入税务登记号",
		onFocus:"请输入税务登记号",
		onCorrect:"谢谢你的合作，你的税务登记号正确"
	}).inputValidator({
		min:1,
		max:20,
		empty:{
			leftEmpty:false,
			rightEmpty:false,
			emptyError:"两边不能有空格"
			},
		onError:"请填写1~20位字符"
	});
    //企业法人营业执照注册号
    $("#registrationNum").formValidator({
		empty:true,
		onShow:"请输入企业法人营业执照注册号",
		onFocus:"请输入企业法人营业执照注册号",
		onCorrect:"你的企业法人营业执照注册号输入正确"
	}).inputValidator({
		min:15,
		max:15,
		onError:"请填写15位数字"
	}).regexValidator({
		regExp:"intege1",
		dataType:"enum",
		onError:"请填写15位数字"
	});
    //企业编码
    $("#companyNum").formValidator({
		empty:true,
		onShow:"请输入企业编码",
		onFocus:"请输入企业编码",
		onCorrect:"谢谢你的合作，你的企业编码输入正确"
	}).inputValidator({
		min:0,
		max:20,
		empty:{
			leftEmpty:false,
			rightEmpty:false,
			emptyError:"两边不能有空格"
			},
		onError:"请填写0~20位字符"
	});
    //支付宝帐号
    
//		$("#alipay").formValidator({tipID:"paynum",onShow:"请输入支付宝帐号",onFocus:"请输入支付宝帐号"}).inputValidator({min:1,max:30,empty:{leftEmpty:false,rightEmpty:false,emptyError:"两边不能有空格"},onError:"请输入1~30位的支付宝帐号"});
//		$("#alipayName").formValidator({tipID:"paynum",onShow:"请输入注册支付宝姓名",onFocus:"请输入注册支付宝姓名"}).inputValidator({min:1,empty:{leftEmpty:false,rightEmpty:false,emptyError:"两边不能有空格"},onError:"你输入的姓名错误"});
//		$("#bank").formValidator({tipID:"bankTip",onShow:"请输入开户银行",onFocus:"请输入开户银行"}).inputValidator({min:3,max:30,empty:{leftEmpty:false,rightEmpty:false,emptyError:"两边不能有空格"},onError:"你输入3~30位的银行名称"});
//		$("#bankcardNum").formValidator({tipID:"bankTip",onShow:"请输入1~20位数字的银行卡号",onFocus:"请输入1~20位数字的银行卡号"}).inputValidator({min:1,max:20,empty:{leftEmpty:false,rightEmpty:false,emptyError:"两边不能有空格"},onError:"请输入1~20位数字的银行卡号"});
//		function allEmpty(val,elem){return ($("#alipay").val()=="" && $("#bank").val()=="")?'为了保证您能收到货款，请至少填写一种收<br/>款帐号！':true;} 

	$("#alipay,#bank,#alipayName,#bankcardNum,#bankAccountName").formValidator({
		tipID:"paynum",onFocus:"银行账号和支付宝账号至少填写一个",onCorrect:"输入正确！"
		})
		.functionValidator({
			fun : function() {
				var $alipay = $("#alipay"),
					$alipayName = $("#alipayName"),
				    $bank = $("#bank"),
				    $bankcardNum = $("#bankcardNum"),
				    $bankAccountName=$("#bankAccountName");
				    
				var alipayVal = $.trim($alipay.val()),
				    bankVal = $.trim($bank.val()),
				    alipayNameVal = $.trim($alipayName.val()),
				    bankcardNumVal = $.trim($bankcardNum.val()),
				    bankAccountNameVal=$.trim($bankAccountName.val());
				
				if(alipayVal.length == 0 && bankVal.length == 0
						&& alipayNameVal.length == 0 && bankcardNumVal.length == 0){
					return "银行账号和支付宝账号至少填写一个";
				}
				if(alipayVal.length > 0 || alipayNameVal.length > 0){
					var $span = $("#paynum");
					$("#paynum").remove();
					var $td = $alipayName.closest("tr").find("td:last");
					$td.append($span);
					
					if(alipayVal.length == 0 || alipayVal.length > 30){
						return"请输入1~30位的支付宝帐号";
					}
					if(alipayNameVal.length < 1 || alipayNameVal.length > 50){
						return "请输入1~50位的注册支付宝姓名";
					}
				}
				if(bankVal.length > 0 || bankcardNumVal.length > 0 || bankAccountNameVal.length>0){
					var $span = $("#paynum");
					$("#paynum").remove();
					var $td = $bankcardNum.closest("tr").find("td:last");
					$td.append($span);
					
					if(bankVal.length < 3 || bankVal.length > 30){
 						return "请输入3~30位的开户银行名称";
 					}
					if(!/^\d{1,30}$/.test(bankcardNumVal)){
						return "请输入1~30位数字的银行卡号";
					}
					if(bankAccountNameVal.length==0){
						return "请输入银行开户名";
					}
				}
			}
	});
	//营业执照
	$("#uploadImageValueId").formValidator({
		empty:true, 
		onShow: "请输入图片名", 
		onCorrect: "谢谢你的合作，你的图片名正确"
	}).inputValidator({
		min:1,
		onErrorMin:"请上传图片"
	}).regexValidator({
		regExp: "picture", 
		dataType: "enum", 
		onError: "图片名格式不正确" 
	});
	
	  /*$.formValidator.initConfig({
		  formID:"form1",
		  theme:"Default",
		  submitOnce:true,
		  wideWord:false,
		  onError:function(){}
	  });*/
	
	//可售品牌
	$(".br-list input:checkbox").formValidator({
		tipID:"brandTip",
		onShow:"请选择可售品牌",
		onFocus:"你至少选择1个可售品牌",
		onCorrect:"恭喜你,你选对了"
	}).inputValidator({
		min:1,
		onError:"你至少选择1个可售品牌"
	});
	//验证三级联动
	$("#add-f").find("#shiper_region").formValidator({
        onFocus:"请选择具体地址",
        tipID:"addrTip-f"
    }).inputValidator({
    	min:1,
    	onError: "请选择具体地址!"
    });
	
	$("#add-t").find("#receiver_region").formValidator({
        onFocus:"请选择具体地址",
        tipID:"addrTip-t"
    }).inputValidator({
    	min:1,
    	onError: "请选择具体地址!"
    });
	
	
	//品牌筛选
	  var bindCheckBox=function(){
		  $(':checkbox[name="userInfo.listBrandIds"]').bind('click',function(){
			  var brandName = $(this).next().text();
			  var brandId = $(this).attr('id');//复选框ID
			  var st=$('#selectedBrandNames').text();
			  if(this.checked){
			 	 if($('#selectedBrandNames').text() == ''){
						$('#selectedBrandNames').text(brandName);
					}else{
						if(st.indexOf(brandName)>=0){
							//alert('已经勾选过这个商品');
						}else{
							$('#selectedBrandNames').text(st + ',' + brandName);
						}
					}
				}else{
					var b = brandId;
					if(brandId.indexOf('brand-')>=0){
						b = brandId.substring(6,brandId.length);
						$('#'+b).removeAttr('checked');//移除旧的
					}
					$(this).removeAttr('checked');
					if(st.indexOf(brandName) == 0){
						if(st.indexOf(',')==-1){
							$('#selectedBrandNames').text(st.replace(brandName,''));
						}else{
							$('#selectedBrandNames').text(st.replace(brandName+',',''));
						}
					}else if(st.indexOf(brandName)>0){
						$('#selectedBrandNames').text(st.replace(','+brandName,''));
					}
				}
				
			});
	  };
	  bindCheckBox(); //运行函数
	  
	  $("#add-f select").click();
	  $("#add-t select").click();
		
		$(".sal-brand-t a").click(function(){
			var text = $(this).text();
			/* if(text.length > 1){
				text = "";
			} */
			var brand_temp = "brand-" + text;
			if(!$("#"+brand_temp)[0]){
				$.ajax({
					url : _ctxPath+"/admin/brand/brand-listBrands.htm",
					type : "POST",
					data : {
						'brand.firstChar' : text,
						'brand.userInfo.userInfoId': $('#sellerId').val(),
						'brand.userInfo.user.userId':$('#sellerUserId').val()
					},
					dataType : "html",
					success : function(data) {
						if(data!='' && data!=null){
							var data="<div id=\""+brand_temp+"\" class=\"br-list\">"+data+"</div>";
							$(".sal-brand-t").after($(data));
							$("#"+brand_temp).show().siblings(".br-list").hide();
							$(':checkbox[name="seller.listBrandIds"]').unbind('click');
							bindCheckBox();
							//操作已经勾选的品牌start
							$(".br-list input:checkbox").each(function(){
								if (this.checked) {
									var st=$('#selectedBrandNames').text();
									var brandNameTemp=$(this).next().text()
//									var selectBrandId=$(this).val()
									if(st.indexOf(brandNameTemp)<0){
										if(st == ''){
											$('#selectedBrandNames').text(brandNameTemp);
										}else{
											$('#selectedBrandNames').text(st + ',' + brandNameTemp);
										}
										
									}
								}
							 });
							//操作已经勾选的品牌End
						}
					},
					error : function(data) {
						//alert(data.responseText);
					}
				});
				
			}else{
				$("#"+brand_temp).show().siblings(".br-list").hide();
			}
			
		});
	/*============ 初始化编辑器 s============*/
	var businessScopeEditor = CKEDITOR.replace("userInfo.businessScope");
	var remarkEditor = CKEDITOR.replace("userInfo.remark");
	/*============ 初始化编辑器 e============*/	
	
	/*============ 图片上传操作 s============*/
	var uploadDefaultParams = {
		'auto' : true,
		'buttonImg' :_jsPath+'/plugin/uploadify/uploadimg_btn.png',
		'cancelImg' : _jsPath+'/plugin/uploadify/cancel.png',
		'expressInstall' : _jsPath+'/plugin/uploadify/expressInstall.swf',
		'fileDataName' : 'file',
		'fileDesc' : '请选择jpg、gif、png文件',
		'fileExt' : '*.jpg;*.jpeg;*.gif;*.png',
		'height' : 20,
		'multi' : false,
		'script' : _ctxPath+'/upload/upload.htm',
		'sizeLimit' : 2097152,
		'uploader' : _jsPath+'/plugin/uploadify/uploadify.allglyphs.swf',
		'width' : 94
	};
	
	var uploadImgParams = uploadDefaultParams;
	uploadImgParams.scriptData = {'category' : 'seller'};
	uploadImgParams.onComplete = function(event, ID, fileObj, response, data) {
		$('#uploadImageValueId').val(response);
		//得到缩略图url
		var suffix = response.split(".")[1];
		var url = _fileThumbPath + response + "_t24." + suffix;
		$(".license").empty();
		$(".license").append("<img src='"+url+"'/>");
	};
	$('#imgUpload').uploadify(uploadImgParams);
	/*============ 图片上传操作 e============*/
	
	//提交表单
	$('#submitForm').bind('click',function(){
		var isCheckbox=false;
		//成立日期
		var regDateStr = $("#rq").val();
		if(regDateStr){
    		$("#registerDate").val(regDateStr + "-01");	
		}
        $('#companyRegionCodes').val($("#company_region").val());
        $('#shiperRegionCodes').val($("#shiper_region").val());
        $('#receiverRegionCodes').val($("#receiver_region").val());
        
        
        
        //验证表单
        var result = $.formValidator.pageIsValid('1');
        
		if(!result){ //不通过验证，阻止
			return false;
		}else{
			$('#form1').submit();
		}
    });
	//返回上一页
	$('#backList').click(function(){
		  window.location.href=_ctxPath+'/admin/user/user-sellerManage.htm';
	});
});
