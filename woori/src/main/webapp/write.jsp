<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <title>게시글 작성</title>
    <meta name="viewport" content="user-scalable=no, initial-scale=1,maximum-scale=1">
    <style>
        * {
            font-family: '빙그레체' , 'Malgun Gothic' , Gothic, sans-serif;
        }
        #writemenu {
            width: 500px; margin: 0 auto;
        }
        h1{
            color:  rgb(138, 111, 111);
            text-align: center;
            text-shadow: 2px 2px 1px rgb(194, 157, 157);
        }
        #submit {
            cursor: pointer;
            background:rgb(204, 180, 180);
            border:1px solid rgb(158, 158, 158);
            border-radius: 3px;
            font-size: 15px;
        }
        #submit:hover{
            color:white;
        }
        #submitbtn{
            width: 100px; margin: 0 auto;
        }
        /* 반응형_스마트폰*/
        @media screen and (max-width:767px){
        body{ width: auto }
        }
    </style>
</head>
<body>
    <div id="writemenu">
        <h1>게시글 작성</h1>
        <form method="post" action="writeAction.jsp">
            <table id="bbwrite">
                <tr>
                    <td><label for="title">제목</label></td>
                    <td><input id="title" type="text" name="brdTitle" style="width:400px;" autofocus="autofocus"></td>
                </tr>
                <tr>
                    <td><label for="content">내용</label></td>
                    <td><textarea id="content" type="text" name="brdContent" style="width:400px;  height:400px;"></textarea></td>
                </tr>
            </table>
            <br>
            <div id="submitbtn">
        	<input id="submit" type="submit" name="submit" style="width:100px;" value="등록">
    		</div>
        </form>
    </div>
</body>