<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.MemberDAO" %>
<%@ page import ="team03.bean.KloginDAO"  %>
<%@ page import="team03.bean.BoardDAO" %>

<jsp:useBean class="team03.bean.MemberDTO" id="dto" />
<jsp:setProperty property="*" name="dto" />
<jsp:useBean class="team03.bean.KloginDTO" id="kdto" />
<jsp:setProperty property="*" name="kdto" />
<jsp:useBean class="team03.bean.BoardDTO" id="bdto" />
<jsp:setProperty property="*" name="bdto" />

<%
	String id = request.getParameter("id");
	String kid = request.getParameter("kid");
	String writer;
	
	if(kid == null){
		writer = id;
	} else {
		writer = "카카오" + kid;
	}

	MemberDAO dao = new MemberDAO();
	int result = dao.MemberDataDelete(dto);
	
	KloginDAO manager = KloginDAO.getInstance(); 
	int kresult = manager.KmemberDataDelete(kdto);
	
	
	if(kresult != 1){
	if(result == 1){
		session.invalidate();	// 세션 삭제
		
		BoardDAO Bdao = BoardDAO.getInstance();
		int Bresult = Bdao.deleteWriter(writer);
	%>
	<script>
		alert("탈퇴 되었습니다.");
		window.location='/team03/main.jsp';
	</script>
<%}else{ %>
	<script>
		alert("비밀번호를 확인하세요.");
		history.go(-1);
	</script>
	<%}} 
	if(result != 1){
		if(kresult == 1){
			session.invalidate();

			BoardDAO Bdao = BoardDAO.getInstance();
			int Bresult = Bdao.deleteWriter(writer);
		%>
	<script>
		alert("탈퇴 되었습니다.");
		window.location='/team03/main.jsp';
	</script>
	<%}else{ %>
	<script>
		alert("다시 확인하세요.");
		history.go(-1);
	</script>
	
	<%}}%>
	