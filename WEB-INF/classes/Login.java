import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;


public class Login extends HttpServlet {

  //Process the HTTP Get request
  public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    
    PrintWriter out = response.getWriter();

    String u_name=request.getParameter("username");
    String pwd=request.getParameter("password");

	 HttpSession session = request.getSession();
    
    out.println("<html>");
    out.println("<head><title>Login</title></head>");
    out.println("<body bgcolor=\"#ffffff\">");


    try{
    Class.forName("com.mysql.jdbc.Driver");

    String url = "jdbc:mysql://127.0.0.1/user_data";

    Connection con=DriverManager.getConnection(url,"root","root");

    Statement st=con.createStatement();
    
     String query="Select * from user_records where username='"+u_name+"' ";
   
     ResultSet rs = st.executeQuery( query );
   
     if(rs.next()){

    	String name = rs.getString("username");
    	String password = rs.getString("password");
	String userType = rs.getString("type");

	    if(u_name.equals(name) && pwd.equals(password)){
		
		session.setAttribute("name", name);	
		session.setAttribute("password", password);
		session.setAttribute("type", userType);
			if(userType.equals("user")){
				RequestDispatcher rd= request.getRequestDispatcher("UserView.jsp");
                    		rd.forward(request, response);

}

			if(userType.equals("admin")){
				RequestDispatcher rd= request.getRequestDispatcher("adminView.jsp");
                    		rd.forward(request, response);
}
		
}

	else if(!u_name.equals(name) && pwd.equals(password))
{
		RequestDispatcher rd = request.getRequestDispatcher("Error-page.jsp");
      		request.setAttribute("error", "noUserName");
      		rd.include(request, response);
		//out.println("<h1>Wrong Username</h1>");

}

	else if(u_name.equals(name) && !pwd.equals(password))
{
		RequestDispatcher rd = request.getRequestDispatcher("Error-page.jsp");
      		request.setAttribute("error", "noPwd");
      		rd.include(request, response);
		//out.println("<h1>Wrong Password</h1>");

}

	    else{
		
		RequestDispatcher rd = request.getRequestDispatcher("Error-page.jsp");
      		request.setAttribute("error", "noCredentials");
      		rd.include(request, response);
		
		//out.println("<h1>Wrong Credentials</h1>");

}

	  }
     
     else{

		RequestDispatcher rd = request.getRequestDispatcher("Error-page.jsp");
      		request.setAttribute("error", "noUser");
      		rd.include(request, response);
    	 //out.println("<h1>No record found</h1>");
          }


out.println("</body></html>");
           st.close();
           con.close();

    }catch(Exception e){

      out.println(e);
    }

  }


  public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        RequestDispatcher rd = request.getRequestDispatcher("Error-page.jsp");
        request.setAttribute("error", "userLogin");
        rd.forward(request, response);
    }

}