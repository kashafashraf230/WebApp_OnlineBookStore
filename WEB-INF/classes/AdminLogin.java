import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;


public class AdminLogin extends HttpServlet {

  //Process the HTTP Get request
  public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    
    PrintWriter out = response.getWriter();

    String a_name=request.getParameter("admin_name");
    String pwd=request.getParameter("password");
    
    out.println("<html>");
    out.println("<head><title>Admin--Login</title></head>");
    out.println("<body bgcolor=\"#ffffff\">");


    try{
    Class.forName("com.mysql.jdbc.Driver");

    String url = "jdbc:mysql://127.0.0.1/admin_data";

    Connection con=DriverManager.getConnection(url,"root","root");

    Statement st=con.createStatement();
    
     String query="Select * from admin_record where name='"+a_name+"' ";
   
     ResultSet rs = st.executeQuery( query );
   
     if(rs.next()){

    	    String name = rs.getString("name");
    	    String password = rs.getString("password");

	    if(a_name.equals(name) && pwd.equals(password)){
			
		out.println("<h1>Login Successful</h1>");

}

	else if(!a_name.equals(name) && pwd.equals(password))
{
		out.println("<h1>Wrong Username</h1>");

}

	else if(a_name.equals(name) && !pwd.equals(password))
{
		out.println("<h1>Wrong Password</h1>");

}

	    else{
		
		out.println("<h1>Wrong Credentials</h1>");

}

	  }
     
     else{
    	 out.println("<h1>No record found</h1>");
          }


out.println("</body></html>");
           st.close();
           con.close();

    }catch(Exception e){

      out.println(e);
    }

  }

}