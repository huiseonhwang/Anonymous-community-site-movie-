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
	
	String LboardNum = request.getParameter("LboardNum");
	String Lnum = request.getParameter("Lnum");
	
	String MboardNum = request.getParameter("MboardNum");
	String Mnum = request.getParameter("Mnum");

	AdminDAO dao = AdminDAO.getInstance();
	
	if(Cnum != null){
		int result = dao.deleteComment(Integer.parseInt(CboardNum), Integer.parseInt(Cnum));
		
		if(result == 1){ %>
			<div style="text-align: center;">
				<h3>삭제 완료.</h3>
				<input type="button" value="창 닫기" onclick="windowClose();" />
			</div>
	<%	}
	}
	
	if(Lnum != null){
		int result = dao.localDeleteComment(Integer.parseInt(LboardNum), Integer.parseInt(Lnum));
		
		if(result == 1){ %>
			<div style="text-align: center;">
				<h3>삭제 완료.</h3>
				<input type="button" value="창 닫기" onclick="windowClose();" />
			</div>
	<%	}
	}
	
	if(Mnum != null){
		int result = dao.movieDeleteComment(Integer.parseInt(MboardNum), Integer.parseInt(Mnum));
		
		if(result == 1){ %>
			<div style="text-align: center;">
				<h3>삭제 완료.</h3>
				<input type="button" value="창 닫기" onclick="windowClose();" />
			</div>
	<%	}
	}
%>
