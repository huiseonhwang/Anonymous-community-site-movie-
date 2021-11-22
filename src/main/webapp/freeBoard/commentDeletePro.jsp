<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.CommentDAO" %>

<jsp:useBean class="team03.bean.CommentDTO" id="dto" />
<jsp:setProperty property="*" name="dto" />

<head>
	<meta charset="UTF-8">
	<link href="https://cdn.discordapp.com/attachments/902120345748774922/912167936536481842/My_Post_Copy_1.jpg" rel="shortcut icon" type="image/x-icon">
	<title>시네톡-자유게시판</title>
</head>

<%
	String pw = request.getParameter("pw");
	String pageNum = request.getParameter("pageNum");
	int re_step = Integer.parseInt(request.getParameter("re_step"));
	int re_level = Integer.parseInt(request.getParameter("re_level"));
	
	if(pw == null){
		CommentDAO dao = CommentDAO.getInstance();
		int result = dao.deleteMemComment(dto, re_step, re_level);
		if(result == 1){ %>
		
			<script>
				alert("삭제되었습니다.");
				opener.location.reload();
				window.close();
			</script>
			
		<%}
	} else {
		CommentDAO dao = CommentDAO.getInstance();
		dto.setPw(pw);
		int result = dao.deleteComment(dto, re_step, re_level);
		if(result == 1){ %>
		
			<script>
				alert("삭제되었습니다.");
				opener.location.reload();
				window.close();
			</script>
			
		<%} else { %>
			
			<script>
				alert("비밀번호가 틀립니다.");
				history.go(-1);
			</script>
			
		<%}
	}
%>