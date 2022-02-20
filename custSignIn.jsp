<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@page import="java.sql.*" %>
<%@page import="db.ConnectionManager" %>
<!DOCTYPE html>
<html>
	<body>
		<%
			String username2 = request.getParameter("username");
			String password2 = request.getParameter("password");
			
			try{ 
				
				//create the connection object 
				Connection con = ConnectionManager.getConnection();
				String username = request.getParameter("username");
				String pass = request.getParameter("pass");
		
				//create the statement object 
				Statement stmt=con.createStatement(); 
				String sql = "select * from customer where custUsername= '" + username + "' and custPwd= '" + pass + "'";
				
				//execute query 
				ResultSet rs=stmt.executeQuery(sql); 

				//processing resultset - iterate
				if(rs.next()){
					String custID = rs.getString("custID");
					session.setAttribute("SES_ID",custID);
					response.sendRedirect("Homepage.jsp?custID=" + custID);
				}
				else {
					request.setAttribute("error", "Wrong username or password. Try Again");
					RequestDispatcher rd = request.getRequestDispatcher("index.jsp"); 
					rd.include(request, response);
				} 
				con.close(); 
			}
			catch(Exception e){ 
				System.out.println(e); 
			} 
		%>
	</body>
</html>