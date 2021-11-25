<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "team03.bean.MovieDAO" %>
<%@ page import = "team03.bean.MovieCommentDAO" %>
<%@ page import = "team03.bean.MovieCommentDTO" %>
<%@ page import = "team03.bean.GoodbadDAO" %>
<%@ page import = "team03.bean.GoodbadDTO" %>
<%@ page import = "java.util.Random"%>
<%@ page import = "java.util.List"%>
<%@ page import = "java.net.URLEncoder"%>

<jsp:useBean class = "team03.bean.MovieDTO" id = "dto" />
<jsp:setProperty property = "num" name = "dto" />
<jsp:useBean class = "team03.bean.GoodbadDTO" id = "dto2" />
<jsp:setProperty property = "num" name = "dto" />

<head>
	<meta charset="UTF-8">
	<link href="https://cdn.discordapp.com/attachments/902120345748774922/912167936536481842/My_Post_Copy_1.jpg" rel="shortcut icon" type="image/x-icon">
	<title>시네톡-영화게시판</title>
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
		window.open("commentUpdateForm.jsp?boardNum="+boardNum+"&num="+num+"&pageNum="+pageNum+"&re_step="+re_step+"&re_level="+re_level,
					"updateForm", "width=570, height=350, resizable = no, scrollbars = no");
}

	// 댓글 삭제 함수
	function deleteComment(boardNum, num, pageNum, re_step, re_level){
		window.name = "ParentForm";
		window.open("commentDeleteForm.jsp?boardNum="+boardNum+"&num="+num+"&pageNum="+pageNum+"&re_step="+re_step+"&re_level="+re_level,
				"deleteForm", "width=570, height=350, resizable = no, scrollbars = no");
}

	// 대댓글 함수
	function reComment(boardNum, num, re_step, re_level){
		window.name = "ParentForm";
		window.open("reCommentForm.jsp?boardNum="+boardNum+"&num="+num+"&re_step="+re_step+"&re_level="+re_level,
				"reCommentForm", "width=570, height=350, resizable = no, scrollbars = no");
	
}
	
	// 제목, 내용, 비밀번호 입력값이 없을 시 띄우는 경고창 (유효성 검사)
	function memNullCheck(){
		contentVal = document.getElementsByName("content")[0].value;
		
		if(contentVal == ""){
			alert("내용을 작성해주세요.");
			return false;
		}	
	}
	
	// 제목, 내용, 비밀번호 입력값이 없을 시 띄우는 경고창 (유효성 검사)
	function nullCheck(){
		contentVal = document.getElementsByName("content")[0].value;
		pwVal = document.getElementsByName("pw")[0].value;
		
		if(contentVal == ""){
			alert("내용을 작성해주세요.");
			return false;
		}
		if(pwVal == ""){
			alert("비밀번호를 입력해주세요.");
			return false;
		}
	}
	
</script>


<%
	request.setCharacterEncoding("UTF-8");

	String id = (String)session.getAttribute("id");
	String kid = (String)session.getAttribute("kid");
	
	if(kid != null) {
		// kid에 값이 존재할 때
		kid = "카카오" + kid;
	}

	String pageNum = request.getParameter("pageNum");
	
	if (pageNum == null) {
		pageNum = "1";
	}
	
	MovieDAO dao = MovieDAO.getInstance();
	dao.readCountUp(dto);
	
	dto = dao.getContent(dto);
%>

<table style="width: 50%;">
	<tr>
		<th colspan="4"> <a href="list.jsp"> 게시글 </a> </th>
	</tr>
	<tr>
		<td id="center" style="width: 15%"> 작성자 </td>
		<td> <%= dto.getWriter() %> </td>
		<td id="center" style="width: 15%"> 조회수 </td>
		<td> <%= dto.getReadcount() %> </td>
	</tr>
	<tr>
		<td id="center" style="width: 15%"> 카테고리 </td>
		<td colspan = "4"> <%=dto.getKategorie() %></td>
	</tr>
	<tr>
		<td id="center" style="width: 15%"> 제목 </td>
		<td colspan="4"> <%= dto.getSubject() %> </td>
	</tr>
	<tr>
		<td style="padding-bottom: 300px; width: 10%" id="center"> 내용 </td>
		<td colspan="4" style="padding-bottom: 300px; width: 85%;"> <%= dto.getContent() %> </td>
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
		<td style="width: 2%;"> <input type="button" value="공감"
				onclick="window.location='goodPro.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>&boardName=<%="freeBoard" %>'" /> </td>
		<td style="width: 48%;"> <%= dto.getGood() %> </td>
		<td style="width: 2%;"> <input type="button" value="비공감"
				onclick="window.location='badPro.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>&boardName=<%="freeBoard" %>'" /> </td>
		<td style="width: 48%;"> <%= dto.getBad() %> </td>
	</tr>
	
<%
	if(kid == null){
		// kid 에 정보가 없고
		if(id == null){
			// kid, id에 정보가 없을 경우 = 익명
			// 개시글 작성자가 익명일 때 표시되는 항목
			if(dto.getPw() != null){ 
				// dto에 있는 pw값이 있을 경우 => 익명
				%>
				<tr id="center">
					<td style="width: 5%;" colspan="2">
						<input type="button" value="글 수정"
							onclick="window.location='updateForm.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" />
						<input type="button" value="글 삭제"
							onclick="window.location='deleteForm.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" />
					</td>
					<td style="width: 90%;" colspan="2" >
						<input type="button" value="글 목록"
							onclick="window.location='list.jsp?pageNum=<%=pageNum%>'" />
					</td>
				</tr>
			<%}
			
		} else {
			// 게시글 작성자가 회원이고, 회원의 id세션이 작성자와 같을 때 표시되는 항목
			if(id.equals(dto.getWriter())){ %>
					<tr id="center">
						<td style="width: 5%;" colspan="2">
							<input type="button" value="글 수정"
								onclick="window.location='updateForm.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" />
							<input type="button" value="글 삭제"
								onclick="window.location='deleteForm.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" />
						</td>
						<td style="width: 90%;" colspan="2">
							<input type="button" value="글 목록"
								onclick="window.location='list.jsp?pageNum=<%=pageNum%>'" />
						</td>
					</tr>
			<%} else { 
			// 게시글 작성자가 회원이지만, 회원의 id세션이 작성자와 같이 않을 때 표시되는 항목 %>
				<tr id="center">
					<td colspan="4">
						<input type="button" value="글 목록"
							onclick="window.location='list.jsp?pageNum=<%=pageNum%>'" />
					</td>
				</tr>
			<%}
		}
	} else {
		// 게시글 작성자가 카카오 회원이고, 카카오 회원의 kid세션이 작성자와 같을 때 표시되는 항목
		if(kid.equals(dto.getWriter())){ %>
		<tr id="center">
			<td style="width: 5%;" colspan="2">
				<input type="button" value="글 수정"
					onclick="window.location='updateForm.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" />
				<input type="button" value="글 삭제"
					onclick="window.location='deleteForm.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>'" />
			</td>
			<td style="width: 90%;" colspan="2">
				<input type="button" value="글 목록"
					onclick="window.location='list.jsp?pageNum=<%=pageNum%>'" />
			</td>
		</tr>
	<%} else { 
	// 게시글 작성자가 카카오 회원이지만, 카카오 회원의 kid세션이 작성자와 같이 않을 때 표시되는 항목 %>
		<tr id="center">
			<td colspan="4">
				<input type="button" value="글 목록"
					onclick="window.location='list.jsp?pageNum=<%=pageNum%>'" />
			</td>
		</tr>
	
	<%}
}
	if (kid == null) {
		if (id == null) {
			if ( dto.getPw() == null) { 
				// 익명인데 pw가 없을 경우 => id, kid로 작성된 글일 경우
			%>
			
				<tr id="center">
				<td style="width: 90%;" colspan="4">
					<input type="button" value="글 목록"
						onclick="window.location='list.jsp?pageNum=<%=pageNum%>'" />
				</td>
			</tr>
			<%}
			}
		}%>

		

</table>

<br/>
<%-- 댓글 작성 --%>
<%	
	// 댓글 작성자 writer 변수 선언
	String writer;


	// kid 가 null 일 때
	if (kid == null) {
		// id 가 null 일 때
		if (id == null) {
			Random r = new Random();
			writer = "익명" + r.nextInt(10000);
		} else {
			// id 가 null 이 아닐 떄
			// writer 에 id 대입
			writer = id;
		}
	} else {
		// kid 가 null 이 아닐 때
		// writer 에 kid 대입
		writer = kid;
	}
	
	// 페이징 처리
	int pageSize = 10;
	
	String CMpageNum = request.getParameter("CMpageNum");
	
	if(CMpageNum == null){
		CMpageNum = "1";
	}
	
	int currentPage = Integer.parseInt(CMpageNum);
	int start = (currentPage - 1) * pageSize + 1; // 결과 = 11
	int end = currentPage * pageSize; // 결과 = 20
	int count = 0;
	
	String num = request.getParameter("num");

	
	List<MovieCommentDTO> list = null;
	MovieCommentDAO MCdao = MovieCommentDAO.getInstance();
	
	count = MCdao.countComment(Integer.parseInt(num));
	if (count > 0) {
		list = MCdao.getAllComment(Integer.parseInt(num), start, end);
	}
%>

<%
	if(kid == null && id == null){%>
		<%-- 게시글에서 댓글을 작성할 수 있는 폼을 작성하고 값(피아미터)를 넘김 --%>
		<form action = "commentPro.jsp" method = "post" onsubmit="return nullCheck();">
			<table style="width: 50%;">
				<tr>
					<th colspan = "5">
						댓글 작성
						<input type = "hidden" name = "num" value = "<%=num %>" />
						<input type = "hidden" name = "pageNum" value = "<%=pageNum %>"/>
					</th>
				</tr>
				<tr>
					<td> 작성자 </td>
					<td colspan = "3" >
						<%= writer%>
						<input type = "hidden" name = "writer" value = "<%=writer %>" />
					</td>
				</tr>
				<tr>
					<td> 비밀번호 </td>
					<td colspan = "3" >
					<input type = "password" name = "pw" /> 
					</td>
				</tr>
				<tr>
					<td colspan = "5" >
						<textarea style="width: 100%;" name="content" placeholder="내용을 작성해주세요!"></textarea>
					<br/><br/>
						<div id="center">
							<input type = "submit" value = "댓글작성" />
						</div>
					</td>
				</tr>
			</table>
		</form>
<%	}else{%>
		<form action = "commentPro.jsp" method = "post" onsubmit="return memNullCheck();">
			<table style="width: 50%;">
				<tr>
					<th colspan = "5">
						댓글 작성
						<input type = "hidden" name = "num" value = "<%=num %>" />
						<input type = "hidden" name = "pageNum" value = "<%=pageNum %>"/>
					</th>
				</tr>
				<tr>
					<td> 작성자 </td>
					<td colspan = "3" >
						<%= writer%>
						<input type = "hidden" name = "writer" value = "<%=writer %>" />
					</td>
				</tr>
				<tr>
					<td colspan = "5" >
						<textarea style="width: 100%;" name="content" placeholder="내용을 작성해주세요!"></textarea>
					<br/><br/>
						<div id="center">
							<input type = "submit" value = "댓글작성" />
						</div>
					</td>
				</tr>
			</table>
		</form>
<%	}
%>


<br/>

<table style="text-align: left; width: 50%;">
	<tr>
		<% if ( count == 0) { %>
			<td colspan = "3" > 댓글이 없습니다. </td>
	</tr>
		<% } else { %>
	<tr>
		<th colspan = "3"> 댓글 </th>
	</tr>
	<tr>
		<% for (MovieCommentDTO MCdto : list) { %>
				<td style="font-size: 13;">
					<div>
							<% if(MCdto.getRe_level() > 0){ 
								for(int i=0; i<MCdto.getRe_level(); i++) { %>
								&nbsp;&nbsp;&nbsp;&nbsp;
								<% } %>
								<img src="images/re.gif">
							<% }
								if(MCdto.getWriter().contains("익")) { %>
								<%=MCdto.getWriter()%>
							<% } else { %>
									<a href="/team03/visitor/visitorForm.jsp?owner=<%=URLEncoder.encode(MCdto.getWriter(), "UTF-8")%>">
										<%=MCdto.getWriter()%>
									</a>
								<% } %>
					</div>
				</td>
				<td style="width: 70%;">
					<div>
						<%= MCdto.getContent()%>
					</div>
				</td>
					<td style="font-size: 13; width: 10%; height: 80;" id="center">
						<div>
							<%if(kid != null){
								if(kid.equals(MCdto.getWriter())){ %>
									<p><a href="#" onclick="updateComment(<%=MCdto.getBoardNum()%>, <%=MCdto.getNum()%>, <%=pageNum%>, <%=MCdto.getRe_step()%>, <%=MCdto.getRe_level()%>)">[수정]</a></p>
									<p><a href="#" onclick="deleteComment(<%=MCdto.getBoardNum()%>, <%=MCdto.getNum()%>, <%=pageNum%>, <%=MCdto.getRe_step()%>, <%=MCdto.getRe_level()%>)">[삭제]</a></p>
							<%	}
							} %>
									
							<%if(id != null){
								if(id.equals(MCdto.getWriter())){ %>	
									<p><a href="#" onclick="updateComment(<%=MCdto.getBoardNum()%>, <%=MCdto.getNum()%>, <%=pageNum%>, <%=MCdto.getRe_step()%>, <%=MCdto.getRe_level()%>)">[수정]</a></p>
									<p><a href="#" onclick="deleteComment(<%=MCdto.getBoardNum()%>, <%=MCdto.getNum()%>, <%=pageNum%>, <%=MCdto.getRe_step()%>, <%=MCdto.getRe_level()%>)">[삭제]</a>	</p>						
							<%	}
							} %>
									
							<%if(MCdto.getPw() != null){ %>		
								<p><a href="#" onclick="updateComment(<%=MCdto.getBoardNum()%>, <%=MCdto.getNum()%>, <%=pageNum%>, <%=MCdto.getRe_step()%>, <%=MCdto.getRe_level()%>)">[수정]</a></p>
								<p><a href="#" onclick="deleteComment(<%=MCdto.getBoardNum()%>, <%=MCdto.getNum()%>, <%=pageNum%>, <%=MCdto.getRe_step()%>, <%=MCdto.getRe_level()%>)">[삭제]</a>	</p>						
							<% } %>
								<p><a href="#" onclick="reComment(<%=MCdto.getBoardNum()%>, <%=MCdto.getNum()%>, <%=MCdto.getRe_step()%>, <%=MCdto.getRe_level()%>)">
									[답글]
								</a></p>
					</div>
				</td>
		</tr>
		<% } 
		}%>
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
			<a href="content.jsp?num=<%=num%>&pageNum=<%=pageNum%>&CMpageNum=<%=startPage-10%>">[이전]</a>
		<%}
		for(int i = startPage ; i <= endPage ; i++){
		%>	<a href="content.jsp?num=<%=num%>&pageNum=<%=pageNum%>&CMpageNum=<%=i%>">[<%=i%>]</a> 	
	  <%}
		if(endPage < pageCount){%>
		<a href="content.jsp?num=<%=num%>&pageNum=<%=pageNum%>&CMpageNum=<%=startPage + 10%>">[다음]</a>
	  <%}
	}
%>
</div>
	