<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
	<head>
		<title>모임 만들기</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<link rel="stylesheet" href="assets/css/project_woori.css" />
	</head>
	<body>

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
							<article class="post" id="makemeeting">
								<header>
									<div class="title">
										<h2>모임 만들기</h2>
										<p>직접 모임을 만들어 멤버를 모집해보세요.</p>
									</div>
								</header>
                                <form method="post" action="makeMeetingAction.jsp">
                                    <table id="mymeeting">
                                        <tr>
                                            <td><label for="category"  style=" font-weight: 500;">카테고리</label></td>
                                            <td><input id="category" type="text" name="mtCategory" list="categoryList" autofocus="autofocus" style="width:180px;"></td>
                                        </tr>
                                        <datalist id="categoryList">
                                            <option value="운동"></option>
                                            <option value="봉사활동"></option>
                                            <option value="게임"></option>
                                            <option value="문화/공연"></option>
                                            <option value="반려동물"></option>
                                            <option value="공예/만들기"></option>
                                            <option value="요리/제조"></option>
                                            <option value="공부/스터디"></option>
                                            <option value="음악/댄스"></option>
                                            <option value="사교"></option>
                                            <option value="여행"></option>
                                            <option value="독서"></option>
                                            <option value="자유"></option>
                                        </datalist>
                                        <tr>
                                            <td><label for="meeting_name" style=" font-weight: 500;">모임명</label></td>
                                            <td><input id="meeting_name" type="text" name="mtID" style="width:740px;"></td>
                                        </tr>
                                        <tr>
                                            <td><label for="meeting_report" style=" font-weight: 500;">모임소개</label></td>
                                            <td><input  id="meeting_report" type="text" name="mtSummary"></td>
                                        </tr>
                                    </table>
								<div>
                               		<input id="create" type="submit" name="submit" value="생성" style="width:100%; margin-bottom: 20px; font-weight: 500;">
								</div>
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