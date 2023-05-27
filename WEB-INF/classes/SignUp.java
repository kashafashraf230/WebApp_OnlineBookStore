import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;

public class SignUp extends HttpServlet {


	  public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			
				response.setContentType("text/html");
			
			// get PrintWriter object
			PrintWriter out = response.getWriter();

			String first_name=request.getParameter("firstName");
			String last_name=request.getParameter("lastName");
			String name=request.getParameter("username");
			String phone=request.getParameter("contact_no");
			String email=request.getParameter("email");
			String password=request.getParameter("password");
			String confirm_password=request.getParameter("confirm_password");
			String type = "user";

			out.println("<html>");
			out.println("<head><title>SignUp</title></head>");
			out.println("<body bgcolor=\"#ffffff\">");
			
				// server-side validation
			if(first_name.equals("") || last_name.equals("") || name.equals("") || email.equals("") || password.equals("") || confirm_password.equals(""))
			{
				out.println("<h2>Enter all fields!</h2>");
			}// end if
			
			else if(!emailValidate(email)){
					out.println("<h2>Email format wrong!</h2>");
			
			}
			
			else if(!(password.equals(confirm_password))){
						out.println("<h2>Password and confirm password dont match!</h2>");
			
			}
			
			
			else{
			try
			{
			
			    Class.forName("com.mysql.jdbc.Driver");

				String url = "jdbc:mysql://127.0.0.1/user_data";

				Connection con=DriverManager.getConnection(url, "root", "root");

				Statement st=con.createStatement();
				Statement st1=con.createStatement();
				
				String query="Select * from user_records where username='"+name+"' ";
				ResultSet rs= st.executeQuery(query);
				
				if(rs.next()){
					out.println("<h2>UserName is not available.Try Another!</h2>");
				}
				else
				{
				
					String query1="Select * from user_records where email='"+email+"' ";
					ResultSet rs1 = st1.executeQuery( query1 );
					
					if(rs.next()){
							out.println("<h2>Email not unique!</h2>");
							
							
					}					
					else
					{
						String query2 = "INSERT INTO user_records(firstname,lastname,username,phone,email,password,type) VALUES('"+ first_name + "','"+ last_name + "','"+ name + "','" + phone+ "', '"+email+"' ,'" + password+ "','" + type+ "') ";
						int rst = st1.executeUpdate( query2 );
						if(rst==1){	RequestDispatcher rd= request.getRequestDispatcher("Login.html");
                    		rd.forward(request, response);		}
						else{	out.println("<h1>Account could not be created.</h1>"); 		}
					
					}
				
				}
				
				st.close();
				st1.close();
				con.close();
				
			
			}   // end try block
			catch(Exception e){
				out.println(e);
			}
			}
			out.println("</body></html>");
			out.close();
		}// end do post



		   public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
			{
				RequestDispatcher rd = request.getRequestDispatcher("Error-page.jsp");
				request.setAttribute("error", "userLogin");
				rd.forward(request, response);
			}

		public static boolean emailValidate(String email){
			
			if(email.indexOf("@")>0 && email.indexOf("@")< email.indexOf("."))
			{

				if(email.indexOf(".") > email.indexOf("@")+1 && email.indexOf(".") < email.length()-1)
					{	
						return true;
					}

					else 
						{return false;}

			}
			else 
				{return false;}

			}
}// end class