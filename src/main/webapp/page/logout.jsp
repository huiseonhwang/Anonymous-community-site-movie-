<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
 	<script>
			alert("로그아웃 되었습니다.");
			window.location='main.jsp';
	</script>
   
    <%
    	session.removeAttribute("id");
   	 	session.removeAttribute("pw");
    	session.removeAttribute("name");
    	session.removeAttribute("email1");
    %>
