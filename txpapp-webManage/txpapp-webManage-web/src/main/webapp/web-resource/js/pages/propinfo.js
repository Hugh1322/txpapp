﻿/*
$(document).ready(function(){
	//alert(_ctxPath);
});
*/
var targetObj;
/*
 * 加载子集
 */
function changeArea(val,tag) {
	targetObj = tag;
	//alert(targetObj);
	$.ajax({
		type: "POST",
		dataType : 'json',
		async:false,
	    url: _ctxPath + "/admin/propinfo/propinfo-listChildPropinfo.htm",
	    data:{"propinfo.propId":val},
	    success: function(data){
	    	removeFromList(targetObj);
      		var opt="<option value='-1'>请选择</option>";
      		targetObj.append(opt);

        	for(var i=0;i<data.length;i++){
        		opt="<option value='"+data[i].propId+"'>"+data[i].name+"</option>";
      			targetObj.append(opt);
        	}
        	for(var j=0;j<targetObj.nextAll("select").length;j++) {
        		var opt_ = "<option value='-1'>请选择</option>";
        		targetObj.nextAll("select").eq(j).append(opt_);
        	}
	    }
	});
}

/*
给定某个数值，在下拉选单中选择
*/
function locateArea(obj,locateStr){

if(typeof(obj)!="undefined" && null!=obj && null!=obj.children()){

	for(var i=0;i<obj.children().length;i++){
			if(locateStr==obj.children()[i].value){
				obj.children()[i].selected = "selected";
				break;
			}
		}
	}	
}
//删除子元素
function removeFromList(listname) {
	if(listname.children().length>0){
		listname.empty();
  	}
	for(var i=0;i<listname.nextAll("select").length;i++) {
		listname.nextAll("select").eq(i).empty();
	}
}
