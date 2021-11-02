<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="team03.bean.MemberDAO" %>
<%@ page import ="team03.bean.MemberDTO" %>
<%@ page import ="team03.bean.KloginDAO" %>
<%@ page import ="team03.bean.KloginDTO" %>


<link rel="stylesheet" type="text/css" href="mypage.css">
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
	
	String kid = (String)session.getAttribute("kid");
	KloginDAO manager = KloginDAO.getInstance();
	KloginDTO kdto = manager.kgetUserInfo(kid);


if(id != null){%>
<div id="containAll">
<form action="updatePro.jsp" method="post">
	<h3>아이디 : <%=id%> <input type="hidden" name="id" value="<%=id %>"/></h3>  
	<h3>이름 : <input type="text" name="name" value="<%=dto.getName() %>" /></h3> 
	<h3>이메일 : <input type="text" name="email1" value="<%=dto.getEmail1() %>" /></h3>
	<h3>		<input type="text" name="email2" value="<%=dto.getEmail2() %>" /> </h3>
			<input type="submit" value="정보 수정" /> &nbsp;&nbsp; &nbsp;&nbsp;
			<input type="button" value="회원탈퇴" onclick="window.location.href='deleteForm.jsp'"/>
		
</form>
</div>
<%}if(kid != null){%>
<div id="containAll">
<form action="updatePro.jsp" method="post">
	<h3>아이디 : <%=kid%> <input type="hidden" name="id" value="<%=kid%>"/></h3>  
	<h3>이름 : <input type="text" name="kname" value="<%=kdto.getName() %>" /></h3> 
	<h3>이메일 : <input type="text" name="kemail1" value="<%=kdto.getEmail() %>" /></h3>
			<input type="submit" value="정보 수정" /> &nbsp;&nbsp; &nbsp;&nbsp;
			<input type="button" value="회원탈퇴" onclick="window.location.href='deleteForm.jsp'"/>
		
</form>
</div>
<%}%>