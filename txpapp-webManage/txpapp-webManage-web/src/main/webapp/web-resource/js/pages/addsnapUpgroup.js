$.formValidator.initConfig({
	formID : "addGroupZoneFrm",
	theme : "Default",
	validatorGroup : '1',
	submitOnce : false,
	wideWord : false,
	onError : function() {
	}
});
$('#zonenameBefore').formValidator({
	"tipID" : 'zonenameTipBefore',
	"onShow" : '请输入4-10个中英文字符',
	"onFocus" : '请输入4-10个中英文字符',
	"onCorrect" : ''
}).inputValidator({
	"min" : 4,
	"max" : 10,
	"onError" : '请输入4-10个中英文字符'
}).functionValidator({
	fun : function(val, el) {
		val = $.trim(val);
		var regText = /[A-Za-z\u4E00-\u9FA5\uF900-\uFA2D]/;
		if (!regText.test(val)) {
			return '请输入4-10个中英文字符'
		}
	}
});

$('#zonenameAfter').formValidator({
	"tipID" : 'zonenameTipAfter',
	"onShow" : '请输入4-10个中英文字符',
	"onFocus" : '请输入4-10个中英文字符',
	"onCorrect" : ''
}).inputValidator({
	"min" : 4,
	"max" : 10,
	"onError" : '请输入4-10个中英文字符'
}).functionValidator({
	fun : function(val, el) {
		val = $.trim(val);
		var regText = /[A-Za-z\u4E00-\u9FA5\uF900-\uFA2D]/;
		if (!regText.test(val)) {
			return '请输入4-10个中英文字符'
		}
	}
});
$('#zonerankbeforeRank').formValidator({
	"tipID" : 'zonerankTipBefore',
	"onShow" : '请输入开团前显示顺序',
	"onFocus" : '请输入开团后显示顺序',
	"onCorrect" : ''
}).inputValidator({
	"min" : 1,
	"onError" : '请输入开团后显示顺序'
}).functionValidator({
	fun : function(val, el) {
		val = $.trim(val);
		var regText = /^(\+|-)?(0|[1-9]\d*)(\.\d*[1-9])?$/;
		if (!regText.test(val)) {
			return '请输入数字'
		}
	}
});

$('#zonerankbeforeRank').formValidator({
	"tipID" : 'zonerankTipBefore',
	"onShow" : '请输入开团前显示顺序',
	"onFocus" : '请输入开团后显示顺序',
	"onCorrect" : ''
}).inputValidator({
	"min" : 1,
	"onError" : '请输入开团后显示顺序'
}).functionValidator({
	fun : function(val, el) {
		val = $.trim(val);
		var regText = /^(\+|-)?(0|[1-9]\d*)(\.\d*[1-9])?$/;
		if (!regText.test(val)) {
			return '请输入数字'
		}
	}
});
$('#zonerankafterRank').formValidator({
	"tipID" : 'zonerankTipAfter',
	"onShow" : '请输入开团前显示顺序',
	"onFocus" : '请输入开团后显示顺序',
	"onCorrect" : ''
}).inputValidator({
	"min" : 1,
	"onError" : '请输入开团后显示顺序'
}).functionValidator({
	fun : function(val, el) {
		val = $.trim(val);
		var regText = /^(\+|-)?(0|[1-9]\d*)(\.\d*[1-9])?$/;
		if (!regText.test(val)) {
			return '请输入数字'
		}
	}
});


var showIcon = {
	correct : function(el, text) {
		el.show().html('<span class="yto_onCorrect">' + text + '</span>');
	},
	error : function(el, text) {
		el.show().html('<span class="onError_top">' + text + '</span>');
	},
	show : function(el, text) {
		el.show().html('<span class="yto_onShow">' + text + '</span>');
	}
}

var wdate = function() {
	$(".Wdate").each(function() {
		$(this).focus(function() {
			WdatePicker({
				dateFmt : 'yyyy-MM-dd HH:mm:ss',
				readOnly : true
			})
		});
	});
}
// 验证日历
function rangeDate(startVal, endVal) {
	if (startVal != '') {
		var startUTC = (Date.parse(startVal.replace(/-/g, '/')) / 1000), formatUTC = (Date
				.parse(endVal.replace(/-/g, '/')) / 1000), dateGap = parseInt(formatUTC
				- startUTC);
		// return 这里写验证条件
		return (dateGap >= 0);
	}
}

//取消
$("#cancelForm").on("click", function() {
	$('#addGroupZoneFrm')[0].reset();
	window.location = _ctxPath + '/admin/zone/zone-searchZone.htm';
});
// 提交
$("#submitForm")
		.on(
				"click",
				function() {
					var formZone = $('#addGroupZoneFrm');
					var result = $.formValidator.pageIsValid('1');
					var index = 0;
					// 对日期进行校验
					var startTime = $('#startTime'), endTime = $('#endTime'), dateTip = $('#dateTip'), checkRangeDate = rangeDate(
							startTime.val(), endTime.val());
					if (startTime.val() == "" || endTime.val() == "") {
						alert('请设置时间');
						return false;
						index++;
					}
					if (startTime.val() !== "" && endTime.val() !== "") {
						if (!checkRangeDate) {
							alert('起始日期不能大于结束日期');
							return false;
							index++;
						}
					}
					if (result == true) {
						$("#submitForm").attr("disabled", true);
						$
								.ajax({
									type : 'POST',
									url : _ctxPath
											+ "/admin/zone/zone-saveGroupZone.htm",
									data : formZone.serialize(),
									success : function(data) {
										switch (data.info) {
										case '2':
											if (confirm("保存成功！")) {
												window.location = _ctxPath
														+ '/admin/zone/zone-searchZone.htm';
											}
											break;
										default:
											// alert(data.info);
											$.dialog({
												title : false,
												content : data.info,
												time : 2000
											});
											$("#submitForm").attr("disabled",
													false);
											$(".d-close").hide();
											break;
										}
									},
									error:function(data){
										alert("保存失败！");
										$("#submitForm").attr("disabled", false);
									},
									dataType : 'json'
								});
					}

				});
