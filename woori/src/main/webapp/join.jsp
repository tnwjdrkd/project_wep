<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="kr">
    <head>
        <meta name="viewport" content="user-scalable=no, initial-scale=1,maximum-scale=1">
        <title>우리 동네 커뮤니케이션 회원가입</title>
        <style>
            * {
                font-family: '빙그레체' , 'Malgun Gothic' , Gothic, sans-serif;
            }

            h1 {text-align: center;}
            p {text-align: center;}
            #result {
                width: 100%;
                border: 1px solid #444444;
                border-collapse: collapse;
                text-align: center;
            }
            h3{text-align: right;}
        </style>
    </head>
    <body>
        <h1>우리 동네 커뮤니케이션</h1>
        <fieldset>
            <legend>회원가입</legend>
            <form action='project_userinfo.js' method='post'>
                <table>
                    <tr>
                        <td><label for="id">아이디 </label></td>
                        <td><input id="id" type="text" name="id"></td>
                    </tr>
                    <tr>
                        <td><label for="password">비밀번호</label></td>
                        <td><input id="password" type="password" name="pw"></td>
                    </tr>
                    <tr>
                        <td><label for="name">이름</label></td>
                        <td><input id="name" type="text" name="name"></td>
                    </tr>
                    <tr>
                        <td><label for="birth">생년월일</label></td>
                        <td><input id="birth" type="text" name="birth"></td>
                    </tr>
                    <tr>
                        <td><label for="phonenum">휴대전화번호</label></td>
                        <td><input id="phonenum" type="text" name="phonenum"></td>
                    </tr>
                    <tr>
                        <td><label for="address">주소</label></td>
                        <td><input id="address" type="text" name="address"></td>
                    </tr>
                    <tr>
                        <td><label for="nickname">닉네임</label></td>
                        <td><input id="nickname" type="text" name="nickname"></td>
                    </tr>
                    <tr>
                        <td colspan="2"><br><input type="submit"  style="width:275px; height:45px;" value="가입하기"></td>
                        <td></td>
                    </tr>
                </table>
            </form>
        </fieldset>