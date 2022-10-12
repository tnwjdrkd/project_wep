<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="r_meeting.R_meetingDAO" %>
<%@ page import="r_meeting.R_meeting" %>
<%@ page import="review.ReviewDAO" %>
<%@ page import="review.Review" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE HTML>
<html>
	<head>
		<title>정모 후기 작성하기</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<link rel="stylesheet" href="assets/css/project_woori.css" />
	</head>
	<body>
		<% 
			String userID = null;    // 로그인 확인 후 userID에 로그인한 값, 비로그인 null
			if(session.getAttribute("userID") != null) {
				userID = (String)session.getAttribute("userID");
			}
			int pageNumber = 1; // 게시판 기본 페이지 설정
			if (request.getParameter("pageNumber") != null) {  // pageNumber 존재 시 해당 페이지 값 대입.
				pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
			}
			String mtID = null;
			if(request.getParameter("mtID") != null) {
				mtID = (String)request.getParameter("mtID");
			}
			int rmtID = 0;			// 글번호 매개변수 관리
			if (request.getParameter("rmtID") != null) {
				rmtID = Integer.parseInt(request.getParameter("rmtID"));
			}
			R_meeting rmt = new R_meetingDAO().getR_meeting(rmtID); // 모임 조회 인스턴스
		%>

		<!-- Wrapper -->
			<div id="wrapper">

				<!-- Header -->
					<header id="header">
						<h1><a href="main.jsp" style="font-weight:500;">우리 동네 커뮤니케이션</a></h1>
						<nav class="main">
							<ul>
								<li class="search">
									<a class="fa-search" href="#search">Search</a>
									<form id="search" method="get" action="#">
										<input type="text" name="query" placeholder="Search" />
									</form>
								</li>
							</ul>
						</nav>
					</header>

				<!-- Main -->
					<div id="main">

						<!-- Post -->
							<article class="post" id="Rmeeting">
								<header>
									<div class="title">
										<h2>정모 후기 작성하기</h2>
										<p>정모를 마치고 후기를 작성해보세요.</p>
									</div>
								</header>
                                <form method="post" action="reviewAction.jsp?mtID=<%= mtID %>&rmtID=<%= rmtID %>">
                                    <table id="mymeeting">
                                        <tr style="border:none;">
                                            <td><label for="RmeetingDate"><img src="images/date.png" width="25")></label></td>
                                            <td><input id="RmeetingDate" type="text" style="width:850px;" value=" <%= rmt.getRmtDate().substring(0, 4) + "년 " + rmt.getRmtDate().substring(5, 7) + "월 " + rmt.getRmtDate().substring(8, 10) + "일 " + rmt.getRmtTime() %>"></td>
                                        </tr>
                                        <tr style="border:none;">
                                            <td><label for="Rmeetinglocation"><img src="images/location.png" width="29")></label></td>
                                            <td><input id="Rmeetinglocation" type="text" style="width:850px;" value=" <%= rmt.getRmtPlace() %>"></td>
                                        </tr>
                                        <tr style="border:none;">
                                            <td><label for="Rmeetingreview"><img src="images/review.png" width="29")></label></td>
                                            <td><textarea name="rvContent" style="width:850px;" placeholder="후기를 입력해주세요."></textarea></td>
                                        </tr>
										<tr style="border:none;">
											<td colspan="2"><input type="submit" value="등록" style="width:905px;"></td>
											<td></td>
										</tr>
                                    </table>
                                </form>
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