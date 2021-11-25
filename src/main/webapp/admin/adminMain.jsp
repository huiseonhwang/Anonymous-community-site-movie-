<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ page import="team03.bean.BoardDAO" %>
<%@ page import="team03.bean.BoardDTO" %>
<%@ page import="team03.bean.LocalBoardDAO" %>
<%@ page import="team03.bean.LocalBoardDTO" %>
<%@ page import="team03.bean.MovieDAO" %>
<%@ page import="team03.bean.MovieDTO" %>
<%@ page import="team03.bean.AdminDAO" %>
<%@ page import="team03.bean.AdminDTO" %>


<html>

<style>
	#parent{
		margin: 5px auto;
		width: 95%;
	}

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
	<meta charset="UTF-8">
	<title>관리자 페이지에 오신 것을 환영합니다.</title>
	<link href="https://cdn.discordapp.com/attachments/902120345748774922/912167936536481842/My_Post_Copy_1.jpg" rel="shortcut icon" type="image/x-icon">
</head>

<% //관리자 세션이 아니면 접근할 수 없게 함
String admin = (String)session.getAttribute("admin");
if(admin == null){ 
%>	<script>
		alert("잘못된 접근입니다.");
		window.location="/team03/main.jsp";
	</script>
<%	}else{ %>
	
<div style="psition: absolute; clear: left; text-align: center;">
	<input type="button" name="adminBoardDelete" value="자유게시판 보기" onclick="window.location='/team03/admin/adminFBoardDeleteForm.jsp'" />
	<input type="button" name="adminBoardDelete" value="지역게시판 보기" onclick="window.location='/team03/admin/adminLBoardDeleteForm.jsp'" />
	<input type="button" name="adminBoardDelete" value="영화게시판 보기" onclick="window.location='/team03/admin/adminMBoardDeleteForm.jsp'" />
	<input type="button" name="adminMemDelete" value="회원 탈퇴" onclick="window.location='/team03/admin/adminMemDeleteForm.jsp'" />
	<input type="button" name="adminVisitorDelete" value="방명록 삭제" onclick="window.location='/team03/admin/adminVisitorDeleteForm.jsp'" />
	<input type="button" name="adminCommentDelete" value="댓글 삭제" onclick="window.location='/team03/admin/adminCommentDeleteForm.jsp'" />
	<input type="button" value="Q&A 답변하기"    onclick="window.location='/team03/QnA/q&a_List.jsp'"/> 
	<input type="button" name="adminBoardDelete" value="메인으로" onclick="window.location='/team03/main.jsp'" />
</div>
	
<%	SimpleDateFormat sdf = 
	        new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	int pageNum = 1;
	int pageSize = 10;
	int currentPage = pageNum;
	int start = (currentPage - 1) * pageSize + 1;
	int end = currentPage * pageSize;
	int number = 0;
	int Fcount = 0;
	
	// AdminDAO가 아닌 BoardDAO에서 바로 정보를 가져옴
	BoardDAO Bdao = BoardDAO.getInstance();
	List<BoardDTO> Flist = null; //리스트 선언
	
	Fcount = Bdao.getCount(); //자유게시판의 게시글 수를 세옴
	if(Fcount > 0){
		Flist = Bdao.getAllList(start, end); //자유게시판의 모든 글을 불러옴
	}
	
%>

<body>
<div id = "parent">
	<table style="float: left; width: 30%;">
		<tr>
			<th colspan="5"> 자유게시판 최신글 </th>
		</tr>
		<tr>
			<th> 작성자 </th>
			<th> 제목 </th>
			<th> 작성일 </th>
			<th> 삭제여부 </th>
		</tr>
		<%	if(Fcount == 0){ %> <!-- 게시글 수가 없을 때 -->
				<tr>
					<td colspan="5">작성된 글이 없습니다...</td>
				</tr>
		<%	}else{ %>
		
			<%	for(BoardDTO dto : Flist) { %>
					<tr>
						<td> 
							<% if(!dto.getWriter().contains("익")){ %>
								<a href="/team03/visitor/visitorForm.jsp?owner=<%=URLEncoder.encode(dto.getWriter(), "UTF-8")%>">
										<%= dto.getWriter() %>
								</a>
								
								
							<%} else { %>
								<%= dto.getWriter() %>
							<%}%>
						</td>
						<td>
							<a href="/team03/freeBoard/content.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>">
								<%= dto.getSubject() %>
							</a>
						</td>
						<td> <%= sdf.format(dto.getReg()) %> </td>
						<td> <input type="button" value="게시글 삭제" onclick="window.location='adminDeleteContentConfirm.jsp?num=<%=dto.getNum()%>'"/></td>
		
					</tr>
			<%	} %>
		<%	} %>
	</table>
<%
	int Lnumber = 0;
	int Lcount = 0;
	
	// AdminDAO가 아닌 LocalBoardDAO에서 바로 정보를 가져옴
	LocalBoardDAO Ldao = LocalBoardDAO.getInstance();
	List<LocalBoardDTO> Llist = null;
	
	Lcount = Ldao.LgetCount();
	if(Lcount > 0){
		Llist = Ldao.LgetAllList(start, end);
	}
	

%>
	<table style="float: left; width: 30%; margin-left: 3%; margin-right: 3%;">
		<tr>
			<th colspan="6"> 지역게시판 최신글 </th>
		</tr>
			<tr>
				<th> 작성자 </th>
				<th> 제목 </th>
				<th> 작성일 </th>
				<th> 삭제여부 </th>
			</tr>
		<%	if(Lcount == 0){ %>
				<tr>
					<td colspan="7">작성된 글이 없습니다...</td>
				</tr>
		<%	}else{ %>
		
			<%	for(LocalBoardDTO dto : Llist) { %>
					<tr>
						<td> 
							<a href="/team03/visitor/visitorForm.jsp?writer=<%=dto.getWriter()%>">
										<%= dto.getWriter() %>
								</a>
						</td>
						<td>
							<a href="/team03/localBoard/localContent.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>">
								<%= dto.getSubject() %>
							</a>
						</td>
						<td> <%= sdf.format(dto.getReg()) %> </td>
						<td> <input type="button" value="게시글 삭제" onclick="window.location='adminDeleteContentConfirm.jsp?Lnum=<%=dto.getNum()%>'"/></td>
					</tr>
			<%	} %>
		<%	} %>
	</table>

<%
	int Mcount = 0;
	
	// AdminDAO가 아닌 LocalBoardDAO에서 바로 정보를 가져옴
	MovieDAO Mdao = MovieDAO.getInstance();
	List<MovieDTO> Mlist = null;
	
	Mcount = Mdao.getCount();
	if(Lcount > 0){
		Mlist = Mdao.getAllList(start, end);
	}
	
%>
	
	<table style="float: left; width: 30%;">
		<tr>
			<th colspan="5"> 영화게시판 최신글 </th>
		</tr>
		<tr>
			<th> 작성자 </th>
			<th> 제목 </th>
			<th> 작성일 </th>
			<th> 삭제여부 </th>
		</tr>
		<%	if(Mcount == 0){ %>
				<tr>
					<td colspan="5">작성된 글이 없습니다...</td>
				</tr>
		<%	}else{ %>
		
			<%	for(MovieDTO dto : Mlist) { %>
					<tr>
						<td> 
							<% if(!dto.getWriter().contains("익")){ %>
								<a href="/team03/visitor/visitorForm.jsp?owner=<%=URLEncoder.encode(dto.getWriter(), "UTF-8")%>">
										<%= dto.getWriter() %>
								</a>
								
								
							<%} else { %>
								<%= dto.getWriter() %>
							<%}%>
						</td>
						<td>
							<a href="/team03/movieBoard/content.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>">
								<%= dto.getSubject() %>
							</a>
						</td>
						<td> <%= sdf.format(dto.getReg()) %> </td>
						<td> <input type="button" value="게시글 삭제" onclick="window.location='adminDeleteContentConfirm.jsp?Mnum=<%=dto.getNum()%>'"/></td>
		
					</tr>
			<%	} %>
		<%	} %>
	</table>
</div>

</body>



<%}%>

</html>

