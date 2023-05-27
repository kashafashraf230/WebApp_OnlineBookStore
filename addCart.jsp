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

String b_isbn = request.getParameter("addCart");
String b1_price = request.getParameter("b_price");
String b_status = request.getParameter("b_status");
String username = (String)session.getAttribute("name");
int b_quantity =1;
int b_price= Integer.parseInt(b1_price);
int b1_status= Integer.parseInt(b_status);


if(b1_status > 0){	
try{
    Class.forName("com.mysql.jdbc.Driver");
    String url = "jdbc:mysql://127.0.0.1/book_store";
    Connection con=DriverManager.getConnection(url, "root", "root");

String name = "";
String isbn = "";
int quantity = 0;
int price = 0;

Statement stmt = con.createStatement();
ResultSet rs = stmt.executeQuery("select * from cart where username='"+username+"' and isbn ='"+b_isbn+"' ");


if(rs.next()) {

 quantity = rs.getInt("quantity");
 price = rs.getInt("price");

		quantity = quantity +1;
		price = quantity * b_price;

		int result = stmt.executeUpdate("UPDATE cart SET quantity = '"+quantity+"',price = '"+price+"' WHERE ISBN='"+b_isbn+"'" );

		if(result>0)
		{out.println("Added to cart");
	
		}
		else
		{out.println("Couldn't be added to cart");
		}
}


else{
	 String query2 = "INSERT INTO cart(username,isbn,quantity,price)VALUES('"+ username + "','"+ b_isbn + "','"+ b_quantity + "','" + b_price+ "') ";
	 int rst = stmt.executeUpdate( query2 );

     if(rst==1){	out.println("<h1>Added to cart!</h1>"); 		}
	else{	out.println("<h1>Couldn't add to cart.</h1>"); 		}
}



stmt.close();
con.close();
}
catch(Exception e){System.out.println("Exception");}
}

else{
	out.println("<h3>Book is Unavailable Now</h3>"); 
}

}

%>
