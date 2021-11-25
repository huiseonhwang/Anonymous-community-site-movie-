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

	String CboardNum = request.getParameter("CboardNum");
	String Cnum = request.getParameter("Cnum");
	String Cre_step = request.getParameter("Cre_step");
	String Cre_level = request.getParameter("Cre_level");
	
	String LboardNum = request.getParameter("LboardNum");
	String Lnum = request.getParameter("Lnum");
	String Lre_step = request.getParameter("Lre_step");
	String Lre_level = request.getParameter("Lre_level");
	
	String MboardNum = request.getParameter("MboardNum");
	String Mnum = request.getParameter("Mnum");
	String Mre_step = request.getParameter("Mre_step");
	String Mre_level = request.getParameter("Mre_level");

	AdminDAO dao = AdminDAO.getInstance();
	
	if(Cnum != null){
		int result = dao.deleteComment(Integer.parseInt(CboardNum), Integer.parseInt(Cnum), Integer.parseInt(Cre_step), Integer.parseInt(Cre_level));
		
		if(result == 1){ %>
			<div style="text-align: center;">
				<h3>삭제 완료.</h3>
				<input type="button" value="창 닫기" onclick="windowClose();" />
			</div>
	<%	}
	}
	
	if(Lnum != null){
		int result = dao.localDeleteComment(Integer.parseInt(LboardNum), Integer.parseInt(Lnum), Integer.parseInt(Lre_step), Integer.parseInt(Lre_level));
		
		if(result == 1){ %>
			<div style="text-align: center;">
				<h3>삭제 완료.</h3>
				<input type="button" value="창 닫기" onclick="windowClose();" />
			</div>
	<%	}
	}
	
	if(Mnum != null){
		int result = dao.movieDeleteComment(Integer.parseInt(MboardNum), Integer.parseInt(Mnum), Integer.parseInt(Mre_step), Integer.parseInt(Mre_level));
		
		if(result == 1){ %>
			<div style="text-align: center;">
				<h3>삭제 완료.</h3>
				<input type="button" value="창 닫기" onclick="windowClose();" />
			</div>
	<%	}
	}
%>
