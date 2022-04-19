<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<head>
    <title>���� �߰��ϱ�</title>
    <meta name="viewport" content="user-scalable=no, initial-scale=1,maximum-scale=1">
    <style>
        * {
            font-family: '���׷�ü' , 'Malgun Gothic' , Gothic, sans-serif;
        }
        #Rmeeting {
            width: 470px; margin: 0 auto;
        }
        h1{
            color: #8b60be;
            text-align: center;
            text-shadow: 3px 3px 1px #C996CC;
        }
        #submit {
            cursor: pointer;
            border: 1px solid #d5a0e6;
            background: #d5a0e6;
            width:100px;
            font-size: 15px;
        }
        #submit:hover{
            color: white;
        }
        #submit_btn{
            width: 100px; margin: 0 auto;}
        td{
            width: 40px;
            height: 10px;
        }
        td>input{
            width:400px;
        }
    /* ������_����Ʈ��*/
        @media screen and (max-width:767px){
        body{ width: auto }
        }
    </style>
</head>
<body>
    <div id="Rmeeting">
        <h1>���� �߰��ϱ�</h1>
        <form>
            <table id="add_Rmeeting">
                <tr>
                    <td><label for="date">��¥</label></td>
                    <td><input id="date" type="date" name="date"></td>
                </tr>
                <tr>
                    <td><label for="time">�ð�</label></td>
                    <td><input id="time" type="time" name="time"></td>
                </tr>
                <tr>
                    <td><label for="place" style="text-align: right;">���</label></td>
                    <td><input id="place" type="text" name="place" placeholder="�ڼ��� �Է����ּ���." onfocus="this.placeholder=''" onblur="this.placeholder='�ڼ��� �Է����ּ���.'"></td>
                </tr>
                <tr>
                    <td><label for="cost">���</label></td>
                    <td><input id="cost" type="text" name="cost"></td>
                </tr>
            </table>
        </form>
    </div>
    <br>
    <div id="submit_btn">
        <input id="submit" type="submit" name="submit" value="���">
    </div>
</body> 