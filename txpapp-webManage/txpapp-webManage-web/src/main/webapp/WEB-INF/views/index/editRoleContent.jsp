<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<%@include file="../include/taglibs.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
	span.folder{
		background-image: url("${_treePath}/images/folder.gif");
		background-repeat: no-repeat;
		font-size: 14px;
		padding-left: 20px;
		height: 17px;
	}

	/*ul li{
        list-style: none;
    }*/
</style>
<div id="locSubInput">

	<div class="addADV cf">
		<label for=""><i class="red">*</i>权限名称：</label>
		<div class="infoADV leftFloat">

			<input type="text"  style="width: 150px"  name="roleCode" value="${role.roleCode}" id="roleCode" class="locSubInput"/>
			<div id="currentPriceTip21"></div>
		</div>
	</div>
	<div class="addADV cf">
		<label for=""><i class="red">*</i>权限名称：</label>
		<div class="infoADV leftFloat">

			<input type="text"  style="width: 150px"  name="roleName" value="${role.roleName}" id="roleName" class="locSubInput"/>
			<div id="currentPriceTip22"></div>
		</div>
	</div>
</div>
<div class="addADV cf">
	<label for=""><i class="red">*</i>权限描述：</label>
	<div class="infoADV">
						<textarea name="roleDesc" id="roleDesc"
								  style="width: 450px; height: 70px;">${role.roleDesc}</textarea>
		<span>最大支持50个中文字长度</span>
		<div id="descContentTip"></div>
	</div>
</div>
<br>
<!-- 标题显示 -->
<div id="Title_bar">
	<div id="Title_bar_Head">
		<div id="Title_Head"></div>
		<div id="Title"><!--页面标题-->
			<input type="checkbox" id="chkAll" onclick="$('[name=chkbox]').attr('checked',this.checked)">
			<label for="chkAll">全选</label>
			配置权限
		</div>
		<div id="Title_End"></div>
	</div>
</div>

<!--显示表单内容-->
<div id=MainArea>
	<ul id="tree">
	<c:forEach items="${treeList}" var="treeL1" varStatus="ccc">
		<li>
			<input class="roleLv1" role-lv="1" type="checkbox" id="${ccc.index}" name="chkbox" value="${treeL1.id}" <c:if test="${treeL1.checked}">checked</c:if> >
			<label for="${ccc.index}"><span class="folder">${treeL1.name}</span></label>
			<c:if test="${not empty treeL1.children}">
				<c:forEach items="${treeL1.children}" var="treeL2">
					<ul>
						<li>
							<input class="roleLv2" role-lv="2" type="checkbox" id="${treeL2.id}" name="chkbox" value="${treeL2.id}" <c:if test="${treeL2.checked}">checked</c:if>>
							<label for="${treeL2.id}"><span class="folder">${treeL2.name}</span></label>
							<c:if test="${not empty treeL2.children}">
								<c:forEach items="${treeL2.children}" var="treeL3">
									<ul>
										<li><input class="roleLv3" role-lv="3" type="checkbox" id="${treeL3.id}" name="chkbox" value="${treeL3.id}" <c:if test="${treeL3.checked}">checked</c:if>>
											<label for="${treeL3.id}"><span class="">${treeL3.name}</span></label></li>
									</ul>
								</c:forEach>
							</c:if>

						</li>
					</ul>
				</c:forEach>
			</c:if>

		</li>
	</c:forEach>
	</ul>

</div>

<script language="javascript">
	$("#tree").treeview();

	$(function(){
		$("[name=chkbox]").click(function(){

			//当某一个父权限下的子权限都不选中时，该父权限也不选中
//			console.log($(this).attr("role-lv"));
			if(!this.checked && $(this).attr("role-lv")!="1") {
				var elements;
				var elementsL2=0;
				if($(this).attr("role-lv")=="3") {			//lv3
//					console.log("lv3" + this.checked);
					elements=$(this).parent("li").parent("ul").parent("li").find("ul li .roleLv3");
					elementsL2=$(this).parent("li").parent("ul").parent("li").parent("ul").parent("li").find("ul li .roleLv2");
				}else if($(this).attr("role-lv")=="2") {		//lv2
//					console.log("lv2" + this.checked);
					elements=$(this).parent("li").parent("ul").parent("li").find("ul li .roleLv2");
				}
//				console.log("同级长度："+elements.length);
				var num=elements.length;
				var a=0;
				for(var i=0;i<num;i++){
					if(elements[i].checked==false){
						a++;
					}
				}
				if(a==num){
					$(this).parent("li").parent("ul").siblings("input").attr("checked",false);
				}
				//如果是从三级子目录开始反推也取消根目录
				if(elementsL2.length>0) {
					var numL2=elementsL2.length;
					var aL2=0;
					for(var i=0;i<numL2;i++){
						if(elementsL2[i].checked==false){
							aL2++;
						}
					}
					if(aL2==numL2){
						$(this).parent("li").parent("ul").parent("li").parent("ul").parent("li").find(".roleLv1").attr("checked",false);
					}
				}
			}

			//当选中或取消一个权限时，也同时选中或取消所有的下级权限
			$(this).siblings("ul").find("input").attr("checked",this.checked);

			//当选中一个权限时，也要选中所有的直接上级权限
			if(this.checked ==true){
				$(this).parents("li").children("input").attr("checked",true);
			}



		});

	});
</script>

