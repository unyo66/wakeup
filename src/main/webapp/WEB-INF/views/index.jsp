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
    <link rel="stylesheet" href="./css/common.css">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <title>Wakeup!</title>
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
        .click_box, .chart_box, .text_box
        {
            width: 70vw;
            height: 70vw;
            position: absolute;
            top: 30vw;
            left: 50%;
            transform: translateX(-50%);
            border: 1px solid;
        }
        .text_box
        {
            opacity: 0;
        }
        .click_box
        {
            opacity: 0;
            z-index: 99;
        }
        .chart
        {
            display:inline-block;
            position: absolute;
            width: 100%;
            height: 100%;
            border-radius: 50%;
        }

        .ch1 {background: conic-gradient(#8b22ff 0% 25%, transparent 25% 100%);}
        .ch2 {background: conic-gradient(transparent 0% 25%, #ffc33b 25% 56%, transparent 56% 100%);}
        .ch3 {background: conic-gradient(transparent 0% 56%, #21f3d6 56% 100%);}

        .ch_center
        {
            position:absolute;
            width: 70%;
            height: 70%;
            background :#fff;
            border-radius: 50%;
            top: 50%;
            left:50%;
            transform: translate(-50%, -50%);
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .text_box
        {
            display: flex;
            flex-direction: column;
            justify-content: space-evenly;
            align-items: center;
        }
        .name, .ch_center
        {
            font-weight: 800;
            font-size: 5vw;
        }
        .money_sum, .money_once
        {
            font-size: 3vw;
        }
        .button_box
        {
            position: absolute;
            top: 110vw;
            left: 50%;
            transform: translateX(-50%);
        }
        button
        {
            width: 15vw;
            height: 6vw;
        }
    </style>
</head>
<body>
<div class="wrap">
    <div class="title">오늘은 누구?</div>
    <div class="click_box"></div>
    <div class="chart_box">
        <div class="chart ch1"></div>
        <div class="chart ch2"></div>
        <div class="chart ch3"></div>
        <div class="ch_center">251,000</div>
    </div>
    <div class="text_box">
        <div class="person p1">
            <div class="name"></div>
            <div class="money_sum"></div>
            <div class="money_once"></div>
        </div>
        <div class="person p2">
            <div class="name"></div>
            <div class="money_sum"></div>
            <div class="money_once"></div>
        </div>
        <div class="person p3">
            <div class="name"></div>
            <div class="money_sum"></div>
            <div class="money_once"></div>
        </div>
    </div>
    <div class="button_box">
    </div>
</div>


<script>
    let idx = `${setting_user_idx}`.split(",");
    let name = `${setting_user_name}`.split(",");
    let recordIdx = `${user_idx}`.split(",");
    let recordDate = `${event_date}`.split(",");
    let strCount = `${count}`.split(",");
    console.log(idx);
    let count = new Array(idx.length);
    for (let i = 0; i < idx.length; i++) {
        count[i] = Number(strCount[i]);
    }
    let color = `${setting_user_color}`.split(",");


    let money = Number(`${setting_money}`);
    let levelup_count = Number(`${setting_count}`);

    //////////////////////화면 초기 세팅 메서드//////////////////////////////////////////////////////////////////
    function setScreen() {
        for (let i = 0; i < count.length; i++) {
            //이름에 색 텍스트 넣기
            document.getElementsByClassName("name")[i].style = "color : " + color[i];
            document.getElementsByClassName("name")[i].innerText = name[i];
            //버튼 달기
            document.getElementsByClassName("button_box")[0].innerHTML += `<button>` + name[i] + `</button>`;
        }
        let op_index = 1;
        $(".click_box").click(function(){
            if (op_index == 1) {
                $(".chart_box").animate({
                    opacity: 0
                }, 200)
                $(".text_box").animate({
                    opacity: 1
                }, 200)
            }
            else {
                $(".text_box").animate({
                    opacity: 0
                }, 200)
                $(".chart_box").animate({
                    opacity: 1
                }, 200)
            }
            op_index *= -1;
        })
    }
    setScreen();
    //////////////////////화면 적용 메서드//////////////////////////////////////////////////////////////////
    function applyScreen() {
        let sum = new Array(count.length);
        let total = 0;
        for (let i = 0; i < count.length; i++) {
            //인당 합계 구하기
            sum[i] = 0;
            for (let j = 1; j <= count[i]; j++) {
                if (j % levelup_count == 0 && j != 0) {
                    sum[i] += money * (Math.floor(j / levelup_count));
                }
                else {
                    sum[i] += money * (Math.floor(j / levelup_count) + 1);
                }
            }
            //총 합계 구하기
            total += sum[i];
            //금액 넣기
            document.getElementsByClassName("money_once")[i].innerText = "회당 벌금 : " + (money * (Math.floor(count[i] / levelup_count) + 1)).toLocaleString("ko-KR") + "원 (승급까지 " + (levelup_count - count[i] % levelup_count) + "회)";
            document.getElementsByClassName("money_sum")[i].innerText = "누적 벌금 : " + sum[i].toLocaleString("ko-KR") + "원 (누적 " + count[i] + "회)";
        }
        //기여 비율 구하기
        let rate = new Array(count.length);
        for (let i = 0; i < count.length; i++) {
            rate[i] = sum[i] / total * 100;
            for (let j = 0; j < i; j++) {
                rate[i] += rate[j];
            }
            rate[i] = Math.round(rate[i]);
            if (count[i + 1] == null) {
                rate[i] = 100;
            }
        }
        //차트 스타일 바꾸기
        let chart_style = new Array(count.length);
        for (let i = 0; i < count.length; i++) {
            //스트링배열에 +로 담을거라 초기화 안하면 undefined 들어감
            chart_style[i] = "";
            for (let j = 0; j < count.length; j++) {
                //스타일 3개 * 3종
                chart_style[i] += (i == j ? color[i] + " " : "transparent ") + (j == 0 ? 0 : rate[j - 1]) + "% " + rate[j] + "%";
                if (count[j + 1] != null) {
                    chart_style[i] += ", ";
                }
            }
            document.getElementsByClassName("chart")[i].style = "background: conic-gradient(" + chart_style[i] + ")"
        }
        //토탈 금액 표시
        $(".ch_center").text(total.toLocaleString("ko-KR"));
    }
    applyScreen();

    //버튼에 ajax 달기
    let btn = $("button");
    for (let i = 0; i < idx.length; i++) {
        let dateFlag = 0;
        btn.eq(i).click(function (){
            let dt = new Date();
            let tmpDate = dt.getFullYear() + "-" + (dt.getMonth() + 1) + "-" + dt.getDate();
            for (let j = 0; j < recordDate.length; j++) {
                // console.log("tmpDate : " + tmpDate);
                // console.log("recordDate : " + recordDate[j]);
                // console.log("inputIdx : " + idx[i]);
                // console.log("recordIdx : " + recordIdx[j]);
                if (tmpDate == recordDate[j]) {
                    if (idx[i] == recordIdx[j]) {
                        dateFlag++;
                        alert("클릭은 하루에 한 번");
                        break;
                    }
                }
                // console.log("flag : " + dateFlag);
            }
            if (dateFlag == 0) {
                let tmpInput = {"user_idx":idx[i], "event_date":tmpDate};
               $.ajax({
                   type:'POST',
                   url:'/sendEvent',
                   headers : { "content-type": "application/json"},
                   dataType : 'text',
                   data : JSON.stringify(tmpInput),
                   success : function(result){
                       // console.log(result);
                       recordDate.push(tmpDate);
                       recordIdx.push(idx[i]);
                       count[i] += 1;
                       // console.log(count[i]);
                       applyScreen();
                   },
                   error   : function(){
                       alert("error")
                   }
               }); //ajax
            }
        });
    }
    $(".title").click(function (){
        location.href = "/admin";
    })
</script>
</body>

</html>