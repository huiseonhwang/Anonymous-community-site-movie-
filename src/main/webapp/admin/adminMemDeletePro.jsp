<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.MemberDAO" %>
<%@ page import ="team03.bean.KloginDAO"  %>
<%@ page import="team03.bean.BoardDAO" %>
<%@ page import="team03.bean.AdminDAO" %>

<jsp:useBean class="team03.bean.MemberDTO" id="dto" />
<jsp:setProperty property="*" name="dto" />
<jsp:useBean class="team03.bean.KloginDTO" id="kdto" />
<jsp:setProperty property="*" name="kdto" />
<jsp:useBean class="team03.bean.BoardDTO" id="bdto" />
<jsp:setProperty property="*" name="bdto" />

<%
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	String kid = request.getParameter("kid");
	String writer;
	
	if(kid == null){
		writer = id;
	} else {
		writer = "카카오" + kid;
	}
	
	AdminDAO dao = AdminDAO.getInstance();
	int result = dao.deleteMem(id);
	int kresult = dao.deleteKMem(kid);
	
	if(kresult == 1){
		BoardDAO Bdao = BoardDAO.getInstance();
		int Bresult = Bdao.deleteWriter(writer);
	%>
		<script>
			alert("탈퇴완료");
			history.go(-1);
		</script>
	<%} else {
		if(result == 1){
			BoardDAO Bdao = BoardDAO.getInstance();
			int Bresult = Bdao.deleteWriter(writer);
		%>
			<script>
				alert("탈퇴완료");
				history.go(-1);
			</script>
		<%}
	}
%>