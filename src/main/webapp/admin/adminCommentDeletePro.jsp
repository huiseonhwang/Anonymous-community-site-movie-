<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.AdminDAO" %>

<jsp:useBean class="team03.bean.CommentDTO" id="Cdto" />
<jsp:setProperty property="*" name="Cdto" />

<script type="text/javascript">
	
	function windowClose(){
		opener.location.reload();
		window.close();
	}
	
</script>

<%
	String pageNum = request.getParameter("pageNum");

	AdminDAO Adao = AdminDAO.getInstance();
	int Aresult = Adao.deleteComment(Cdto);
	
	if(Aresult == 1){ %>
		<div style="text-align: center;">
			<h3>삭제 완료.</h3>
			<input type="button" value="창 닫기" onclick="windowClose();" />
		</div>
<%	}
%>
