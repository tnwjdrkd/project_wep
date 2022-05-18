<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE HTML>
<html>
	<head>
		<title>정모 추가하기</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<link rel="stylesheet" href="assets/css/project_woori.css" />
	</head>
	<body>
		<% 
			String userID = null;
			if(session.getAttribute("userID") != null) {
				userID = (String)session.getAttribute("userID");
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
						<h1><a href="#" style="font-weight:500;">우리 동네 커뮤니케이션</a></h1>
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
										<h2>정모 추가하기</h2>
										<p>정모를 추가해 모임 멤버들과 만나세요.</p>
									</div>
								</header>
								<form method="post" action="addR_meetingAction.jsp?mtID=<%= URLEncoder.encode(mtID, "UTF-8") %>">
	                                <li id="Rmeeting_date"><input id="date" type="date" name="rmtDate" style="width:100%; height:40px; margin-bottom:10px;"></li>
	                                <li id="Rmeeting_time"><input id="time" type="time" name="rmtTime" style="width:100%; height:40px; margin-bottom:10px;" ></li>
	                                <li id="Rmeeting_place"><input id="place" type="text" name="rmtPlace" style="margin-bottom:10px;" placeholder="정모 장소를 입력해주세요." onfocus="this.placeholder=''" onblur="this.placeholder='정모 장소를 입력해주세요.'"></li>
	                                <li id="Rmeeting_cost"><input id="cost" type="text" name="rmtCost" style="margin-bottom:15px;" placeholder="비용을 입력해주세요." onfocus="this.placeholder=''" onblur="this.placeholder='비용을 입력해주세요'"></li>
	                                <input id="submit" type="submit" name="submit" value="등록" style="width:100%;">
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