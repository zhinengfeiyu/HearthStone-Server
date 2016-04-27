import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class ManagerValidate extends HttpServlet {
	
	private final String jdbc_driver = "com.mysql.jdbc.Driver";
	private final String jdbc_url = "jdbc:mysql://localhost:3306/hearthstone";
	private final String jdbc_user = "root";
	private final String jdbc_psw = "njcyc3haicheng,.";

	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws IOException,ServletException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println("<html>");
		out.println("<head></head>");
		out.println("<body>");
		if (request.getParameter("login")!=null) {
			String name = request.getParameter("name");
			String psw = request.getParameter("psw");
			try {
				if (userExist(name,psw)) {
					request.getRequestDispatcher("/server.jsp").forward(request, response);
				}
				else {
					out.println("登录失败，用户名或密码错误");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		else if (request.getParameter("register")!=null) {
			String name = request.getParameter("name");
			String psw = request.getParameter("psw");
			if (name==null || name.equals("")) {
				out.println("用户名不能为空！");
			}
			else if (psw==null || psw.equals("")) {
				out.println("密码不能为空！");
			}
			else {
				try {
					if (usernameExist(name)) {
						out.println("用户名已存在！");
					}
					else {
						addUserToDatabase(name,psw);
						request.getRequestDispatcher("/server.jsp").forward(request, response);
					}
				} catch (Exception e) {
					e.printStackTrace();
				}
			}
		}
		out.println("</body>");
		out.println("</html>");
	}

	private boolean usernameExist(String name) throws Exception{
		boolean usernameFound = false;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = "select * from users where name='"+name+"' and role=1;";
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url,jdbc_user,jdbc_psw);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.first()) {
				usernameFound = true;
			}
		} finally {
			if (rs!=null) rs.close();
			if (stmt!=null) stmt.close();
			if (conn!=null) conn.close();
		}
		return usernameFound;
	}
	
	private void addUserToDatabase(String name,String psw) throws Exception{
		Connection conn = null;
		Statement stmt = null;
		String sql = "insert into users values ('"+name+"','"+psw+"',1);";
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url,jdbc_user,jdbc_psw);
			stmt = conn.createStatement();
			stmt.executeUpdate(sql);
		} finally {
			if (stmt!=null) stmt.close();
			if (conn!=null) conn.close();
		}
	}
	
	private boolean userExist(String name,String psw) throws Exception{
		boolean userFound = false;
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		String sql = "select * from users where name='"+name+"' and password='"+psw+"' and role=1;";
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url,jdbc_user,jdbc_psw);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.first()) {
				userFound = true;
			}
		} finally {
			if (rs!=null) rs.close();
			if (stmt!=null) stmt.close();
			if (conn!=null) conn.close();
		}
		return userFound;
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		this.doGet(request, response);
	}

}
