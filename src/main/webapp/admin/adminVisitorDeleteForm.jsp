<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="team03.bean.VisitorDTO" %>
<%@ page import="team03.bean.MemberDTO" %>    
<%@ page import="team03.bean.KloginDTO" %>    
<%@ page import="team03.bean.AdminDTO" %>
<%@ page import="team03.bean.AdminDAO" %>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.sql.ResultSet"%>
<%@ page import="java.util.List" %> 

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

	<head>

	<title>관리자용 미니페이지</title>
	<link href="https://cdn.discordapp.com/attachments/902120345748774922/912167936536481842/My_Post_Copy_1.jpg" rel="shortcut icon" type="image/x-icon">
</head>

<%
String admin = (String)session.getAttribute("admin");
if(admin == null){ 
%>	<script>
		alert("잘못된 접근입니다.");
		window.location="/team03/main.jsp";
	</script>
<%	}else{

	request.setCharacterEncoding("UTF-8");
	
	String pageNum = request.getParameter("pageNum");
	
	if(pageNum ==null){
		pageNum = "1";
	}

	int pageSize = 10;
	int currentPage=Integer.parseInt(pageNum);
	int start =(currentPage-1)*pageSize+1;
	int end = currentPage*pageSize;
	
	int number = 0;
	int count=0;
	
	AdminDAO dao = AdminDAO.getInstance();
	List<VisitorDTO> list = null;
	
	count =dao.getVisitorCount();
	if(count>0){
		list=dao.getAllVlist(start, end);
	}
	number = count - (currentPage-1) * pageSize;
%>

<center>
	<input type="button" value="메인으로 돌아가기"
		onclick="window.location='/team03/main.jsp'" />
	<input type="button" value="관리자페이지로 돌아가기"
		onclick="window.location='/team03/admin/adminMain.jsp'" />
</center>

<br/>

<form>
			<table width="700">
				<tr>
					<% if(count == 0){ %> 
					<td colspan="4"> 방명록이 없습니다! </td>
				</tr>
					<% }else{ 
						
						 for(VisitorDTO dto : list) { %>
									<tr>
									<td width="100" align="center">
										<h5><%=dto.getReg()%></h5>
										<strong><font color="red"><h5>No.<%=number--%></h5></font></strong>
										<h3><font color="blue"><%=dto.getId()%></font></h3>
									</td>
									<th align="left"> <%=dto.getContent()%> </th>
									<th width="90">
										<input type="button" value="삭제하기" onclick="window.location='/team03/admin/adminVisitorDeletePro.jsp?owner=<%=URLEncoder.encode(dto.getOwner(), "UTF-8")%>&num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'"/>
									</th>
								 </tr>
						<% } %>	
					<% } %>
					 
			</table>
		</form>		
<%
	if(count > 0){
	int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
	int startPage = (currentPage / 10) * 10 + 1;
	int pageBlock = 10;
	int endPage = startPage + pageBlock - 1;
								
	if(endPage > pageCount){ 
		endPage = pageCount;
	} 
	if(startPage > 10){ %>
		<a href="adminVisitorDeleteForm.jsp?pageNum=<%=startPage-10%>">[이전]</a>
	<% }
	for(int i = startPage ; i <= endPage ; i++){ %>
		<a href="adminVisitorDeleteForm.jsp?pageNum=<%=i%>">[<%=i%>]</a>
	<% }
	if(endPage < pageCount){ %>
		<a href="adminVisitorDeleteForm.jsp?pageNum=<%=startPage+10%>">[다음]</a>
	<% }
} %>

<%}%>