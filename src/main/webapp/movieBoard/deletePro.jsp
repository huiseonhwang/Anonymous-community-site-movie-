<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team03.bean.MovieDAO" %>
<%@ page import = "java.io.File" %>
<jsp:useBean class = "team03.bean.MovieDTO" id = "dto" />
<jsp:setProperty property = "*" name = "dto" />

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pw = request.getParameter("pw");
	String pageNum = request.getParameter("pageNum");
	
	if (pw != null) {
		// pw 의 값이 입력돼 있으면
		MovieDAO dao = MovieDAO.getInstance();
		int result = dao.deleteContent(num, pw);
		
		// 파일 삭제 
		if (result == 1) {
			String path = request.getRealPath("team03File");
			File f = new File(path+"//"+result);
			f.delete(); %>
			
			<script>
				alert ("삭제되었습니다");
				window.location="list.jsp?pageNum=<%=pageNum%>";
			</script>
			
		<% } else { %>
			<script>
				alert("비밀번호가 틀렸습니다.");
				history.go(-1);
			</script>
		<% }
	} else {
		MovieDAO dao = MovieDAO.getInstance();
		int result = dao.deleteMemContent(dto);
		
		// 파일 삭제
		if (result ==1) {
			String path = request.getRealPath("team03File");
			File f = new File(path+"//"+result);
			f.delete(); %>
			
			<script>
				alert ("삭제되었습니다");
				window.location="list.jsp?pageNum=<%=pageNum%>";
			</script>
<% }
}
%>