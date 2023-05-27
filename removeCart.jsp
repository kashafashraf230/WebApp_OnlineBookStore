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

String b_isbn = request.getParameter("removeCart");
String username = (String)session.getAttribute("name");

try{
    Class.forName("com.mysql.jdbc.Driver");
    String url = "jdbc:mysql://127.0.0.1/book_store";
    Connection con=DriverManager.getConnection(url, "root", "root");

String name = "";
String isbn = "";

Statement stmt = con.createStatement();
ResultSet rs = stmt.executeQuery("select * from cart where username='"+username+"' and isbn ='"+b_isbn+"' ");


if(rs.next()) {


		int result = stmt.executeUpdate("DELETE FROM cart WHERE ISBN='"+b_isbn+"'" );

		if(result>0)
		{out.println("Book(s) Deleted");
	
		}
		else
		{out.println("Book(s) could not be deleted");
		}
}


stmt.close();
con.close();
}
catch(Exception e){System.out.println("Exception");}


}

%>
