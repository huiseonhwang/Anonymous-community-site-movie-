<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.CommentDAO" %>

<% 
	// 한글처리는 파라미터 받기 전에 미리 처리 후 파라미터 받아야 인코딩 됨
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean class="team03.bean.CommentDTO" id="dto" />
<jsp:setProperty property="*" name="dto" />

<head>
	<meta charset="UTF-8">
	<link href="https://cdn.discordapp.com/attachments/902120345748774922/912167936536481842/My_Post_Copy_1.jpg" rel="shortcut icon" type="image/x-icon">
	<title>시네톡-자유게시판</title>
</head>
    
<%
	// 해당 게시글의 num을 파라미터로 받음 (댓글 번호가 아님)
	String num = request.getParameter("num");
	String pageNum = request.getParameter("pageNum");
	
	CommentDAO dao = CommentDAO.getInstance();
	// 댓글 작성 메소드에 넘겨받은 파라미터를 대입해주고, 게시글의 번호는 메게변수로 직접 대입해줌
	int result = dao.insertComment(dto, Integer.parseInt(num));
	
	if(result == 1){ %>
		<script>
			alert("댓글 작성완료");
			window.location='content.jsp?num=<%=num%>&pageNum=<%=pageNum%>';
		</script>
<%	}  %>
