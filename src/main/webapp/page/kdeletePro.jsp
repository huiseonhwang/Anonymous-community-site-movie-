<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="team03.bean.KloginDAO"  %>

<jsp:useBean class="team03.bean.KloginDTO" id="kdto" />
<jsp:setProperty property="*" name="kdto" />

<% 
	KloginDAO manager = KloginDAO.getInstance(); 
	int kresult = manager.KmemberDataDelete(kdto);
	
	if(kresult ==1){
		session.invalidate();
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
	<%} %>
	
	
	