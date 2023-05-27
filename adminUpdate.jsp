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
		RequestDispatcher rd = request.getRequestDispatcher("Error-page.jsp");
      		request.setAttribute("error", "userLogin");
     	 	rd.forward(request, response);
}


	else if(type.equals("admin"))
	{
%>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Book</title>
    <link rel="stylesheet" href="userNavbar.css">
    <link rel = "stylesheet" href = "admin.css"/>
<script>
        function validate(){

            var isbn = document.getElementById("b_isbn").value;
	    var quantity = document.getElementById("b_quantity").value;
	    var price = document.getElementById("b_price").value;

	    if(isbn == "")
            {
                document.getElementById("isbn").innerHTML = "ISBN is empty!";
                return false;
            }
        
        if(price == "")
            {
                document.getElementById("price").innerHTML = "Price is empty!";
                return false;
            }
        
	    if(quantity == "")
            {
                document.getElementById("quantity").innerHTML = "Quantity is empty!";
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

        label{
        margin-top: 20px;
    }

    .msg{
        margin-top: 5%;
         margin-left:40%;
        color:white;
        position: relative;
        z-index: 100;
    }

    form {
    height: 620px;
    width: 400px;
    top: 70%;
    }
</style>
 
  
</head>
<body>
<div class= "container">

 
    <nav class="topnav">
        <a href="adminView.jsp"><b>Admin Panel</b></a>
      <a href="adminView.jsp">View </a>
      <a href="adminAdd.jsp">Add </a>
      <a href="adminDelete.jsp">Delete</a>
      <a class="active"  href="adminUpdate.jsp">Update</a>
      <a href="logout.jsp">LogOut</a>
      <div class="dot"></div>
    </nav>

</div>


<div class="form-container">
    <form action= "adminUpdate.jsp" onsubmit="return validate()">
        
       
        <h3>Update Book</h3>
       
        <label for="ISBN">ISBN</label>
        <input type="text" name="isbn" placeholder="Enter ISBN" id="b_isbn"><br>
        <div class="errors" id="isbn"></div><br>
	<label for="Price">Change Price</label>
        <input type="text" name="price" placeholder="Enter Price " id="b_price"><br>
        <div class="errors" id="price"></div><br>
	<label for="Quantity">Change Quantity</label>
        <input type="text" name="quantity" placeholder="Enter Qunatity" id="b_quantity"><br>
        <div class="errors" id="quantity"></div><br>
        <input type="submit" value="Update">
</div>

  </body>

</html>

<%
String isbn= request.getParameter("isbn");
String quantity= request.getParameter("quantity");
String price= request.getParameter("price");

if(isbn != null){
try{
    Class.forName("com.mysql.jdbc.Driver");
    String url = "jdbc:mysql://127.0.0.1/book_store";
    Connection con=DriverManager.getConnection(url, "root", "root");

Statement stmt = con.createStatement();

 String query="Select * from book_records where ISBN='"+isbn+"' ";
   
     ResultSet rs = stmt.executeQuery( query );
   
     if(rs.next()){
		int result = stmt.executeUpdate("UPDATE book_records SET quantity = '"+quantity+"',price = '"+price+"' WHERE ISBN='"+isbn+"'" );

		if(result>0)
		{%>
            <h2 class="msg" style="color: rgb(164, 236, 164); margin-left: 43%;" >Book Updated!</h2>
	<%
		}
		else
		{%>
            <h2 class="msg" style="color: red" >Book could not be updated!</h2> 
          <%
		}
  

	  }
     
     else{
        %>
        <h2 class="msg" style="color: red" >No such book found!</h2> 
    	<%
          }



%>

<%
stmt.close();
con.close();
%>

<%
}
catch(Exception e){System.out.println("Exception");} 
}
%>

<%
}
%>

