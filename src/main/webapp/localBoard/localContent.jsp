<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.net.URLEncoder"%>
<%@ page import="team03.bean.LocalBoardDAO" %>
<%@ page import="team03.bean.LocalBoardCommentDAO" %>
<%@ page import="team03.bean.LocalBoardCommentDTO" %>
<%@page import="java.util.List" %>

<jsp:useBean class="team03.bean.LocalBoardDTO" id="dto" />
<jsp:setProperty property="num" name="dto" />

<head>
<link href="https://cdn.discordapp.com/attachments/902120345748774922/912167936536481842/My_Post_Copy_1.jpg" rel="shortcut icon" type="image/x-icon">
<title>지역게시판 게시물</title>
</head>

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


<script type="text/javascript">
	
	//댓글 수정 함수
	function updateComment(boardNum, num, pageNum, re_step, re_level){
		window.name = "ParentForm";
		window.open("localcommentupdateForm.jsp?boardNum="+boardNum+"&num="+num+"&pageNum="+pageNum+"&re_step="+re_step+"&re_level="+re_level,
					"updateForm", "width=570, height=350, resizable = no, scrollbars = no");
	}
	
	// 댓글 삭제 함수
	function deleteComment(boardNum, num, pageNum, re_step, re_level){
		window.name = "ParentForm";
		window.open("localcommentdeleteForm.jsp?boardNum="+boardNum+"&num="+num+"&pageNum="+pageNum+"&re_step="+re_step+"&re_level="+re_level,
					"deleteForm", "width=570, height=350, resizable = no, scrollbars = no");
	}
	
	// 답글 함수
	function reComment(boardNum, num, re_step, re_level){
		window.name = "ParentForm";
		window.open("localrecommentForm.jsp?boardNum="+boardNum+"&num="+num+"&re_step="+re_step+"&re_level="+re_level,
					"reCommentForm", "width=570, height=350, resizable = no, scrollbars = no");
		
	}
	
</script>


<%
	String id = (String)session.getAttribute("id");
	String kid = (String)session.getAttribute("kid");
	
	if(kid != null){
		kid = "카카오" + kid;
	}
	

	String pageNum = request.getParameter("pageNum");
	
	LocalBoardDAO dao = LocalBoardDAO.getInstance();
	dao.LreadcountUp(dto);
	
	dto = dao.LgetContent(dto);
	
	 %>


<table style="width: 50%;">
	<tr>
		<th colspan="4"> <a href="localList.jsp"> 게시글 </a> </th>
	</tr>
	<tr>
	<td id="center">지역</td><td colspan="3"><%=dto.getLocal() %></td>
	</tr>
	<tr>
		<td id="center"> 작성자 </td>
		<td> <%= dto.getWriter() %> </td>
		<td id="center"> 조회수 </td>
		<td> <%= dto.getReadcount() %> </td>
	</tr>
	<tr>
		<td id="center"> 제목 </td>
		<td colspan="4"> <%= dto.getSubject() %> </td>
	</tr>
	<tr>
		<td style="padding-bottom: 300px;" id="center"> 내용 </td>
		<td colspan="4" style="padding-bottom: 300px; width: 90%;"> <%= dto.getContent() %> </td>
	</tr>
	<%if(dto.getFilename() != null){ %>
		<tr>
			<td> 첨부파일 </td>
			<td colspan="4">
				<a href="/team03/team03File/<%= dto.getFilename() %>">
					<%= dto.getFilename() %> </a>
			</td>
		</tr>
<%	} %>
	<tr>
		<td style="width: 2%;"> <input type="button" value="공감"
				onclick="window.location='goodPro.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>&boardName=<%="localBoard"%>'" /> </td>
		<td style="width: 48%;"> <%= dto.getGood() %> </td>
		<td style="width: 2%;"> <input type="button" value="비공감"
				onclick="window.location='badPro.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>&boardName=<%="localBoard"%>'" /> </td>
		<td style="width: 48%;"> <%= dto.getBad() %> </td>
	</tr>
	<tr>
		<%
		if(kid == null){
			if(id != null){
				if(id.equals(dto.getWriter())){ %>
				<tr id="center">
					<td style="width: 5%;" colspan="2">
						<input type="button" value="글 수정"
							onclick="window.location='localupdateForm.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" />
						<input type="button" value="글 삭제"
							onclick="window.location='localdeleteForm.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" />
					</td>
					<td colspan="4" id="center">
						<input type="button" value="글 목록"
							onclick="window.location='localList.jsp?pageNum=<%=pageNum%>'" />
					</td>
				</tr>
				<%}else{%>
					<tr>
						<td colspan="4" id="center">
							<input type="button" value="글 목록"
								onclick="window.location='localList.jsp?pageNum=<%=pageNum%>'" />
						</td>
					</tr>
				<%}
			}
			
		}else{
			if(kid.equals(dto.getWriter())){ %>
			<tr id="center">
				<td style="width: 5%;" colspan="2">
					<input type="button" value="글 수정"
						onclick="window.location='localupdateForm.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" />
					<input type="button" value="글 삭제"
						onclick="window.location='localdeleteForm.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" />
				</td>
				<td colspan="4" id="center">
					<input type="button" value="글 목록"
						onclick="window.location='localList.jsp?pageNum=<%=pageNum%>'" />
				</td>
			</tr>
		<%	} else {%>
				<tr>
					<td colspan="4" id="center">
						<input type="button" value="글 목록"
							onclick="window.location='localList.jsp?pageNum=<%=pageNum%>'" />
					</td>
				</tr>
			<%}
		}%>
</table>

<br/>

<%-- 댓글 작성 --%>
<%
	// 댓글 작성자 writer 변수 선언
	String writer = "사용자";
	
	if(kid != null){
		writer = kid;
	}
	if(id != null){
		writer = id;
	}

	
	// 페이징 처리
	int pageSize = 20;
	
	String CMpageNum = request.getParameter("CMpageNum");
	
	if(CMpageNum == null){
		CMpageNum = "1";
	}
	
	int currentPage = Integer.parseInt(CMpageNum);
	int start = (currentPage - 1) * pageSize + 1; // 결과 = 11
	int end = currentPage * pageSize; // 결과 = 20
	int count = 0;
 	
	String num = request.getParameter("num");
	
	List<LocalBoardCommentDTO> list = null;
	LocalBoardCommentDAO Cdao = LocalBoardCommentDAO.getInstance();
	
	count = Cdao.LcountComment(Integer.parseInt(num));
	if (count > 0){
		list = Cdao.LgetAllComment(Integer.parseInt(num), start, end);
	}
	
%>
<%-- 컨텐츠 페이지 내에 폼태그를 작성하여 컨텐츠 페이지 내에서 댓글을 작성하고 파라미터를 넘김 --%>

<script>
   function check(){
	  contentv = document.getElementsByName("content")[0].value;
	   if(contentv == ""){
		   alert("내용을 입력하세요");
		   return false;
	   }
   }
   </script>

<form action="localcommentPro.jsp" method="post" onsubmit = "return check();">
	<table style="width: 50%;">
		<tr>
			<th colspan="2">
				댓글 작성
				<input type="hidden" name="num" value="<%=num%>" />
				<input type="hidden" name="pageNum" value="<%=pageNum%>" />
			</th>
		</tr>
		<tr>
			<td> 작성자 </td>
			<td style="width: 80%;">
				<%= writer %>
				<input type="hidden" name="writer" value="<%=writer%>" />
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<textarea style="width: 100%;" name="content" placeholder="내용을 작성해주세요!"></textarea>
			<br/><br/>
				<div id="center">
					<input type = "submit" value = "댓글작성" />
				</div>
			</td>
		</tr>
	</table>
</form>

<br/>

<table style="text-align: left; width: 50%;">
	<tr>
		<% if(count == 0){ %>
			<td colspan="3">댓글이 없습니다.</td>
	</tr>
		<% } else { %>
	<tr>
		<%	for(LocalBoardCommentDTO Cdto : list){ %>
				<tr>
					<td style="font-size: 13;">
						<div>
						<%
							if(Cdto.getRe_level() > 0){ 
								for(int i = 0; i < Cdto.getRe_level(); i++){%>
									&nbsp;&nbsp;&nbsp;&nbsp;
								<%}%>
							<img src="images/re.gif">
						<%	}%>
							<a href="/team03/visitor/visitorForm.jsp?owner=<%=URLEncoder.encode(Cdto.getWriter(), "UTF-8")%>">
							<%=Cdto.getWriter()%>
							</a>
						
						</div>
					</td>	
					<td style="width: 70%;">
						<div>
							<%= Cdto.getContent() %>
						</div>
					</td>
					<td style="font-size: 13; width: 10%; height: 80;" id="center">
						<div>
							<%if(kid != null){
								if(kid.equals(Cdto.getWriter())){ %>
									<p><a href="#" onclick="updateComment(<%=Cdto.getBoardNum()%>, <%=Cdto.getNum()%>, <%=pageNum%>, <%=Cdto.getRe_step()%>, <%=Cdto.getRe_level()%>)">[수정]</a></p>
									<p><a href="#" onclick="deleteComment(<%=Cdto.getBoardNum()%>, <%=Cdto.getNum()%>, <%=pageNum%>, <%=Cdto.getRe_step()%>, <%=Cdto.getRe_level()%>)">[삭제]</a></p>
							<%	}
							} %>
									
							<%if(id != null){
								if(id.equals(Cdto.getWriter())){ %>	
									<p><a href="#" onclick="updateComment(<%=Cdto.getBoardNum()%>, <%=Cdto.getNum()%>, <%=pageNum%>, <%=Cdto.getRe_step()%>, <%=Cdto.getRe_level()%>)">[수정]</a></p>
									<p><a href="#" onclick="deleteComment(<%=Cdto.getBoardNum()%>, <%=Cdto.getNum()%>, <%=pageNum%>, <%=Cdto.getRe_step()%>, <%=Cdto.getRe_level()%>)">[삭제]</a>	</p>						
							<%	}
							} %>
									
								<p><a href="#" onclick="reComment(<%=Cdto.getBoardNum()%>, <%=Cdto.getNum()%>, <%=Cdto.getRe_step()%>, <%=Cdto.getRe_level()%>)">
									[답글]
								</a></p>
					</div>
				</td>
			</tr>
		<%	} 
		}  %>
</table>

<div id="center">
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
			<a href="localContent.jsp?num=<%=num%>&pageNum=<%=pageNum%>&CMpageNum=<%=startPage-10%>">[이전]</a>
		<%}
		for(int i = startPage ; i <= endPage ; i++){
		%>	<a href="localContent.jsp?num=<%=num%>&pageNum=<%=pageNum%>&CMpageNum=<%=i%>">[<%=i%>]</a> 	
	  <%}
		if(endPage < pageCount){%>
		<a href="localContent.jsp?num=<%=num%>&pageNum=<%=pageNum%>&CMpageNum=<%=startPage + 10%>">[다음]</a>
	  <%}	
	}
%>
</div>