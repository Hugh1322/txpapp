/**
 * prop 包含属性
 * table:jquery选择器表达式或者控件对象
 * editTrigger:jquery选择器表达式或控件本身,默认为'.editTrigger'
 * saveTrigger:jquery选择器表达式或控件本身,默认为'.saveTrigger'
 * addTrigger:jquery选择器表达式或控件本身,默认为'.addTrigger'
 * editable:需要编辑的td的class属性,默认为'editable'
 * onEdit:触发编辑时候的回调
 * onSaved:触发保存的时候的回调
 * onAdd:触发添加的时候的回调
 * 在所有的回调中,如果有回调并且回调明确地返回false,则其对应的事件将被阻断不在发生
 * inputTextClass:编辑的时候输入文本框的样式
 * switchTrigger:时候需要切换触发,如果为true,则editTrigger,和saveTrigger只显示一个
 */
var TableEdit = function(properties){
	this.prop = properties;
	this.table = $(this.prop.table)
	this.editTrigger = this.prop.editTrigger || '.editTrigger';
	this.saveTrigger = this.prop.saveTrigger || '.saveTrigger';
	this.addTrigger = this.prop.addTrigger || '.addTrigger';
	this.deleteTrigger = this.prop.deleteTrigger || '.deleteTrigger';
	this.prop.onEdit= this.prop.onEdit || function(){};
	this.prop.editableTdClass =this.prop.editableTdClass || 'editable';
	this.prop.inputTextClass =this.prop.inputTextClass || '';
	 
};

TableEdit.prototype.init=function(){
	var outCaller = this;
	$(this.table).find(this.editTrigger).on('click',function(){
		if(outCaller.prop.onEdit){
			var result =outCaller.prop.onEdit(this);
			if(result === false){
				return ;
			}
		}
		$(this).parents('tr').find('td.'+outCaller.prop.editableTdClass).each(function(){
			var source = $(this).html()||'';
			var inputHtml = outCaller.prop.inputHtml ||"<input type='text' class='"+outCaller.prop.inputTextClass+"' value='"+source+"'>";
			$(this).html(inputHtml);
		});
		if(outCaller.prop.switchTrigger){
			outCaller.switchTrigger($(this),outCaller.saveTrigger)
		}
	});
	$(this.table).find(this.saveTrigger).on('click',function(){
		if(outCaller.prop.onSaved){
			var result = outCaller.prop.onSaved(this);
			if(result === false){
				return ;
			}
		}
		$(this).parents('tr').find('td.'+outCaller.prop.editableTdClass).each(function(){
			var value = $(this).find('input').val();
			$(this).remove("input[type='text']")
			$(this).html(value)
		});
		
		if(outCaller.prop.switchTrigger){
			outCaller.switchTrigger($(this),outCaller.editTrigger)
		}
	})
	$(this.table).find(this.addTrigger).on('click',function(){
		if(outCaller.prop.onAdd){
			var result =  outCaller.prop.onAdd(this);
			if(result === false){
				return ;
			}
		}
		var newCtrl= $(this).parents('tr').clone(true);
		$(outCaller.table).append(newCtrl);
		
	});
	$(this.table).find(this.deleteTrigger).on('click',function(){
		if(outCaller.prop.onDelete){
			var result =  outCaller.prop.onDelete(this);
			if(result === false){
				return ;
			}
		}
		$(this).parents('tr').remove();
	})
}

TableEdit.prototype.switchTrigger =function (hiddenCtrl,showCtr){
	if(this.prop.switchTrigger){
		 $(hiddenCtrl).hide();
    	 $(hiddenCtrl).parent().find(showCtr).show();
	}
}

