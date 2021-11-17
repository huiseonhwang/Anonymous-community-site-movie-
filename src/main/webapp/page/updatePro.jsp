<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.MemberDAO" %>   
<%@ page import="team03.bean.KloginDAO" %>   
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean class="team03.bean.MemberDTO" id="dto" />
<jsp:setProperty property="*" name="dto" />
<jsp:useBean class="team03.bean.KloginDTO" id="kdto" />
<jsp:setProperty property="*" name="kdto" />

<%
	MemberDAO dao = new MemberDAO();
	int result = dao.MemberDataUpdate(dto);
	
	KloginDAO manager = KloginDAO.getInstance();
	int kresult = manager.KmemberDataUpdate(kdto);
		
	if(kresult != 1){
		if(result==1){%>
		<script>
			alert("수정 되었습니다.");
			window.location='/team03/main.jsp';
		</script>
		<%}else{ %>
		<script>
			alert("잘못된 입력이 있습니다. 확인하세요.");
			history.go(-1);
		</script>
		<%}} 
		if(result!=1){
		if(kresult ==1){%>
		<script>
		alert("수정 되었습니다.");
		window.location='/team03/main.jsp';
	</script>
		<%}else {%>
		<script>
		alert("잘못된 입력이 있습니다. 확인하세요.");
		history.go(-1);
	</script>
	<%}}%>
	
