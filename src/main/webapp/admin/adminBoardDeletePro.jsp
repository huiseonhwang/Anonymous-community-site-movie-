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

<%
	int num = Integer.parseInt(request.getParameter("num"));
	int Lnum = Integer.parseInt(request.getParameter("Lnum"));
	String pageNum = request.getParameter("pageNum");	
	
	AdminDAO dao = AdminDAO.getInstance();
	int result = dao.deleteContent(num);
	int Lresult = dao.deleteLcontent(Lnum);
	
	if(num != 0){
	if(result == 1){ 
			String path = request.getRealPath("team03File");
			File f = new File(path+"//"+result);
			f.delete();		%>	
			
			<script>
				alert("삭제되었습니다.");
				window.location="adminDeleteContentConfirm.jsp?pageNum=<%=pageNum%>";
			</script>
				
	<%	} else { %>
			<script>
				alert("비밀번호가 틀립니다.");
				history.go(-1);
			</script>
	<%	}%>
	<% }
	
	if(Lnum != 0){
	if(Lresult == 1){ 
			Ldto.setNum(Lnum);
			String path = request.getRealPath("team03File");
			File f = new File(path+"//"+result);
			f.delete();		%>	
			
			<script>
				alert("삭제되었습니다.");
				window.location="adminDeleteContentConfirm.jsp?pageNum=<%=pageNum%>";
			</script>
				
	<%	} else { %>
			<script>
				alert("비밀번호가 틀립니다.");
				history.go(-1);
			</script>
	<%	}%>
	<%} %>