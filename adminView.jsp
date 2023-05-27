<%

if (session==null)
{
	RequestDispatcher rd = request.getRequestDispatcher("Login.html");
     	 	rd.forward(request, response);
}
	String type = (String)session.getAttribute("type");
	if(type == null)
	{
		RequestDispatcher rd = request.getRequestDispatcher("Error-page.jsp");
      		request.setAttribute("error", "noLogin");
     	 	rd.forward(request, response);
}

	else if(type.equals("user"))
	{
		RequestDispatcher rd = request.getRequestDispatcher("Error-page.jsp");
      		request.setAttribute("error", "userLogin");
     	 	rd.forward(request, response);
}


	else if(type.equals("admin"))
	{


%>

<html>
<head>
<title>All_Books</title>

<link rel="stylesheet" href="aTable.css">
<link rel="stylesheet" href="userNavbar.css">

	<style>
		@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300&display=swap');
	</style>

</head>
<%@ page language = "java" import = "java.sql.Statement,java.sql.ResultSet,java.sql.Connection,java.sql.DriverManager" %>
<body>

<div class= "container">

 
    <nav class="topnav">
		<a href="adminView.jsp"><b>Admin Panel</b></a>
      <a class= "active" href="adminView.jsp">View </a>
      <a href="adminAdd.jsp">Add </a>
      <a href="adminDelete.jsp">Delete</a>
      <a href="adminUpdate.jsp">Update</a>
      <a href="logout.jsp">LogOut</a>
      <div class="dot"></div>
    </nav>

</div>


<h1 class="head">All Books</h1>

<table class="rwd-table"  border = "1" width = "400">
<tr>
<td><b>Title</b></td>
<td><b>ISBN</b></td>
<td><b>Author</b></td>
<td><b>Price</b></td>
<td><b>Quantity</b></td>
</tr>
<%

try{
    Class.forName("com.mysql.jdbc.Driver");
    String url = "jdbc:mysql://127.0.0.1/book_store";
    Connection con=DriverManager.getConnection(url, "root", "root");

String title = "";
String isbn = "";
String author = "";
int quantity = 0;
int price = 0;

Statement stmt = con.createStatement();
ResultSet rs = stmt.executeQuery("select * from book_records");

while(rs.next()) {
 title = rs.getString("title");
 isbn = rs.getString("isbn");
 author = rs.getString("author");
 quantity = rs.getInt("quantity");
 price = rs.getInt("price");
%>

<tr>
<td><%= title %></td>
<td><%= isbn %></td>
<td><%= author %></td>
<td><%= price %></td>
<td><%= quantity %></td>
</tr>
<%
}
%>
<%
stmt.close();
con.close();
}
catch(Exception e){System.out.println("Exception");}
%>

</table>
</body>
</html>

<%
}
%>