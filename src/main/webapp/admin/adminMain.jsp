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
</head>

<%
String admin = (String)session.getAttribute("admin");
if(admin == null){ 
%>	<script>
		alert("잘못된 접근입니다.");
		window.location="/team03/main.jsp";
	</script>
<%	}else{ 
	
	int FpageNum = 1;
	int FpageSize = 10;
	int FcurrentPage = FpageNum;
	int Fstart = (FcurrentPage - 1) * FpageSize + 1;
	int Fend = FcurrentPage * FpageSize;
	int Fnumber = 0;
	int Fcount = 0;
	
	// AdminDAO가 아닌 BoardDAO에서 바로 정보를 가져옴
	BoardDAO Bdao = BoardDAO.getInstance();
	List<BoardDTO> Flist = null;
	
	Fcount = Bdao.getCount();
	if(Fcount > 0){
		Flist = Bdao.getAllList(Fstart, Fend);
	}
	
	Fnumber = Fcount - (FcurrentPage-1)*FpageSize;
	
%>

<body>
<div id = "parent">
	<table style="float: left; width: 30%;">
		<tr>
			<th colspan="5"> 자유게시판 최신글 </th>
		</tr>
		<tr>
			<th> 글 번호 </th>
			<th> 제목 </th>
			<th> 작성자 </th>
			<th> 작성일 </th>
			<th> 삭제여부 </th>
		</tr>
		<%	if(Fcount == 0){ %>
				<tr>
					<td colspan="5">작성된 글이 없습니다...</td>
				</tr>
		<%	}else{ %>
		
			<%	for(BoardDTO dto : Flist) { %>
					<tr>
						<td>
							<%= Fnumber-- %>
							<input type="hidden" name="num" value="<%=dto.getNum() %>" />
						</td>
						<td>
							<a href="/team03/freeBoard/content.jsp?num=<%=dto.getNum()%>&pageNum=<%=FpageNum%>">
								<%= dto.getSubject() %>
							</a>
						</td>
						<td> 
							<% if(!dto.getWriter().contains("익")){ %>
								<a href="/team03/visitor/visitorForm.jsp?owner=<%=URLEncoder.encode(dto.getWriter(), "UTF-8")%>">
										<%= dto.getWriter() %>
								</a>
								
								
							<%} else { %>
								<%= dto.getWriter() %>
							<%}%>
						</td>
						<td> <%= dto.getReg() %> </td>
						<td> <input type="button" value="게시글 삭제" onclick="window.location='adminDeleteContentConfirm.jsp?num=<%=dto.getNum()%>&pageNum=<%=FpageNum%>'"/></td>
		
					</tr>
			<%	} %>
		<%	} %>
	</table>
<%
	int LpageNum = 1;
	int LpageSize = 10;
	int LcurrentPage = LpageNum;
	int Lstart = (LcurrentPage - 1) * LpageSize + 1;
	int Lend = LcurrentPage * LpageSize;
	int Lnumber = 0;
	int Lcount = 0;
	
	// AdminDAO가 아닌 LocalBoardDAO에서 바로 정보를 가져옴
	LocalBoardDAO Ldao = LocalBoardDAO.getInstance();
	List<LocalBoardDTO> Llist = null;
	
	Lcount = Ldao.LgetCount();
	if(Lcount > 0){
		Llist = Ldao.LgetAllList(Lstart, Lend);
	}
	
	Lnumber = Lcount - (LcurrentPage-1)*LpageSize;

%>
	<table style="float: left; width: 30%; margin-left: 3%; margin-right: 3%;">
		<tr>
			<th colspan="6"> 지역게시판 최신글 </th>
		</tr>
			<tr>
				<th> 글 번호 </th>
				<th> 지역 </th>
				<th> 제목 </th>
				<th> 작성자 </th>
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
						<td> <%= dto.getNum() %> </td>
						<td><%= dto.getLocal() %></td>
						<td>
							<a href="/team03/localBoard/localContent.jsp?num=<%=dto.getNum()%>&pageNum=<%=LpageNum%>">
								<%= dto.getSubject() %>
							</a>
						</td>
						<td> 
							<a href="/team03/visitor/visitorForm.jsp?writer=<%=dto.getWriter()%>">
										<%= dto.getWriter() %>
								</a>
						</td>
						<td> <%= dto.getReg() %> </td>
						<td> <input type="button" value="게시글 삭제" onclick="window.location='adminDeleteContentConfirm.jsp?num=<%=dto.getNum()%>&pageNum=<%=LpageNum%>'"/></td>
					</tr>
			<%	} %>
		<%	} %>
	</table>

<%
	int MpageNum = 1;
	int MpageSize = 10;
	int McurrentPage = MpageNum;
	int Mstart = (McurrentPage - 1) * MpageSize + 1;
	int Mend = McurrentPage * MpageSize;
	int Mnumber = 0;
	int Mcount = 0;
	
	// AdminDAO가 아닌 LocalBoardDAO에서 바로 정보를 가져옴
	MovieDAO Mdao = MovieDAO.getInstance();
	List<MovieDTO> Mlist = null;
	
	Mcount = Mdao.getCount();
	if(Lcount > 0){
		Mlist = Mdao.getAllList(Mstart, Mend);
	}
	
	Mnumber = Mcount - (McurrentPage-1)*MpageSize;
%>
	
	<table style="float: left; width: 30%;">
		<tr>
			<th colspan="5"> 영화게시판 최신글 </th>
		</tr>
		<tr>
			<th> 글 번호 </th>
			<th> 제목 </th>
			<th> 작성자 </th>
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
							<%= Mnumber-- %>
							<input type="hidden" name="num" value="<%=dto.getNum() %>" />
						</td>
						<td>
							<a href="/team03/movieBoard/content.jsp?num=<%=dto.getNum()%>&pageNum=<%=MpageNum%>">
								<%= dto.getSubject() %>
							</a>
						</td>
						<td> 
							<% if(!dto.getWriter().contains("익")){ %>
								<a href="/team03/visitor/visitorForm.jsp?owner=<%=URLEncoder.encode(dto.getWriter(), "UTF-8")%>">
										<%= dto.getWriter() %>
								</a>
								
								
							<%} else { %>
								<%= dto.getWriter() %>
							<%}%>
						</td>
						<td> <%= dto.getReg() %> </td>
						<td> <input type="button" value="게시글 삭제" onclick="window.location='adminDeleteContentConfirm.jsp?num=<%=dto.getNum()%>&pageNum=<%=MpageNum%>'"/></td>
		
					</tr>
			<%	} %>
		<%	} %>
	</table>
</div>

<div style="psition: absolute; clear: left; bottom: 0px; text-align: center; padding-top: 10px;">
	<input type="button" name="adminBoardDelete" value="게시글 삭제" onclick="window.location='/team03/admin/adminBoardDeleteForm.jsp'" />
	<input type="button" name="adminMemDelete" value="회원 탈퇴" onclick="window.location='/team03/admin/adminMemDeleteForm.jsp'" />
	<input type="button" name="adminVisitorDelete" value="방명록 삭제" onclick="window.location='/team03/admin/adminVisitorDeleteForm.jsp'" />
	<input type="button" name="adminCommentDelete" value="댓글 삭제" onclick="window.location='/team03/admin/adminCommentDeleteForm.jsp'" />
	
</div>

</body>



<%}%>

</html>

