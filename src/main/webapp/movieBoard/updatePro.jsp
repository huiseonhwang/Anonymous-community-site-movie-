<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team03.bean.MovieDAO" %>
<%@ page import = "team03.bean.MovieDTO" %>
<%@ page import = "com.oreilly.servlet.MultipartRequest"  %>
<%@ page import = "com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import = "java.io.File" %>

<%
	request.setCharacterEncoding("UTF-8");

	String path = request.getRealPath("team03File");  // 저장 경로 
	String enc = "UTF-8";			
	int size = 1024*1024*100;  
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy(); 
	MultipartRequest mr = new MultipartRequest(request,path,size,enc,dp); 
	
	String kategorie = mr.getParameter("kategorie");
	String num = mr.getParameter("num");
	String pageNum = mr.getParameter("pageNum");
	String subject = mr.getParameter("subject");
	String content = mr.getParameter("content");
	String pw = mr.getParameter("pw");
	
	String org = mr.getParameter("org");
	String filename = mr.getFilesystemName("filename");
	
	MovieDTO dto = new MovieDTO();
	dto.setNum(Integer.parseInt(num));
	dto.setSubject(subject);
	dto.setContent(content);
	dto.setPw(pw);
	dto.setKategorie(kategorie);
	
	if(filename == null){
		dto.setFilename(org);
	} else {
		dto.setFilename(filename);
	}
	
	if(pw != null){
		MovieDAO dao = MovieDAO.getInstance();
		int result = dao.updateContent(dto);
		
		if(result == 1){
			
			if(filename != null && org != null){
				File f = new File(path+"//"+org);
				f.delete();	%>
	<%	} %>
		<script>
			alert("수정완료");
			window.location="content.jsp?num=<%=num%>&pageNum=<%=pageNum%>";
		</script>
			
	<%	} else { %>
			<script>
				alert("비밀번호가 틀립니다.");
				history.go(-1);
			</script>
	<%	} 
	} else {
		MovieDAO dao = MovieDAO.getInstance();
		int result = dao.updateMemContent(dto);
	
		if(result == 1){
			if(filename != null && org != null){
				File f = new File(path+"//"+org);
				f.delete();
			} %>
			<script>
				alert("수정완료");
				window.location="content.jsp?num=<%=num%>&pageNum=<%=pageNum%>";
			</script>
		<%}
	}
	
%>