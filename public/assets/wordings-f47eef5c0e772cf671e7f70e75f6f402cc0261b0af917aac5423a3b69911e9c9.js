// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$( function() {
  $( "#wording" ).sortable();
  $( "#wording" ).disableSelection();
} );
function add_card(){
	var sn = $("#card_num").val();
	var group = $("#group_num").val();
	$("#wording").append("<div id=\"card_group" + group + "\" class=\"divborder\"><b>卡片樣式</b><button type=\"button\" onclick=\"more_card('card_group" + group + "')\">插入卡片</button><button type=\"button\" onclick=\"remove_div('card_group" + group + "')\">刪除卡片</button><br><td>Name:<input type=\"text\" name=\"[card_group" + group + "][card" + sn + "]Name\" value=\"NAME\" /></td><td>標題:<input type=\"text\" name=\"[card_group" + group + "][card" + sn + "]title\" value=\"title\" /></td><td>副標題:<input type=\"text\" name=\"[card_group" + group + "][card" + sn + "]subtitle\" value=\"subtitle\" /></td><td>圖片連結:<input type=\"text\" name=\"[card_group" + group + "][card" + sn + "]image_url\" value=\"image_url\" /></td><br />按鈕:<button type=\"button\" onclick=\"add_card_button('card_group" + group + "','card" + sn + "')\">插入按鈕</button><button type=\"button\" onclick=\"add_card_payload('card_group" + group + "','card" + sn + "')\">插入payload</button><br /><div id=\"card_group" + group + "_card" + sn + "_buttons\"><input type=\"hidden\" name=\"card_group" + group + "_card" + sn + "_bt_sn\" value=\"1\" disabled/></div></div>");
	$("#card_num").val(parseInt(sn)+1);
	$("#group_num").val(parseInt(group)+1);
}
function add_card_button(group, order){
	var sn = $("input[name="+group+"_"+order+"_bt_sn]").val();
	if (parseInt(sn) < 4){
		$("#"+group+"_"+order+"_buttons").append("類型:<input type=\"text\" name=\"["+ group + "][" + order + "][buttons" + sn + "]type\" value=\"web_url\" />標題:<input type=\"text\" name=\"["+ group + "][" + order + "][buttons" + sn + "]title\" value=\"查看目前的達成率\" />url:<input type=\"text\" name=\"["+ group + "][" + order + "][buttons" + sn + "]url\" value=\"\" /><br />");
		$("input[name="+group+"_"+order+"_bt_sn]").val(parseInt(sn)+1);
	}
}
function add_card_payload(group, order){
	var sn = $("input[name="+group+"_"+order+"_bt_sn]").val();
	if (parseInt(sn) < 4){
		$("#"+group+"_"+order+"_buttons").append("類型:<input type=\"text\" name=\"["+group+"][" + order + "][buttons" + sn + "]type\" value=\"postback\" />標題:<input type=\"text\" name=\"[" + group + "][" + order + "][buttons" + sn + "]title\" value=\"查看目前的達成率\" />payload:<input type=\"text\" name=\"[" + group + "][" + order + "][buttons" + sn + "]payload\" value=\"\" /><br />");
		$("input[name="+group+"_"+order+"_bt_sn]").val(parseInt(sn)+1);
	}
}
function more_card(order){
	var sn = $("#card_num").val();
	$("#"+order).append("卡片樣式</b><br><td>Name:<input type=\"text\" name=\"["+ order +"][card" + sn + "]Name\" value=\"NAME\" /></td><td>標題:<input type=\"text\" name=\"["+ order +"][card" + sn + "]title\" value=\"title\" /></td><td>副標題:<input type=\"text\" name=\"["+ order +"][card" + sn + "]subtitle\" value=\"subtitle\" /></td><td>圖片連結:<input type=\"text\" name=\"["+ order +"][card" + sn + "]image_url\" value=\"image_url\" /></td><br />按鈕:<button type=\"button\" onclick=\"add_card_button('" + order + "','card" + sn + "')\">插入按鈕</button><button type=\"button\" onclick=\"add_card_payload('" + order + "','card" + sn + "')\">插入payload</button><br /><div id=\"" + order + "_card" + sn + "_buttons\"><input type=\"hidden\" name=\"" + order + "_card" + sn + "_bt_sn\" value=\"1\" disabled/></div>");
	$("#card_num").val(parseInt(sn)+1);
}
function add_text(){
	var sn = $("#text_num").val();
	var group = $("#group_num").val();
	$("#wording").append("<div id=\"text_group" + group + "\" class=\"divborder\"><b>文字樣式</b><button type=\"button\" onclick=\"remove_div('text_group" + group + "')\">刪除文字</button><br><td>名稱:<input type=\"text\" name=\"[text_group" + group + "][text" + sn + "]Name\" value=\"NAME\" /></td><td><input type=\"hidden\" name=\"[text_group" + group + "][text" + sn + "]type\" value=\"text\" /></td><td>文字:<input type=\"text\" name=\"[text_group" + group + "][text" + sn + "]text\" value=\"text\" /></td><td>延遲:<input type=\"text\" name=\"[text_group" + group + "][text" + sn + "]delay\" value=\"1\" /></td></div>")
	$("#text_num").val(parseInt(sn)+1);
	$("#group_num").val(parseInt(group)+1);
}
function add_picture(){
	var sn = $("#pic_num").val();
	var group = $("#group_num").val();
	$("#wording").append("<div id=\"pic_group" + group + "\" class=\"divborder\"><b>圖片樣式</b><button type=\"button\" onclick=\"remove_div('pic_group" + group + "')\">刪除圖片</button><br><td>名稱:<input type=\"text\" name=\"[pic_group" + group + "][pic" + sn + "]Name\" value=\"NAME\" /></td><td><input type=\"hidden\" name=\"[pic_group" + group + "][pic" + sn + "]type\" value=\"image\"/></td><td>圖片網址:<input type=\"text\" name=\"[pic_group" + group + "][pic" + sn + "]url\" value=\"text\" /></td><td>延遲:<input type=\"text\" name=\"[pic_group" + group + "][pic" + sn + "]delay\" value=\"1\" /></td></div>");
	$("#pic_num").val(parseInt(sn)+1);
	$("#group_num").val(parseInt(group)+1);
}
function add_quick_reply(group, order){
	var reply_sn = $("input[name="+ group + "_reply_bt_sn]").val();
	$("#" + group + "_reply").append("類型:<input type=\"text\" name=\"["+ group + "]["+ order + "][reply"+ reply_sn +"]content_type\" value=\"text\" />payload:<input type=\"text\" name=\"["+ group + "]["+ order + "][reply"+ reply_sn +"]payload\" value=\"\" />回覆:<input type=\"text\" name=\"["+ group + "]["+ order + "][reply"+ reply_sn +"]title\" value=\"對\" /><br />")
	$("input[name="+ group + "_reply_bt_sn]").val(parseInt(reply_sn)+1);
}
function add_quick(){
	var sn = $("#quick_num").val();
	$("#wording").append("<div id=\"quick_group" + sn + "\" class=\"divborder\"><b>快速回覆</b><button type=\"button\" onclick=\"remove_div('quick_group" + sn + "')\">刪除快回</button><br/><td>問題:<input type=\"text\" name=\"[quick_group" + sn + "][quick1]text\" value=\"今天熱嗎？\" /></td><td>名稱:<input type=\"text\" name=\"[quick_group" + sn + "][quick1]name\" value=\"\" /></td><br/>回覆:<button type=\"button\" onclick=\"add_quick_reply('quick_group" + sn + "', 'quick1');\">插入回覆</button><br /><div id=\"quick_group" + sn + "_reply\"><input type=\"hidden\" name=\"quick_group" + sn + "_reply_bt_sn\" value=\"1\" disabled=\"\"></div></div>");
}
function remove_div(name){
	$("#"+name).remove();
}
function tapCopy($id) {
	selectText($id);
	document.execCommand('copy');
	alert('複製成功');
}
function selectText(element) {
	var text = document.getElementById(element);
	if (document.body.createTextRange) {
		var range = document.body.createTextRange();
		range.moveToElementText(text);
		range.select();
	} else if (window.getSelection) {
		var selection = window.getSelection();
		var range = document.createRange();
		range.selectNodeContents(text);
		selection.removeAllRanges();
		selection.addRange(range);
	} else {
		alert("複製失敗");
	}
}
;
