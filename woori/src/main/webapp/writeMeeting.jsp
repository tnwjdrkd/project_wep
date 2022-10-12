<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="member.MemberDAO" %>
<%@ page import="member.Member" %>
<!DOCTYPE HTML>
<html>
	<head>
		<title>모임게시판 글 작성</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<link rel="stylesheet" href="assets/css/project_woori.css" />

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
			String userID = null;
			if(session.getAttribute("userID") != null) {  // 세션 확인
				userID = (String) session.getAttribute("userID"); // 세션이 존재하면 userID에 해당 세션 값 부여
			}
			if(userID == null) {  // 세션이 부여된 상태
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('로그인하세요.')");
				script.println("location.href='main.jsp'");
				script.println("</script>");
			} 
			String mtID = null;
			if(request.getParameter("mtID") != null) {
				mtID = (String)request.getParameter("mtID");
			}
			MemberDAO mbr = new MemberDAO();  // brdID 값으로 해당 글을 가져온다.
			if(!mtID.equals(mbr.checkMember(userID, mtID))) {  // 글 작성자 확인
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('모임에 가입되어있지 않습니다.')");      
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
							<article class="post" id="bulletinboard">
								<header>
									<div class="title">
										<h2>글쓰기</h2>
										<p>모임게시판에 글을 작성해보세요.</p>
									</div>
								</header>
								<form method="post" action="writeMeetingAction.jsp?mtID=<%= URLEncoder.encode(mtID, "UTF-8") %>">
									<table>
										<tr style="border:none;">
											<td ><label for="title" style="font-weight: 500;">제목</label></td>
											<td><input id="title" type="text" name="brdTitle" style="width:765px;" autofocus="autofocus"></td>
										</tr>
										<tr style="border:none;">
											<td><label for="content" style="font-weight: 500;">내용</label></td>
											<td><textarea name="brdContent" style="width:765px;"></textarea></td>
										</tr>
									</table>
									<input type="submit" name="submit" style="width:100%;" value="등록">
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