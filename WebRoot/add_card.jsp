<%@ page contentType="text/html; charset=utf-8" language="java" errorPage=""  %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>增加卡牌</title>
  </head>
  
  <body>
  <script type="text/javascript">
  function submitNewCard() {
  	var name;
  	var color;
	var job;
	var price;
	var content;
	var all;
	name = document.cardform.name.value;
	content = document.cardform.content.value;
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
	var url = "addRecordResult?name="+name+"&color="+color+"&job="+job+"&price="+price+"&content="+content;
	url = encodeURI(url);
	url = encodeURI(url);
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
				window.alert("浏览器不支持AJAX");
			}
		}
	}
	xmlHttp.open("POST", url, true);
	xmlHttp.onreadystatechange = function() {
		if (xmlHttp.readyState==4) {
			window.alert(xmlHttp.responseText);
		}
	};
	xmlHttp.send();
  }
  </script>
    <form name="cardform" method="post">
    	卡牌名字：<input type="text" name="name"><br>
    	卡牌颜色：<input type="radio" name="color" value="基础">基础
    		   	<input type="radio" name="color" value="普通">普通	
    			<input type="radio" name="color" value="稀有">稀有	
    			<input type="radio" name="color" value="史诗">史诗
    			<input type="radio" name="color" value="传说">传说<br>
    	所属职业：<input type="radio" name="job" value="中立">中立
    			<input type="radio" name="job" value="法师">法师	
    			<input type="radio" name="job" value="牧师">牧师
    			<input type="radio" name="job" value="萨满">萨满
    			<input type="radio" name="job" value="圣骑">圣骑
    			<input type="radio" name="job" value="战士">战士
    			<input type="radio" name="job" value="德鲁伊">德鲁伊
    			<input type="radio" name="job" value="术士">术士
    			<input type="radio" name="job" value="潜行者">潜行者
    			<input type="radio" name="job" value="猎人">猎人<br>
    			
    	卡牌费用：<input type="radio" name="price" value="0">0
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
    	卡牌描述：<input type="text" name="content" size="80"><br>
    	<input type="button" value="确认提交" onclick="submitNewCard()">
    	<input type="reset" value="重新填写">
    </form>
  </body>
</html>
