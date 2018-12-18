/**
 * 
 */
function delAdv(id,url){// 删除广告
		$.dialog({
			  lock: true,
			  padding: "5px",
			  title:false,
			  content:"确认删除该项吗?",
			  fixed: false,
			  cancel: true,
			  cancelValue:"取 消",
			  ok:function(){
				  $.ajax({
						url:url,
						type:"POST",
						data:{'adv.advertisementId':id},
						dataType:"json",
						async: false,
						success:function(data){
							if(data.code==3){// 删除成功
								window.location.reload();
							}else{
								alert("删除失败!");
							}
						}
					});
			  },
			  okValue:"删除"
		});
	}


var clickAddOrEdit=function(id,actionUrl){
	// alert(code+"----"+${SHUFFLING_FIGURE});
	var html = '';
	$.ajax({
		url: actionUrl,// + "/admin/adv/seasonal_toEditDetail.htm",
		type:"POST",
		data:{'adv.advertisementId':id},
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
				  var result = $.formValidator.pageIsValid('1');
				  if(!result){
				  	return false;
				  }
				 $("#advForm").submit();
			  },
			  okValue:"发  布"
			});
		},
		error:function(data){
			// alert(data.responseText);
		}
	});
};

function addAdv(formId){
	var result = $.formValidator.pageIsValid('1');
	if(!result){
		return false;
	}
	$("#"+formId).submit();
}

var imgView=function(obj){
	  $.dialog({
	    lock: true,
	    padding: "5px",
	    title:false,
	    content : "<img src="+$(obj).prev().html()+" width='100'/>",
	    fixed: true,
	    cancel: true,
	    cancelValue: "关  闭",
	    closed:false
	  });
	  $(".d-close").hide();
};


// 选择广告位置 改变图片大小提示
$(function(){
var advPositionWH = $("#advPositionWH");
var data,dataDetail;
advPositionWH.on("change",function(){
	var $this = $(this).find("option:selected");
	var advPositionId = $this.val();
	$("#advUploadImageTip > span:visible").hide();
	$("#advPosition-" + advPositionId).show();
});

});
function addAdv(index){
var result = $.formValidator.pageIsValid('1');
if(!result){
	return false;
}
$("#advForm").submit();
}

jQuery.fn.placeholder = function(){
	var i = document.createElement('input'),
		placeholdersupport = 'placeholder' in i;
	if(!placeholdersupport){
		var inputs = jQuery(this);
		inputs.each(function(){
			var input = jQuery(this),
				text = input.attr('placeholder'),
				pdl = 0,
				height = input.outerHeight(),
				width = input.outerWidth(),
				placeholder = jQuery('<span class="phTips">'+text+'</span>');
			try{
				pdl = input.css('padding-left').match(/\d*/i)[0] * 1;
			}catch(e){
				pdl = 5;
			}
			placeholder.css({'margin-left': -(width-pdl),'height':height,'line-height':height+"px",'position':'absolute', 'color': "#cecfc9", 'font-size' : "12px"});
			placeholder.click(function(){
				input.focus();
			});
			if(input.val() != ""){
				placeholder.css({display:'none'});
			}else{
				placeholder.css({display:'inline'});
			}
			placeholder.insertAfter(input);
			input.keyup(function(e){
				if(jQuery(this).val() != ""){
					placeholder.css({display:'none'});
				}else{
					placeholder.css({display:'inline'});
				}
			});
		});
	}
	return this;
};


function succusTip(content){
	 $.dialog({
		  lock: true,
		  padding: "5px",
		  title:false,
		  content:content,
		  fixed: false,
		  cancel: false,
		  okValue:"确定"
		}); 
}



