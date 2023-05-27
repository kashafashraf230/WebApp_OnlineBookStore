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
<title>Cart</title>
<link rel="stylesheet" href="userNavbar.css">
<link rel="stylesheet" href="viewCart.css">

<style>

</style>
</head>
<body>

<div class="topnav">
  <a href="UserView.jsp">Home</a>
  <a class="active" href="viewCart.jsp">View Cart</a>
  <a href="checkout.jsp">Buy Now</a>
  <a href="logout.jsp">LogOut</a>
  <div class="search-container">
    <form action="userSearch.jsp">
      <input type="text" placeholder="Enter title/ISBN/author" name="search">
      <button type="submit">Search</button>
    </form>
  </div>
</div>

<div class="text">
<h3>Your Cart</h3>

<%
String username = (String)session.getAttribute("name");

try{
    Class.forName("com.mysql.jdbc.Driver");
    String url = "jdbc:mysql://127.0.0.1/book_store";
    Connection con=DriverManager.getConnection(url, "root", "root");

String name = "";
String isbn = "";
int quantity = 0;
int price = 0;
int total = 0;
int totalBooks = 0;

Statement stmt = con.createStatement();
Statement st = con.createStatement();
ResultSet rs = stmt.executeQuery("select * from cart where username='"+username+"'");


while(rs.next()) {
 isbn = rs.getString("isbn");
 quantity = rs.getInt("quantity");
 price = rs.getInt("price");

		total = total + price;
		totalBooks = totalBooks + quantity;

		ResultSet rs1 = st.executeQuery("select * from book_records where ISBN='"+isbn+"'");
		if(rs1.next()){

			String title = rs1.getString("title");
			String isbn1 = rs1.getString("ISBN");
			String author = rs1.getString("author");
			String price1 = rs1.getString("price");

			%>

			
			<h4><%= "Book Title: " + title %></h4>
			<p><%= "Author: " + author %><br>
			<%= "Price: Rs." +price1 %><br>
			<%= "ISBN: "+ isbn1 %><br>
			<%= "Quantity: "+quantity %></p>

			<form action="removeCart.jsp" method="post">
			<input type="hidden" name="removeCart" value="<%=isbn1%>">
			<input type="submit" name="submit" value="Remove Book" ></form>
		
			<%
}
}

if(totalBooks != 0 && total != 0){
%>
		<p class="total"><%= "Total items: " + totalBooks %><br>
		<%= "Total bill: Rs." + total %> <p>
		<form class="checkout" action="checkout.jsp">
		<input type="submit" name="submit" value="CheckOut"> </form><br>
		<form class="checkout" action="UserView.jsp">
		<input type="submit" name="submit" value="More Shopping"> </form>
	</div>
<%
}


	else{
%>
		<h4>Your cart is empty!</h4>
<%
}

stmt.close();
st.close();
con.close();
}
catch(Exception e){System.out.println("Exception");}


}

%>

</body>
</html>

