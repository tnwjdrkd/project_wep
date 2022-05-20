<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.Board" %>
<%@ page import="meeting.MeetingDAO" %>
<%@ page import="meeting.Meeting" %>
<%@ page import="member.MemberDAO" %>
<%@ page import="member.Member" %>
<%@ page import="r_meeting.R_meetingDAO" %>
<%@ page import="r_meeting.R_meeting" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE HTML>
<html>
	<head>
		<title>우리 동네 모임</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<link rel="stylesheet" href="assets/css/woori_meeting.css" />

		<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
		<script>
			$(function (){
					$("#joinBtn").click(function (){
					  $("#join").toggle();
				});
			});
		</script>
	</head>
	<body>
		<% 
			String userID = null;    // 로그인 확인 후 userID에 로그인한 값, 비로그인 null
			if(session.getAttribute("userID") != null) {
				userID = (String)session.getAttribute("userID");
			}
			int pageNumber = 1; // 게시판 기본 페이지 설정
			int r_meetingpage = 1;
			if (request.getParameter("pageNumber") != null) {  // pageNumber 존재 시 해당 페이지 값 대입.
				pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
				r_meetingpage = Integer.parseInt(request.getParameter("r_meetingpage"));
			}
			String mtID = null;
			if(request.getParameter("mtID") != null) {
				mtID = (String)request.getParameter("mtID");
			}
			if(mtID == null) {   // 모임 존재시 모임 페이지 조회가능
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('존재하지 않는 모임입니다.')");      
				script.println("location.href='main.jsp'");   
				script.println("</script>");
			}
			Meeting mt = new MeetingDAO().getMeeting(mtID); // 모임 조회 인스턴스
		%>
		<!-- Wrapper -->
			<div id="wrapper">

				<!-- Header -->
					<header id="header">
						<h1><a href="#" style="font-weight:500;">우리 동네 커뮤니케이션</a></h1>

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
							<li><input id="login_id" type="text" placeholder="아이디" style="margin-bottom: 5px;"></li>
							<li><input id="login_pw" type="password" placeholder="비밀번호" style="margin-bottom: 10px;"></li>
							<li><input class="button big fit"  type="submit" value="로그인"></li>
							<li id="joinBtn" style="float:right; cursor:pointer; font-size: 13px;">회원가입</li>
						</section>

						<section id="join" style="display:none">
							<form method="post">
							<li><input id="id" type="text"placeholder="아이디" style="margin-bottom: 5px;"></li>
							<li><input id="pw" type="password" placeholder="비밀번호" style="margin-bottom: 5px;"></li>
							<li><input id="name" type="text" placeholder="이름" style="margin-bottom: 5px;"></li>
							<li><input id="birth" type="text" placeholder="생년월일(숫자 8자리 입력)" style="margin-bottom: 5px;"></li>
							<li><input id="phonenum" type="text" placeholder="휴대폰 번호('-'제외 입력)" style="margin-bottom: 5px;"></li>
							<li><input id="address" type="text" placeholder="주소" style="margin-bottom: 5px;"></li>
							<li><input id="nickname" type="text" placeholder="닉네임" style="margin-bottom: 10px;"></li>
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
										<h2>게시판</h2>
										<p>모임 멤버들과 소통할 수 있는 공간입니다.</p>
									</div>
									<div class="meta">
										<a href="woori_meetingBBwrite.html" class="author"><span class="name" style="font-size: 10px;">글쓰기</span></a>
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
											<%
												BoardDAO brdDAO = new BoardDAO(); // 인스턴스 생성
												ArrayList<Board> list = brdDAO.getMtList(pageNumber, mtID); // 리스트 생성.
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
								               		int targetPage = new BoardDAO().targetMtPage(pageNumber, mtID);
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
							<article class="post" id="meeting">
								<header>
									<div class="title">
										<h2>정모</h2>
										<p>모임 멤버들과 만남 약속을 정할 수 있는 공간입니다.</p>
									</div>
									<div class="meta">
										<a href="addR_meeting.jsp?mtID=<%= URLEncoder.encode(mtID, "UTF-8") %>" class="author"><span class="name" style="font-size: 10px;">정모 추가하기</span></a>
									</div>
								</header>
									<%
										R_meetingDAO rmtDAO = new R_meetingDAO(); // 인스턴스 생성
										ArrayList<R_meeting> rmlist = rmtDAO.getRmList(r_meetingpage, mtID); // 리스트 생성.
										for(int i = 0; i < rmlist.size(); i++) { 
									%>
										<table>
											<tr>
												<td><img src="date.png" width="20")> <%= rmlist.get(i).getRmtDate().substring(0, 4) + "년 " + rmlist.get(i).getRmtDate().substring(5, 7) + "월 " + rmlist.get(i).getRmtDate().substring(8, 10) + "일 " + rmlist.get(i).getRmtTime() %> </td> <!-- 정모 시간 -->
												<td></td>
												<td style="text-align: center;" width="200px" rowspan="3" input id="Rmeeting_join"  type="button" onClick="alert('참여 신청을 보냈습니다. 모임장 수락시 참여 가능합니다.')"><br><br>참여하기</td> <!-- 클릭시 알림창 생성-->
											</tr>
											<tr>
												<td><img src="location.png" width="22")> <%= rmlist.get(i).getRmtPlace() %></td> <!-- 정모 장소-->
												<td><input type="button" value="지도로 보기"></td>
											</tr>
											<tr>
												<td><img src="money.png" width="20")> <%= rmlist.get(i).getRmtCost() %></td> <!-- 정모 비용 -->
												<td></td>
											</tr>
										</table>
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
									<h2><%= mt.getMtID() %></h2>
									<p>동네 이웃들과 이야기 나누고 취미를 공유해보세요.</p>
								</header>
							</section>
                            <section id="main-aside">
                                <div class="inner-aside">
                                    <h2>모임</h2>
                                        <li class="meeting_leader"><img src="leader.png" width="20")><a href="project_meminfo.html"> <%= mt.getMtLeader() %></a></li> <!-- 모임장(닉네임) -->
                                        <li class="meeting_opendate"><img src="date.png" width="20")> <%= mt.getMtDate().substring(0, 4) + "년" + mt.getMtDate().substring(5, 7) + "월" + mt.getMtDate().substring(8, 10) + "일" %></li> <!-- 모임 생성 날짜 -->
                                        <li class="meeting_introduction"><%= mt.getMtSummary() %></li> <!-- 모임 소개 -->
                                </div>
                                <div class="inner-aside">
                                    <h2>멤버</h2>
                                    <%
										MemberDAO mbDAO = new MemberDAO(); // 인스턴스 생성
										ArrayList<Member> mblist = mbDAO.getMbList(mtID); // 리스트 생성.
										for(int i = 0; i < mblist.size(); i++) { 
									%>
                                    <li><img src="people.png" width="18")><a href="project_meminfo.html"> <%= mblist.get(i).getMbUser() %></a></li> <!-- 모임에 가입된 회원 -->
					                <%
										}
									%>
                                </div>
                                <div class="meeting-aside">
                                    <input id="meeting-join"  type="button" value="모임 가입하기" style="font-size: 17px;" onClick="location.href='meetingJoin.jsp?mtID=<%= URLEncoder.encode(mtID, "UTF-8") %>'">
                                </div>
                                <div class="meeting-aside">
                                    <input id="meeting-record"  type="button" value="정모후기 보기" style="font-size: 17px;" onClick="location.href='review.jsp?mtID=<%= URLEncoder.encode(mtID, "UTF-8") %>'">
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