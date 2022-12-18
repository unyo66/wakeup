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
        .wrap
        {
            position: relative;
            margin-top: 15vw;
        }
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
            top: 5vw;
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
            height: 10vw;
            border-bottom: 1px solid #eee;
            display: flex;
            align-items: center;
            justify-content: space-evenly;
        }
        .set_user
        {
            width: 30%;
            font-size: 16px;
            outline: none;
            border: none;
        }
        .set_user_color
        {
            width: 30%;
            overflow: hidden;
            box-sizing: border-box;
            margin-right: 1px;
            border-right: 1px solid;
        }
        .add_user
        {
            width: 7vw;
            height: 7vw;
            text-align: center;
            line-height: 7vw;
            float: right;
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
    <div class="title">기록</div>
    <img src="../img/setting.png" alt="" class="setting_button">
    <div class="admin_record_box">
    </div>
    <div class="admin_setting_box display">
        <div class="setting_box">
            <div class="user_box">
            </div>
        </div>
<%--        <div class="add_user">+</div>--%>
    </div>
    <div class="admin_setting_box display">
        <div class="setting_box">
            <div class="set_money">
                <div style="width: 50%;">회당 벌금</div>
                <input type="text" name="" id="money" value="${setting_money}">
                <div class="setting_submit">확인</div>
            </div>
            <div class="set_count">
                <div  style="width: 50%;">레벨업 필요 횟수</div>
                <input type="text" name="" id="count" value="${setting_count}">
                <div class="setting_submit">확인</div>
            </div>
            <div class="set_init">
                초기화
            </div>
        </div>
    </div>
</div>
<script>
    let idx = `${setting_user_idx}`.split(",");
    let name = `${setting_user_name}`.split(",");
    let recordIdx = `${user_idx}`.split(",");
    let recordDate = `${event_date}`.split(",");
    let strCount = `${count}`.split(",");
    let recordName = new Array(idx.length);
    for (let i = 0; i < recordIdx.length; i++) {
        for (let j = 0; j < idx.length; j++) {
            if (recordIdx[i] == idx [j]) {
                recordName[i] = name[j];
            }
        }
    }
    console.log(recordName);
    console.log(idx);
    let count = new Array(idx.length);
    for (let i = 0; i < idx.length; i++) {
        count[i] = Number(strCount[i]);
    }
    let color = `${setting_user_color}`.split(",");
    let money = Number(`${setting_money}`);
    let levelup_count = Number(`${setting_count}`);
    console.log(money + " " +  levelup_count)
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
    let tmpRecord = "";
    for (let i = 0; i < recordDate.length; i++) {
        tmpRecord += `<div class="record_box">
                            <div class="record_date">` + recordDate[i] + `</div>
                            <div class="record_name">` + recordName[i] + `</div>
                        </div>`;
    }
    $(".admin_record_box").html(tmpRecord);
    for (let i = 0; i < recordDate.length; i++) {
        for (let j = 0; j < color.length; j++) {
            if (recordIdx[i] == idx[j]) {
                $(".record_name").eq(i).css({
                    color: color[j]
                })
                $(".record_date").eq(i).css({
                    color: color[j]
                })
            }
        }
    }
    //////////////////////////////설정1//////////////////////////////
    function set_user(add){
        let tmpUser = "";
        for (let i = 0; i < idx.length; i++) {
            tmpUser += `<div class="user_box">
                    <input type="text" name="" class="set_user user` + idx[i] + `" value=` + name[i] + `>
                    <div class="set_user_color">
                        <input class="color-picker" value=` + color[i] + ` />
                    </div>
                    <div class="submit">확인</div>
                </div>`;
        }
        if (add) {
            tmpUser += `<div class="user_box">
                    <input type="text" name="" class="set_user user` + (idx.length + 1) + `" value="" placeholder="새로운 유저"/>
                    <div class="set_user_color">
                        <input class="color-picker" value="#eeeeee"/>
                    </div>
                    <div class="submit">확인</div>
                </div>`;
        }
        $(".setting_box").eq(0).html(tmpUser);
        $('.color-picker').spectrum({
            type: "text"
        });
        for (let i = 0; i < $(".user_box").length; i++) {
            $(".user_box").eq(i).children(".submit").click(function () {
                let tmpIdx = $(this).parent().children(".set_user").attr("class")[13];
                let tmpName = $(this).parent().children(".set_user").val();
                let tmpColor = $(this).parent().find(".color-picker").val();
                let tmpSendUser = {"user_idx": tmpIdx, "user_name": tmpName, "user_color": tmpColor};
                console.log(tmpSendUser);


                $.ajax({
                    type: 'POST',
                    url: '/sendUser',
                    headers: {"content-type": "application/json"},
                    dataType: 'text',
                    data: JSON.stringify(tmpSendUser),
                    success: function (result) {
                        alert(name[i] + " ➞ " + tmpName + "\n" + color[i] + " ➞ " + tmpColor)
                    },
                    error: function () {
                        alert("error")
                    }
                }); //ajax
            })
        }
    }
    set_user(false);
    $(".add_user").click(function () {
        set_user(true);
    })
//////////////////////////////설정2//////////////////////////////
    function sendSetting(map) {
        $.ajax({
            type:'POST',
            url:'/sendSetting',
            headers : { "content-type": "application/json"},
            dataType : 'text',
            data : JSON.stringify(map),
            success : function(result){
                alert("변경 완료");
            },
            error   : function(){
                alert("error")
            }
        }); //ajax
    }
        $(".setting_submit").click(function () {
            if (confirm("설정 변경?")) {
                let tmpMoney = $("#money").val();
                let tmpCount = $("#count").val();
                let tmpSendSetting = {"money_per":tmpMoney, "levelup_count":tmpCount};
                sendSetting(tmpSendSetting);
            }
        })







    $(".setting_button").click(function(){
        if (n == 0) {
            $(this).animate({
                rotate: "90deg"
            }, 500)
            $(".title").text("유저 설정");
        }
        else if (n == 1) {
            $(this).animate({
                rotate: "180deg"
            }, 500)
            $(".title").text("기타 설정");
        }
        else if (n == 2) {
            $(this).animate({
                rotate: "0deg"
            }, 700)
            $(".title").text("기록");
        }
        changeDisplay();
    })
    $(".title").click(function (){
        location.href = "/";
    })
</script>
</body>
</html>