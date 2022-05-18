<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.Board" %>
<%@ page import="woori.UserDAO" %>
<%@ page import="woori.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE HTML>
<html>
	<head>
		<title>우리 동네 커뮤니케이션</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<link rel="stylesheet" href="assets/css/project_woori.css" />

		<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
		<script>
			$(function (){
					$("#joinBtn").click(function (){
					  $("#join").show();
					  $("#loginBtn").show();
					  $("#joinBtn").hide();
					  $(".login").hide();
				});
			});
			$(function (){
					$("#loginBtn").click(function (){
						$(".login").show();
						$("#loginBtn").hide();
						$("#joinBtn").show();
						$("#join").hide();
				});
			});
		</script>
		<%-- date picker 선언_jquery UI --%>
			<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
			<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
			<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	</head>
	<body>
		<% 
			String userID = null;    // 로그인 확인 후 userID에 로그인한 값, 비로그인 null
			String add = null;
			String nick = null;
			if(session.getAttribute("userID") != null) {
				userID = (String)session.getAttribute("userID");
				UserDAO user = new UserDAO();
				add = user.add(userID);
				nick = user.nick(userID);
			}
			int pageNumber = 1; // 게시판 기본 페이지 설정
			if (request.getParameter("pageNumber") != null) {  // pageNumber 존재 시 해당 페이지 값 대입.
				pageNumber = Integer.parseInt(request.getParameter("pageNumber")); 
			}
		%>
		<!-- Wrapper -->
			<div id="wrapper">

				<!-- Header -->
					<header id="header">
						<h1><a href="#" style="font-weight:500;">우리 동네 커뮤니케이션</a></h1>
						<nav class="links">
							<ul>
								<li><a href="#bulletinboard">시 게시판</a></li>
								<li><a href="#meeting">모임</a></li>
							</ul>
						</nav>
						<nav class="main">
							<ul>
								<li class="search">
									<a class="fa-search" href="#search">Search</a>
									<form id="search" method="get" action="#">
										<input type="text" name="query" placeholder="Search" />
									</form>
								</li>
								<li class="menu">
									<a class="fa-bars" href="#menu">Menu</a>
								</li>
							</ul>
						</nav>
					</header>

				<!-- Menu (css:3339)-->
					<section id="menu" >

						<!-- 로그인-->
						<section id="login">
							<%
								if(userID == null) {
							%>
							<form method="post" action="loginAction.jsp">
							<li class="login"><input id="login_id" type="text" name="userID" placeholder="아이디" style="margin-bottom: 5px;"></li>
							<li class="login"><input id="login_pw" type="password" name="userPassword" placeholder="비밀번호" style="margin-bottom: 10px;"></li>
							<li class="login"><input class="button big fit" type="submit" value="로그인"></li>
							<li id="joinBtn" style="float:right; cursor:pointer; font-size: 13px;">회원가입</li>
							<li id="loginBtn" style="float:right; cursor:pointer; font-size: 13px; display:none;">로그인</li>
							</form>
							<%
								} else {
							%>
							<div class="after_login"> <!-- 로그인 성공 시 before_login 대체-->
								<h1>
			                   		<%
										out.println(nick + "님 환영합니다.</br>");
			                    	%>                    	
			                    </h1>
			                    <a href=logoutAction.jsp style="font-size: 14px; text-align: right; text-decoration:none;" id="logout">로그아웃</a>
			                </div>
			                 <%
								}
							%>
						</section>

						<section id="join" style="display:none">
							<form method="post" action="joinAction.jsp">
							<li><input id="id" type="text" name="userID" placeholder="아이디" style="margin-bottom: 5px;"></li>
							<li><input id="pw" type="password" name="userPassword" placeholder="비밀번호" style="margin-bottom: 5px;"></li>
							<li><input id="name" type="text" name="userName" placeholder="이름" style="margin-bottom: 5px;"></li>
							<li><input id="birth" type="text" name="userBirth" placeholder="생년월일(숫자 8자리 입력)" style="margin-bottom: 5px;">
								<script>
    						    $(function() {
    					            $("#birth").datepicker({
    					                dateFormat: 'yy-mm-dd', showOtherMonths: true, showMonthAfterYear:true
    					                ,changeYear: true, changeMonth: true, yearSuffix: "년"
    					                ,monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
    					            	,dayNamesMin: ['일','월','화','수','목','금','토'] //달력의 요일 부분 텍스트	
    					           		,dayNames: ['일요일','월요일','화요일','수요일','목요일','금요일','토요일']
    					            });
    					            $('#datepicker').datepicker('setDate', 'today');    
    					        });
	   							</script>
							</li>
							<li><input id="phonenum" type="text" name="userPhone" placeholder="휴대폰 번호('-'제외 입력)" style="margin-bottom: 5px;"></li>
							<li><input id="address" type="text" name="userAddress" placeholder="주소" style="margin-bottom: 5px;" onClick="addPopup()"><!-- 주소 입력창 클릭시 위치 인증 팝업으로-->
								<script type="text/javascript">
					        	function addPopup(){
					        		const pop = window.open("${pageContext.request.contextPath}/location.jsp", "pop", "width=550, height=630, scrollbars=no, resizable=yes");
					        	}
					       		 </script>
					        </li> 
							<li><input id="nickname" type="text" name="userNickname" placeholder="닉네임" style="margin-bottom: 10px;"></li>
							<li><input class="button big fit" type="submit" value="가입하기"></li>
							</form>
						</section>

					</section> 

				<!-- Main -->
					<div id="main">

						<!-- Post -->
							<article class="post" id="bulletinboard">
								<header>
									<div class="title">
										<%if(userID == null){%>
											<h2>시 게시판</h2>
										<%}else{%>
											<h2 class="article-title"><%=add %> 게시판</h2>
                    					<%}%>
										<p>같은 지역에 사는 이웃들과 자유롭게 이야기할 수 있는 공간입니다.</p>
									</div>
									<div class="meta">
										<a href="write.jsp" class="author"><span class="name" style="font-size: 10px;">글쓰기</span></a>
									</div>
								</header>
								<table id="bulletinboard">
									<tr>
										<td class="bbline">번호</td>
										<td class="bbline">제목</td>
										<td class="bbline">작성자</td>
										<td class="bbline">작성일</td>
										<td class="bbline">댓글수</td>
										<td class="bbline">조회수</td>
									</tr>
										<%  // 게시글 출력 부분. 게시글을 뽑아올 수 있도록
											BoardDAO brdDAO = new BoardDAO(); // 인스턴스 생성
											ArrayList<Board> list = brdDAO.getList(pageNumber); // 리스트 생성.
											for(int i = 0; i < list.size(); i++) { 
										%>
									<tr>
										<td class="bbline"><%= list.get(i).getBrdID() %></td>
										<td class="bbline"><a href="boardView.jsp?brdID=<%= list.get(i).getBrdID() %>"><%= list.get(i).getBrdTitle() %></a></td>
										<td class="bbline"><%= list.get(i).getUserNickname() %></td>
										<td class="bbline"><%= list.get(i).getBrdDate().substring(0, 11)  + list.get(i).getBrdDate().substring(11, 13) + "시" + list.get(i).getBrdDate().substring(14,16) + "분" %></td>
										<td class="bbline"><%= list.get(i).getCmtCount() %></td>
										<td class="bbline"><%= list.get(i).getBrdCount() %></td>
									</tr>
										<%
											}
										%>
								</table>	
								<ul class="number-menu">
								<%
	                        		int startPage = (pageNumber / 10) * 10 + 1;
	                        		if(pageNumber % 10 == 0) startPage -= 10;
	                        		int targetPage = new BoardDAO().targetPage(pageNumber);
	                        		if(startPage != 1) {
	                        	%>		
	                        		<li class="inner-number"><a href="main.jsp?pageNumber=<%= startPage - 1 %>">&lt;&lt;&nbsp;</a></li>
	    						<%
	    							} else {
	                        	%>
	                        		<li class="inner-number">&lt;&lt;&nbsp;</li>
	                        	<%
	    							}
	                        		if(pageNumber != 1)	{
								%>
									<li class="inner-number"><a href="main.jsp?pageNumber=<%= pageNumber - 1 %>">&lt;&nbsp;</a></li>
								<%
									} else {
			                    %>
		                        	<li class="inner-number">&lt;&nbsp;</li>
		                        <%
		    						}
	                        		for(int i = startPage; i < pageNumber; i++) {
	                        	%>
	                        		<li class="inner-number"><a href="main.jsp?pageNumber=<%= i %>"><%= i %></a></li>
	                        	<%
	                        		}
	                        	%>
	                        		<li class="inner-number"><a href="main.jsp?pageNumber=<%= pageNumber %>"><%= pageNumber %></a></li>
	                        	<%
	                        		for (int i = pageNumber + 1; i <= targetPage + pageNumber; i++) {
	                        			if(i <startPage + 10) {
	                        	%>
	                                <li class="inner-number"><a href="main.jsp?pageNumber=<%= i %>"><%= i %></a></li>
	                            <%			
	                        			}
	                        		}
	                        		if(pageNumber != targetPage + pageNumber)	{
	    						%>
	    							<li class="inner-number"><a href="main.jsp?pageNumber=<%= pageNumber + 1 %>">&nbsp;&gt;</a></li>
	    						<%
	    							} else {
	    		                %>
	    	                        <li class="inner-number">&nbsp;&gt;</li>
	    	                    <%
	    	    					}
	                        		if(targetPage + pageNumber > startPage + 9) {
	                        	%>
	                                <li class="inner-number"><a href="main.jsp?pageNumber=<%= startPage + 10 %>">&nbsp;&gt;&gt;</a></li>
	                            <%	
	                        		} else {
	                        	%>
	                        		<li class="inner-number">&nbsp;&gt;&gt;</li>
	                        	<%
	                        		}
	                        	%>
								</ul>
							</article>

						<!-- Post -->
							<article class="post" id="meeting">
								<header>
									<div class="title">
										<h2>모임</h2>
										<p>근처의 이웃들과 함께 모임을 만들어 취미를 즐길 수 있는 공간입니다.</p>
									</div>
									<div class="meta">
										<a href="woori_makemeeting.html" class="author"><span class="name" style="font-size: 10px;">모임 만들기</span></a>
									</div>
								</header>
								<header id="category">
									<ul style="list-style:none; margin: 1% 1% 1% 26%;">
										<li id="firstcategorylist" style="float:left; margin-right: 5%; font-size: 15px;"><a href="" target="_blank">전체</a></li>
										<li class="categorylist" style="float:left; margin-right: 5%; font-size: 15px;"><a href="" target="_blank">운동</a></li>
										<li class="categorylist" style="float:left; margin-right: 5%; font-size: 15px;"><a href="" target="_blank">봉사활동</a></li>
										<li class="categorylist" style="float:left; margin-right: 5%; font-size: 15px;"><a href="" target="_blank">게임</a></li>
										<li class="categorylist" style="float:left; margin-right: 5%; font-size: 15px;"><a href="" target="_blank">문화/공연</a></li>
										<li class="categorylist" style="float:left; margin-right: 5%; font-size: 15px;"><a href="" target="_blank">공예/만들기</a></li>
										<li class="categorylist" style="float:left; margin: 0 5% 0 2%; font-size: 15px;"><a href="" target="_blank">공부/스터디</a></li>
										<li class="categorylist" style="float:left; margin-right: 5%; font-size: 15px;"><a href="" target="_blank">음악/댄스</a></li>
										<li class="categorylist" style="float:left; margin-right: 5%; font-size: 15px;"><a href="" target="_blank">사교</a></li>
										<li class="categorylist" style="float:left; margin-right: 5%; font-size: 15px;"><a href="" target="_blank">여행</a></li>
										<li class="categorylist" style="float:left; margin-right: 5%; font-size: 15px;"><a href="" target="_blank">독서</a></li>
										<li  id="firstcategorylist" style="float:left; font-size: 15px;"><a href="" target="_blank">자유</a></li>
									</ul>
								</header>
								<article>
								<ul class="posts">
										<article style="margin-bottom: 30px; padding-bottom: 30px; border-bottom: solid 1px #dddddd;" >
											<header>
												<h3 style="margin-left:70px; font-size: 18px; font-weight: 500;"><a href="#">독서모임</a></h3>
												<h3 style="margin-left:70px; font-size: 13px; font-weight: 500;" class="published">2022년 05월 12일</h3>
											</header>
											<a href="#" class="image"><img src="images/pic08.jpg" style="width: 130px;" /></a>
										</article>
								</ul>
								<ul class="posts">
									<article>
										<header>
											<h3 style="margin-left:70px; font-size: 18px; font-weight: 500;"><a href="#">독서모임</a></h3>
											<h3 style="margin-left:70px; font-size: 13px; font-weight: 500;" class="published">2022년 05월 15일</h3>
										</header>
										<a href="#" class="image"><img src="images/pic08.jpg" style="width: 130px;" /></a>
									</article>
								</article>
							</ul>
							</article>
					</div>

				<!-- Sidebar -->
					<section id="sidebar">
						<!-- Intro -->
							<section id="intro">
								<a href="#" class="logo"><img src="images/logo.jpg" alt="" /></a>
								<header>
									<h2>우리동네 <br>커뮤니케이션</h2>
									<p>동네 이웃들과 이야기 나누고 취미를 공유해보세요.</p>
								</header>
							</section>
					</section>
			</div>

		<!-- Scripts -->
			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/skel.min.js"></script>
			<script src="assets/js/util.js"></script>
			<!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
			<script src="assets/js/main.js"></script>
	</body>
</html>