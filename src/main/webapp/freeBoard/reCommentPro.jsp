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
	// 게시글 번호(boardNum)와 대댓글을 달 댓글 번호(num)를 파라미터로 받아옴
	int boardNum = Integer.parseInt(request.getParameter("boardNum"));
	int num = Integer.parseInt(request.getParameter("num"));

	CommentDAO dao = CommentDAO.getInstance();
	// 파라미터로 받아온 게시글 번호와 댓글 번호를 메소드의 메게변수로 넣어줌
	int result = dao.insertReComment(dto, boardNum, num);
	
	if(result == 1){ %>
		<script>
			alert("작성완료");
			opener.location.reload();
			window.close();
		</script>
	<%}
%>