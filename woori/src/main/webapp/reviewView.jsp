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
		<title>정모 후기 보기</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<link rel="stylesheet" href="assets/css/project_woori.css" />

        <script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
		<script>
			$(function (){
					$(".Rmeeting01").click(function (){
                        $(".review01").toggle();
				});
			});
            $(function (){
					$(".Rmeeting02").click(function (){
                        $(".review02").toggle();
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
			if (request.getParameter("pageNumber") != null) {  // pageNumber 존재 시 해당 페이지 값 대입.
				pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
										<h2>정모 후기 보기</h2>
										<p>모임의 정모 후기를 확인할 수 있습니다.</p>
									</div>
								</header>
                                <div class="content">
                                    <ul class="Rmeeting01" style="font-size:17px;">
                                        <li><img src="date.png" width="23")> 2022년 04월 10일 오후 3:00</li> <!-- 정모 시간 -->
                                        <li><img src="location.png" width="23")> 경기 안산시 단원구 중앙대로 907 4동 4층 귀큰여우 카페</li> <!-- 정모 장소-->
                                        <li><img src="money.png" width="23")> 개인 음료값</li> <!-- 정모 장소-->
                                    </ul>
                                    <ul class="review01" style="display:none;">
                                        <li><img src="review.png" width="24")> 후기내용</li> <!-- 후기 내용 -->
                                        <li><img src="review.png" width="24")> 후기내용</li> <!-- 후기 내용 -->
                                        <li><img src="review.png" width="24")> 후기내용</li> <!-- 후기 내용 -->
                                        <li><img src="review.png" width="24")> 후기내용</li> <!-- 후기 내용 -->
                                    </ul>
                                </div>
                                <div class="content">
                                    <ul class="Rmeeting02" style="font-size:17px;">
                                        <li><img src="date.png" width="23")> 2022년 05월 14일 오후 2:00</li> <!-- 정모 시간 -->
                                        <li><img src="location.png" width="23")> 경기 안양시 만안구 안양로 316 VON PLAZA</li> <!-- 정모 장소-->
                                        <li><img src="money.png" width="23")> 개인 음료값</li> <!-- 정모 장소-->
                                    </ul>
                                    <ul class="review02" style="display:none;">
                                        <li><img src="review.png" width="24")> 후기내용</li> <!-- 후기 내용 -->
                                        <li><img src="review.png" width="24")> 후기내용</li> <!-- 후기 내용 -->
                                        <li><img src="review.png" width="24")> 후기내용</li> <!-- 후기 내용 -->
                                        <li><img src="review.png" width="24")> 후기내용</li> <!-- 후기 내용 -->
                                    </ul>
                                </div>
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