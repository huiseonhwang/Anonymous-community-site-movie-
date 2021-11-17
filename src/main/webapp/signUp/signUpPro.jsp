<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team03.bean.SignUpDAO" %>

<jsp:useBean class = "team03.bean.SignUpDTO" id = "dto" />
<jsp:setProperty property = "*" name ="dto" />

<%
SignUpDAO dao = new SignUpDAO();
	int result = dao.memberInsert(dto);
	if (result == 1) { 
%>
		<script>
			alert("가입되었습니다.");
			window.location='/team03/login/loginform.jsp';
		</script>
	<%} else {%>
		<script>
			alert("잘못된 입력이 있습니다. 확인하세요..");
			history.go(-1);
		</script>
	<%}%>