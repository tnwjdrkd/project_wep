<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.Board" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="woori.UserDAO" %>
<%@ page import="woori.User" %>
<%@ page import="comment.Comment" %>
<%@ page import="comment.CommentDAO" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE HTML>
<html>
	<head>
		<title>게시글 상세보기</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<link rel="stylesheet" href="assets/css/woori_bulletinboard.css" />

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
			String add = null;
			String nick = null;
			if(session.getAttribute("userID") != null) {
				userID = (String)session.getAttribute("userID");
				UserDAO user = new UserDAO();
				add = user.add(userID);
				nick = user.nick(userID);
			}
			int pageNumber = 1; // 게시판 기본 페이지 설정
			if (request.getParameter("pageNumber") != null) {
				pageNumber = Integer.parseInt(request.getParameter("pageNumber")); 
			}
			int brdID = 0;			// 글번호 매개변수 관리
			if (request.getParameter("brdID") != null) {
				brdID = Integer.parseInt(request.getParameter("brdID"));
			}
			if(brdID == 0) {   // 글번호 존재시 특정 글 조회가능
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('존재하지 않는 게시글입니다.')");      
				script.println("location.href='main.jsp'");   
				script.println("</script>");
			}
			Board brd = new BoardDAO().getBoard(brdID); // 게시글 조회 인스턴스 생성
			BoardDAO brdDAO = new BoardDAO();
			Comment cmt = new CommentDAO().getComment(brdID);
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
							<article class="post">
                                    <h1><%= brd.getBrdTitle().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></h1>
                                    <li id="postinfo">
                                        <ul><img src="people.png" width="13")> <%= brd.getUserNickname() %></ul> 
                                        <ul id="contentdate"><%= brd.getBrdDate().substring(0,16) %></ul> 
                                    </li>
                                    <p id="content"><%= brd.getBrdContent().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></p>
                                    <%
										if(userID != null && userID.equals(brd.getUserID())) {
									%>
                                    <input type="button" id="delete" value="삭제" style="width:80px; height:50px; float:right;" onClick="dltbtnClick()">
                                    <script>
										function dltbtnClick() {
											if (confirm('정말로 삭제하시겠습니까?') == true)
												location.href="deleteAction.jsp?brdID=<%= brdID %>";
										}
									</script>
                                    <input type="button" id="modify" value="수정" style="width:80px; height:50px; float:right;" onClick="location.href='update.jsp?brdID=<%= brdID %>'">
                                    <%
										}
									%>
                                    <br>
                                    <h3 id="comment"> 댓글</h3>
                                    <%
										CommentDAO cmtDAO = new CommentDAO(); // 인스턴스 생성
										ArrayList<Comment> cmtlist = cmtDAO.getList(brdID); // 리스트 생성.
										for(int i = 0; i < cmtlist.size(); i++) { 
									%>
                                    <li>
                                        <ul id="nickname"><img src="people.png" width="13")> <%= cmtlist.get(i).getUserNickname() %></ul>
                                        <ul id="cc"><%= cmtlist.get(i).getCmtContent().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">","&gt;").replaceAll("\n","<br>") %></ul>
                                        <ul id="commentdate"><%=cmtlist.get(i).getCmtDate().substring(0,16) %></ul> <!-- 날짜 -->
                                    </li>
                                    <%
										}
									%>
									<form method="post" action="commentAction.jsp?brdID=<%= brdID %>">
										<ul id="nickname" style="margin-top:30px;"><img src="people.png" width="13")> <%= brdDAO.getuserNickname(userID) %></ul>
	                                    <table>
	                                        <tr style="border:none;  padding:0;">
	                                            <td style="width:80%; padding:0;"><textarea style="height:70px;" name="cmtContent" placeholder="동네 이웃에게 따뜻한 댓글을 달아주세요."></textarea> </td>
	                                            <td style="width:20%;  text-align: center; padding:0;"><input type="submit" id="register" value="등록" style="width:100px; height:70px; text-align: center;"></td>
	                                        </tr>
	                                    </table>
	                               	</form>
							</article>
					</div>

				<!-- Sidebar -->
					<section id="sidebar">
                            <section>
                                <h1>게시판 목록</h1>
                                <table id="bulletinboard">
                                    <tr>
                                        <td class="bbline">제목</td>
                                        <td class="bbline">작성자</td>
                                        <td class="bbline">작성일</td>
                                        <td class="bbline">댓글수</td>
                                    </tr>
                                    	<%	
											ArrayList<Board> list = brdDAO.getList(pageNumber); // 리스트 생성.
											for(int i = 0; i < list.size(); i++) { 
										%>
                                    <tr>
										<td class="bbline2" title="<%= list.get(i).getBrdTitle() %>"><a href="boardView.jsp?brdID=<%= list.get(i).getBrdID() %>"><%= list.get(i).getBrdTitle() %></a></td>
										<td class="bbline2"><%= list.get(i).getUserNickname() %></td>
										<td class="bbline2"><%= list.get(i).getBrdDate().substring(0, 11) %></td>
										<td class="bbline2"><%= list.get(i).getCmtCount() %></td>
									</tr>
										<%
											}
										%>
                                </table>
                                <ul class="number-menu">
	                                <%
		                        		int startPage = (pageNumber / 5) * 5 + 1;
		                        		if(pageNumber % 5 == 0) startPage -= 5;
		                        		int targetPage = new BoardDAO().targetPage(pageNumber);
		                        		if(startPage != 1) {
		                        	%>		
		                        		<li class="inner-number"><a href="boardView.jsp?brdID=<%= brdID %>&pageNumber=<%= startPage - 1 %>">&lt;&lt;&nbsp;</a></li>
		    						<%
		    							} else {
		                        	%>
		                        		<li class="inner-number">&lt;&lt;&nbsp;</li>
		                        	<%
		    							}
		                        		if(pageNumber != 1)	{
									%>
										<li class="inner-number"><a href="boardView.jsp?brdID=<%= brdID %>&pageNumber=<%= pageNumber - 1 %>">&lt;&nbsp;</a></li>
									<%
										} else {
				                    %>
			                        	<li class="inner-number">&lt;&nbsp;</li>
			                        <%
			    						}
		                        		for(int i = startPage; i < pageNumber; i++) {
		                        	%>
		                        		<li class="inner-number"><a href="boardView.jsp?brdID=<%= brdID %>&pageNumber=<%= i %>"><%= i %></a></li>
		                        	<%
		                        		}
		                        	%>
		                        		<li class="inner-number"><a href="boardView.jsp?brdID=<%= brdID %>&pageNumber=<%= pageNumber %>"><%= pageNumber %></a></li>
		                        	<%
		                        		for (int i = pageNumber + 1; i <= targetPage + pageNumber; i++) {
		                        			if(i <startPage + 5) {
		                        	%>
		                                <li class="inner-number"><a href="boardView.jsp?brdID=<%= brdID %>&pageNumber=<%= i %>"><%= i %></a></li>
		                            <%			
		                        			}
		                        		}
		                        		if(pageNumber != targetPage + pageNumber)	{
		    						%>
		    							<li class="inner-number"><a href="boardView.jsp?brdID=<%= brdID %>&pageNumber=<%= pageNumber + 1 %>">&nbsp;&gt;</a></li>
		    						<%
		    							} else {
		    		                %>
		    	                        <li class="inner-number">&nbsp;&gt;</li>
		    	                    <%
		    	    					}
		                        		if(targetPage + pageNumber > startPage + 4) {
		                        	%>
		                                <li class="inner-number"><a href="boardView.jsp?brdID=<%= brdID %>&pageNumber=<%= startPage + 5 %>">&nbsp;&gt;&gt;</a></li>
		                            <%	
		                        		} else {
		                        	%>
		                        		<li class="inner-number">&nbsp;&gt;&gt;</li>
		                        	<%
		                        		}
		                        	%>
								</ul>
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