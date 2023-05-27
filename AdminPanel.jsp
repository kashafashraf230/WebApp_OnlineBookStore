<%@page import="javax.servlet.http.*" %>

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


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AdminPanel</title>
    <link rel="stylesheet" href="userNavbar.css">

	<style>
		@import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300&display=swap');
	</style>
 
  
</head>
<body>
<div class= "container">

    <nav class="topnav">
	<a href="adminView.jsp"><b>Admin Panel</b></a>
      <a class = "active" href="adminView.jsp">View </a>
      <a href="adminAdd.jsp">Add </a>
      <a href="adminDelete.jsp">Delete</a>
      <a href="adminUpdate.jsp">Update</a>
      <a href="logout.jsp">LogOut</a>
      <div class="dot"></div>
    </nav>

</div>
  </body>

</html>

<%
}
%>


