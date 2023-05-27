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
    <title>Add Book</title>
    <link rel="stylesheet" href="userNavbar.css">
    <link rel = "stylesheet" href = "admin.css"/>
<script>
        function validate(){

            var b_name = document.getElementById("b_title").value;
	    var author = document.getElementById("b_author").value;
            var isbn = document.getElementById("b_isbn").value;
	    var quantity = document.getElementById("b_quantity").value;
	    var price = document.getElementById("b_price").value;

            if(b_name == "")
            {
                document.getElementById("title").innerHTML = "Title is empty!";
                return false;
            }

            if(author == "")
            {
                document.getElementById("author").innerHTML = "Author name is empty!";
                return false;
            }
	
	    if(isbn == "")
            {
                document.getElementById("isbn").innerHTML = "ISBN is empty!";
                return false;
            }

	    if(quantity == "")
            {
                document.getElementById("quantity").innerHTML = "Quantity is empty!";
                return false;
            }
	    if(price == "")
            {
                document.getElementById("price").innerHTML = "Price is empty!";
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

    form {
    height: 900px;
    width: 491px;
    top: 90%;
    }

    .msg{
        margin-top: 3%;
         margin-left:40%;
        color:white;
        position: relative;
        z-index: 100;
    }

    body{
    /* display: flex; */
    background-size:100vw 200vh ;
}
</style>
 
  
</head>
<body>
<div class= "container">

 
    <nav class="topnav">
        <a href="adminView.jsp"><b>Admin Panel</b></a>
      <a href="adminView.jsp">View </a>
      <a class="active" href="adminAdd.jsp">Add </a>
      <a href="adminDelete.jsp">Delete</a>
      <a href="adminUpdate.jsp">Update</a>
      <a href="logout.jsp">LogOut</a>
      <div class="dot"></div>
    </nav>

</div>


<div class="form-container">
    <form action= "adminAdd.jsp" onsubmit="return validate()">
        
       
        <h3>Add Book</h3>
        <label for="title">Book Title</label>
        <input type="text" name = "title" placeholder="Enter Title" id="b_title"><br>
        <div class="errors" id="title"></div><br>
	<label for="author">Author</label>
        <input type="text" name="author" placeholder="Author Name" id="b_author"><br>
        <div class="errors" id="author"></div><br>
        <label for="ISBN">ISBN</label>
        <input type="text" name="isbn" placeholder="Enter ISBN" id="b_isbn"><br>
        <div class="errors" id="isbn"></div><br>
	<label for="Price">Price</label>
        <input type="text" name="price" placeholder="Enter Price" id="b_price"><br>
        <div class="errors" id="price"></div><br>
	<label for="Quantity">Quantity</label>
        <input type="text" name="quantity" placeholder="Enter Qunatity" id="b_quantity"><br>
        <div class="errors" id="quantity"></div><br>
        <input type="submit" value="Add Book">
</div>

  </body>

</html>
<%
String title = request.getParameter("title");
String isbn= request.getParameter("isbn");
String author= request.getParameter("author");
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
   
     if(!rs.next()){

	 
int result = stmt.executeUpdate("INSERT INTO book_records(title,ISBN,author,quantity,price)VALUES('"+ title + "','" + isbn+ "','" + author+ "','" + quantity+ "','" + price+ "') " );

if(result==1)
{%>
	<h2 class="msg" style="color: rgb(164, 236, 164); margin-left: 44%;" >Book added!</h2>
	<%
}
else
{%>
    <h2 class="msg" style="color: red" >Book could not be added!</h2>
    <%

}
}

stmt.close();
con.close();

}
catch(Exception e){System.out.println("Exception");} 
}
%>


<%
}
%>

