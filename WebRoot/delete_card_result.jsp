<%@ page import="java.sql.*,java.net.URLDecoder;" contentType="text/html; charset=utf-8" language="java" errorPage=""  %>

<%
  String cardName = request.getParameter("cardname");
  cardName = URLDecoder.decode(cardName, "UTF-8");
  Class.forName("com.mysql.jdbc.Driver");
  Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hearthstone",
  							"root","njcyc3haicheng,.");
  Statement stmt = conn.createStatement();
  String query_sql = "select * from cards where name='"+cardName+"';";
  ResultSet rs = stmt.executeQuery(query_sql);
  if (!rs.first()) {
	out.println("找不到卡牌："+cardName);
  }
  else {
  	String[] colors = {"基础","普通","稀有","史诗","传说"};
	String[] jobs = {"中立","法师","牧师","萨满","圣骑","战士","德鲁伊","术士","潜行者","猎人"};
	out.println("卡牌名称："+rs.getString(1));
	out.println("稀有度："+colors[rs.getInt(2)]);
	out.println("职业："+jobs[rs.getInt(3)]);
	out.println("费用："+rs.getInt(4));
	if (rs.getString(5).equals(""))
		out.println("卡牌描述：无");
	else
		out.println("卡牌描述："+rs.getString(5));	
		
 	String delete_sql = "delete from cards where name='"+cardName+"';";
 	int count = stmt.executeUpdate(delete_sql);
 	if (count>0) {
 		out.println("删除成功！");
 	}
 	else {
 		out.println("删除失败！");
 	}
  }
  if (rs!=null) rs.close();
  if (stmt!=null) stmt.close();
  if (conn!=null) conn.close();
%>  
