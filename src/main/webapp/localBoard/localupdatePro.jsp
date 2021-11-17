<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"  %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="team03.bean.LocalBoardDTO" %>
<%@ page import="team03.bean.LocalBoardDAO" %>

<%
	request.setCharacterEncoding("UTF-8");
	String path = request.getRealPath("team03File");  // 저장 경로 
	String enc = "UTF-8";			
	int size = 1024*1024*100;  
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy(); 
	MultipartRequest mr = new MultipartRequest(request,path,size,enc,dp); 
	
	String num = mr.getParameter("num");
	String pageNum = mr.getParameter("pageNum");
	String subject = mr.getParameter("subject");
	String content = mr.getParameter("content");
	
	
	String org = mr.getParameter("org");
	String filename = mr.getFilesystemName("filename");
	
	LocalBoardDTO dto = new LocalBoardDTO();
	dto.setNum(Integer.parseInt(num));
	dto.setSubject(subject);
	dto.setContent(content);
	
	
	if(filename == null){
		dto.setFilename(org);
	} else {
		dto.setFilename(filename);
	}
	
	LocalBoardDAO dao = LocalBoardDAO.getInstance();
	int result = dao.LupdateContent(dto);
	
	if(result == 1){
		
		if(filename != null && org != null){
			File f = new File(path+"//"+org);
			f.delete();	%>
<%		} %>
	<script>
		alert("수정완료");
		window.location="localContent.jsp?num=<%=num%>&pageNum=<%=pageNum%>";
	</script>
		
<%	} else { %>
		<script>
			alert("다시 확인해주세요.");
			history.go(-1);
		</script>
<%	} %>
			