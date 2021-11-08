<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.MovieDAO" %>
<%@ page import="java.io.File"%>
<jsp:useBean class="team03.bean.MovieDTO" id="dto" />
<jsp:setProperty property="num" name="dto" />

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	MovieDAO dao = MovieDAO.getInstance();
	int result = dao.deleteMemContent(dto);
	
	if(result == 1) {
		String path = request.getRealPath("team03File");
		File f = new File(path+"//"+result);
		f.delete(); %>
		
		<script>
			alert("삭제완료");
			window.location="list.jsp?pageNum<%=pageNum%>";
		</script>
	<%}%>