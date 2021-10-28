<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.MemberDAO" %>

<jsp:useBean class="team03.bean.MemberDTO" id="dto" />
<jsp:setProperty property="*" name="dto" />
<%
	MemberDAO dao = new MemberDAO();
	int result = dao.MemberDataDelete(dto);
	if(result == 1){
		session.invalidate();	// 세션 삭제
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
	<%} %>