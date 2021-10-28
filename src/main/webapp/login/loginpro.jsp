<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team03.bean.LoginDAO" %>
<%@ page import = "team03.bean.LoginDTO" %>

    
 
 
 <jsp:useBean class = "team03.bean.LoginDTO" id ="dto"/>
 <jsp:setProperty property = "*" name ="dto"/>
 
 
 
<% 
	
LoginDAO manager = LoginDAO.getInstance();
boolean result = manager.logincheck(dto);
String kid = request.getParameter("id");

	if(kid != null){
	session.setAttribute("id", dto.getKid()); 
	response.sendRedirect("/team03/main.jsp"); 
    }%>
    <h2> 로그인 되었습니다 </h2>

	<%
	if(result == true){
	session.setAttribute("id", dto.getId()); 
    %>
    <script>
    window.location.href='/team03/main.jsp';
    </script>
    <h2> 로그인 되었습니다 </h2>
    <%}else{ %>
    <script>
    alert("아이디/비밀번호를 확인하세요");
    history.go(-1);
    </script>
    <% } %>