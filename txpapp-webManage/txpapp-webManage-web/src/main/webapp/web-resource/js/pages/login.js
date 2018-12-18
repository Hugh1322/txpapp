/* ============
 *
 * 登录页
 *
 ============= */
 $(function(){
	$('#loginCen').Merlin({
		'tabSwitcher': {
			activeCls:"cur", //选中的样式
			tabCls:".logPanel li", //切换栏列表cls
			itemCls:".logCon", //切换块cls
			trigger:"click", //事件类型
		}
	});
 })
	