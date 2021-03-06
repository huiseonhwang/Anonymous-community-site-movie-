<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.CommentDAO" %>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean class="team03.bean.CommentDTO" id="dto" />
<jsp:setProperty property="*" name="dto" />

<head>
	<meta charset="UTF-8">
	<link href="https://cdn.discordapp.com/attachments/902120345748774922/912167936536481842/My_Post_Copy_1.jpg" rel="shortcut icon" type="image/x-icon">
	<title>시네톡-자유게시판</title>
</head>

<%
	String pageNum = request.getParameter("pageNum");
	String content = request.getParameter("content");
	String pw = request.getParameter("pw");

	int re_step = Integer.parseInt(request.getParameter("re_step"));
	int re_level = Integer.parseInt(request.getParameter("re_level"));
	
	// pw가 null 일 때 (익명이 작성한 댓글이 아닐 때)
	if(pw == null) {
		dto.setContent(content);
		CommentDAO dao = CommentDAO.getInstance();
		int result = dao.updateMemComment(dto, re_step, re_level);
		if(result == 1) { %>
		
			<script>
				alert("수정완료");
				opener.location.reload();
				window.close();
			</script>
			
	<%	}
	} else { // pw가 null이 아닐 때 (익명이 작성한 댓글일 때)
		dto.setContent(content);
		dto.setPw(pw);
		CommentDAO dao = CommentDAO.getInstance();
		int result = dao.updateComment(dto, re_step, re_level);
		if(result == 1) { %>
		
			<script>
				alert("수정완료");
				opener.location.reload();
				window.close();
			</script>
			
	<%	} else { %>
	
			<script>
				alert("비밀번호가 틀립니다.");
				history.go(-1);
			</script>
			
	  <%}
	}
%>