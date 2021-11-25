<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="https://cdn.discordapp.com/attachments/902120345748774922/912167936536481842/My_Post_Copy_1.jpg" rel="shortcut icon" type="image/x-icon">
<title>시네톡-회원탈퇴</title>    
<style>
		*{
			text-align:center;
		 }
</style>
		<h1>탈퇴</h1><br />
   
<%	String id = (String)session.getAttribute("id");
 	String kid = (String)session.getAttribute("kid");
	
 	if(kid == null){
	if(id != null){%>	
		<form action="deletePro.jsp" method="post">
		 <input type="hidden" name="id" value="<%=id %>" />
		 <h3>password : <input type="password" name="pw"></h3> <br />
		 <input type="submit" value="탈퇴" />
	</form>
<% }else{ %>
	<script>
			alert("로그인 후 사용가능합니다.");
			window.location="/team03/login/loginform.jsp";
		</script>
<%}}
 	if(id ==null){
 	if(kid !=null){%>
 		<form action="deletePro.jsp" method="post">
		 <input type="hidden" name="kid" value="<%=kid%>" />
		<input type="submit" value="탈퇴" />
	</form>
	<% }else{ %>
	<script>
			alert("로그인 후 사용가능합니다.");
			window.location="/team03/login/loginform.jsp";
		</script>
 		<%}}%>
	
	
	
	

