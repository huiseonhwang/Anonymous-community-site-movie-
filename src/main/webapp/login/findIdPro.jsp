<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.LoginDAO" %>

<% request.setCharacterEncoding("UTF-8"); %>

<head>
 	<link href="https://cdn.discordapp.com/attachments/902120345748774922/912167936536481842/My_Post_Copy_1.jpg" rel="shortcut icon" type="image/x-icon">
	<title>로그인-아이디 찾기</title>
</head>

<style>
	*{
		text-align: center;
	}
</style>

<jsp:useBean class="team03.bean.MemberDTO" id="dto" />
<jsp:setProperty property="name" name="dto" />

<script>
	function windowClose(){
		window.close();
	}
</script>

<%
	String name = request.getParameter("name");

	LoginDAO dao = LoginDAO.getInstance();
	String result = dao.getMemberID(name);
	
	if(result != null){ %>
		회원님의 아이디는 [ <%=result%> ] 입니다.
		<br/><br/>
		<input type="button" value="비밀번호 찾기" onclick="window.location='findPw.jsp'"/>
		<input type="button" value="창 닫기" onclick="windowClose();"/>
<%	} else { %>
		해당 이름으로 가입된 아이디가 없습니다.
		<br/><br/>
		<input type="button" value="회원가입 하기" onclick="window.location='/team03/signUp/signUpForm.jsp'"/>
		<br/><br/>
		<input type="button" value="창 닫기" onclick="windowClose();"/>
<%	}
%>