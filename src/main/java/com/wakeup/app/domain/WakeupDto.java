package com.wakeup.app.domain;


import java.sql.Date;

public class WakeupDto {
    private int user_idx;
    private String user_name;
    private String user_color;
    private String event_date;
    private int money_per;
    private int levelup_count;


    @Override
    public String toString() {
        return "WakeupDto{" +
                "user_idx=" + user_idx +
                ", user_color='" + user_color + '\'' +
                ", event_date=" + event_date +
                ", money_per=" + money_per +
                ", levelup_count=" + levelup_count +
                '}';
    }

    public int getUser_idx() {
        return user_idx;
    }

    public void setUser_idx(int user_idx) {
        this.user_idx = user_idx;
    }

    public String getUser_name() {
        return user_name;
    }

    public void setUser_name(String user_name) {
        this.user_name = user_name;
    }

    public String getUser_color() {
        return user_color;
    }

    public void setUser_color(String user_color) {
        this.user_color = user_color;
    }

    public String getEvent_date() {
        return event_date;
    }

    public void setEvent_date(String event_date) {
        this.event_date = event_date;
    }

    public int getMoney_per() {
        return money_per;
    }

    public void setMoney_per(int money_per) {
        this.money_per = money_per;
    }

    public int getLevelup_count() {
        return levelup_count;
    }

    public void setLevelup_count(int levelup_count) {
        this.levelup_count = levelup_count;
    }
}