<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="team03.bean.MemberDAO" %>
<%@ page import ="team03.bean.MemberDTO" %>

<link rel="stylesheet" type="text/css" href="mypage.css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

	
	<%
	String id = (String)session.getAttribute("id");
	MemberDAO dao = new MemberDAO();
	MemberDTO dto = dao.getUserInfo(id);
	String kid = request.getParameter("kid");
	%>
     
    
   
<title>마이페이지</title>
 <div id="containAll">
	<div id="container">
   		<h1>마이페이지 </h1>
   	 
 
   	   <%if(kid == null){%>
   	   <table>
   	   <tr>
   	   		<td>안녕하세요!</td>
   	   </tr> 
   	   <tr>
       		<td>아이디 : <%=id%><input type="hidden" name="id" value="<%=id %>" /></td>        			
       </tr>
       <tr>
          	<td>비밀번호 : <%=dto.getPw() %> <input type="hidden" name="pw" value="<%=dto.getPw() %>" /></td>
       </tr> 
       <tr>
          	<td>이름 : <%=dto.getName() %><input type="hidden" name="name" value="<%=dto.getName() %>" /></td>
       </tr>
       <tr>
          	<td>이메일 : <%=dto.getEmail1()%>@<%=dto.getEmail2() %>
          	<input type="hidden" name="email1" value="<%=dto.getEmail1() %><%=dto.getEmail2() %>" /></td>
       </tr> 
       <tr>
      		<td>
      			<input type="button" value="정보수정" onclick="window.location='updateForm.jsp'"/>
      			<input type="button" value="정보수정" onclick="window.location='updateForm.jsp'"/>
      		</td>
       </tr>
		<tr>
          <td colspan="2"><input type="button" value="홈으로 가기" onclick="window.location.href='/team03/main.jsp'"/></td>
       </tr> 
       </table>
   <%}else{ %>
   <table>
   	   <tr>
   	   		<td>안녕하세요!</td>
   	   </tr>
       <tr>
       		<td>아이디 : <input type="text" name="id" value="null" /></td>        			
       </tr>   
       <tr>
          	<td>비밀번호 : <input type="text" name="pw" value="null" /></td>
       </tr> 
       <tr>
          	<td>이름 : <input type="text" name="name" value="null" /></td>
       </tr>
       <tr>
          	<td>이메일 : <input type="text" name="email1" value="null" /></td>
       </tr> 
       <tr>
      		<td>
      			<input type="button" value="비밀번호 변경"  onclick=" window.location='logout.jsp'" />
      			<input type="button" value="정보수정" onclick="window.location='updateForm.jsp'"/>
      		</td>
       </tr>
		<tr>
          <td colspan="2"><input type="button" value="홈으로 가기" onclick="window.location.href='/team03/main.jsp'"/></td>
       </tr> 
       </table>
 	</div>
   </div><%} %>
 	


