/*
 * yipin_Manage V3.0
 * editer fishsky QQ:20121310
 * 2014-10-12 V:1.0
*/
var sTopNum = 0; //当前滚动条位置
var hartNum = 0;  //心跳数
var oneHartTime = 100; //一下心跳的时间
var timer = setInterval(addHart, oneHartTime);  //心跳Timer
var nowLoadNum = 0;  //当前加载的indexNum
var outTime = 50;  //超时心跳数
var loadHistory = new Array(); //加载历史记录
var lastLoadtime = -1;  //最后加载时间
var baseSize = "153"; //其实加载问价总和(KB)
var userNetSpeed = 0; //估算用户网速
var moduleSelectArr = new Array(); //菜单组件变更验证

//页面加载完成初始化脚本
$(document).ready(function(){ 
	createModule();
//	pageSite();
	
	$("#checkboxAll").on("click",function(){
		if($(this).is(":checked")){
			$("input[name='checkbox']").prop("checked",true);
		}else{
			$("input[name='checkbox']").prop("checked",false);
		}
	});
	
})

//当前滚动条位置
$(window).bind("scroll",function(){  
	//sTopNum = $(window).scrollTop();
	
});

//切换浏览模式
$(window).resize(function (){
//	pageSite();
});


//加载好基本内容计算访问者估算网速
$(window).load(function(){ 
	userNetSpeed = baseSize / hartNum;
})

//调整分页位置
/*function pageSite(){
	var mainW = $(window).width();
	var num = $(".table").find("table").width();
	if(mainW < 1035){
		$(".module_page").css("width","");
	}else{
		$(".module_page").css("width",num);		
	}	
}*/
//表格移入行变背景色
$(".table tr").not(':first').hover(function(){
	$(this).toggleClass("c-d6e1f7");
})

//键盘侦听,显示/隐藏 DEBUG
$(document).keydown(function(event){
	var keycode = event.which;
	var ifDebugShow = $("#DEBUG").css("display");
	//F1 显示/关闭DEBUG keycode = 112
	if(keycode == 113){
		if(ifDebugShow == "block"){
			$("#DEBUG").hide();
		}else{
			$("#DEBUG").show();	
		}
	}
});

//添加心跳
function addHart(){
	hartNum = hartNum + 1;	
	//基本资源加载完成
	if(userNetSpeed > 0){
		
	}
	addModuleListener();
}

//去除换行符号和空格
function delEmptyWord(str){
	str = str.replace(/[\r\n]/g, ""); 
	str = str.replace(/\s+/g, ""); 
	return str;
}

//查询出在数组的位置
function gerArrIndex(arr,str){
	var leg = arr.length;
	var backStr = -1;
	for(var i=0;i<leg;i++){
		if(arr[i] == str){
			backStr = i;
		}
	}
	return backStr;
}

//清理数组
function delArr(arr){
	var leg = arr.length;
	
	for(var i=0;i<leg;i++){
		arr.pop();	
	}
}

//数组每一项更改为0
function changeArrtozero(arr){
	var leg = arr.length;
	
	for(var i=0;i<leg;i++){
		arr[i] = 0;
	}
}

//创建所有组件
function createModule(obj){
	if(obj == undefined){
		obj = $(document);
	}
	
	//用户选项组件
	obj.find(".headInfo").ready(function(e) {
		var subConObj = $(".headInfo").find("dd");
        $(".headInfo").find("dl").mouseenter(function (){
			var wNum = $(this).width();
			subConObj.find(".userInfo i").css("left",(wNum-10)/2)
			subConObj.show();
			subConObj.css("width",wNum);	
		});
		$(".headInfo").find("dl").mouseleave(function (){
			var subConObj = $(this).find("dd");
			subConObj.fadeOut();	
		});
    });
	//导航组件
	obj.find("title").ready(function(e) {
		
        var titleStr = $("title").html();
		var temArr = titleStr.split("-");
		$(".navFrame dl").each(function(index, element) {
            var subLeg = $(this).find("dd a").length;
			var titObj = $(this).find("dt");
			var titStr = titObj.text();
			if(subLeg > 0){
				titObj.html("<a href='javascript:'>" + titStr + "<em></em></a>");	
			}else{
				var onlyOneUrl = $(this).find("dt a").attr("href");
				titObj.html("<a href='" + onlyOneUrl + "'>" + titStr + "</a>");	
			}
			$(this).find("dd a").each(function(index, element) {
                var subTitStr = $(this).html();
				if(subTitStr == temArr[1]){
					$(this).addClass("ahover");
				}
            });		
			//alert(titStr);
			if(titStr == temArr[0]){
				titObj.addClass("hover");
				$(this).find("dd").show();	
			}
			$(this).find('dd a:even').addClass('even')
        });
		$(".slideArrow").click(function (){
			var num = $(".slideNav").css("left");
			if(num == "-178px"){
				$(".slideNav").css("left","0");
				$(".main").css("marginLeft","180px");
				$(this).css("left","180px");
			}else{
				$(".slideNav").css("left","-178px");
				$(".main").css("marginLeft","0");
				$(this).css("left","0");
			}
		});
		$(".navFrame dt").click(function (){
			var leg;
			var subObj = $(this).parent().find("dd");
			
			leg = subObj.find("a").length;
			if(leg > 0){
				$(".navFrame dt em").removeClass("emhover");
				$(this).find("em").addClass("emhover");
				$(".navFrame dd").hide();
				subObj.show();	
			}
		}); 
    });
	//页面分页代码组件
	obj.find(".module_page").ready(function(e) {
        var pageRule = obj.find(".module_page").html() + "resultPage.currentPage=";
		var hangRule = "&resultPage.limit=";
		var totRule = "&resultPage.total=";
		var totalNum = parseInt($(".module_page").attr("totnum"));//总记录数
		var totPageNum;//总页数
		var selectNum;
		var hangNum;
		var htmlStr = "";
		var urlName = window.location + "";
		selectNum = urlName.split("resultPage.currentPage=")[1];
		if(totalNum > 1 && selectNum == undefined){
			selectNum = "0";
		}
	if(getUrlParam('resultPage.currentPage')){
		if(getUrlParam('resultPage.currentPage')*getUrlParam('resultPage.limit')>=getUrlParam('resultPage.total')){
			selectNum = "0";
		};};
		
		if(selectNum != undefined){
			hangNum = urlName.split("resultPage.limit=")[1];
			if(hangNum != undefined){
				hangNum = hangNum.split("&")[0];
			}else{
				hangNum = 20;	
			}	
			if ((totalNum % hangNum) == 0) {
				totPageNum = totalNum / hangNum;
			} else {
				if(totalNum%hangNum != 0){
					totPageNum = Math.floor(totalNum / hangNum) + 1;
				}else{
					totPageNum = Math.floor(totalNum / hangNum);
				}
			}
			totPageNum = Math.floor(totPageNum);
			selectNum = parseInt(selectNum.split("&")[0]);
			if(selectNum < 0 || selectNum > (totPageNum - 1)){
				obj.find(".module_page").html("");
				
			}else{
				
				var tempStr = obj.find(".module_page").html().split("<a").length;
				if(tempStr <= 1){
					createPage();
				}
			}
		}else{
			obj.find(".module_page").html("");
		}	
	
		//当前页码存在才创建分页
		function createPage(){		
			var showNum = 7;			
			for(var i=0;i<showNum;i++){
				var num;
				var ifOut = false;
				
				if(selectNum > 2 && selectNum < (totPageNum - 1)){
					num = selectNum+i-2;	
				}else if(selectNum > (totPageNum - 2)){
					num = selectNum+i-4;
				}else{
					num = i;	
				}
				
				if(num < 0 || num > (totPageNum - 1)){
					ifOut = true;	
				}
				
				if(ifOut == false){
					if( i < 5){
						htmlStr = htmlStr + aStr(selectNum,(num),delEmptyWord(pageRule+(num)+ hangRule + hangNum + totRule + totalNum));
					}else if(i==5){
						if(totPageNum > 5 && selectNum <= (totPageNum - 4)){
							htmlStr = htmlStr + "<span>...</span>";
						}
					}else if(i == (showNum - 1) && (num-1)<=totPageNum ){
						htmlStr = htmlStr + aStr(selectNum,(totPageNum),delEmptyWord(pageRule+(totPageNum)+ hangRule + hangNum + totRule + totalNum));	
					}	
				}
			}
			if((selectNum) >= 1){
				htmlStr = '<a href="' + delEmptyWord(pageRule+(selectNum-1) + hangRule + hangNum + totRule + totalNum) + '" class="prev">上一页</a>' + htmlStr;
			}
			if((selectNum) < (totPageNum-1) && totPageNum >1){
				htmlStr = htmlStr + '<a href="' + delEmptyWord(pageRule+(selectNum+1)+ hangRule + hangNum + totRule + totalNum) + '" class="next">下一页</a>';	
			}
			htmlStr = htmlStr + '<label for="">共' + totalNum + '条记录&nbsp;&nbsp;每页显示：</label><dl><div class="nowSelect"><dt>' + hangNum + '条<i></i></dt></div><div class="select"><ul><li><a href="' + delEmptyWord(pageRule+(selectNum) + hangRule) +'100&' + totRule + totalNum + '">100条</a></li><li><a href="' + delEmptyWord(pageRule+(selectNum) + hangRule) +'50&' + totRule + totalNum +'">50条</a></li><li><a href="' + delEmptyWord(pageRule+(selectNum) + hangRule) +'20' + totRule + totalNum +'">20条</a></li></ul></div></dl>';
			
			$(".module_page").html(htmlStr).ready(function(e) {
			   $(".module_page .nowSelect").mouseenter(function (){
					$(".module_page .select").show();
			   }); 
			   $(".module_page .select").mouseleave(function (){
					$(".module_page .select").hide();   
			   });
			   $(".module_page .select li").click(function (){
					var str = $(this).find("a").html() + "<i></i>";
					$(".module_page .nowSelect dt").html(str);  
					$(".module_page .select").hide();  
			   });
			});		
			function aStr(selectNum,nowNum,url){
				var backStr = "";
				if(selectNum == nowNum){
					backStr = '<a href="' + url + '" class="cur">' + (nowNum+1) + '</a>';
				}else{
					backStr = '<a href="' + url + '">' + (nowNum+1) + '</a>';	
				}	
				return backStr;
			}
		}
    }); 
	//选择菜单组件
	obj.find(".module_Select").each(function(index, element) {
		var selectName = "";
		var selectVal = "";
		var htmlStr = "";
		var nowParID = "";
		var parObj;
		
		$(this).find(".trueMenu option").each(function(index, element) {
            var vals = $(this).val();
			var texts = $(this).html();
			var ifSelect = $(this).attr("selected");			
			if(ifSelect == "selected"){
				selectName = texts;
				selectVal = vals;
			}
			htmlStr = htmlStr + '<a valNum="' + vals + '" href="javascript:">' + texts + '</a>';
        });
		htmlStr = '<dl class="selectMenu"><dt class="bgcf9f bdStyle" vals="' + selectVal + '">' + selectName + '<i></i></dt><dd>' + htmlStr + '</dd>' +'</dl>';
		
		nowParID = "module_Select_" + Math.floor(Math.random()*10000) +"_"+ + index ;
		$(this).attr("id",nowParID);
		parObj = $("#" + nowParID);
		
		$(this).find(".newSelectCer").html(htmlStr).ready(function(e) {
           var newMenuObj = parObj.find(".selectMenu");
		   //var maxWidth = newMenuObj.find("dd").width() + 3;
           var maxWidth =143;
		   newMenuObj.css("width",maxWidth);
		   newMenuObj.mouseenter(function (){
			   $(this).find("dd").show();   
		   });
		   newMenuObj.find("dd").mouseleave(function (){
			   newMenuObj.find("dd").hide();   
		   });
		   newMenuObj.find("dd a").click(function (){
			   newMenuObj.find("dd").hide();
			   var vals = $(this).attr("valnum");
			   var names = $(this).html();
			   var selectObj = $(this).parent().parent().find("dt");
			   var trueSelectObj = parObj.find(".trueMenu");
			   selectObj.html(names + "<i></i>");
			   selectObj.attr("vals",vals);
			   trueSelectObj.find("option").attr("selected",false);
			   trueSelectObj.find("option").eq($(this).index()).attr("selected",true);	   
			   trueSelectObj.trigger("change");
		   });
        });
    });
	//日期组件,单日期选项
	obj.find(".calendarOne").ready(function(e) {
		var nowCID;
        //创建一个单日期选项
		var classMap = [];
			classMap[ Kalendae.moment().add({d:5}).format('YYYY-MM-DD') ] = 'closed';
			
		new Kalendae(document.body, {
			dateClassMap: classMap
		});
		$(".kalendae").hide();
		$(".calendarOne").each(function(index, element) {
            var cID = "calendarOneCon_" + index;
			$(this).attr("id",cID);
			$(this).attr("readonly","");
        });
		$(".calendarOne").click(function (){
			var cObj = $(".kalendae");
			var topNum = $(this).offset().top + 30;
			var leftNum = $(this).offset().left;
			nowCID = $(this).attr("id");
			cObj.css("top",topNum);
			cObj.css("left",leftNum);
			cObj.css("position","absolute");	
			$(".kalendae").show();
			
		});	
		$(".kalendae").find(".k-days span").click(function (){
			var date = $(this).attr("data-date");
			$("#" + nowCID).val(date);
		});
		$(".kalendae").mouseleave(function (){
			$(".kalendae").hide();
		});	
    });
	//日期组件,双日期选项
	obj.find(".calendarTwo").each(function(index, element) {
        var parObj;
		var htmlStr = '<dt class="bgcf9f bdStyle"><input name="" type="text" readonly></dt><b> - </b><dt class="bgcf9f bdStyle"><input name="" type="text" readonly><input class="calendar_data" name="" type="text"></dt><i></i><div id="" class="calendarCon"></div>';
		var nowParID = "moduleCalendar_" + index;
		$(this).attr("id",nowParID);
		parObj = $("#" + nowParID);
		$(this).html(htmlStr).ready(function(e) {
			var conID = "calendarCon_" + index;
			parObj.find(".calendarCon").attr("id",conID);
			moduleCalendar("TWO",conID);
			parObj.find("i").click(function (){
				var id = $(this).parent().attr("id");
				$("#" + id).find(".calendarCon").show();
				enterVal();
			});			
        });
		$(".calendarCon").mouseleave(function (){
			$(this).hide();
		});
		//创建日期
		function moduleCalendar(type,CID){
			new Kalendae({
				attachTo:document.getElementById(CID),
				months:2,
				mode:'range',
				selected:[Kalendae.moment().subtract({M:1}), Kalendae.moment().add({M:0})]
			});
			var parObj = $("#" + CID).parent();
			parObj.find(".k-calendar .k-days span").click(function (){
				var obj = parObj.find(".calendar_data");
				var oldDate = obj.val();
				var dateStr = $(this).attr("data-date");
				var ifMax = true;
				
				if(oldDate == ""){
					parObj.find("input").eq(0).val("");
					parObj.find("input").eq(1).val("");
					obj.val(dateStr);
				}else{
					ifMax = getDateType(obj.val(),dateStr);
					if(ifMax == true){
						parObj.find("input").eq(0).val(oldDate);
						parObj.find("input").eq(1).val(dateStr);
					}else{
						parObj.find("input").eq(0).val(dateStr);
						parObj.find("input").eq(1).val(oldDate);	
					}
					obj.val("");
				}
			});
		}
		//判断新输入的日期大小
		function getDateType(oldDate,newDate){
			var sDate = new Date(oldDate);
			var eDate = new Date(newDate);
			var backStr = true;
			if(sDate > eDate){
				backStr = false;
			}
			return backStr;
		}
		//默认展开输入到Input
		function enterVal(){
			var nowData = new Array();
			var leg;
			parObj.find("span").each(function(index, element) {
				var ifSelect = $(this).hasClass("k-selected");
				if(ifSelect == true){
					nowData.push($(this).attr("data-date"));
				}
			});
			leg = nowData.length;
			if(leg == 1){
				parObj.find("input").eq(0).val("");
				parObj.find("input").eq(1).val("");
			}else{
				parObj.find("input").eq(0).val(nowData[0]);
				parObj.find("input").eq(1).val(nowData[nowData.length - 1]);		
			}
		}		
    });
	obj.find(".searchInput").each(function(i){
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
}
//各种组件
function addModule(){
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
	//菜单组件
	$(".menuList").each(function(index, element) {
        $(this).find(".select").hide();
		getInfo($(this));
		function getInfo(obj){
			obj.find("option").each(function(index, element) {
                var val = $(this).val();
				var name = $(this).html();
				var str = "<li vals=\"" + val + "\">" + name + "</li>";
				obj.find("ul").append(str);
            });
			soreFormant(obj);
		}
		function soreFormant(obj){
			var maxWidth = 0;
			var leg = obj.find("li").length;
			var liHeight = 25;
			var fontSize = "12px";
			var btnWidth = obj.find("span").width();
	
			obj.find("li").each(function(index, element) {
                if(index == 0){
					maxWidth = $(this).width();
				}else{
					if($(this).width()>maxWidth){
						maxWidth = $(this).width();	
					}
				}
				obj.find("li").css("height",liHeight);
				obj.find("li").css("lineHeight",liHeight + "px");
				obj.find("li").css("fontSize",fontSize);
				obj.find("li").css("margin","0px");
				obj.find("li").css("borderBottom","1px solid #FFF");
            });	
			obj.css("width",maxWidth);
			obj.css("text-align","right");
			obj.find("span").css("fontSize",fontSize);
			obj.find(".selectBtn").css("height",liHeight);
			obj.find(".selectBtn").css("lineHeight",liHeight + "px");
			obj.find("ul").css("width",maxWidth);
			obj.find("ul").css("position","relative");
			obj.find("ul").css("height",leg*(liHeight+1));
			obj.find("ul").css("background","#000000");
			obj.find("ul").css("opacity","0.8");
			obj.find("ul").css("z-index","100");
			obj.find("ul").hide();
			obj.find(".selectVal").val("");
			obj.find(".selectVal").hide();
			//obj.css("height",(leg*(liHeight+1) + obj.find(".selectBtn").height()));
			obj.css("position","absolute");
			
			obj.find("li").click(function (){
				var vals = $(this).attr("vals");
				var names = $(this).html();
				obj.find("span").html(names + "<i>></i>");
				obj.find("ul").fadeOut();	
				obj.find(".selectVal").val(vals);
			});
			
			obj.find("span").mouseover(function (){
				obj.find("ul").fadeIn();	
			});
			
			obj.mouseleave(function (){
				obj.find("ul").fadeOut();		
			});
		}
    });
}
//添加组件侦听
function addModuleListener(){
	$(".trueMenu").each(function(index, element) {
		var obj = $(this);
		var nowObjID = obj.parent().attr("id");
		var nowSelectIndex =  obj.get(0).selectedIndex;
		
		if(moduleSelectArr[index] == undefined){
			moduleSelectArr[index] = nowSelectIndex;
			changeNowModule(nowObjID,index);
		}else{
			if(moduleSelectArr[index] != nowSelectIndex){
				moduleSelectArr[index] = nowSelectIndex;
				changeNowModule(nowObjID,index);
			}
		}
		
		$("#DEBUG").html(moduleSelectArr);
		function changeNowModule(id,arrIndex){
			var obj = $("#" + id + " .newSelectCer");
			var showObj = obj.find("dt");
			var newName = obj.find("dd a").eq(moduleSelectArr[arrIndex]).html();
			var newVal = obj.find("dd a").eq(arrIndex).attr("vals");
			showObj.html(newName + "<i></i>");
			showObj.attr("vals",newVal);
		}
		function getName(obj){
			var backStr = "";
			obj.each(function(index, element) {
				$(this).find("option").each(function(index, element) {
				   var ifSelect = $(this).get(0).selectedIndex;
				   if(ifSelect == "selected"){
						backStr = ifSelect;
				   }
				});
            });
			return backStr;
		}   
    });	
	
}

function showMsgDialog(obj){
	$.dialog({
		title: "提示",
		lock:true,
		content: obj,
		okValue: "确定",
	    time:5000
	});
}

//比较日前大小  如果开始大于结束，返回true
function compareDate(checkStartDate, checkEndDate) {      
    var arys1= new Array();      
    var arys2= new Array();    
	if(checkStartDate != null && checkEndDate != null) {      
	    arys1=checkStartDate.split('-');      
	    var sdate=new Date(arys1[0],parseInt(arys1[1]-1),arys1[2]);      
	    arys2=checkEndDate.split('-');      
	    var edate=new Date(arys2[0],parseInt(arys2[1]-1),arys2[2]);    
		if(sdate > edate) {      
		    return true;         
		}else{   
		    return false;      
	    }   
    }      
}

function checkTrim(str){
	if(str==undefined||str==null||str.trim()==''){
		return false;
	}else{
		return true;
	}
}

//获取url中的参数
function getUrlParam(name) {
    var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)"); 
    var r = window.location.search.substr(1).match(reg);  
    if (r != null) return unescape(r[2]); return null; 
}