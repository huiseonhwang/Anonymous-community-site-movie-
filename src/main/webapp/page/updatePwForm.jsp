<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="team03.bean.MemberDAO" %>
<%@ page import ="team03.bean.MemberDTO" %>
<link rel="stylesheet" type="text/css" href="mypage.css">
<link href="https://cdn.discordapp.com/attachments/902120345748774922/912167936536481842/My_Post_Copy_1.jpg" rel="shortcut icon" type="image/x-icon">
<title>시네톡-비밀번호 변경</title>
<style>
		*{
			text-align:center;
		 }
</style>

<div id="containAll">
<h1>비밀번호 변경</h1>


<%
	String id = (String)session.getAttribute("id");
	MemberDAO dao = new MemberDAO();
	MemberDTO dto = dao.getUserInfo(id);
 %>


	
	<form action="updatePwPro.jsp" method="post" >
		<h3><input type="hidden" name="id" value="<%=id %>"/></h3> 
		<h3>비밀번호 : <%=dto.getPw()%></h3>
		<h3>새로운 비밀번호 : <input type="password" name="pw" value="<%=dto.getPw() %>" /></h3>
		<input type="submit" value="비밀번호 변경"  />
	</form>			
</div>
