<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.List"%>
<%@ page import="team03.bean.BoardDAO" %>    
<%@ page import="team03.bean.AdminDAO" %>    

    
<jsp:useBean class="team03.bean.BoardDTO" id="dto" />
<jsp:setProperty property="num" name="dto" />
<jsp:useBean class="team03.bean.LocalBoardDTO" id="Ldto" />
<jsp:setProperty property="num" name="Ldto" />
<jsp:useBean class="team03.bean.MovieDTO" id="Mdto" />
<jsp:setProperty property="num" name="Mdto" />


<%
	String num = request.getParameter("num");
	String Lnum = request.getParameter("Lnum");
	String Mnum = request.getParameter("Mnum");
	
	if(num != null){
		
		AdminDAO dao = AdminDAO.getInstance();
		int result = dao.deleteContent(Integer.parseInt(num));
		
		if(result == 1){ 
		String path = request.getRealPath("team03File");
		File f = new File (path+"//"+result);
		f.delete();%>

			<script>
				alert("삭제되었습니다.");
				window.location="adminMain.jsp";
			</script>
		<%}else{%>
			<script>
				alert("오류.");
				history.go(-1);
			</script>
		<%}
	}
	
	if(Lnum != null){
		
		AdminDAO dao = AdminDAO.getInstance();
		int result = dao.LocalDeleteContent(Integer.parseInt(Lnum));
		
		if(result == 1){
			String path = request.getRealPath("team03File");
			File f = new File (path + "//" + result);
			f.delete(); %>
			
			<script>
				alert("삭제되었습니다.");
				window.location="adminMain.jsp";
			</script>
		<%}else{%>
			<script>
				alert("오류.");
				history.go(-1);
			</script>
		<%}
	}
	
	if(Mnum != null){
		
		AdminDAO dao = AdminDAO.getInstance();
		int result = dao.MovieDeleteContent(Integer.parseInt(Mnum));
		
		if(result == 1){
			String path = request.getRealPath("team03File");
			File f = new File(path + "//" + result);
			f.delete(); %>
			
			<script>
				alert("삭제되었습니다.");
				window.location="adminMain.jsp";
			</script>
		<%}else{%>
				<script>
				alert("오류.");
				history.go(-1);
			</script>
		<%}
	}%>
	