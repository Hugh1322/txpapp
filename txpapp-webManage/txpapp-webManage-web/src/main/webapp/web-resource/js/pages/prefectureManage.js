$(function(){	
	//编辑排序
	$(".J_edit").on("click",function(){
		var $this=$(this);
		var $input=$this.parent().find(".J_input");
		var $num=$this.parent().find(".J_num");
		var numVal=$num.text();
		if($this.text()=="编辑"){
			$input.show();
			$num.hide();
			$this.text("确定");
			$input.val(numVal);
		}else{
			$input.hide();
			$num.show();
			$this.text("编辑");
			
			// 获取排序序号
			var rankId = parseInt($input.val()); 
			var zid = $input.attr("data-item");
			var type = $input.attr("data-type");
			$.ajax({
				type : 'POST',
				url :  _ctxPath+ '/admin/zone/zone-doSort.htm',
				data : {'zone.zoneId':zid,'zone.rank':rankId,'zone.zoneType':type},
				success : function(data) {
					switch (data.info) {
					case '1':
						$.dialog({
							title : false,
							content : "排序修改失败！",
							time : 2000
						});
						$(".d-close").hide();
						
						$num.text(numVal);
						break;
					case '2':
						$.dialog({
							title : false,
							content : "排序修改成功！",
							time : 2000
						});
						$(".d-close").hide();
						$num.text($input.val());
						window.location.reload();
						break;
					}
				},
				dataType : 'json'
			});
		}
	});
		
		
		//编辑排数
		$(".J_edits").on("click",function(){
			var $this=$(this);
			var $input=$this.parent().find(".J_inputs");
			var $num=$this.parent().find(".J_num");
			var numVal=$num.text();
			if($this.text()=="编辑"){
				$input.show();
				$num.hide();
				$this.text("确定");
				$input.val(numVal);
			}else{
				$input.hide();
				$num.show();
				$this.text("编辑");
				
				// 获取排序序号
				var lineNo = parseInt($input.val()); 
				var zid = $input.attr("data-item");
							
				$.ajax({
					type : 'POST',
					url :  _ctxPath+ '/admin/zone/zone-doModifyLineNo.htm',
					data : {'zone.zoneId':zid,'zone.lineNo':lineNo},
					success : function(data) {
						switch (data.info) {
						case '1':
							$.dialog({
								title : false,
								content : "排序修改失败！",
								time : 2000
							});
							$(".d-close").hide();
							
							$num.text(numVal);
							break;
						case '2':
							$.dialog({
								title : false,
								content : "排序修改成功！",
								time : 2000
							});
							$(".d-close").hide();
							$num.text($input.val());
							window.location.reload();
							break;
						}
					},
					dataType : 'json'
				});
			}
	});
	// 文本框只能输入1-10的限制
	$(".J_input").keyup(function(){
		var value = $(this).val();
		$(this).val($(this).val().replace(/[^0-9]/g,''));
		if($(this).val()>10){
			$(this).val(10);
		}
		if($(this).val()==0){
			$(this).val("");
		}
	});
	
	// 文本框只能输入1-4的限制
	$(".J_inputs").keyup(function(){
		var value = $(this).val();
		$(this).val($(this).val().replace(/[^0-4]/g,''));
		if($(this).val()>4){
			$(this).val(4);
		}
		if($(this).val()==0){
			$(this).val("");
		}
	});
	$(".J_color").on("click",function(){
		color(this);
	});
});

// 编辑
var editZone = function(zoneId){
	var zid = zoneId;
	window.location = _ctxPath+ '/admin/zone/zone-showUpdateZone.htm?zone.zoneId='+zoneId;
				
}

//设置为历史团购
var setHistoryGroupPurchase = function(zoneId){
	$.get
	(_ctxPath+ '/admin/zone/zone-setHistoryGroupBuy.htm',{"groupActivity.groupId":zoneId},
		function(data){
			if(data !=null && data.code=="true"){
				window.location = _ctxPath+ '/admin/zone/zone-searchZone.htm';
			}else{
				if(data !=null && data.code=="false"){
					alert('设置失败!');
				}
			}
		}
	);
}



//编辑group
var editGroupZone = function(zoneId){
	var zid = zoneId;
	window.location = _ctxPath+ '/admin/zone/zone-showGroupUpdateZone.htm?zone.zoneId='+zoneId;
				
}

//发布
var releaseZone = function(zoneId){
	var zid = zoneId;
	if (confirm("确认发布专区！")) {
		$.ajax({
			type : 'POST',
			url :  _ctxPath+ '/admin/zone/zone-doRelease.htm',
			data : {'zone.zoneId':zid},
			success : function(data) {
				switch (data.info) {
				case '1':
					$.dialog({
						title : false,
						content : "发布失败！",
						time : 2000
					});
					$(".d-close").hide();
					break;
				case '2':
					$.dialog({
						title : false,
						content : "发布成功！",
						time : 2000
					});
					$(".d-close").hide();
					window.location.reload();
					break;
				}
			},
			dataType : 'json'
		});
	}
}
//发布
var releaseGroupZone = function(zoneId){
	var zid = zoneId;
	if (confirm("确认发布专区！")) {
		$.ajax({
			type : 'POST',
			url :  _ctxPath+ '/admin/zone/zone-doGroupRelease.htm',
			data : {'zone.zoneId':zid},
			success : function(data) {
				switch (data.info) {
				case '1':
					$.dialog({
						title : false,
						content : "发布失败！",
						time : 2000
					});
					$(".d-close").hide();
					break;
				case '2':
					$.dialog({
						title : false,
						content : "发布成功！",
						time : 2000
					});
					$(".d-close").hide();
					window.location.reload();
					break;
				}
			},
			dataType : 'json'
		});
	}
}
//查看
var showGroupZone = function(zoneId){
	window.location = _ctxPath+ '/admin/zone/zone-showGroupZonePage.htm?zone.zoneId='+zoneId;
}
// 查看
var showZone = function(zoneId){
	window.location = _ctxPath+ '/admin/zone/zone-showZone.htm?zone.zoneId='+zoneId;
}
// 团购件数人数调整
var showGroupZoneList = function(groupId){
	window.location = _ctxPath+ '/seller/product/group/gp-getGroupItemList.htm?groupActivity.groupId='+groupId;
}
// 团购件数人数调整
var configGroupProduct = function(groupId){
	window.location = _ctxPath+ '/seller/product/group/gp-configGroupProduct.htm?groupItemPage.params.groupId='+groupId;
}

//下架
var offGroupZone = function(zoneId){
	var zid = zoneId;
	if (confirm("确认下架专区！")) {
		$.ajax({
			type : 'POST',
			url :  _ctxPath+ '/admin/zone/zone-doGroupOff.htm',
			data : {'zone.zoneId':zid},
			success : function(data) {
				switch (data.info) {
				case '1':
					$.dialog({
						title : false,
						content : "下架失败！",
						time : 2000
					});
					$(".d-close").hide();
					break;
				case '2':
					$.dialog({
						title : false,
						content : "下架成功！",
						time : 2000
					});
					$(".d-close").hide();
					window.location.reload();
					break;
				}
			},
			dataType : 'json'
		});
	}
	
				
}

// 逻辑删除
var logicDelete = function(zoneType, zoneId){
	if (confirm("确认删除专区吗？")) {
		$.ajax({
			type : 'POST',
			url :  _ctxPath+ '/admin/zone/zone-logicDelete.htm',
			data : {'zone.zoneType':zoneType, 'zone.zoneId':zoneId},
			success : function(data) {
				if(data.code || data.code == 'true'){
					alert(data.info);
				}
				window.location.reload();
			},
			dataType : 'json'
		});
	}
				
}

//下架
var offZone = function(zoneId){
	var zid = zoneId;
	if (confirm("确认下架专区！")) {
		$.ajax({
			type : 'POST',
			url :  _ctxPath+ '/admin/zone/zone-doOff.htm',
			data : {'zone.zoneId':zid},
			success : function(data) {
				switch (data.info) {
				case '1':
					$.dialog({
						title : false,
						content : "下架失败！",
						time : 2000
					});
					$(".d-close").hide();
					break;
				case '2':
					$.dialog({
						title : false,
						content : "下架成功！",
						time : 2000
					});
					$(".d-close").hide();
					window.location.reload();
					break;
				}
			},
			dataType : 'json'
		});
	}
	
				
}
/*颜色搭配方案*/
var color=function(ctrl){
	var colors=$(ctrl).parent().find(".zoneColors").val();
	var id =$(ctrl).parent().find(".zoneId").val();
	var html='<form action="'+_ctxPath+'/admin/zone/zone-saveZoneColors.htm" id="colorForm"><select class="J_select color_select">'+
	'<option value="0">请选择配色方案</option>'+
	'<option value="cff8" '+(colors == 'cff8'?'selected="selected"':"")+' class="cff8">休闲零食</option>'+
	'<option value="ce36" '+(colors == 'ce36'?'selected="selected"':"")+'  class="ce36">五谷杂粮</option>'+
	'<option value="cd99" '+(colors == 'cd99'?'selected="selected"':"")+'  class="cd99">南北干货</option>'+
	'<option value="cf56" '+(colors == 'cf56'?'selected="selected"':"")+'  class="cf56">冲饮谷物</option>'+
	'<option value="cd17" '+(colors == 'cd17'?'selected="selected"':"")+'  class="cd17">优选名茶</option>'+
	'<option value="cc81" '+(colors == 'cc81'?'selected="selected"':"")+'  class="cc81">酒水饮料</option>'+
	'<option value="c51c" '+(colors == 'c51c'?'selected="selected"':"")+'  class="c51c">调味酱料</option>'+
	'<option value="c7ab" '+(colors == 'c7ab'?'selected="selected"':"")+'  class="c7ab">生鲜食品</option>'+
	'<option value="c4d9" '+(colors == 'c4d9'?'selected="selected"':"")+'  class="c4d9">滋补营养</option>'+
    '</select><p class="J_tip red"></p>'+
    '<input type="hidden" name="zone.zoneId" value="'+colors+'">'+
    '<input type="hidden" name="zone.colors"  value="'+id+'">'+
	'</form>';
	$.dialog({
		"title":"颜色搭配",
		"lock":true,
		"content":html,
		"cancelValue":"取消",
		"cancel":true,
		"okValue":"确定",
		"ok":function(){
			if($(".J_select").val()!="0"){
				changColors(id,$(".J_select").val(),function(va){
					$(ctrl).parent().find(".zoneColors").val(va)
				});
			}else{
				$(".J_tip").text("请选择一种配方方案");
				setTimeout(function(){
					$(".J_tip").text("");
				},1000)
				return false;
			}
		}
	});
}

function changColors(id,value,onSuccess){
	$.ajax({
		type: "POST",
	   	url:  _ctxPath+'/admin/zone/zone-saveZoneColors.htm',
	   	data: {
	   		"zone.zoneId":id,
	   		"zone.colors":value
	   	},
	   	success: function(data){
	     	if(data.code=="true" && onSuccess){
	     		onSuccess(value);
	     	}else{
	     		alert("修改失败");
	     	}
	   	}
	});
}
/*
//显示
var show = function(zoneId){
	if (confirm("是否执行此操作?")) {
		$.ajax({
			type : 'POST',
			url :  _ctxPath+ '/admin/zone/zone-show.htm',
			data : {'zone.zoneId': zoneId},
			dataType : 'json',
			success : function(data) {
				if(data.code = 'true'){
					$.dialog({
						title : false,
						content : data.info,
						time : 2000
					});
					window.location.reload();
				}
			}
		});
	}			
};
//隐藏
var hide = function(zoneId){
	if (confirm("是否执行此操作?")) {
		$.ajax({
			type : 'POST',
			url :  _ctxPath+ '/admin/zone/zone-hide.htm',
			data : {'zone.zoneId': zoneId},
			dataType : 'json',
			success : function(data) {
				if(data.code = 'true'){
					$.dialog({
						title : false,
						content : data.info,
						time : 2000
					});
					window.location.reload();
				}
			}
		});
	}			
};*/
