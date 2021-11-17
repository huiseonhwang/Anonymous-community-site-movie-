<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team03.bean.MovieCommentDAO" %>

<%
	// 한글처리
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean class = "team03.bean.MovieCommentDTO" id = "dto" />
<jsp:setProperty property = "*" name = "dto" />

<%
	String num = request.getParameter("num");
	String pageNum = request.getParameter("pageNum");
	dto.setBoardNum(Integer.parseInt(num));
	
	MovieCommentDAO dao = MovieCommentDAO.getInstance();
	int result = dao.insertComment(dto, Integer.parseInt(num));
	
	if(result == 1) { %>
		<script>
			alert("댓글 작성완료");
			window.location="content.jsp?num=<%=num%>&pageNum=<%=pageNum%>";
		</script>
<% } %>