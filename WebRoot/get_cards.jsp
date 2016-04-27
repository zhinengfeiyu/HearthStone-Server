<%@ page import="java.sql.*" contentType="text/html; charset=utf-8" language="java" errorPage=""  %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <title>欢迎来到我的酒馆</title>
</head>
<script type="text/javascript">
function enlarge(image) {
	image.style.width = 150;
	image.style.height = 205;
}
function recover(image) {
	image.style.width = 130;
	image.style.height = 185;
}
function buyCards() {
	document.getElementById("first").style.visibility="hidden";
	document.getElementById("second").style.visibility="hidden";
	document.getElementById("third").style.visibility="hidden";
	document.getElementById("fourth").style.visibility="hidden";
	document.getElementById("fifth").style.visibility="hidden";
	var url = "new_pack.jsp";
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
			document.getElementById("first").src="images/back.jpg";
			document.getElementById("second").src="images/back.jpg";
			document.getElementById("third").src="images/back.jpg";
			document.getElementById("fourth").src="images/back.jpg";
			document.getElementById("fifth").src="images/back.jpg";
			document.getElementById("first").style.visibility="visible";
			document.getElementById("second").style.visibility="visible";
			document.getElementById("third").style.visibility="visible";
			document.getElementById("fourth").style.visibility="visible";
			document.getElementById("fifth").style.visibility="visible";
			var str = xmlHttp.responseText;
			imageSrc = str.split("//");
			document.getElementById("first").onclick=function(){
					this.alt=imageSrc[0];
					this.src="images/"+imageSrc[0]+".jpg";
					this.onclick=function(){};
			};
			document.getElementById("second").onclick=function(){
					this.alt=imageSrc[1];
					this.src="images/"+imageSrc[1]+".jpg";
					this.onclick=function(){};
			};
			document.getElementById("third").onclick=function(){
					this.alt=imageSrc[2];
					this.src="images/"+imageSrc[2]+".jpg";
					this.onclick=function(){};
			};
			document.getElementById("fourth").onclick=function(){
					this.alt=imageSrc[3];
					this.src="images/"+imageSrc[3]+".jpg";
					this.onclick=function(){};
			};
			document.getElementById("fifth").onclick=function(){
					this.alt=imageSrc[4];
					this.src="images/"+imageSrc[4]+".jpg";
					this.onclick=function(){};
			};
		}
		else {
			
		}
	};
	xmlHttp.send();
}
</script>
<body>
	<img id="first" alt="卡牌1" src="images/back.jpg"
		onmouseover="enlarge(this);" onmouseout="recover(this);"
		style="position:absolute; width:130; height:185; border:solid 1px; border-color:white; 
  				top:50px;left:240px;visibility:hidden;" />
	<img id="second" alt="卡牌2" src="images/back.jpg"
		onmouseover="enlarge(this);" onmouseout="recover(this);"
		style="position:absolute; width:130; height:185; border:solid 1px; border-color:white; 
  				top:260px;left:60px;visibility:hidden;" />
	<img id="third" alt="卡牌3" src="images/back.jpg"
		onmouseover="enlarge(this);" onmouseout="recover(this);"
		style="position:absolute; width:130; height:185; border:solid 1px; border-color:white; 
  				top:260px;left:420px;visibility:hidden;">
	<img id="fourth" alt="卡牌4" src="images/back.jpg"
		onmouseover="enlarge(this);" onmouseout="recover(this);"
		style="position:absolute; width:130; height:185; border:solid 1px; border-color:white; 
  				top:470px;left:140px;visibility:hidden;">
	<img id="fifth" alt="卡牌5" src="images/back.jpg"
		onmouseover="enlarge(this);" onmouseout="recover(this);"
		style="position:absolute; width:130; height:185; border:solid 1px; border-color:white; 
  				top:470px;left:350px;visibility:hidden;">
  	<input type="button" value="买卡包" onclick="buyCards();"
  		style="position:absolute; width:100; height:50; top:320px;left:260px;
  				font-size:18px;font-weight:bold"/>
</body>
</html>
