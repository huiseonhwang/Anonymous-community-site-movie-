<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="team03.bean.MemberDAO" %>
<%@ page import ="team03.bean.MemberDTO" %>
<h1>정보 수정</h1>
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
	<h3>이름 : <input type="text" name="name" value="<%=dto.getName() %>" /></h3> 
	<h3>이메일 : <input type="text" name="email1" value="<%=dto.getEmail1() %>" /></h3>
	<h3>		<input type="text" name="email2" value="<%=dto.getEmail2() %>" /> </h3>
			<input type="submit" value="정보 수정" /> &nbsp;&nbsp; &nbsp;&nbsp;
			<input type="button" value="회원탈퇴" onclick="window.location.href='deleteForm.jsp'"/>
		
</form>
