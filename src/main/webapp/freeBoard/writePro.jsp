<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"  %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="team03.bean.BoardDTO" %>
<%@ page import="team03.bean.BoardDAO" %>

<head>
	<meta charset="UTF-8">
	<link href="https://cdn.discordapp.com/attachments/902120345748774922/912167936536481842/My_Post_Copy_1.jpg" rel="shortcut icon" type="image/x-icon">
	<title>시네톡-자유게시판</title>
</head>

<%
	request.setCharacterEncoding("UTF-8");

	String path = request.getRealPath("team03File");
	String enc = "UTF-8";			//한글명 파일업로드시 적용된다.
	int size = 1024*1024*100;  // 100MB (업로드 최대크기 100MB 설정)
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy(); // 파일명 중복방지
	MultipartRequest mr = new MultipartRequest(request,path,size,enc,dp); //업로드
	
	String writer = mr.getParameter("writer");
	String subject = mr.getParameter("subject");
	String content = mr.getParameter("content");
	String filename = mr.getFilesystemName("filename");
	String pw = mr.getParameter("pw");
	
	BoardDTO dto = new BoardDTO();
	dto.setWriter(writer);
	dto.setSubject(subject);
	dto.setContent(content);
	dto.setFilename(filename);
	dto.setPw(pw);
	
	BoardDAO dao = BoardDAO.getInstance();
	int result = dao.insertContent(dto);
	if(result == 1){ %>
		<script>
			alert("작성완료");
			window.location="list.jsp";
		</script>
<%	}
%>