<%@ page import="java.sql.*,java.util.*" contentType="text/html; charset=utf-8" language="java" errorPage=""  %>
<%
Class.forName("com.mysql.jdbc.Driver");
Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hearthstone",
  							"root","njcyc3haicheng,.");
Statement stmt = conn.createStatement();
int whiteNum = 0;
int blueNum = 0;
int purpleNum = 0;
int orangeNum = 0;
for (int i=0;i<5;i++) {
	if (i==4 && whiteNum==4) {
		blueNum++;
		break;
	}
	int rand = new Random().nextInt(1000)+1;
	if (rand<=13) 
		orangeNum++;
	else if (rand<=56)
		purpleNum++;
	else if (rand<=287)
		blueNum++;
	else
		whiteNum++; 
}

ResultSet rs = null;
List<String> cardList = new ArrayList<String>();
int whiteTotal = 0;
int blueTotal = 0;
int purpleTotal = 0;
int orangeTotal = 0;
String countSql = "select color,count(*) from cards where color<>0 group by color;";
rs = stmt.executeQuery(countSql);
if (rs.first()) {
	do {
		int color = rs.getInt(1);
		if (color==1)
			whiteTotal = rs.getInt(2);
		else if (color==2)
			blueTotal = rs.getInt(2);
		else if (color==3)
			purpleTotal = rs.getInt(2);
		else if (color==4)
			orangeTotal = rs.getInt(2);	
	} while (rs.next());
}
if (whiteNum>0) {
	rs = stmt.executeQuery("select name,color from cards where color=1;");
	for (int i=0;i<whiteNum;i++) {
		int row = new Random().nextInt(whiteTotal)+1;
		rs.absolute(row);
		cardList.add(rs.getString(1));
	}
}
if (blueNum>0) {
	rs = stmt.executeQuery("select name,color from cards where color=2;");
	for (int i=0;i<blueNum;i++) {
		int row = new Random().nextInt(blueTotal)+1;
		rs.absolute(row);
		cardList.add(rs.getString(1));
	}
}
if (purpleNum>0) {
	rs = stmt.executeQuery("select name,color from cards where color=3;");
	for (int i=0;i<purpleNum;i++) {
		int row = new Random().nextInt(purpleTotal)+1;
		rs.absolute(row);
		cardList.add(rs.getString(1));
	}
}
if (orangeNum>0) {
	rs = stmt.executeQuery("select name,color from cards where color=4;");
	for (int i=0;i<orangeNum;i++) {
		int row = new Random().nextInt(orangeTotal)+1;
		rs.absolute(row);
		cardList.add(rs.getString(1));
	}
}
String result = "";
for (int i=0;i<4;i++) {
	result += cardList.remove(new Random().nextInt(cardList.size()));
	result += "//";
} 
result += cardList.get(0);
out.println(result);
if (rs!=null) rs.close();
if (stmt!=null) stmt.close();
if (conn!=null) conn.close();
%>