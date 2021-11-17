<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="team03.bean.VisitorDTO" %>
<%@ page import="team03.bean.VisitorDAO" %>
<%@ page import="team03.bean.AdminDAO" %>
    
<%
	request.setCharacterEncoding("UTF-8");
	
	int num = Integer.parseInt(request.getParameter("num"));
	String owner = request.getParameter("owner");
	String pageNum = request.getParameter("pageNum");

	AdminDAO dao = AdminDAO.getInstance();
	int delete = dao.VisitorDelete(owner, num);
	
	if(delete == 1){%>
	<script>
		alert("<%=owner%>님의 글이 삭제되었습니다.");
		window.location="adminVisitorDeleteForm.jsp?pageNum=<%=pageNum%>";
		</script>
	<% }else{%>
		<script>;
		alert("오류")
		history.go(-1);
		</script>
	<%}%>

