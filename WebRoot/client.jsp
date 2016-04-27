<%@ page import="java.sql.*" contentType="text/html; charset=utf-8" language="java" errorPage=""  %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <title>欢迎来到我的酒馆</title>
</head>

<body>
<script type="text/javascript">
function showing(imgpath){
    document.getElementById("popup").innerHTML="<img src="+imgpath+" width='260' height='370' />";
	document.getElementById("popup").style.top=event.clientY+document.body.scrollTop;
	document.getElementById("popup").style.left=event.clientX+document.body.scrollLeft;
	document.getElementById("popup").style.visibility="visible";
}
function clearing(){
	document.getElementById("popup").style.visibility="hidden";
}
function showCards() {
	var color;
	var job;
	var price;
	var all;
	all = document.getElementsByName("color");
	for (i=0;i<all.length;i++) {
		if (all[i].checked) {
			color = all[i].value;
			break;
		}
	}
	all = document.getElementsByName("job");
	for (i=0;i<all.length;i++) {
		if (all[i].checked) {
			job = all[i].value;
			break;
		}
	}
	all = document.getElementsByName("price");
	for (i=0;i<all.length;i++) {
		if (all[i].checked) {
			price = all[i].value;
			break;
		}
	}
	var url = "card_table.jsp?color="+color+"&job="+job+"&price="+price;
	var xmlHttp = false;
	if (window.XMLHttpRequest) {
		xmlHttp = new XMLHttpRequest();
	}
	else if (window.ActiveXObject) {
		try {
			xmlHttp = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			try {
				xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e) {
				window.alert("该浏览器不支持Ajax");
			}
		}
	}
	xmlHttp.open("POST", url, true);
	xmlHttp.onreadystatechange = function() {
		if (xmlHttp.readyState==4) {
			cardResult.innerHTML = xmlHttp.responseText;
		}
		else {
			cardResult.innerHTML = "正在查询，请稍候。。。";
		}
	};
	xmlHttp.send();
}
function getCards() {
	window.location.href = "get_cards.jsp";
}
</script>
	<form method="post" name="choiceForm">
    	卡牌颜色：      <input type="radio" name="color" value="-1">全部
    			<input type="radio" name="color" value="0">基础
    		   	<input type="radio" name="color" value="1">普通	
    			<input type="radio" name="color" value="2">稀有	
    			<input type="radio" name="color" value="3">史诗
    			<input type="radio" name="color" value="4">传说<br>
    	所属职业：      <input type="radio" name="job" value="-1">全部
    			<input type="radio" name="job" value="0">中立
    			<input type="radio" name="job" value="1">法师	
    			<input type="radio" name="job" value="2">牧师
    			<input type="radio" name="job" value="3">萨满
    			<input type="radio" name="job" value="4">圣骑
    			<input type="radio" name="job" value="5">战士
    			<input type="radio" name="job" value="6">德鲁伊
    			<input type="radio" name="job" value="7">术士
    			<input type="radio" name="job" value="8">潜行者
    			<input type="radio" name="job" value="9">猎人<br>
    			
    	卡牌费用：     <input type="radio" name="price" value="-1">全部
    			<input type="radio" name="price" value="0">0
    			<input type="radio" name="price" value="1">1
    			<input type="radio" name="price" value="2">2
    			<input type="radio" name="price" value="3">3
    			<input type="radio" name="price" value="4">4
    			<input type="radio" name="price" value="5">5
    			<input type="radio" name="price" value="6">6
    			<input type="radio" name="price" value="7">7
    			<input type="radio" name="price" value="8">8
    			<input type="radio" name="price" value="9">9
    			<input type="radio" name="price" value="10">10+<br>
    	<input type="button" value="查找卡牌" onclick="showCards();">
    	<input type="button" value="开包模拟" onclick="getCards();">
    </form>
    <div id="cardResult">
 	</div>
 	<div style="position:absolute; width:260; height:370; border:solid 1px; border-color:white; 
  		visibility:hidden;" id="popup">
    </div>
</body>
</html>
