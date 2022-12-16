<%--
  Created by IntelliJ IDEA.
  User: opre6
  Date: 2022-12-01
  Time: 오후 2:08
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Wake Up!</title>
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/spectrum-colorpicker2/dist/spectrum.min.js"></script>
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/spectrum-colorpicker2/dist/spectrum.min.css">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic+Coding:wght@400;700&display=swap');
        .title
        {
            padding-top: 10vw;
            text-align: center;
            font-size: 7vw;
        }
        .setting_button
        {
            width: 8vw;
            height: 8vw;
            position: absolute;
            top: 6.8vw;
            right: 17vw;
            padding: 5vw;
            /* transform: rotateZ(170deg); */
        }
        .display
        {
            /* opacity: 0; */
            display: none;
        }
        .admin_record_box, .admin_setting_box
        {
            width: 70vw;
            max-height: 100vw;
            position: absolute;
            top: 30vw;
            left: 50%;
            transform: translateX(-50%);
            border: 1px solid;
            overflow: scroll;
            transition: all 0.5s;
        }
        .record_box
        {
            display: flex;
            text-align: center;
            border-bottom: 1px solid #eee;
        }
        .record_date
        {
            width: 60%;
            border-right: 1px solid #eee;
        }
        .record_name
        {
            width: 38%;
        }
        .setting_box
        {
            width: 99%;
            margin: 0 auto;
        }
        .user_box
        {
            width: 100%;
            height: 7vw;
            border-bottom: 1px solid #eee;
            display: flex;
            align-items: center;
            justify-content: space-evenly;
        }
        .set_user, .delete_user
        {
            border-right: 1px solid #eee;
            box-sizing: border-box;
            text-align: center;
        }
        .set_user_color
        {
            width: 24%;
            overflow: hidden;
            box-sizing: border-box;
            margin-right: 1px;
        }

        .set_money, .set_count, .set_init
        {
            height: 7vw;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 5vw;
            border-bottom: 1px solid #eee;
        }
        .set_init
        {
            color: #f00;
        }
        #money, #count
        {
            width: 20%;
            outline: none;
            border: none;
        }
    </style>
</head>
<body>
<div class="wrap">
    <div class="title">그간의 기록들</div>
    <img src="./setting.png" alt="" class="setting_button">
    <div class="admin_record_box">
    </div>
    <div class="admin_setting_box display">
        <div class="setting_box">
            <div class="user_box">
                <div class="set_user">이고훈</div>
                <div class="set_user_color"></div>
                <div class="delete_user">삭제</div>
                <div class="add_user">추가</div>
            </div>
        </div>
    </div>
    <div class="admin_setting_box display">
        <div class="setting_box">
            <div class="set_money">
                <div style="width: 50%;">회당 벌금</div>
                <input type="text" name="" id="money" value="1000">
                <div class="submit">확인</div>
            </div>
            <div class="set_count">
                <div  style="width: 50%;">레벨업 필요 횟수</div>
                <input type="text" name="" id="count" value="10">
                <div class="submit">확인</div>
            </div>
            <div class="set_init">
                초기화
            </div>
        </div>
    </div>
</div>
<script>
    //////////////////////////////화면 전환//////////////////////////////
    let n = 0;
    function changeDisplay() {
        if (n == 0) {
            $(".admin_record_box").addClass("display");
            $(".admin_setting_box").eq(0).removeClass("display");
            n = 1;
        }
        else if (n == 1) {
            $(".admin_setting_box").eq(0).addClass("display");
            $(".admin_setting_box").eq(1).removeClass("display");
            n = 2;
        }
        else if (n == 2) {
            $(".admin_setting_box").eq(1).addClass("display");
            $(".admin_record_box").removeClass("display");
            n = 0;
        }
    }

    //////////////////////////////그간의 기록들//////////////////////////////
    let dateArr = ["2022-12-12","2022-12-12","2022-12-12","2022-12-12","2022-12-12"];
    let nameArr = ["이고훈","이고훈","이고훈","이고훈","이고훈"];
    let tmpRecord = "";
    for (let i = 0; i < dateArr.length; i++) {
        tmpRecord += `<div class="record_box">
                            <div class="record_date">${dateArr[i]}</div>
                            <div class="record_name">${nameArr[i]}</div>
                        </div>`;
    }
    $(".admin_record_box").html(tmpRecord);
    //////////////////////////////설정1//////////////////////////////
    $(".set_user_color").html(`<input id="color-picker" value='#276cb8' />`);
    $('#color-picker').spectrum({
        type: "text"
    });
    $(".setting_button").click(function(){
        if (n == 0) {
            $(this).animate({
                rotate: "90deg"
            }, 500)
            $(".title").text("설정1");
        }
        else if (n == 1) {
            $(this).animate({
                rotate: "180deg"
            }, 500)
            $(".title").text("설정2");
        }
        else if (n == 2) {
            $(this).animate({
                rotate: "0deg"
            }, 700)
            $(".title").text("그간의 기록들");
        }
        changeDisplay();
    })
</script>
</body>
</html>