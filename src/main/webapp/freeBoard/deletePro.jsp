<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.BoardDTO" %>
<%@ page import="team03.bean.BoardDAO" %>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pw = request.getParameter("pw");
	String pageNum = request.getParameter("pageNum");
	
	BoardDAO dao = BoardDAO.getInstance();
	// 객체생성 대신 dao 의 인스턴스 메서드를 호출하고있따 .
	int result = dao.deleteContent(num, pw);
			
	if(result == 1){ 
		String path = request.getRealPath("team03File");
		File f = new File(path+"//"+result);
		f.delete();		%>	
		
		<script>
			alert("삭제되었습니다.");
			window.location="list.jsp?pageNum=<%=pageNum%>";
		</script>
			
<%	} else { %>
		<script>
			alert("비밀번호가 틀립니다.");
			history.go(-1);
		</script>
<%	}
%>