<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="team03.bean.MemberDAO"%>

<html>
<head>
<title>실시간 박스오피스 & 영화검색</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/movie.css">
<script>
	// $. 제이쿼리에서 유틸리티 함수(); 선택된 html 요소를 제이쿼리에서 이용할 수 있는 형태로
	// 	  생성해 주는 역할을 한다.
	// val 함수는 태그의 값을 추가할 수 있다.
	// append() 메서드는 선택된 html 요소의 끝 부분에 컨텐츠를 삽입.
	// ajax(비동기식 자바스크립트와 xml) : 비동기적으로 서버에 요청을 하여 페이지 전환 없이도
	// 예상 검색어와 결과를 보여준다.
	
	//crossDomain 해결코드
	// crossDomain : 서로 다른 도메인의 request client 와 response server 서버 간의 ajax 통신 할 때
	// (또는 client 쪽의 웹서버 설정 자체가 없는 경우) crossdomain 이슈로 인한 클라이언트 쪽의 오류 방지.
	$.ajaxPrefilter('json', function(options, orig, jqXHR) {
	return 'jsonp';
	}); $.ajax({
		url: "domain",
		crossDomain: true,
		dataType: "json",
		method: "GET",
		data: {},
		headers: {},
		success: function(result, textStatus, jqXHR ) {} 
	});

	//조회할 날짜를 계산
	var dt = new Date();
	//0(1월)부터 시작하기때문에 1더해주기
	var m = dt.getMonth() + 1;
	if (m < 10) { 
		var month = "0" + m;
	} else { 
		var month = m + ""; }
	//당일 박스오피스는 안나오기때문에 전날 박스오피를 가져오기위해 -1해줌
	var d = dt.getDate() - 1;
	if (d < 10) { 
		var day = "0" + d;
	} else { 
		var day = d + ""; }
	var y = dt.getFullYear();
	var year = y + "";
	var result = year + month + day;
	
	//천단위마다 콤마찍어주는 함수
	function addComma(num) {
		// 문자열 길이가 3과 같거나 작은 경우 입력 값을 그대로 리턴
		if (num.length <= 3) {
			return num;
		}
		// 3단어씩 자를 반복 횟수 구하기
		var count = Math.floor((num.length - 1) / 3);
		// 결과 값을 저정할 변수
		var result = "";
		// 문자 뒤쪽에서 3개를 자르며 콤마(,) 추가
		for (var i = 0; i < count; i++) {
			// 마지막 문자(length)위치 - 3 을 하여 마지막인덱스부터 세번째 문자열 인덱스값 구하기
			var length = num.length;
			var strCut = num.substr(length - 3, length);
			// 반복문을 통해 value 값은 뒤에서 부터 세자리씩 값이 리턴됨.
			// 입력값 뒷쪽에서 3개의 문자열을 잘라낸 나머지 값으로 입력값 갱신
			num = num.slice(0, length - 3);
			// 콤마(,) + 신규로 자른 문자열 + 기존 결과 값
			result = "," + strCut + result;
		}
		// 마지막으로 루프를 돌고 남아 있을 입력값(value)을 최종 결과 앞에 추가
		result = num + result;
		// 최종값 리턴
		return result;
	}
	//박스오피스 로딩하는 함수시작
	// xml 방식 : 태그 구조의 형식으로 데이터를 표현
	$(function() {
		$.ajax({
					//&itemPerPage: 1-10위 까지의 데이터가 출력되도록 설정
					url : "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.xml?key=585d102f4dcc0706f1ac945fdb84ae85&targetDt="
							+ result + "&itemPerPage=10",
					dataType : "xml",
					success : function(data) {
						var $data = $(data).find("boxOfficeResult>dailyBoxOfficeList>dailyBoxOffice");
						//데이터를 테이블 구조에 저장.
						if ($data.length > 0) {
							var table = $("<table/>").attr("class", "table");
							//<table>안에 테이블의 컬럼 타이틀 부분인 thead 태그
							var thead = $("<thead/>").append($("<tr/>"))
									.append(
											//추출하고자 하는 컬럼들의 타이틀 정의
											$("<th width='100px' style='background-color:#f0f0f0'/>").html("순위"),
											$("<th width='500px' style='background-color:#f0f0f0'/>").html("영화 제목"),
											$("<th width='200px' style='background-color:#f0f0f0'/>").html("영화 개봉일"),
											$("<th width='200px' style='background-color:#f0f0f0'/>").html("오늘 관객수"),
											$("<th width='200px' style='background-color:#f0f0f0'/>").html("누적 관객수"));
							var tbody = $("<tbody/>");
							
							$.each($data, function(i, o) {
								//오픈 API에 정의된 변수와 내가 정의한 변수 데이터 파싱
								var $rank = $(o).find("rank").text(); // 순위
								var $movieNm = $(o).find("movieNm").text(); //영화명
								var $openDt = $(o).find("openDt").text();// 영화 개봉일
								var $audiCnt = $(o).find("audiCnt").text(); //해당일의 관객수
								var $audiAcc = $(o).find("audiAcc").text(); //누적 관객수
								//<tbody><tr><td>태그안에 파싱하여 추출된 데이터 넣기
								var row = $("<tr style='background-color:#f0f0f0'/>").append(
										$("<td style='background-color:#f0f0f0'/>").text($rank),
										$("<td style='background-color:#f0f0f0'/>").text($movieNm),
										$("<td style='background-color:#f0f0f0'/>").text($openDt),
										$("<td style='background-color:#f0f0f0'/>").text(addComma($audiCnt)),
										$("<td style='background-color:#f0f0f0'/>").text(addComma($audiAcc)));
								tbody.append(row);
							});// end of each 
							table.append(thead);
							table.append(tbody);
							$(".wrap").append(table);
						}
					},
					//에러 발생시 "실시간 박스오피스 로딩중"메시지가 뜨도록 한다.
					error : function() {
						alert("실시간 박스오피스 로딩중...");
					}
				});
	}); //박스오피스 로딩하는 함수끝
	//검색결과 받아오는 함수 시작	
	// json 방식 : 자바스크립트 객체 데이터 형식, xml에 비해 구조 정의의 용이성과 가독성이 뛰어남
	$(function() {
		// 발급받은 네이버 id랑 시크릿키 변수로 선언해줌
		var XNaverClientId = "S2WqORD12J8iRsG3NNWD";
		var XNaverClientSecret = "GGDnUjPjOV"; 
		$.popup = function() {
			$('.wrap3').css('display','block');
		}
		$.close = function() {
			$('.wrap3').css('display','none');
			
			//그전에 출력되있는 정보는 삭제해줌
			$('#table2').remove();
		}
		// form에서 값 받아오기
		// trim(); : 문자열의 앞뒤에 공백을 없애주는 기능
		$.serviceAPISearchBlog = function() {
			if ("" == $.trim($("#query").val())) {
				$("#query").val("검색어");
			}
			$.ajax({	
						crossDomain : true,
						context : this,
						traditional : true,
						//json 요청 url 	
						url : "https://openapi.naver.com/v1/search/movie.json",
						method : "GET",
						type : "GET",
						dataType : "JSON",
						contentType : "application/x-www-form-urlencoded; charset=UTF-8",
						headers : {
							//네이버에서 발급받은 아이디랑 시크릿키 입력
							'X-Naver-Client-Id' : 'S2WqORD12J8iRsG3NNWD',
							'X-Naver-Client-Secret' : 'GGDnUjPjOV'
						},
						//Form의 값을 전달해줌
						data : {query:'이터'},
						success : function(data, textStatus, jqXHR) {
							if (data != null) {
								//JSON을 문자열로 바꿔줌
								// attr 선택한 요소의 속성의 값을 가져옵니다.
								var json = JSON.stringify(data);
								if (json.length > 0) {
									var table2 = $("<table/>").attr("id","table2");
									$('#table2').remove();
									
									//<table>안에 테이블의 컬럼 타이틀 부분인 thead 태그
									var thead2 = $("<thead/>").append(
											$("<tr/>")).append(
									//추출하고자 하는 컬럼들의 타이틀 정의
											$("<th />").html("포스터"),
											$("<th width='200px;'/>").html("영화제목"),
											$("<th width='300px;'/>").html("감독"),
											$("<th width='500px;'/>").html("주연배우"),
											$("<th width='100px;'/>").html("평점"));
									var tbody2 = $("<tbody/>");
									var item = JSON.parse(json);
									$.each(item.items, function(i) {
														var data = item.items;
														var title = data[i].title.replace(/<b>|<\/b>/g,'');
														var link = data[i].link
														var img = data[i].image;
														var director = data[i].director.replace('|','');
														var actor = data[i].actor.replace(/\|/g,' | ');
														var rate = data[i].userRating;
														var row2 = $("<tr/>").append(
																		//포스터이미지클릭시 링크이동
																		$("<td> <a href="+ link +"> <img id=\"img_src\" src="+ img +"></a> </td>"),
																		$("<td/>").text(title),
																		$("<td/>").text(director),
																		$("<td/>").text(actor),
																		$("<td/>").text(rate));
														tbody2.append(row2);
													});// end of each 
									table2.append(thead2);
									table2.append(tbody2);
									$(".wrap2").append(table2);
								}
							}
						},
						error : function(jqXHR, textStatus, errorThrown) { //에러났을때
							var errorResponseCode = "";
							errorResponseCode += "readyState : ";
							errorResponseCode += jqXHR.readyState;
							// 요청이 준비되기 전
							if ("0" == jqXHR.readyState) {
								errorResponseCode += "-UNSENT";
							}
							// 서버 연결이 성립된 시점
							if ("1" == jqXHR.readyState) {
								errorResponseCode += "-OPENED";
							}
							// 서버의 요청을 받은 시점
							if ("2" == jqXHR.readyState) {
								errorResponseCode += "-HEADERS_RECEIVED";
							}
							// 서버의 작업이 수행되는 시점
							if ("3" == jqXHR.readyState) {
								errorResponseCode += "-LOADING";
							}
							// 서버의 작업이 완료되고 reponse의 준비가 완료된 시점
							if ("4" == jqXHR.readyState) {
								errorResponseCode += "-DONE";
							}
							alert(errorResponseCode);
						},
						complete : function(jqXHR, textStatus) {
						}
					});
		}
	}); //검색결과 출력하는 함수 끝
</script>
</head>
<body style='background-color: #e4e4e4;'>
	
<%
	String id = (String)session.getAttribute("id");
	String kid = (String)session.getAttribute("kid");
	String admin = (String)session.getAttribute("admin");
	
	if(admin == null){
		if(kid == null) {
			if(id == null){ %>
				<div class="login"  >
					<input type="button" value="로그인" onclick="window.location='/team03/login/loginform.jsp'"/>
					<input type="button" value="회원가입" onclick="window.location='/team03/signUp/signUpForm.jsp'"/>
					<input type="button" value="자유게시판"	onclick="window.location='/team03/freeBoard/list.jsp'"/>
					<input type="button" value="방명록"    onclick="window.location='/team03/visitor/visitorForm.jsp'"/> 
					<input type="button" value="영화게시판"	onclick="window.location='/team03/movieBoard/list.jsp'"/>
					<input type="button" value="Q&A"    onclick="window.location='/team03/QnA/q&a_List.jsp'"/> 
				</div>
			<%}else{%>
		<div class="login" >
			<h3> [<%=id %>] 님.</h3>
			<input type="button" value="로그아웃" onclick=" window.location='/team03/page/logout.jsp'" /> 
			<input type="button" value="마이페이지" onclick="window.location='/team03/page/mypage.jsp'"/>
			<input type="button" value="자유게시판"	onclick="window.location='/team03/freeBoard/list.jsp'"/>
			<input type="button" value="방명록"    onclick="window.location='/team03/visitor/visitorForm.jsp?owner=<%=id%>'"/> 
			<input type="button" value="지역게시판"    onclick="window.location='/team03/localBoard/localMain.jsp'"/>
			<input type="button" value="영화게시판"	onclick="window.location='/team03/movieBoard/list.jsp'"/>
			<input type="button" value="Q&A"    onclick="window.location='/team03/QnA/q&a_List.jsp'"/>  
		</div>
		<%}%>
		<%}else{ %>
		<div class="login"  >
		<h3> [<%=kid %>] 님.</h3>
			<input type="button" value="로그아웃" onclick=" window.location='/team03/page/logout.jsp'" /> 
			<input type="button" value="마이페이지" onclick="window.location='/team03/page/mypage.jsp'"/>
			<input type="button" value="자유게시판"	onclick="window.location='/team03/freeBoard/list.jsp'"/>
			<input type="button" value="방명록"    onclick="window.location='/team03/visitor/visitorForm.jsp?owner=<%=kid%>'"/>
			<input type="button" value="지역게시판"    onclick="window.location='/team03/localBoard/localMain.jsp'"/>
			<input type="button" value="영화게시판"	onclick="window.location='/team03/movieBoard/list.jsp'"/>
			<input type="button" value="Q&A"    onclick="window.location='/team03/QnA/q&a_List.jsp'"/>   
		</div>												
	<%}
	} else { %>
		<div class="login"  >
		<h3> [<%=admin %>] 님.</h3>
			<input type="button" value="로그아웃" onclick=" window.location='/team03/page/logout.jsp'" /> 
			<input type="button" value="자유게시판"	onclick="window.location='/team03/freeBoard/list.jsp'"/>
			<input type="button" value="지역게시판"    onclick="window.location='/team03/localBoard/localMain.jsp'"/>
			<input type="button" value="영화게시판"	onclick="window.location='/team03/movieBoard/list.jsp'"/>
			<input type="button" value="Q&A"    onclick="window.location='/team03/QnA/q&a_List.jsp'"/>   
			<input type="button" value="관리자 페이지"    onclick="window.location='/team03/admin/adminMain.jsp'"/> 
		</div>
<%} %>

	<div id="movieChart">
		
		<div id="mo_searchBox">
			<form name="serviceAPISearchForm" id="serviceAPISearchForm"	method="post" action="" onsubmit="return false;">
				<div id="mo_inline">
					<div id="MovieSearchInput" >		
						<input class="form-control" type="text" id="query"  name="query"	placeholder="보고싶은 영화를 검색하세요" value="" />
					</div>
				</div>
				
				<button class="btn btn-primary"  type="button" onclick="$.serviceAPISearchBlog(); $.popup();">검색</button>
			</form>
		</div>
		
		<div class="wrap"></div>
		
	</div>
	<div class="wrap3">
		<h5 style="display:inline-block;">포스터를 클릭하면 네이버 영화정보로 넘어갑니다.</h5>
		<div id="close" onclick="$.close();" style="float:right;">X</div>
		<div class="wrap2" id="popup"></div>
	</div>
	
	<div id="bottomSpace"></div>
</body>
</html>





