<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.List"%>
<%@ page import="team03.bean.BoardDAO" %>    
    
<jsp:useBean class="team03.bean.BoardDTO" id="dto" />
<jsp:setProperty property="num" name="dto" />

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
	#center{
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
	
	request.setCharacterEncoding("UTF-8");
	String pageNum = request.getParameter("pageNum");
	BoardDAO dao = BoardDAO.getInstance();
	dto = dao.getContent(dto);
%>

<table id="center">
	<tr>
		<th colspan="4"> <a href="adminBoardDeleteForm.jsp"> 관리자 확인용 게시판 </a> </th>
	</tr>
	<tr>
		<td> 작성자 </td>
		<td> <%= dto.getWriter() %> </td>
		<td> 조회수 </td>
		<td> <%= dto.getReadcount() %> </td>
	</tr>
	<tr>
		<td> 제목 </td>
		<td colspan="4"> <%= dto.getSubject() %> </td>
	</tr>
	<tr>
		<td style="padding-bottom: 300px;"> 내용 </td>
		<td colspan="4" style="padding-bottom: 300px;"> <%= dto.getContent() %> </td>
	</tr>
	<%if(dto.getFilename() != null){ %>
		<tr>
			<td> 첨부파일 </td>
			<td colspan="4">
				<a href="/team03/team03File/<%= dto.getFilename() %>">
					<%= dto.getFilename() %>
				</a>
			</td>
		</tr>
<%	} else { %>
		<tr>
			<td colspan="4">
				[첨부파일 없음]
			</td>
		</tr>
<%	} %>
	<tr>
		<td> <input type="button" value="삭제하기"
				onclick="window.location='adminBoardDeletePro.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" /> </td>
		<td> <%= dto.getGood() %> </td>

	</tr>
</table>

<%}%>