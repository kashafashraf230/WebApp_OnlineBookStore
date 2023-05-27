<%@page import="javax.servlet.http.*,java.sql.*" %>
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


%>

<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Home</title>
<link rel="stylesheet" href="userNavbar.css">
<link rel="stylesheet" href="aTable.css">

<style>

input[type='submit']{
    /* margin-top: 50px; */
    width: 100%;
    background-color: #ffffff;
	/* background-color: #34495E; */
    color: #080710;
	/* color: white; */
    padding: 13px 0;
    font-size: 15px;
    font-weight: 600;
	border: none;
    border-radius: 5px;
    cursor: pointer;
}

</style>
</head>
<body>

<div class="topnav">
  <a class="active" href="UserView.jsp">Home</a>
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


<div class= "allBooks">

	<h1 class="head">Books for you!</h1>

<table class="rwd-table" border = "1" width = "400">
<tr>
<td><b>Title</b></td>
<td><b>ISBN</b></td>
<td><b>Author</b></td>
<td><b>Price</b></td>
<td><b>Status</b></td>
<td><b>Add to Cart</b></td>
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
String status = "";

Statement stmt = con.createStatement();
ResultSet rs = stmt.executeQuery("select * from book_records");

while(rs.next()) {
 title = rs.getString("title");
 isbn = rs.getString("isbn");
 author = rs.getString("author");
 quantity = rs.getInt("quantity");
 price = rs.getInt("price");

	if(quantity > 0){

		status = "Available";

}

	else {
		status = "Not Available";
}
%>

<tr>
<td><%= title %></td>
<td><%= isbn %></td>
<td><%= author %></td>
<td><%= price %></td>
<td><%= status %></td>

<td><form action="addCart.jsp">
<input type="hidden" name="addCart" value="<%=isbn%>">
<input type="hidden" name="b_price" value="<%=price%>">
<input type="hidden" name="b_status" value="<%=rs.getInt("quantity")%>">
<input type="submit" name="submit" value="Add to Cart"> </form>
</td>


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
</div>


</body>
</html>


<%
}
%>