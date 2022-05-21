<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="woori.UserDAO" %>
<%@ page import="woori.User" %>
<!DOCTYPE HTML>
<html>
	<head>
		<title>모임 가입하기</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<link rel="stylesheet" href="assets/css/project_woori.css" />
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
			if(userID == null) {  // 세션이 부여된 상태
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('로그인하세요.')");
				script.println("history.back()");
				script.println("</script>");
			} 
			String mtID = null;
			if(request.getParameter("mtID") != null) {
				mtID = (String)request.getParameter("mtID");
			}
			if(mtID == null) {   // 모임 존재시 모임 페이지 조회가능
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('존재하지 않는 모임입니다.')");      
				script.println("history.back()");   
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
										<h2>모임 가입하기</h2>
                                        <p>독서 모임에 가입합니다.</p> <!-- 모임이름 + 에 가입합니다. -->
									</div>
								</header>
                                <form method="post" action="meetingJoinAction.jsp?mtID=<%= URLEncoder.encode(mtID, "UTF-8") %>">
                                    <li id="nickname"><input id="nickname" type="text" name="mbUser" value="<%= nick %>" style="margin-bottom:10px;"></li> <!-- 사용자 닉네임 입력 공간 -->
                                    <li id="meeting_introduce"><input id="introduce" type="text" name="mbGreet" style="margin-bottom:10px;" placeholder="간단한 자기소개를 입력해주세요." onfocus="this.placeholder=''" onblur="this.placeholder='간단한 자기소개를 입력해주세요'"></li>
                                    <li><input id="submit" type="submit" name="submit" value="가입" style="width:100%;"></li>
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