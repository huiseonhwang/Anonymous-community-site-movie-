<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"  %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "team03.bean.MovieDAO" %>
<%@ page import = "team03.bean.MovieDTO" %>
<%@ page import = "java.io.File" %>

<%
	request.setCharacterEncoding("UTF-8");
	String path = request.getRealPath("team03File");
	String ecn = "UTF-8";
	int size = 1024 * 1024 * 100;
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request, path, size, ecn, dp);
	
	int num = Integer.parseInt(mr.getParameter("num"));
	String pageNum = mr.getParameter("pageNum");
	String subject = mr.getParameter("subject");
	String content = mr.getParameter("content");
	
	String org = mr.getParameter("org");
	String filename = mr.getParameter("filename");
	
	MovieDTO dto = new MovieDTO();
	dto.setNum(num);
	dto.setSubject(subject);
	dto.setContent(content);
	
	
	if (filename == null) {
		dto.setFilename(org);
		} else {
			dto.setFilename(filename);
	}
	
	MovieDAO dao = MovieDAO.getInstance();
	int result = dao.updateMemContent(dto);
	
	if (result == 1) {
		if (filename != null && org != null) {
			File f = new File(path+"//"+org);
			f.delete();
		} %>
		<script>
			alert("수정완료");
			window.location="content.jsp?num=<%=num%>&pageNum=<%=pageNum%>";
		</script>
	<% } %>