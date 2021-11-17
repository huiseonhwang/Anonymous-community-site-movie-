<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team03.bean.SignUpDAO" %>

<jsp:useBean class = "team03.bean.SignUpDTO" id = "dto"/>
<jsp:setProperty property="*" name ="dto"/>

<style>
	*{
		text-align: center;
		margin: 0 auto;
		margin-top: 5%;
	}
</style>

<%
	String id = request.getParameter("id");

	SignUpDAO dao = new SignUpDAO();
	boolean result = dao.memberIdCheck(dto);
	
	String str = "사용가능";
	
	if(dto.getId() == null){ %>
		아이디를 입력해주세요.
		<br/>
		<input type="button" value="창 닫기" onclick="window.close();" />
	<%} else {
		
		if(result == true){
			str = "사용불가능";
	%>		<jsp:getProperty property="id" name="dto" />는 이미 사용중인 아이디입니다.
	  <%} else {%>
			<jsp:getProperty property="id" name="dto" />는 사용 가능한 아이디입니다.
	  <%}
	%>

	<script>
		function returnClose(){
			opener.document.getElementById("idCheck").innerHTML = "<font color=red><%=str%></font>";
			self.close();
		}
	</script>

	<input type="button" value="창 닫기" onclick="returnClose();" />
	
<%}%>
	
	