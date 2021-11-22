<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.BoardDAO" %>

<jsp:useBean class="team03.bean.BoardDTO" id="dto" />
<jsp:setProperty property="num" name="dto" />

<head>
	<meta charset="UTF-8">
	<link href="https://cdn.discordapp.com/attachments/902120345748774922/912167936536481842/My_Post_Copy_1.jpg" rel="shortcut icon" type="image/x-icon">
	<title>시네톡-자유게시판</title>
</head>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pw = request.getParameter("pw");
	String pageNum = request.getParameter("pageNum");
	
	if(pw != null){
		BoardDAO dao = BoardDAO.getInstance();
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
	} else {
		BoardDAO dao = BoardDAO.getInstance();
		int result = dao.deleteMemContent(dto);
		
		if(result == 1){
			String path = request.getRealPath("team03File");
			File f = new File(path+"//"+result);
			f.delete(); %>
			
			<script>
				alert("삭제완료");
				window.location="list.jsp?pageNum=<%=pageNum%>";
			</script>		
	<%	}
	}
	
%>