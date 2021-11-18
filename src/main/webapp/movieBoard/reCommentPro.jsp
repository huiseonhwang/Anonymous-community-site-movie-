<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.MovieCommentDAO" %>
    
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean class="team03.bean.MovieCommentDTO" id="dto" />
<jsp:setProperty property="*" name="dto" />

<%
	int boardNum = Integer.parseInt(request.getParameter("boardNum"));
	int num = Integer.parseInt(request.getParameter("num"));

	MovieCommentDAO dao = MovieCommentDAO.getInstance();
	int result = dao.insertReComment(dto, boardNum, num);
	
	if(result == 1){ %>
		<script>
			alert("작성완료");
			opener.location.reload();
			window.close();
		</script>
	<%}
%>