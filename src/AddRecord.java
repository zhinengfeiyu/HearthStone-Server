import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class AddRecord extends HttpServlet {

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		String name = request.getParameter("name");
		String color = request.getParameter("color");
		String job = request.getParameter("job");
		String price = request.getParameter("price");
		String content = request.getParameter("content");
		
		if (infoError(name,color,job,price)) {
			PrintWriter out = response.getWriter();
			out.println("信息不完整！");
			return;
		}
		
		name = URLDecoder.decode(name, "UTF-8");
		color = URLDecoder.decode(color, "UTF-8");
		job = URLDecoder.decode(job, "UTF-8");
		content = URLDecoder.decode(content, "UTF-8");
	
		try {
			if (cardExist(name)) {
				PrintWriter out = response.getWriter();
				out.println("卡牌 "+name+" 已存在");
				return;
			}
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		
		String[] colors = {"基础","普通","稀有","史诗","传说"};
		String[] jobs = {"中立","法师","牧师","萨满","圣骑","战士","德鲁伊","术士","潜行者","猎人"};
		int _color = -1;
		int _job = -1;
		int _price = -1;
		for (int i=0;i<colors.length;i++) {
			if (color.equals(colors[i])) {
				_color = i;
				break;
			}
		}
		for (int i=0;i<jobs.length;i++) {
			if (job.equals(jobs[i])) {
				_job = i;
				break;
			}
		}
		_price = Integer.parseInt(price);
	
		int count = 0;
		try {
			count = execSQL("insert into cards (name,color,job,price,content) values ("
						+ "'"+name+"',"+_color+","+_job+","+_price+",'"+content+"');");
		} catch (Exception e) {
			count = -99;
			e.printStackTrace();
		}
		
		PrintWriter out = response.getWriter();
		if (count>0) {
			out.println("记录插入成功！");
		} 
		else if (count==0) {
			out.println("记录插入失败！");
		}
		else if (count==-99) {
			out.println("出现严重错误！");
		}
		else if (count==-999) {
			out.println("参数初始化错误！");
		}
		
		out.println("卡牌名称："+name);
		out.println("稀有度："+color);
		out.println("职业："+job);
		out.println("费用："+price);
		if (content.equals(""))
			out.println("卡牌描述：无");
		else
			out.println("卡牌描述："+content);
		
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doGet(request, response);
	}
	
	private int execSQL(String sql) throws Exception {
		ServletConfig config = getServletConfig();
		String driver = config.getInitParameter("driver");
		String url = config.getInitParameter("url");
		String user = config.getInitParameter("user");
		String psw = config.getInitParameter("psw");
		Connection conn = null;
		Statement stmt = null;
		int count = 0;
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url,user,psw);
			stmt = conn.createStatement();
			count = stmt.executeUpdate(sql);
		} finally {
			if (stmt!=null)
				stmt.close();
			if (conn!=null)
				conn.close();
		}
		return count;
	}
	
	private boolean cardExist(String cardName) throws Exception{
		boolean exist = true;
		ServletConfig config = getServletConfig();
		String driver = config.getInitParameter("driver");
		String url = config.getInitParameter("url");
		String user = config.getInitParameter("user");
		String psw = config.getInitParameter("psw");
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url,user,psw);
			stmt = conn.createStatement();
			rs = stmt.executeQuery("select * from cards where name='"+cardName+"';");
			if (!rs.first())
				exist = false;
		} finally {
			if (rs!=null) 
				rs.close();
			if (stmt!=null)
				stmt.close();
			if (conn!=null)
				conn.close();
		}
		return exist;
	}
	
	private boolean infoError(String name,String color,String job,String price) {
		if (name==null || name.equals(""))
			return true;
		if (color.equals("undefined"))
			return true;
		if (job.equals("undefined")) 
			return true;
		if (price.equals("undefined"))
			return true;
		return false;
	}

}
