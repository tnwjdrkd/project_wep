<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
        <!-- 기본 클래스 -->
        <style>
            .pull-left { float: left; }
        </style>
         <!-- 페이지 구성 -->
        <style>
            body {
                width: 1500px; margin: 0 auto;
            }
            #page-wrapper {
                background-color: white;
                padding: 10px 20px;
            }
        </style>
        <!-- 헤더 구성 -->
        <style>
            #main-header {
                padding: 70px 50px;
            }
            .master-title {
                font-size: 50px;
                color:  rgb(138, 111, 111);
                text-align: center;
                text-shadow: 3px 3px 1px rgb(194, 157, 157);
            }
            .master-description {
                font-size: 15px; font-weight: 500;
                color: rgb(138, 111, 111);
                text-align: right;
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
        </style>
        <!-- 본문 내용 -->
        <style>
            #content { overflow: hidden; }
            #main-aside {
                width: 300px;
                float: left;
            }
            #main-section {
                width: 710px;
                float: right;
            }
            article>div {
                overflow: hidden;
            }
            img {
                padding-right: 10px;
                float: left;
            }
            .textthin {
                color: rgb(97, 97, 97);
                font-size: 15px; font-weight: 500;
            }
        </style>
        <!-- 본문 포스트 위쪽 내용  -->
        <style>
            article {
                padding: 0 10px 20px 10px;
                border-bottom: 1px solid rgb(138, 111, 111);
            }

            .article-header {padding: 20px 0;}
            .article-title {
                font-size: 25px;
                font-weight: 500;
                padding-bottom: 10px;
            }
            .article-date { font-size: 13px; }
            .article-body{
                font-size: 14px;
            }
        </style>
        <!-- 로그인 메뉴  -->
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

            /* 반응형_스마트폰*/
            @media screen and (max-width:767px){
                body{ width: auto }
                #main-aside { width: auto; float: none;}
                #main-section  { width: auto; float: none;}
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
    </head>
    <body>
        <div id="page-wrapper">
            <header id="main-header">
                <hgroup>
                    <h1 class="master-title">우리 동네 커뮤니케이션</h1>
                </hgroup>
            </header>
            <nav id="main-navigation">
                <div class="pull-left">
                    <ul class="outer-menu">
                        <li class="outer-menu-item">
                            <span class="menu-title">게시판</span>
                            <ul class="inner-menu">
                                <li class="inner-menu-item"><a href="#시게시판">시 게시판</a></li>
                                <li class="inner-menu-item"><a href="#구게시판">구 게시판</a></li>
                                <li class="inner-menu-item"><a href="#동게시판">동 게시판</a></li>
                            </ul>
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
                <div class="login">
                    <h1>로그인</h1>
                    <br>
                    <table>
                    	<form method="post" action="loginAction.jsp">
                       		 <tr>
                         	   <td><label for="id">아이디</label></td>
                         	   <td><input id="id" type="text" name="userID"></td>
                         	   <td rowspan="2"><input id="submit"  style="width:55px; height:45px; background:rgb(204, 180, 180)" type="submit" value="입력"></td>
                       		 </tr>
                       		 <tr>
                         	   <td><label for="password">비밀번호</label></td>
                         	   <td><input id="password" type="password" name="userPassword"></td>
                      		 </tr>
    	               	 	  <tr>
                          	 	 <td></td><td></td>
                          		  <td><br><a href=join.jsp style="font-size: 14px; text-align: right; text-decoration:none;">회원가입</a></td>
                      		  </tr>
                        </form>
                    </table>
                </div>
            </aside>
            <div id="content">
                <section id="main-section">
                    <article>
                        <div class="article-header"  id="시게시판">
                            <h1 class="article-title">시 게시판</h1>
                        </div>
                    </article>
                    <article>
                        <div class="article-header"  id="구게시판">
                            <h1 class="article-title">구 게시판</h1>
                        </div>
                    </article>
                    <article>
                        <div class="article-header"  id="동게시판">
                            <h1 class="article-title">동 게시판</h1>
                        </div>
                    </article>
                    <article>
                        <div class="article-header"  id="내모임">
                            <h1 class="article-title">내 모임</h1>
                        </div>
                    </article>
                    <article>
                        <div class="article-header"  id="모임찾기">
                            <h1 class="article-title">모임찾기</h1>
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
                </section>
            </div>
            <footer id="main-footer">
                <a href="#"></a>
            </footer>
        </div>
    </body>
</html>