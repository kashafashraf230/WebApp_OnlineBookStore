<%

	String error_type = (String)request.getAttribute("error");

	if(error_type.equals("noUserName")){
%>
		<h3> Wrong Username</h3>

<%		
}

	else if(error_type.equals("noPwd")){
%>
		<h3> Wrong Password</h3>

<%		
}
	
	else if(error_type.equals("noCredentials")){
%>
		<h3> Wrong Credentials </h3>

<%		
}

	else if(error_type.equals("noUser")){
%>
		<h3> No such user exists</h3>

<%		
}

	else if(error_type.equals("noLogin")){
%>
		<h3>You've not logged into your account.</h3>

<%		

		RequestDispatcher rd = request.getRequestDispatcher("Login.html");
     	 	rd.forward(request, response);
}

	else if(error_type.equals("userLogin")){
%>
		<h3>Access Denied.</h3>

<%		
}

%>
