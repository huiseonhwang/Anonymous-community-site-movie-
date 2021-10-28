<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
		*{
			text-align:center;
		 }
</style>
		<h1>탈퇴</h1><br />
   
<%	String id = (String)session.getAttribute("id");
	if(id == null){%>	
		<script>
			alert("로그인 후 사용가능합니다.");
			window.location="/team03/login.loginform.jsp";
		</script>
<% }else{ %>
	<form action="deletePro.jsp" method="post">
		 <input type="hidden" name="id" value="<%=id %>" />
		 <h3>password : <input type="password" name="pw"></h3> <br />
		 <input type="submit" value="탈퇴" />
	</form>
<%}%>