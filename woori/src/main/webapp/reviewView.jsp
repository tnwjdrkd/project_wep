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
	</head>
	<body>
		<% 
			String userID = null;    // 로그인 확인 후 userID에 로그인한 값, 비로그인 null
			if(session.getAttribute("userID") != null) {
				userID = (String)session.getAttribute("userID");
			}
			int rmPage = 1; // 게시판 기본 페이지 설정
			if (request.getParameter("rmPage") != null) {  // pageNumber 존재 시 해당 페이지 값 대입.
				rmPage = Integer.parseInt(request.getParameter("rmPage"));
			}
			int reviewPage = 1;
			if (request.getParameter("reviewPage") != null) {
				reviewPage = Integer.parseInt(request.getParameter("reviewPage")); 
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
							<article class="post" id="Rmeeting">
								<header>
									<div class="title">
										<h2>정모 후기 보기</h2>
										<p>모임의 정모 후기를 확인할 수 있습니다.</p>
									</div>
								</header>
								<%
										R_meetingDAO rmtDAO = new R_meetingDAO();
										ArrayList<R_meeting> rmlist = rmtDAO.getRmList(rmPage, mtID);
										for(int i = 0; i < rmlist.size(); i++) { 
								%>
										<style>
										.Rmeeting<%= i %>{
											border-bottom: 2px solid #dbdbdb;
											padding:20px 5px 10px 5px;
										}
										.Rmeeting<%= i %>:hover {
											background-color: #f5f5f5;
											cursor: pointer;
										}
										.review<%= i %> li {
											padding: 10px 5px 10px 5px;
											border-top: 1px solid #dbdbdb;
										}
										</style>
                                <div class="content">
                                    <ul class="Rmeeting<%= i %>" style="font-size:17px;">
                                        <li><img src="images/date.png" width="23")> <%= rmlist.get(i).getRmtDate().substring(0, 4) + "년 " + rmlist.get(i).getRmtDate().substring(5, 7) + "월 " + rmlist.get(i).getRmtDate().substring(8, 10) + "일 " + rmlist.get(i).getRmtTime() %></li> <!-- 정모 시간 -->
                                        <li><img src="images/location.png" width="23")> <%= rmlist.get(i).getRmtPlace() %></li> <!-- 정모 장소-->
                                        <li><img src="images/money.png" width="23")> <%= rmlist.get(i).getRmtCost() %></li> <!-- 정모 장소-->
                                    </ul>
                                    <ul class="review<%= i %>" style="display:none;">
                                    	<%
												ReviewDAO rvDAO = new ReviewDAO();
												ArrayList<Review> rvlist = rvDAO.getRvList(reviewPage, rmlist.get(i).getRmtID());
												for(int y = 0; y < rvlist.size(); y++) { 
										%>
                                        <li><img src="images/review.png" width="24")> <%= rvlist.get(y).getRvContent()%></li> <!-- 후기 내용 -->
                                        <%
											}
										%>
										<%  // 페이지를 보여주는 부분
										if(reviewPage != 1)	{
											%>
												<a href="reviewView.jsp?mtID=<%= mtID %>&rmPage=<%= rmPage %>&reviewPage=<%=reviewPage - 1%>">이전</a>
											<%
												} if(rvDAO.nextPage(reviewPage + 1, rmlist.get(i).getRmtID())) {
											%>
												<a href="reviewView.jsp?mtID=<%= mtID %>&rmPage=<%= rmPage %>&reviewPage=<%=reviewPage + 1%>">다음</a>
											<%
												}
											%>							
                                    </ul>
                                    <script>
										$(function (){
												$(".Rmeeting<%= i %>").click(function (){
							                        $(".review<%= i %>").toggle();
											});
										});
									</script>
                                </div>
                                <%
									}
								%>
								<ul class="number-menu">
	                                <%
		                        		int startRmtPage = (rmPage / 5) * 5 + 1;
		                        		if(rmPage % 5 == 0) startRmtPage -= 5;
		                        		int targetRmtPage = new R_meetingDAO().targetR_meetingPage(rmPage, mtID);
		                        		if(startRmtPage != 1) {
		                        	%>		
		                        		<li class="inner-number"><a href="reviewView.jsp?mtID=<%= mtID %>&rmPage=<%= startRmtPage - 1 %>&reviewPage=<%= reviewPage %>#content">&lt;&lt;&nbsp;</a></li>
		    						<%
		    							} else {
		                        	%>
		                        		<li class="inner-number">&lt;&lt;&nbsp;</li>
		                        	<%
		    							}
		                        		if(rmPage != 1)	{
									%>
										<li class="inner-number"><a href="reviewView.jsp?mtID=<%= mtID %>&rmPage=<%= rmPage - 1 %>&reviewPage=<%= reviewPage %>#content">&lt;&nbsp;</a></li>
									<%
										} else {
				                    %>
			                        	<li class="inner-number">&lt;&nbsp;</li>
			                        <%
			    						}
		                        		for(int i = startRmtPage; i < rmPage; i++) {
		                        	%>
		                        		<li class="inner-number"><a href="reviewView.jsp?mtID=<%= mtID %>&rmPage=<%= i %>&reviewPage=<%= reviewPage %>#content"><%= i %></a></li>
		                        	<%
		                        		}
		                        	%>
		                        		<li class="inner-number"><a href="reviewView.jsp?mtID=<%= mtID %>&rmPage=<%= rmPage %>&reviewPage=<%= reviewPage %>#content"><%= rmPage %></a></li>
		                        	<%
		                        		for (int i = rmPage + 1; i <= targetRmtPage + rmPage; i++) {
		                        			if(i <startRmtPage + 5) {
		                        	%>
		                                <li class="inner-number"><a href="reviewView.jsp?mtID=<%= mtID %>&rmPage=<%= i %>&reviewPage=<%= reviewPage %>#content"><%= i %></a></li>
		                            <%			
		                        			}
		                        		}
		                        		if(rmPage != targetRmtPage + rmPage)	{
		    						%>
		    							<li class="inner-number"><a href="reviewView.jsp?mtID=<%= mtID %>&rmPage=<%= rmPage + 1 %>&reviewPage=<%= reviewPage %>#content">&nbsp;&gt;</a></li>
		    						<%
		    							} else {
		    		                %>
		    	                        <li class="inner-number">&nbsp;&gt;</li>
		    	                    <%
		    	    					}
		                        		if(targetRmtPage + rmPage > startRmtPage + 4) {
		                        	%>
		                                <li class="inner-number"><a href="reviewView.jsp?mtID=<%= mtID %>&rmPagee=<%= startRmtPage + 5 %>&reviewPage=<%= reviewPage %>#content">&nbsp;&gt;&gt;</a></li>
		                            <%	
		                        		} else {
		                        	%>
		                        		<li class="inner-number">&nbsp;&gt;&gt;</li>
		                        	<%
		                        		}
		                        	%>
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