<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="team03.bean.MemberDTO" %>
<%@ page import="team03.bean.KloginDTO" %>
<%@ page import="team03.bean.AdminDTO" %>
<%@ page import="team03.bean.AdminDAO" %>

<style>
   	table {
		margin: 0 auto;
		border: 2px solid black;
		border-collapse: collapse;
	}
	tr, td, th {
		border: 2px solid black;
		padding: 10px;
	}
	*{
		text-align: center;
	}
</style>


<%
String admin = (String)session.getAttribute("admin");
if(admin == null){ 
%>	<script>
		alert("잘못된 접근입니다.");
		window.location="/team03/main.jsp";
	</script>
<%	}else{

	String pageNum = request.getParameter("pageNum"); // null 값 대입
	
	int pageSize = 10;
	
	if(pageNum == null){
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	int start = (currentPage - 1) * pageSize + 1; // 결과 = 11
	int end = currentPage * pageSize; // 결과 = 20
	int number = 0;
	
	int count = 0;
	int kcount = 0;
	
	List<MemberDTO> Mlist = null;
	List<KloginDTO> Klist = null;
	AdminDAO dao = AdminDAO.getInstance();
	
	count = dao.getMemCount();
	if(count > 0){
		Mlist = dao.getMember(start, end);
	}
	kcount = dao.getKmemCount();
	if(kcount > 0){
		Klist = dao.getKmember(start, end);
	}
	
%>
<div style="float: left; width: 48%; padding: 10px;">
	<table>
		<tr>
			<th> 회원 아이디 </th>
			<th> 회원 비밀번호 </th>
			<th> 회원 이름 </th>
			<th> 회원 이메일 </th>
			<th> 회원 탈퇴 </th>
		</tr>
		<tr>
			<%
			if(count == 0 && kcount == 0){ %>
				<td colspan="5">	
					회원이 없습니다.
				</td>
			<%} else { %>
		</tr>
			<%for(MemberDTO dto : Mlist){ %>
				<tr>
					<td> <%= dto.getId() %> <input type="hidden" name="id" value="<%=dto.getId()%>" /> </td>
					<td> <%= dto.getPw() %> </td>
					<td> <%= dto.getName() %> </td>
					<td> 
						<%= dto.getEmail1() %>
						<%= dto.getEmail2() %>
					</td>
					<td>	
						<input type="button" value="회원탈퇴" onclick="window.location='adminMemDeletePro.jsp?id=<%=URLEncoder.encode(dto.getId(), "UTF-8")%>'"/>
					</td>
				</tr>
			<%} %>
	</table>
</div>
<div style="float: right; width: 48%; padding: 10px;">
	<table>
		<tr>
			<th> 카카오회원 번호 </th>
			<th> 카카오회원 이름 </th>
			<th> 카카오회원 이메일 </th>
			<th> 카카오회원 탈퇴 </th>
		</tr>
			<%for(KloginDTO kdto : Klist){ %>
			<tr>
				<td> <%= kdto.getKid() %> <input type="hidden" name="kid" value="<%=kdto.getKid()%>" /> </td> 
				<td> <%= kdto.getName() %> </td> 
				<td>
					<%= kdto.getEmail() %>
				</td>
				<td>	
					<input type="button" value="회원탈퇴" onclick="window.location='adminMemDeletePro.jsp?kid=<%=kdto.getKid()%>'"/>
				</td>
			</tr> 
			<%}%>	
		<%}%>
	</table>
</div>
<div style="psition: absolute; clear: left; bottom: 0px; text-align: center;">
	<%
		// 페이지 정렬
		if(count > 0){
			int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
			int startPage = (currentPage / 10) * 10 + 1;
			int pageBlock = 10;
			int endPage = startPage + pageBlock-1;
			if(endPage > pageCount){
				endPage = pageCount;
			}	
			if(startPage > 10){%>
				<a href="adminMemDeleteForm.jsp?pageNum=<%=startPage-10%>">[이전]</a>
			<%}
			for(int i = startPage ; i <= endPage ; i++){
			%>	<a href="adminMemDeleteForm.jsp?pageNum=<%=i%>">[<%=i%>]</a> 	
		  <%}
			if(endPage < pageCount){%>
			<a href="adminMemDeleteForm.jsp?pageNum=<%=startPage + 10%>">[다음]</a>
		  <%}	
		}
	%>
</div>

<%}%>