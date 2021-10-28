<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.MemberDAO" %>
<%@ page import ="team03.bean.MemberDTO" %>
<h1>비밀번호 변경</h1>
<style>
		*{
			text-align:center;
		 }
</style>
<%
	String id = (String)session.getAttribute("id");
	MemberDAO dao = new MemberDAO();
	MemberDTO dto = dao.getUserInfo(id);
%>
<form action="updatePro.jsp" method="post">
	<h3>아이디 : <%=id%> <input type="hidden" name="id" value="<%=id %>"/></h3>  
	<h3>비밀번호 : <input type="text" name="pw" value="<%=dto.getPw() %>" /></h3> 
			<input type="submit" value="비밀번호 변경" />
		
</form>
