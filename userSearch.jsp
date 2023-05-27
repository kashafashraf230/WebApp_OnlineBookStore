<%@ page language = "java" import = "java.sql.Statement,java.sql.ResultSet,java.sql.Connection,java.sql.DriverManager" %>

<%
	String type = (String)session.getAttribute("type");
	if(type == null)
	{
		RequestDispatcher rd = request.getRequestDispatcher("Error-page.jsp");
      		request.setAttribute("error", "noLogin");
     	 	rd.forward(request, response);
}


	else if(type.equals("user"))
	{


%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Search</title>
<link rel="stylesheet" href="userNavbar.css">
<link rel="stylesheet" href="viewCart.css">
</head>
<body>

<div class="topnav">
  <a href="UserView.jsp">Home</a>
  <a href="viewCart.jsp">View Cart</a>
  <a href="checkout.jsp">Buy Now</a>
  <a href="logout.jsp">LogOut</a>
  <div class="search-container">
    <form action="userSearch.jsp">
      <input type="text" placeholder="Enter title/ISBN/author" name="search">
      <button type="submit">Search</button>
    </form>
  </div>
</div>
<table>
	<div class="text">

<%

try{
    Class.forName("com.mysql.jdbc.Driver");
    String url = "jdbc:mysql://127.0.0.1/book_store";
    Connection con=DriverManager.getConnection(url, "root", "root");


	String data = request.getParameter("search");

String title = "";
String isbn = "";
String author = "";
int quantity = 0;
int price = 0;
int flag = 0;

Statement stmt = con.createStatement();
ResultSet rs = stmt.executeQuery("select * from book_records");

while(rs.next()) {
 title = rs.getString("title");
 isbn = rs.getString("isbn");
 author = rs.getString("author");
 quantity = rs.getInt("quantity");
 price = rs.getInt("price");

	if(data.equals(title) || data.equals(isbn) || data.equals(author) ){
		
		flag = 1;
		if(quantity > 0){

			%>

			
			<h4><%= "Book Title: " + title %></h4>
			<p><%= "Author: " + author %><br>
			<%= "Price: Rs" +price %><br>
			<%= "ISBN: "+ isbn %><br>
			<%= "Status: Available" %></p>

			<form action="addCart.jsp">
			<input type="hidden" name="addCart" value="<%=isbn%>">
			<input type="hidden" name="b_price" value="<%=price%>">
			<input type="hidden" name="b_status" value="<%=rs.getInt("quantity")%>">
			<input type="submit" name="submit" value="Add to Cart"> </form>
			
			<%
		}

		else if(quantity <= 0){
			%>

			
			<h4><%= "Book Title: " + title %></h4>
			<p><%= "Author: " + author %><br>
			<%= "Price: Rs" +price %><br>
			<%= "ISBN: "+ isbn %><br>
			<%= "Status: Not Available" %></p>
		
			<%
		}

}


}

if(flag == 0){
%>
<h4><%= "Ooops! We don't have this book! "  %></h4>
</div>
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