<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.Q_DAO" %> 

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String pw = request.getParameter("pw"); 
	
	Q_DAO dao = new Q_DAO();
	int result = dao.deleteQuestion(num, pw);      
	
	if(result == 1){%>
		<script>
			alert("삭제되었습니다");
			window.location="q&a_List.jsp?pageNum=<%=pageNum%>";     
	   </script>
	<%}else{%>
		<script>
			alert("비밀번호를 확인해주세요");
			history.go(-1);
		</script>
	<%}%>
	