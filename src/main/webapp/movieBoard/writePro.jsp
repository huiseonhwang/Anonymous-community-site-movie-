<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"  %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.util.Enumeration" %>
<%@ page import="team03.bean.MovieDTO" %>
<%@ page import="team03.bean.MovieDAO" %>

<%
	request.setCharacterEncoding("UTF-8");

	String path = request.getRealPath("team03File");
	String enc = "UTF-8";			//한글명 파일업로드시 적용된다.
	int size = 1024*1024*100;  // 100MB (업로드 최대크기 100MB 설정)
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy(); // 파일명 중복방지
	MultipartRequest mr = new MultipartRequest(request,path,size,enc,dp); //업로드

	String kategorie = mr.getParameter("kategorie");
	String writer = mr.getParameter("writer");
	String subject = mr.getParameter("subject");
	String content = mr.getParameter("content");
	String filename = mr.getParameter("filename");
	String pw = mr.getParameter("pw");
	
	MovieDTO dto = new MovieDTO();
	dto.setWriter(writer);
	dto.setKategorie(kategorie);
	dto.setSubject(subject);
	dto.setContent(content);
	dto.setFilename(filename);
	dto.setPw(pw);
	
	MovieDAO dao = MovieDAO.getInstance();
	int result = dao.insertContent(dto);
	if (result == 1) { %>
		<script>
			alert("작성완료");
			window.location="list.jsp";
		</script>
		<% } %>