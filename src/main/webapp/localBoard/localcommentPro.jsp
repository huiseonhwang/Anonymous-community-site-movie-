<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.LocalBoardCommentDAO" %>

<% 
	// 한글처리는 파라미터 받기 전에 미리 처리 후 파라미터 받아야 인코딩 됨
	request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean class="team03.bean.LocalBoardCommentDTO" id="dto" />
<jsp:setProperty property="*" name="dto" />
    
<%
	String num = request.getParameter("num");
	String pageNum = request.getParameter("pageNum");
	
	dto.setBoardNum(Integer.parseInt(num));
	
	LocalBoardCommentDAO dao = LocalBoardCommentDAO.getInstance();
	int result = dao.LinsertComment(dto, Integer.parseInt(num));
	
	if(result == 1){ %>
		<script>
			alert("댓글 작성완료");
			window.location='localContent.jsp?num=<%=num%>&pageNum=<%=pageNum%>';
		</script>
<%	}  %>
