/**
 * ÏúÊÛ¼¤Àøjs
 */
$(function(){
	$("#search").click(function(){
		var keywords = $(".J-keywords").val();
		if(keywords == $(".J-keywords").attr("data-default")){
			$(".J-keywords").val("");
		}
		$(".sub-form").submit();
	});
});