import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import javax.swing.*;


public class logout extends HttpServlet 
{  
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        HttpSession session = request.getSession(false);
        session.invalidate();
        request.getRequestDispatcher("login.html").forward(request,response);
    }
}