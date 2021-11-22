<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.List"%>
<%@ page import="team03.bean.BoardDAO" %>
<%@ page import="team03.bean.LocalBoardDAO" %> 
<%@ page import="team03.bean.MovieDAO" %>     

<jsp:useBean class="team03.bean.BoardDTO" id="dto" />
<jsp:setProperty property="num" name="dto" />
<jsp:useBean class="team03.bean.LocalBoardDTO" id="Ldto" />
<jsp:setProperty property="num" name="Ldto" />
<jsp:useBean class="team03.bean.MovieDTO" id="Mdto" />
<jsp:setProperty property="num" name="Mdto" />

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

<head>

<title>관리자 확인용 게시판</title>
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
	
	String num = request.getParameter("num");
	String Lnum = request.getParameter("Lnum");
	String Mnum = request.getParameter("Mnum");
	
	request.setCharacterEncoding("UTF-8");

	if(num != null){
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
						onclick="window.location='adminBoardDeletePro.jsp?num=<%=dto.getNum()%>'" /> </td>
		
			</tr>
		</table>
	<%}
	
	if(Lnum != null){
		Ldto.setNum(Integer.parseInt(Lnum)); 

		LocalBoardDAO Ldao = LocalBoardDAO.getInstance();
		Ldto = Ldao.LgetContent(Ldto);
	%>
			<table id="center">
				<tr>
					<th colspan="4"> <a href="adminBoardDeleteForm.jsp"> 관리자 확인용 게시판 </a> </th>
				</tr>
				<tr>
					<td> 작성자 </td>
					<td> <%= Ldto.getWriter() %> </td>
					<td> 조회수 </td>
					<td> <%= Ldto.getReadcount() %> </td>
				</tr>
				<tr>
					<td> 제목 </td>
					<td colspan="4"> <%= Ldto.getSubject() %> </td>
				</tr>
				<tr>
					<td style="padding-bottom: 300px;"> 내용 </td>
					<td colspan="4" style="padding-bottom: 300px;"> <%= Ldto.getContent() %> </td>
				</tr>
				<%if(Ldto.getFilename() != null){ %>
					<tr>
						<td> 첨부파일 </td>
						<td colspan="4">
							<a href="/team03/team03File/<%= Ldto.getFilename() %>">
								<%= Ldto.getFilename() %>
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
							onclick="window.location='adminBoardDeletePro.jsp?Lnum=<%=Ldto.getNum()%>'" /> </td>
			
				</tr>
			</table>
		<%}
		
		if(Mnum != null){
		Mdto.setNum(Integer.parseInt(Mnum)); 

		MovieDAO Mdao = MovieDAO.getInstance();
		Mdto = Mdao.getContent(Mdto);
	%>
			<table id="center">
				<tr>
					<th colspan="4"> <a href="adminBoardDeleteForm.jsp"> 관리자 확인용 게시판 </a> </th>
				</tr>
				<tr>
					<td> 작성자 </td>
					<td> <%= Mdto.getWriter() %> </td>
					<td> 조회수 </td>
					<td> <%= Mdto.getReadcount() %> </td>
				</tr>
				<tr>
					<td> 제목 </td>
					<td colspan="4"> <%= Mdto.getSubject() %> </td>
				</tr>
				<tr>
					<td style="padding-bottom: 300px;"> 내용 </td>
					<td colspan="4" style="padding-bottom: 300px;"> <%= Mdto.getContent() %> </td>
				</tr>
				<%if(Mdto.getFilename() != null){ %>
					<tr>
						<td> 첨부파일 </td>
						<td colspan="4">
							<a href="/team03/team03File/<%= Mdto.getFilename() %>">
								<%= Mdto.getFilename() %>
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
							onclick="window.location='adminBoardDeletePro.jsp?Mnum=<%=Mdto.getNum()%>'" /> </td>
			
				</tr>
			</table>
		<%}%>
<%}%>