<%@ page import="java.sql.*" contentType="text/html; charset=utf-8" language="java" errorPage=""  %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns="http://www.w3.org/1999/xhtml">
<%!
private final String[] colors = {"基础","普通","稀有","史诗","传说"};
private final String[] jobs = {"中立","法师","牧师","萨满","圣骑","战士","德鲁伊","术士","潜行者","猎人"};
private String convertToSql(int color,int job,int price) {
	String base_sql = "select * from cards";
	String where_sql = "";
	if (color==-1 && job==-1 && price==-1)
		where_sql = ";";
	else if (color!=-1 && job!=-1 && price!=-1)
		where_sql = " where color="+color+" and job="+job+" and price="+price+";";
	else if (color!=-1 && job!=-1 && price==-1)
		where_sql = " where color="+color+" and job="+job+";";  
	else if (color!=-1 && job==-1 && price==-1)
		where_sql = " where color="+color+";"; 
	else if (color!=-1 && job==-1 && price!=-1)
		where_sql = " where color="+color+" and price="+price+";"; 
	else if (color==-1 && job!=-1 && price!=-1)
		where_sql = " where job="+job+" and price="+price+";"; 
	else if (color==-1 && job!=-1 && price==-1)
		where_sql = " where job="+job+";"; 
	else if (color==-1 && job==-1 && price!=-1)
		where_sql = " where price="+price+";"; 
	return base_sql+where_sql;
}
%>
<body>
<%
  String color = request.getParameter("color");
  String job = request.getParameter("job");
  String price = request.getParameter("price");
  if (color.equals("undefined")) color="-1";
  if (job.equals("undefined")) job="-1";
  if (price.equals("undefined")) price="-1";
  String sql = convertToSql(Integer.parseInt(color),Integer.parseInt(job),Integer.parseInt(price));
  	
  Class.forName("com.mysql.jdbc.Driver");
  Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hearthstone",
  							"root","njcyc3haicheng,.");
  Statement stmt = conn.createStatement();
  ResultSet rs = stmt.executeQuery(sql);
%>
  <table width="100%" border="1" align="center">
  	<tr>
  		<td width="20%">卡牌名字</td>
  		<td width="10%">稀有度</td>
  		<td width="10%">职业</td>
  		<td width="10%">费用</td>
  		<td width="50%">卡牌描述</td>
  	</tr>
  	<%while (rs.next()) {%>
  	<tr>
  	<td width="20%">
  		<%=rs.getString(1)%>
  	</td>
	<td width="10%"><%=colors[rs.getInt(2)]%></td>
	<td width="10%"><%=jobs[rs.getInt(3)]%></td>
	<td width="10%"><%=rs.getInt(4)%></td>
	<td width="50%"><%=rs.getString(5)%></td>
  	<%} %>
  </table>
  <%
  	if (rs!=null) rs.close();
  	if (stmt!=null) stmt.close();
  	if (conn!=null) conn.close();
   %>
</body>
</html>
