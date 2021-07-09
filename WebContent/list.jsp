<%@ page language="java" import="java.sql.*" pageEncoding="utf-8"%>
<%@ page errorPage="error.jsp"%>
<html>
<head>
<title>查询</title>
<link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>
	<h1>查询</h1>
	<br/>
		<form action="SearchServlet" method="post">
	            <input type="text" id="value" name="name" placeholder="题目(默认为空)">

	            <input type="text" id="value" name="author" placeholder="作者(默认为空)">

	            <input type="text" id="value" name="ab" placeholder="摘要(默认为空)">
	            <p>
	            <input type="submit" id="select" name="select" value="查询" />   
	            
	    </form>
	<br/>
	<table style="width: 50%;">
		<tr>
			<th>题目</th>
			<th>作者</th>
			<th>摘要</th>
			<th>链接</th>
			<th>PDF</th>
		</tr>
		<%
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/article?&useSSL=false&serverTimezone=UTC", "root", "whyjlbcdy2001");
				//使用Statement对象
				Statement stmt = con.createStatement();
				ResultSet rs = stmt.executeQuery("select * from cvpr");
					

				/*
				PreparedStatement stmt = con.prepareStatement("select * from bookinfo");
				ResultSet rs = stmt.executeQuery();
				*/
				while (rs.next()) {
					String ab = rs.getString(2).substring(0,150)+"......";
					out.println("<tr><td>" + rs.getString(1) + "</td><td>" + rs.getString(3) + "</td><td>" + ab + "</td><td style='word-break:keep-all'><a href='" 
							+ rs.getString(6) +  "'>查看原地址</a>&nbsp</td><td style='word-break:keep-all'><a href='" + rs.getString(5) + "'>PDF下载</a>&nbsp</td></tr>");
				}
				
// 				out.println("<tr><td>" + rs.getString(1) + "</td><td>" + rs.getString(2) + "</td><td>" + rs.getString(3) + "</td><td>"
// 						+ rs.getString(4) + "</td><td>" + rs.getString(5) + "</td><td><a href='edit.jsp?uid=" + uid
// 						+ "'>修改</a>&nbsp;<a href='del.jsp?uid=" + uid + "'>删除</a></td></tr>");
				
				
				rs.close();
				stmt.close();
				con.close();
			} catch (Exception e) {
				out.println("Exception:" + e.getMessage());
			}
		%>	
	</table>
</body>
</html>
