/*
 * yipin Manage Assembly
 * editer fishsky QQ:20121310,yaojianjian
 * 2014-10-15 V:1.0
*/

//快速查询选择组件Demo
//<div id="abc" class="searchInput">
//	<input type="text" name="" id="" value="" class="inputType"/>
//	<textarea name="" rows="" cols="" class="textData"></textarea>
//	<div><ul></ul></div>
//</div>
//
//$("#abc input").on('input',function(){
//    var str = $(this).val();
//	var leg = str.length;
//	
//	switch(leg){
//		case 1:
//			$("#abc textarea").html("class1_id1,class2_id2,class3_id3");
//			break;
//		case 2:
//			$("#abc textarea").html("class4_id4,class5_id5,class6_id6");
//			break;
//	}
//	
//})

$(document).ready(function() {

//快速查询选择组件
	$(".searchInput").each(function(i){
		var obj = $(this);
		var inputObj = $(this).find("input");
		var dataObj = $(this).find("textarea");
		var textDataArr = dataObj.html().split(",");
		var listObj = obj.find("div");
	
		//点击时清空的上次数据
		inputObj.click(function(){
			inputObj.val("");
		});
		//焦点丢失关闭弹出选择框
		inputObj.blur(function(){
			listObj.hide();
		});
		
		$(this).change(function(){
			listObj.find("ul").html("");
			var textDataArr = dataObj.html().split(",");
			listObj.html();
			
			for(var i=0; i<textDataArr.length; i++){
				var tempDataArr = textDataArr[i].split("_");
				listObj.find("ul").append("<li dataID='" + tempDataArr[1] +"'>"+tempDataArr[0]+"</li>");
			}
			
			listObj.find("li").mousedown(function(){
				var names = $(this).html();
				var dataID = $(this).attr("dataID");
				inputObj.val(names);
				obj.find(".valueId").val(dataID);
				listObj.hide();
			});
			
			listObj.find("li").hover(function(){
				$(this).toggleClass("hover");
			});
			
			listObj.show();
		});
	
	});

})