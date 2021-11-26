<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.LoginDAO" %>

<% request.setCharacterEncoding("UTF-8"); %>

<head>
 	<link href="https://cdn.discordapp.com/attachments/902120345748774922/912167936536481842/My_Post_Copy_1.jpg" rel="shortcut icon" type="image/x-icon">
	<title>로그인-비밀번호 찾기</title>
</head>

<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String pw2 = request.getParameter("pw2");
	
	if(pw.equals(pw2)){
		LoginDAO dao = LoginDAO.getInstance();
	
		int update = dao.updatePw(pw, id);
		if(update == 1){%>
			<script>
				alert("비밀번호 변경 완료.");
				window.close();
			</script>
		<%} else { %>
			<script>
				alert("비밀번호를 다시 입력해 주세요.");
				history.go(-1);
			</script>
		<%	}
	} else {%>
		<script>
			alert("비밀번호를 확인해주세요.");
			history.go(-1);
		</script>
	<%}

%>