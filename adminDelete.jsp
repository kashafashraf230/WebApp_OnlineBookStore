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
    <title>Delete Book</title>
    <link rel="stylesheet" href="userNavbar.css">
    <link rel = "stylesheet" href = "admin.css"/>




<script>
        function validate(){

            var isbn = document.getElementById("b_isbn").value;

	    if(isbn == "")
            {
                document.getElementById("isbn").innerHTML = "ISBN is empty!";
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
        margin-top: 40px;
    }

    form {
    height: 380px;
    width: 400px;
    top: 50%
    }

    .msg{
        margin-top: 22%;
         margin-left:40%;
        color:white;
        position: relative;
        z-index: 100;
    }
</style>
 
  
</head>
<body>
<div class= "container">

  
    <nav class="topnav">
        <a href="adminView.jsp"><b>Admin Panel</b></a>
      <a href="adminView.jsp">View </a>
      <a href="adminAdd.jsp">Add </a>
      <a class="active" href="adminDelete.jsp">Delete</a>
      <a  href="adminUpdate.jsp">Update</a>
      <a href="logout.jsp">LogOut</a>
      <div class="dot"></div>
    </nav>

</div>


<div class="form-container">
    <form action= "adminDelete.jsp" onsubmit="return validate()">
        
       
        <h3>Delete Book</h3>

      
        <label for="ISBN">Enter ISBN of book you want to delete</label>
        <input type="text" name="isbn" placeholder="Enter ISBN" id="b_isbn"><br>
        <div class="errors" id="isbn"></div><br>
	<input type="submit" value="Delete"><br><br>
	
</div>

  </body>

</html>
<%
String isbn= request.getParameter("isbn");

if(isbn!= null){
try{
    Class.forName("com.mysql.jdbc.Driver");
    String url = "jdbc:mysql://127.0.0.1/book_store";
    Connection con=DriverManager.getConnection(url, "root", "root");



Statement stmt = con.createStatement();

 String query="Select * from book_records where ISBN='"+isbn+"' ";
   
     ResultSet rs = stmt.executeQuery( query );
   
     if(rs.next()){
		int result = stmt.executeUpdate("DELETE FROM book_records WHERE ISBN='"+isbn+"'" );
          
      if(result>0)
		{ %> <h2 class="msg" style="color: rgb(164, 236, 164); margin-left: 43%;" >Book Deleted!</h2>
	<%
		}

        else
		{%> <h2 class="msg" style="color: red;">Book could not be deleted!</h2>
        <%
		}
  

	  }
     
     else{%>
    	<h2 class="msg" style="color: red;">No such book found!</h2>
        <%}

stmt.close();
con.close();

}
catch(Exception e){System.out.println("Exception");} 
}%>

<%
}
%>
