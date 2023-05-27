<%@ page language = "java" import = "java.sql.*" %>

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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CheckOut</title>
    <link rel="stylesheet" href="userNavbar.css">
	<link rel="stylesheet" href="checkout.css">
</head>
<script>
function validate()
{	
    if ( document.user.name.value == "" )
	    {
            document.getElementById("name").innerHTML = "Name is empty!";		
			return false;
	    }

    if ( !(/^[A-Za-z]+$/.test(document.user.name.value)))
	    {
            document.getElementById("name").innerHTML = "Only alphabtes are allowed in Name!";		
			return false;
	    }


    if ( document.user.contact_no.value == "" )
	{		
        document.getElementById("cnum").innerHTML = "Contact no is empty!!";
			return false;
	}
			 
	if ( document.user.email.value == "" )		
    {
        document.getElementById("email").innerHTML = "Please enter email address!";
		return false;
	}	


	if(document.user.address.value == "")	
	   {
            document.getElementById("add").innerHTML = "Address is empty!!";
			return false;
	   }	

	
	return true;

}


function letternumber(event)
	{
		var keychar;
			
		keychar = event.key;
		if (((".+-0123456789").indexOf(keychar) > -1))
		   return true;
		else{
            document.getElementById("cnum").innerHTML = "Contact Number Format wrong";
		   return false;
        }
	}

    </script>

<style>
        .errors{
            color: red;
            margin-top: 5px;
            font-weight: bold;
            display: inline;
        }
</style>
 
  
</head>
<body>
<div class= "container">

  <div class="topnav">
  <a href="UserView.jsp">Home</a>
  <a href="viewCart.jsp">View Cart</a>
  <a class="active" href="checkout.jsp">Buy Now</a>
  <a href="logout.jsp">LogOut</a>
  <div class="search-container">
    <form action="userSearch.jsp">
      <input type="text" placeholder="Enter title/ISBN/author" name="search">
      <button type="submit">Search</button>
    </form>
  </div>
</div>

</div>


<div class="form-container">
    <form action= "checkout.jsp" name = "user" onsubmit="return validate()">
        
        <h3>Place Order</h3>
        	<label for="name">Name </label>
        	<input type="text" name = "name" placeholder="Enter your Name" id="u_name"><br>
        	<div class="errors" id="name"></div><br>
        	<label for="contact_no">Contact no </label>
                <input type="text" name="contact_no" placeholder="Enter Phone Number" onkeypress="return letternumber(event)" ><br>
                <div class="errors" id="cnum" > </div><br>
                <label for="email">Email </label>
                <input type="email" name="email" placeholder="Enter Email"><br>
                <div class="errors" id="email" > </div><br>
		<label for="address">Address </label>
                <input type="text" name="address" placeholder="Enter Address" ><br>
                <div class="errors" id="add" > </div><br>
		<label for="address">City </label>
                <input type="text" name="city" placeholder="Enter City" ><br>
                <div class="errors" id="city" > </div><br>
               
                <input type="submit" value="Buy">
</div>


<%
String name = request.getParameter("name");
String username = (String)session.getAttribute("name");
int quantity = 0;

if(name != null){
try{
    Class.forName("com.mysql.jdbc.Driver");
    String url = "jdbc:mysql://127.0.0.1/book_store";
    Connection con=DriverManager.getConnection(url, "root", "root");

Statement stmt1 = con.createStatement();
Statement stmt2 = con.createStatement();
int flag = 0;

 String query="Select * from cart where username='"+username+"' ";
   
     ResultSet rs = stmt1.executeQuery( query );
   
     while(rs.next()){

	flag = 1;
	
	String cart_isbn = rs.getString("isbn");
 	int cart_quantity = rs.getInt("quantity");
 	int cart_price = rs.getInt("price");

		String query1="Select * from book_records where ISBN='"+cart_isbn+"' ";
   
     		ResultSet rs1 = stmt2.executeQuery( query1 );
		if(rs1.next()){
			int b_quantity = rs1.getInt("quantity");
			quantity = b_quantity - cart_quantity;

			int result = stmt2.executeUpdate("UPDATE book_records SET quantity = '"+quantity+"' WHERE ISBN='"+cart_isbn+"'" );
			}

		int result = stmt2.executeUpdate("DELETE FROM cart WHERE username='"+username+"'" );

}

	
	if(flag == 1){
%>

<h2 class="msg" style="color: rgb(164, 236, 164); margin-left: 38%;" >Your Order has been placed!</h2>
<%
}

	else{
		%>

	<h2 class="msg" style="color: red;">Your cart is empty!</h2>
<%
}
stmt1.close();
stmt2.close();
con.close();

}

catch(Exception e){System.out.println("Exception");} 
}
%>

  </body>

</html>



<%
}
%>

