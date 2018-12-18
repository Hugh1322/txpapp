/**
 * 
 */
$.fn.placeholder = function(){
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
				    placeholder.attr("id","pl_"+input.attr("id"));
				try{
					pdl = input.css('padding-left').match(/\d*/i)[0] * 1;
				}catch(e){
					pdl = 5;
				}
				placeholder.css({'margin-left': -(width-pdl),'height':height,'line-height':height+"px",'position':'absolute', 'color': "#999999", 'font-size' : "13px"});
				
				placeholder.click(function(){
					$(this).hide();
					input.focus();
				});
				input.focus(function(){
				//	if(placeholder.is(":hidden")){
				//		return ;
				//	}else{
						placeholder.hide();
				//	}
				});
				if(input.val()){
					placeholder.hide();
				}
				placeholder.insertAfter(input);
				input.blur(function(){
				 		if(!$(input).val()){
						placeholder.show();
					}
				}) 
			});
		}
		return this;
	};
	
 	
