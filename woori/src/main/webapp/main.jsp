<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="board.BoardDAO" %>
<%@ page import="board.Board" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
    <head>
        <title>우리 동네 커뮤니케이션</title>
        <meta name="viewport" content="user-scalable=no, initial-scale=1,maximum-scale=1">
        <!-- 초기화 -->
        <style>
            * {
                margin: 0; padding: 0;
                font-family: '빙그레체' , 'Malgun Gothic' , Gothic, sans-serif;
            }
           
            a { text-decoration: none; }
            li { list-style: none; }
        </style>
        <!-- 기본 페이지 구성 -->
        <style>
            .pull-left { float: left; }
            body {
                width: 1500px; margin: 0 auto;
                background-image: url('snowfall.jpg');
                background-size: 100%;
                background-repeat: no-repeat;
                background-attachment: fixed;
            }
            #page-wrapper {
                background-color: white;
                margin: 40px 0; padding: 10px 20px;
            }
        </style>
        <!-- 헤더(타이틀) 구성 -->
        <style>
            #main-header {
                padding: 80px 0;
            }
            .main-title {
                font-size: 50px;
                color:  rgb(138, 111, 111);
                text-align: center;
                text-shadow: 3px 3px 1px rgb(194, 157, 157);
            }
        </style>
        <!-- 내비게이션 및 풀다운 메뉴 구성  -->
        <style>
            #main-navigation {
                border-top: 1px solid rgb(165, 150, 150);
                border-bottom: 1px solid rgb(165, 150, 150);
                margin-bottom: 20px;
                height: 40px;
            }
            .outer-menu-item {
                float: left;
                position: relative;
            }
            .outer-menu-item:hover {
                background-color:  rgb(138, 111, 111);
                color: white;
            }
            .menu-title {
                display: block;
                height: 30px; line-height: 30px;
                text-align: center;
                padding: 5px 20px;
                cursor: pointer;
            }
            .inner-menu {
                display: none;
                position: absolute;
                top: 40px; left: 0;
                width: 180%;
                background-color: white;
                box-shadow: 0 2px 6px rgba(5, 5, 5, 0.9);
                z-index: 1000;
            }
            .inner-menu-item > a {
                display: block;
                padding: 5px 10px;
                color: black;
            }
            .inner-menu-item > a:hover {
                background-color: rgb(138, 111, 111);
                color: white;
            }
            .menu-title > a {
                color: black;
            }
        </style>
        <!-- 본문 -->
        <style>
            #content { overflow: hidden; }
            #main-aside {
                width: 300px;
                float: left;
            }
            article>div {
                overflow: hidden;
            }
        <!-- 본문 포스트 위쪽 내용  -->
        <style>
            article {
                margin: 0 10px 20px 100px;
                padding: 10px 0;
                border-bottom: 1px dashed rgb(138, 111, 111);
            }
			.article-header { padding: 10px 0; }
            .article-title {
                font-size: 25px;
                font-weight: 500;
                padding-bottom: 10px;
            }
        </style>
        <!-- 로그인  -->
        <style>
            .login {
                width: 300px; height: 150px;
                background-color: rgb(255, 255, 255);
                border: 1px solid rgb(138, 111, 111);
                margin: 5px; padding: 15px;
            }
            .login > h1 {
                text-align: center;
                font-weight: 500;
            }
            .login >a {
                text-align: center;
                font-size: 14px;
            }
			#submit {
                width: 55px;
                height: 45px;
                background: rgb(204, 180, 180);
                border: 1px solid rgb(158, 158, 158);
                cursor: pointer;
            }
            #submit:hover {
                color: white;
            }
            #join {
                color: black;
            }
            #join:hover {
                color: brown;
            }
            /* 반응형_스마트폰*/
            @media screen and (max-width:767px){
                body{ width: auto }
                #main-aside { width: auto; float: none;}
            }
        </style>
        <!-- 게시판 -->
        <style>
            #bulletinboard {
              width: 100%;
              border-top: 1px solid #9b9b9b;
              border-collapse: collapse;
            }
            .bbline {
              border-bottom: 1px solid #9b9b9b;
              padding: 10px;
              text-align: center;
            }
            #write {
                width:55px;
                height:35px;
                background:rgb(204, 180, 180);
                border:1px solid rgb(158, 158, 158);
                cursor: pointer;
            }
        </style>
        <script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
        <script>
            $(document).ready(function(){
                $('.outer-menu-item').hover(function() {
                    $(this).find('.inner-menu').show();
                }, function() {
                    $(this).find('.inner-menu').hide();
                });
            });
        </script>
        <!-- 게시판 페이징 -->
        <style>
            #menu {
                width: 300px;
                margin: 0 auto;
            }
            .number-menu {
                list-style: none;
                display: inline-block;
            }
            .inner-number {
                float: left;
            }
            .inner-number > a {
                margin: 3px;
                padding: 3px;
                border: 1px solid #9b9b9b;
                text-align: center;
                text-decoration:none;
                color: black;
            }
            .inner-number > a:hover {
                background:rgb(194, 157, 157);
                color: white;
            }

            #write:hover {
                color: white;
            }
        </style>
        <!-- 모임 -->
        <style>
            .meetingbb {
                width: 150px;
                margin: 5px;
                padding: 10px 30px 10px 30px;
                border: 2px solid #9b9b9b;
                border-radius: 10px;
            }
            .category {
                font-size: 15px;
                text-align: center;
            }
            .meeting_name {
                text-align: center;
            }
            .meeting_name > a {
                font-weight: 500;
                text-align: center;
                color: black;
            }
            .meeting_name>a:hover{
                color: rgb(133, 78, 78);
                font-weight: 600;
            }
            .meeting_info {
                font-size: 15px;
                text-align: center;
            }
        </style>
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
		%>
        <div id="page-wrapper">
            <header id="main-header">
                <hgroup>
                    <h1 class="main-title">우리 동네 커뮤니케이션</h1>
                </hgroup>
            </header>
            <nav id="main-navigation">
                <div class="pull-left">
                    <ul class="outer-menu">
                        <li class="outer-menu-item">
                            <span class="menu-title"><a href="#시게시판">게시판</a></span>
                        </li>
                        <li class="outer-menu-item">
                            <span class="menu-title">모임</span>
                            <ul class="inner-menu">
                                <li class="inner-menu-item"><a href="#내모임">내 모임</a></li>
                                <li class="inner-menu-item"><a href="#모임찾기">모임 찾기</a></li>
                            </ul>
                        </li>
                        <li class="outer-menu-item">
                            <span class="menu-title">문의/신고</span>
                            <ul class="inner-menu">
                                <li class="inner-menu-item"><a href="#자주묻는질문">자주 묻는 질문</a></li>
                                <li class="inner-menu-item"><a href="#문의하기">문의하기</a></li>
                                <li class="inner-menu-item"><a href="#신고하기">신고하기</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </nav>
            <aside id="main-aside">
            	<% 
					if(userID == null) {
				%>
                <div class="login">	
                    <h1>로그인</h1>
                    <br>
                    <table>
                    	<form method="post" action="loginAction.jsp">
                       		 <tr>
                         	   <td><label for="id">아이디</label></td>
                         	   <td><input id="id" type="text" name="userID"></td>
                         	   <td rowspan="2"><input id="submit"  type="submit" value="입력"></td>
                       		 </tr>
                       		 <tr>
                         	   <td><label for="password">비밀번호</label></td>
                         	   <td><input id="password" type="password" name="userPassword"></td>
                      		 </tr>
    	               	 	 <tr>
                          	 	 <td></td><td></td>
                          		  <td><br><a href=join.jsp style="font-size: 14px; text-align: right; text-decoration:none;" id="join">회원가입</a></td>
                      		 </tr>
                        </form>
                    </table>
                </div>
                <%		
					} else {
				%>
                <div class="loginout">	
                    <h1>로그아웃</h1>
                    <br>
                    <table>
                    	<td><br><a href=logoutAction.jsp style="font-size: 14px; text-align: right; text-decoration:none;" id="logout">로그아웃</a></td>
                    </table>
                </div>
                <%
					}
				%>
            </aside>
            <div id="content">
                <article>
                    <div class="article-header"  id="시게시판">
                        <h1 class="article-title">시 게시판</h1>
                        <table id="bulletinboard">
                                <tr>
                                    <td class="bbline">번호</td>
                                    <td class="bbline">제목</td>
                                    <td class="bbline">작성자</td>
                                    <td class="bbline">작성일</td>
                                    <td class="bbline">댓글수</td>
                                    <td class="bbline">조회수</td>
                                </tr>
                                <tr>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                </tr>
                                <tr>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                </tr>
                                <tr>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                </tr>
                                <tr>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                </tr>
                                <tr>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                </tr>
                                <tr>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                </tr>
                                <tr>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                </tr>
                                <tr>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                </tr>
                                <tr>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                </tr>
                                <tr>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                    <td class="bbline"></td>
                                </tr>
                            </table>
                        </div>
                        <div id="menu">
                            <ul class="number-menu">
                                <li class="inner-number"><a href="#">1</a></li>
                                <li class="inner-number"><a href="#">2</a></li>
                                <li class="inner-number"><a href="#">3</a></li>
                                <li class="inner-number"><a href="#">4</a></li>
                                <li class="inner-number"><a href="#">5</a></li>
                                <li class="inner-number"><a href="#">6</a></li>
                                <li class="inner-number"><a href="#">7</a></li>
                                <li class="inner-number"><a href="#">8</a></li>
                                <li class="inner-number"><a href="#">9</a></li>
                                <li class="inner-number"><a href="#">10</a></li>
                                <li class="inner-number"><a href="#">></a></li>
                            </ul>
                        </div>
                    	<div id="registration">
                            <input id="write"  type="button" value="글쓰기" onClick="location.href='write.jsp'">
                        </div>
                    </article>
                    <article>
                        <div class="article-header"  id="내모임">
                            <h1 class="article-title">내 모임</h1>
                        </div>
                       		<div class="meetingbb">
                                <ul class="meeting">
                                <li class="category"><img src="category.png" width="12")> 독서</li>
                                <li class="meeting_name"><a href="project_meeting.html">독서 모임</a></li>
                                <li class="meeting_info"><img src="leader.png" width="12")> 강수정
                                <img src="people.png" width="12")> 5명</li>
                                </ul>
                        </div>
                    </article>
                    <article>
                        <div class="article-header"  id="모임찾기">
                            <h1 class="article-title">모집중인 모임</h1>
                            <table id="category">
                                <tr>
                                    <td>카테고리 선택</td>
                                    <td>
                                    <select>
                                        <option>전체</option>
                                        <option>운동</option>
                                        <option>봉사활동</option>
                                        <option>게임</option>
                                        <option>문화/공연</option>
                                        <option>반려동물</option>
                                        <option>공예/만들기</option>
                                        <option>요리/제조</option>
                                        <option>공부/스터디</option>
                                        <option>음악/댄스</option>
                                        <option>사교</option>
                                        <option>여행</option>
                                        <option>독서</option>
                                        <option>자유</option>
                                    </select>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <div class="meetingbb">
                            <ul class="meeting">
                            <li class="category"><img src="category.png" width="12")> 독서</li>
                            <li class="meeting_name"><a href="project_meeting.html">독서 모임</a></li>
                            <li class="meeting_info"><img src="leader.png" width="12")> 강수정
                            <img src="people.png" width="12")> 5명</li>
                            </ul>
                        </div>
                    </article>
                    <article>
                        <div class="article-header"  id="자주묻는질문">
                            <h1 class="article-title">자주 묻는 질문</h1>
                        </div>
                    </article>
                    <article>
                        <div class="article-header"  id="문의하기">
                            <h1 class="article-title">문의하기</h1>
                        </div>
                    </article>
                    <article>
                        <div class="article-header"  id="신고하기">
                            <h1 class="article-title">신고하기</h1>
                        </div>
                    </article>
               </div>
            <footer id="main-footer">
                <a href="#"></a>
            </footer>
        </div>
    </body>
</html>