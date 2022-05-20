<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="woori.UserDAO" %>
<%@ page import="woori.User" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.Board" %>
<%@ page import="meeting.MeetingDAO" %>
<%@ page import="meeting.Meeting" %>
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
			int meetingPage = 1;
			if (request.getParameter("pageNumber") != null) {  // pageNumber 존재 시 해당 페이지 값 대입.
				pageNumber = Integer.parseInt(request.getParameter("pageNumber")); 
			}
			if (request.getParameter("meetingPage") != null) {
				meetingPage = Integer.parseInt(request.getParameter("meetingPage")); 
			}
			String mtCategory = null;
		%>
		<!-- Wrapper -->
			<div id="wrapper">

				<!-- Header -->
					<header id="header">
						<h1><a href="main.jsp" style="font-weight:500;">우리 동네 커뮤니케이션</a></h1>
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
							<li><input id="birth" type="date" placeholder="생년월일" style="margin-bottom: 5px; width:100%; border:1px soild #dddddd; "></li>
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
	                        		<li class="inner-number"><a href="main.jsp?pageNumber=<%= startPage - 1 %>&meetingPage=<%= meetingPage %>#bulletinboard">&lt;&lt;&nbsp;</a></li>
	    						<%
	    							} else {
	                        	%>
	                        		<li class="inner-number">&lt;&lt;&nbsp;</li>
	                        	<%
	    							}
	                        		if(pageNumber != 1)	{
								%>
									<li class="inner-number"><a href="main.jsp?pageNumber=<%= pageNumber - 1 %>&meetingPage=<%= meetingPage %>#bulletinboard">&lt;&nbsp;</a></li>
								<%
									} else {
			                    %>
		                        	<li class="inner-number">&lt;&nbsp;</li>
		                        <%
		    						}
	                        		for(int i = startPage; i < pageNumber; i++) {
	                        	%>
	                        		<li class="inner-number"><a href="main.jsp?pageNumber=<%= i %>&meetingPage=<%= meetingPage %>#bulletinboard"><%= i %></a></li>
	                        	<%
	                        		}
	                        	%>
	                        		<li class="inner-number"><a href="main.jsp?pageNumber=<%= pageNumber %>&meetingPage=<%= meetingPage %>#bulletinboard"><%= pageNumber %></a></li>
	                        	<%
	                        		for (int i = pageNumber + 1; i <= targetPage + pageNumber; i++) {
	                        			if(i <startPage + 10) {
	                        	%>
	                                <li class="inner-number"><a href="main.jsp?pageNumber=<%= i %>&meetingPage=<%= meetingPage %>#bulletinboard"><%= i %></a></li>
	                            <%			
	                        			}
	                        		}
	                        		if(pageNumber != targetPage + pageNumber)	{
	    						%>
	    							<li class="inner-number"><a href="main.jsp?pageNumber=<%= pageNumber + 1 %>&meetingPage=<%= meetingPage %>#bulletinboard">&nbsp;&gt;</a></li>
	    						<%
	    							} else {
	    		                %>
	    	                        <li class="inner-number">&nbsp;&gt;</li>
	    	                    <%
	    	    					}
	                        		if(targetPage + pageNumber > startPage + 9) {
	                        	%>
	                                <li class="inner-number"><a href="main.jsp?pageNumber=<%= startPage + 10 %>&meetingPage=<%= meetingPage %>#bulletinboard">&nbsp;&gt;&gt;</a></li>
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
										<a href="makeMeeting.jsp" class="author"><span class="name" style="font-size: 10px;">모임 만들기</span></a>
									</div>
								</header>
								<header id="category">
									<ul style="list-style:none; margin: 1% 1% 1% 26%;">
										<li id="firstcategorylist" style="float:left; margin-right: 5%; font-size: 15px;"><a href="main.jsp?pageNumber=<%= pageNumber %>#meeting">전체</a></li>
										<li class="categorylist" style="float:left; margin-right: 5%; font-size: 15px;"><a href="main.jsp?pageNumber=<%= pageNumber %>&mtCategory=<%= "운동" %>#meeting">운동</a></li>
										<li class="categorylist" style="float:left; margin-right: 5%; font-size: 15px;"><a href="main.jsp?pageNumber=<%= pageNumber %>&mtCategory=<%= "봉사활동" %>#meeting">봉사활동</a></li>
										<li class="categorylist" style="float:left; margin-right: 5%; font-size: 15px;"><a href="main.jsp?pageNumber=<%= pageNumber %>&mtCategory=<%= "게임" %>#meeting">게임</a></li>
										<li class="categorylist" style="float:left; margin-right: 5%; font-size: 15px;"><a href="main.jsp?pageNumber=<%= pageNumber %>&mtCategory=<%= "문화/공연" %>#meeting">문화/공연</a></li>
										<li class="categorylist" style="float:left; margin-right: 5%; font-size: 15px;"><a href="main.jsp?pageNumber=<%= pageNumber %>&mtCategory=<%= "공예/만들기" %>#meeting">공예/만들기</a></li>
										<li class="categorylist" style="float:left; margin: 0 5% 0 2%; font-size: 15px;"><a href="main.jsp?pageNumber=<%= pageNumber %>&mtCategory=<%= "공부/스터디" %>#meeting">공부/스터디</a></li>
										<li class="categorylist" style="float:left; margin-right: 5%; font-size: 15px;"><a href="main.jsp?pageNumber=<%= pageNumber %>&mtCategory=<%= "음악/댄스" %>#meeting">음악/댄스</a></li>
										<li class="categorylist" style="float:left; margin-right: 5%; font-size: 15px;"><a href="main.jsp?pageNumber=<%= pageNumber %>&mtCategory=<%= "사교" %>#meeting">사교</a></li>
										<li class="categorylist" style="float:left; margin-right: 5%; font-size: 15px;"><a href="main.jsp?pageNumber=<%= pageNumber %>&mtCategory=<%= "여행" %>#meeting">여행</a></li>
										<li class="categorylist" style="float:left; margin-right: 5%; font-size: 15px;"><a href="main.jsp?pageNumber=<%= pageNumber %>&mtCategory=<%= "독서" %>#meeting">독서</a></li>
										<li  id="firstcategorylist" style="float:left; font-size: 15px;"><a href="main.jsp?pageNumber=<%= pageNumber %>&mtCategory=<%= "자유" %>#meeting">자유</a></li>
									</ul>
								</header>
								<article>
								<%
									MeetingDAO mtDAO = new MeetingDAO();
									if(request.getParameter("mtCategory") != null) {
									mtCategory = (String)request.getParameter("mtCategory");
									ArrayList<Meeting> meetinglist = mtDAO.getMeetingCategoryList(meetingPage, mtCategory); // 리스트 생성.
									for(int i = 0; i < meetinglist.size(); i++) { 
								%>
								<ul class="posts">
										<article style="margin-bottom: 30px; padding-bottom: 30px; border-bottom: solid 1px #dddddd;" >
											<header>
												<h3 style="margin-left:70px; font-size: 18px; font-weight: 500;"><a href="meeting.jsp?mtID=<%= URLEncoder.encode(meetinglist.get(i).getMtID(), "UTF-8")%>"> <%= meetinglist.get(i).getMtID() %></a></h3>
												<h3 style="margin-left:70px; font-size: 13px; font-weight: 500;" class="published"> <%= meetinglist.get(i).getMtDate().substring(0, 4) + "년" + meetinglist.get(i).getMtDate().substring(5, 7) + "월" + meetinglist.get(i).getMtDate().substring(8, 10) + "일" %></h3>
											</header>
											<a href="meeting.jsp?mtID=<%= URLEncoder.encode(meetinglist.get(i).getMtID(), "UTF-8")%>" class="image"><img src="images/pic08.jpg" style="width: 130px;" /></a>
										</article>
								</ul>
								<%
										}
								%>
								<ul class="number-menu">
	                                <%
		                        		int startMtPage = (meetingPage / 5) * 5 + 1;
		                        		if(meetingPage % 5 == 0) startMtPage -= 5;
		                        		int targetMtPage = new MeetingDAO().targetMeetingCategoryPage(meetingPage, mtCategory);
		                        		if(startMtPage != 1) {
		                        	%>		
		                        		<li class="inner-number"><a href="main.jsp?pageNumber=<%= pageNumber %>&meetingPage=<%= startMtPage - 1 %>&mtCategory=<%= mtCategory %>#meeting">&lt;&lt;&nbsp;</a></li>
		    						<%
		    							} else {
		                        	%>
		                        		<li class="inner-number">&lt;&lt;&nbsp;</li>
		                        	<%
		    							}
		                        		if(meetingPage != 1)	{
									%>
										<li class="inner-number"><a href="main.jsp?pageNumber=<%= pageNumber %>&meetingPage=<%= meetingPage - 1 %>&mtCategory=<%= mtCategory %>#meeting">&lt;&nbsp;</a></li>
									<%
										} else {
				                    %>
			                        	<li class="inner-number">&lt;&nbsp;</li>
			                        <%
			    						}
		                        		for(int i = startMtPage; i < meetingPage; i++) {
		                        	%>
		                        		<li class="inner-number"><a href="main.jsp?pageNumber=<%= pageNumber %>&meetingPage=<%= i %>&mtCategory=<%= mtCategory %>#meeting"><%= i %></a></li>
		                        	<%
		                        		}
		                        	%>
		                        		<li class="inner-number"><a href="main.jsp?pageNumber=<%= pageNumber %>&meetingPage=<%= meetingPage %>&mtCategory=<%= mtCategory %>#meeting"><%= meetingPage %></a></li>
		                        	<%
		                        		for (int i = meetingPage + 1; i <= targetMtPage + meetingPage; i++) {
		                        			if(i <startMtPage + 5) {
		                        	%>
		                                <li class="inner-number"><a href="main.jsp?pageNumber=<%= pageNumber %>&meetingPage=<%= i %>&mtCategory=<%= mtCategory %>#meeting"><%= i %></a></li>
		                            <%			
		                        			}
		                        		}
		                        		if(meetingPage != targetMtPage + meetingPage)	{
		    						%>
		    							<li class="inner-number"><a href="main.jsp?pageNumber=<%= pageNumber %>&meetingPage=<%= meetingPage + 1 %>&mtCategory=<%= mtCategory %>#meeting">&nbsp;&gt;</a></li>
		    						<%
		    							} else {
		    		                %>
		    	                        <li class="inner-number">&nbsp;&gt;</li>
		    	                    <%
		    	    					}
		                        		if(targetMtPage + meetingPage > startMtPage + 4) {
		                        	%>
		                                <li class="inner-number"><a href="main.jsp?pageNumber=<%= pageNumber %>&meetingPage=<%= startMtPage + 5 %>&mtCategory=<%= mtCategory %>#meeting">&nbsp;&gt;&gt;</a></li>
		                            <%	
		                        		} else {
		                        	%>
		                        		<li class="inner-number">&nbsp;&gt;&gt;</li>
		                        	<%
		                        		}
		                        	%>
								</ul>
								<%
									} else {
										ArrayList<Meeting> meetinglist = mtDAO.getMeetingList(meetingPage); // 리스트 생성.
										for(int i = 0; i < meetinglist.size(); i++) { 
								%>
								<ul class="posts">
										<article style="margin-bottom: 30px; padding-bottom: 30px; border-bottom: solid 1px #dddddd;" >
											<header>
												<h3 style="margin-left:70px; font-size: 18px; font-weight: 500;"><a href="meeting.jsp?mtID=<%= URLEncoder.encode(meetinglist.get(i).getMtID(), "UTF-8")%>"> <%= meetinglist.get(i).getMtID() %></a></h3>
												<h3 style="margin-left:70px; font-size: 13px; font-weight: 500;" class="published"> <%= meetinglist.get(i).getMtDate().substring(0, 4) + "년" + meetinglist.get(i).getMtDate().substring(5, 7) + "월" + meetinglist.get(i).getMtDate().substring(8, 10) + "일" %></h3>
											</header>
											<a href="meeting.jsp?mtID=<%= URLEncoder.encode(meetinglist.get(i).getMtID(), "UTF-8")%>" class="image"><img src="images/pic08.jpg" style="width: 130px;" /></a>
										</article>
								</ul>
								<%
										}
								%>
								<ul class="number-menu">
	                                <%
		                        		int startMtPage = (meetingPage / 5) * 5 + 1;
		                        		if(meetingPage % 5 == 0) startMtPage -= 5;
		                        		int targetMtPage = new MeetingDAO().targetMeetingPage(meetingPage);
		                        		if(startMtPage != 1) {
		                        	%>		
		                        		<li class="inner-number"><a href="main.jsp?pageNumber=<%= pageNumber %>&meetingPage=<%= startMtPage - 1 %>#meeting">&lt;&lt;&nbsp;</a></li>
		    						<%
		    							} else {
		                        	%>
		                        		<li class="inner-number">&lt;&lt;&nbsp;</li>
		                        	<%
		    							}
		                        		if(meetingPage != 1)	{
									%>
										<li class="inner-number"><a href="main.jsp?pageNumber=<%= pageNumber %>&meetingPage=<%= meetingPage - 1 %>#meeting">&lt;&nbsp;</a></li>
									<%
										} else {
				                    %>
			                        	<li class="inner-number">&lt;&nbsp;</li>
			                        <%
			    						}
		                        		for(int i = startMtPage; i < meetingPage; i++) {
		                        	%>
		                        		<li class="inner-number"><a href="main.jsp?pageNumber=<%= pageNumber %>&meetingPage=<%= i %>#meeting"><%= i %></a></li>
		                        	<%
		                        		}
		                        	%>
		                        		<li class="inner-number"><a href="main.jsp?pageNumber=<%= pageNumber %>&meetingPage=<%= meetingPage %>#meeting"><%= meetingPage %></a></li>
		                        	<%
		                        		for (int i = meetingPage + 1; i <= targetMtPage + meetingPage; i++) {
		                        			if(i <startMtPage + 5) {
		                        	%>
		                                <li class="inner-number"><a href="main.jsp?pageNumber=<%= pageNumber %>&meetingPage=<%= i %>#meeting"><%= i %></a></li>
		                            <%			
		                        			}
		                        		}
		                        		if(meetingPage != targetMtPage + meetingPage)	{
		    						%>
		    							<li class="inner-number"><a href="main.jsp?pageNumber=<%= pageNumber %>&meetingPage=<%= meetingPage + 1 %>#meeting">&nbsp;&gt;</a></li>
		    						<%
		    							} else {
		    		                %>
		    	                        <li class="inner-number">&nbsp;&gt;</li>
		    	                    <%
		    	    					}
		                        		if(targetMtPage + meetingPage > startMtPage + 4) {
		                        	%>
		                                <li class="inner-number"><a href="main.jsp?pageNumber=<%= pageNumber %>&meetingPage=<%= startMtPage + 5 %>#meeting">&nbsp;&gt;&gt;</a></li>
		                            <%	
		                        		} else {
		                        	%>
		                        		<li class="inner-number">&nbsp;&gt;&gt;</li>
		                        	<%
		                        		}
		                        	%>
								</ul>
								<%
									}
								%>
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
						<!-- Mini Posts -->
						<section>
							<header>
								<h2 style="text-align: center;">지역 소식</h2>
							</header>
							<div class="mini-posts">
									<article class="mini-post">
										<header>
											<h3><a href="https://www.gbuspb.kr/userMain.do" style="font-weight: 500;">경기도 청소년 교통비 지원사업</a></h3>
											<p class="published">신청기간 : 2022.07.01.~              문의 : 1577-8459</p>
										</header>
										<a href="https://www.gbuspb.kr/userMain.do" class="image"><img src="images/news01.png" alt=""/></a>
									</article>

									<header>
										<h2 style="text-align: center;">동네 일정</h2>
									</header>

									<li class="mini-post" style="width:49%; float:left; margin-right:7px;">
										<header style="padding:15px;">
											<h3 style="padding-bottom:5px;"><a href="https://www.ayac.or.kr/base/ayac/performance/read?performanceNo=2571&menuLevel=2&menuNo=1" style="font-weight: 500;  font-size: 13px;">APAP 오디오 투어 감상 안내</a></h3>
											<p class="published" style="font-size: 10px;">기간 : 2020.12.14.~2022.12.31.<br>장소 : 안양파빌리온<br>문의 : 031-687-0548</p>
										</header>
										<a href="https://www.ayac.or.kr/base/ayac/performance/read?performanceNo=2571&menuLevel=2&menuNo=1" class="image"><img src="images/schedule01.jpg" alt="" /></a>
									</li>

								<li class="mini-post" style="width:49%; float:left;">
									<header style="padding:15px;">
										<h3 style="padding-bottom:5px;"><a href="https://www.ayac.or.kr/base/schedule/read?scheduleManagementNo=1&scheduleNo=11&page=&searchStartDate=&searchEndDate=&searchCategory=&searchType=&searchWord=&menuLevel=2&menuNo=2" style="font-weight: 500;  font-size: 13px;">김중업, 더 비기닝 건축예술의 문을 열다</a></h3>
										<p class="published"  style="font-size: 10px;" >기간 : 2021.12.16.~2022.06.30.<br>장소 : 김중업건축박물관<br>문의 : 031-687-0909</p>
									</header>
									<a href="https://www.ayac.or.kr/base/schedule/read?scheduleManagementNo=1&scheduleNo=11&page=&searchStartDate=&searchEndDate=&searchCategory=&searchType=&searchWord=&menuLevel=2&menuNo=2" class="image"><img src="images/schedule02.png" alt="" /></a>
								</li>

								<li class="mini-post" style="width:49%; float:left; margin-right:7px;">
									<header style="padding:15px;">
										<h3 style="padding-bottom:5px;"><a href="https://www.ayac.or.kr/base/schedule/read?scheduleManagementNo=1&scheduleNo=10&page=&searchStartDate=&searchEndDate=&searchCategory=&searchType=&searchWord=&menuLevel=2&menuNo=2" style="font-weight: 500;  font-size: 13px;">돌아온 역사, 안양</a></h3>
										<p class="published" style="font-size: 10px;">기간 : 2021.11.30.~2022.06.26.<br>장소 : 안양박물관<br>문의 : 031-687-0909</p>
									</header>
									<a href="https://www.ayac.or.kr/base/schedule/read?scheduleManagementNo=1&scheduleNo=10&page=&searchStartDate=&searchEndDate=&searchCategory=&searchType=&searchWord=&menuLevel=2&menuNo=2" class="image"><img src="images/schedule03.jpg" alt="" /></a>
								</li>

								<li class="mini-post" style="width:49%; float:left;">
									<header style="padding:15px;">
										<h3 style="padding-bottom:5px;"><a href="https://www.ayac.or.kr/base/ayac/performance/read?performanceNo=2627&menuLevel=2&menuNo=1&year=2022&month=5&currentDate=1" style="font-weight: 500;  font-size: 13px;">안양예술공원 미니투어</a></h3>
										<p class="published"  style="font-size: 10px;" >기간 : 2022.05.03.~2022.11.30<br>장소 : 안양파빌리온<br>문의 : 031-687-0548</p>
									</header>
									<a href="https://www.ayac.or.kr/base/ayac/performance/read?performanceNo=2627&menuLevel=2&menuNo=1&year=2022&month=5&currentDate=1" class="image"><img src="images/schedule06.jpg" alt="" /></a>
								</li>

							<li class="mini-post" style="width:49%; float:left; margin-right:7px;">
								<header style="padding:15px;">
									<h3 style="padding-bottom:5px;"><a href="https://www.ayac.or.kr/base/ayac/performance/read?performanceNo=2642&menuLevel=2&menuNo=1&year=2022&month=5&currentDate=1" style="font-weight: 500;  font-size: 13px;">무엇이 삶을 예술로 만드는가</a></h3>
									<p class="published" style="font-size: 10px;">기간 : 2022.04.28.~2022.05.29.<br>장소 : 평촌아트홀<br>문의 : 031-687-0500</p>
								</header>
									<a href="https://www.ayac.or.kr/base/ayac/performance/read?performanceNo=2642&menuLevel=2&menuNo=1&year=2022&month=5&currentDate=1" class="image"><img src="images/schedule05.jpg" alt="" /></a>
							</li>

							<li class="mini-post" style="width:49%; float:left;">
								<header style="padding:15px;">
									<h3 style="padding-bottom:5px;"><a href="https://www.ayac.or.kr/base/schedule/read?scheduleManagementNo=1&scheduleNo=12&page=&searchStartDate=&searchEndDate=&searchCategory=&searchType=&searchWord=&menuLevel=2&menuNo=2" style="font-weight: 500;  font-size: 13px;">김중업, 건축예술로 이어지다</a></h3>
									<p class="published"  style="font-size: 10px;" >기간 : 2022.04.15.~2022.09.25.<br>장소 : 김중업건축박물관<br>문의 : 031-687-0909</p>
								</header>
								<a href="https://www.ayac.or.kr/base/schedule/read?scheduleManagementNo=1&scheduleNo=12&page=&searchStartDate=&searchEndDate=&searchCategory=&searchType=&searchWord=&menuLevel=2&menuNo=2" class="image"><img src="images/schedule04.jpg" alt="" /></a>
							</li>

							<li class="mini-post" style="width:49%; float:left; margin-right:7px;">
								<header style="padding:15px;">
									<h3 style="padding-bottom:5px;"><a href="https://www.ayac.or.kr/base/ayac/performance/read?performanceNo=2646&menuLevel=2&menuNo=1&year=2022&month=5&currentDate=1" style="font-weight: 500;  font-size: 13px;">평촌아트홀 아카데미</a></h3>
									<p class="published" style="font-size: 10px;">기간 : 2022.05.12.~2022.05.25.<br>장소 : 평촌아트홀<br>문의 : 031-687-0555</p>
								</header>
									<a href="https://www.ayac.or.kr/base/ayac/performance/read?performanceNo=2646&menuLevel=2&menuNo=1&year=2022&month=5&currentDate=1" class="image"><img src="images/schedule07.jpg" alt="" /></a>
							</li>

							<li class="mini-post" style="width:49%; float:left;">
								<header style="padding:15px;">
									<h3 style="padding-bottom:5px;"><a href="https://www.ayac.or.kr/base/ayac/performance/read?performanceNo=2620&menuLevel=2&menuNo=1&year=2022&month=5&currentDate=1" style="font-weight: 500;  font-size: 13px;">안양예술공원 작품투어</a></h3>
									<p class="published"  style="font-size: 10px;" >기간 : 2022.05.03.~2022.11.30.<br>장소 : 안양파빌리온<br>문의 : 031-687-0548</p>
								</header>
								<a href="https://www.ayac.or.kr/base/ayac/performance/read?performanceNo=2620&menuLevel=2&menuNo=1&year=2022&month=5&currentDate=1" class="image"><img src="images/schedule08.jpg" alt="" /></a>
							</li>
							</div>
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