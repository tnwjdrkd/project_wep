<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>   <%-- script 문장을 실행할 수 있도록 하는 라이브러리 --%>
<%@ page import="board.Board" %>
<%@ page import="board.BoardDAO" %>
<!DOCTYPE HTML>
<html>
	<head>
		<title>시게시판 글 수정</title>
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
			String userID = null;  // 로그인 세션 관리 
			if(session.getAttribute("userID") != null) {
				userID = (String)session.getAttribute("userID");
			}
			if(userID == null) {   // 비로그인 시 로그인페이지로 이동
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('로그인을 하세요.')");      
				script.println("location.href='main.jsp'");   
				script.println("</script>");
			}
			int brdID = 0;    // 게시글 번호 초기화
			if (request.getParameter("brdID") != null) {
				brdID = Integer.parseInt(request.getParameter("brdID"));
			}
			if(brdID == 0) {   // 번호 존재하지 않다면 오류 메시지 출력
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('존재하지 않는 게시글입니다.')");      
				script.println("location.href='main.jsp'");   
				script.println("</script>");
			}
			Board brd = new BoardDAO().getBoard(brdID);  // brdID 값으로 해당 글을 가져온다.
			if(!userID.equals(brd.getUserID())) {  // 글 작성자 확인
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('수정 권한이 없습니다.')");      
				script.println("location.href='main.jsp'");   
				script.println("</script>");
			}
			String mtID = null;
			if(request.getParameter("mtID") != null) {
				mtID = (String)request.getParameter("mtID");
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
							<article class="post" id="bulletinboard">
								<header>
									<div class="title">
										<h2>글수정</h2>
										<p>작성한 글을 수정해보세요.</p>
									</div>
								</header>
								<form method="post" action="updateAction.jsp?brdID=<%= brdID %>&mtID=<%= mtID %>">
									<table>
										<tr style="border:none;">
											<td ><label for="title" style="font-weight: 500;">제목</label></td>
											<td><input id="title" type="text" name="brdTitle" style="width:765px;" autofocus="autofocus" value="<%= brd.getBrdTitle() %>"></td>
										</tr>
										<tr style="border:none;">
											<td><label for="content" style="font-weight: 500;">내용</label></td>
											<td><textarea name="brdContent" style="width:765px;"><%= brd.getBrdContent() %></textarea></td>
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