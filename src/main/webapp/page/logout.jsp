<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 	<script>
			alert("로그아웃 되었습니다.");
			window.location='/team03/main.jsp';
	</script>
   
    <%
   		session.removeAttribute("admin");
    	session.removeAttribute("kid");
    	session.removeAttribute("id");
   	 	session.removeAttribute("pw");
    	session.removeAttribute("name");
    	session.removeAttribute("email1");
    %>
