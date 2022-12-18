package com.wakeup.app.controller;

import com.wakeup.app.dao.WakeupDao;
import com.wakeup.app.domain.WakeupDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.sql.Array;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
public class MainController {
    @Autowired
    WakeupDao wakeupDao;

    @GetMapping("/")
    public String Main(Model m) throws Exception {
        String user_idx = "";
        String event_date = "";
        List<WakeupDto> mainList = wakeupDao.selectRecord();
        for (int i = 0; i < mainList.size(); i++) {
            user_idx += mainList.get(i).getUser_idx();
            if (i != mainList.size() - 1) {user_idx += ",";};
            event_date += mainList.get(i).getEvent_date();
            if (i != mainList.size() - 1) {event_date += ",";};
        }

        String setting_user_idx = "";
        String setting_user_name = "";
        String setting_user_color = "";
        List<WakeupDto> userList = wakeupDao.selectUser();

        for (int i = 0; i < userList.size(); i++) {
            setting_user_idx += userList.get(i).getUser_idx();
            if (i != userList.size() - 1){setting_user_idx += ",";};
            setting_user_name += userList.get(i).getUser_name();
            if (i != userList.size() - 1){setting_user_name += ",";};
            setting_user_color += userList.get(i).getUser_color();
            if (i != userList.size() - 1){setting_user_color += ",";};
        }
        String count = "";
        int tmpCount;
        for (int i = 0; i < userList.size(); i++) {
            tmpCount = 0;
            for (int j = 0; j < mainList.size(); j++) {
                if (mainList.get(j).getUser_idx() == userList.get(i).getUser_idx()) {
                    tmpCount++;
                }
            }
            count += tmpCount + ",";
        }
        System.out.println(count);

        List<WakeupDto> settingList = wakeupDao.selectSetting();

        m.addAttribute("user_idx", user_idx);
        m.addAttribute("event_date", event_date);
        m.addAttribute("setting_user_idx",setting_user_idx);
        m.addAttribute("setting_user_name", setting_user_name);
        m.addAttribute("setting_user_color", setting_user_color);
        m.addAttribute("count", count);
        m.addAttribute("setting_money", settingList.get(0).getMoney_per());
        m.addAttribute("setting_count", settingList.get(0).getLevelup_count());
        return "index";
    }

    @PostMapping({"/sendEvent"})
    @ResponseBody
    public int sendEvent(@RequestBody Map map) {
        return wakeupDao.insertEvent(map);
    }


    @GetMapping("/admin")
    public String admin(Model m) {
        String user_idx = "";
        String event_date = "";
        List<WakeupDto> mainList = wakeupDao.selectRecord();
        for (int i = 0; i < mainList.size(); i++) {
            user_idx += mainList.get(i).getUser_idx();
            if (i != mainList.size() - 1) {user_idx += ",";};
            event_date += mainList.get(i).getEvent_date();
            if (i != mainList.size() - 1) {event_date += ",";};
        }

        String setting_user_idx = "";
        String setting_user_name = "";
        String setting_user_color = "";
        List<WakeupDto> userList = wakeupDao.selectUser();

        for (int i = 0; i < userList.size(); i++) {
            setting_user_idx += userList.get(i).getUser_idx();
            if (i != userList.size() - 1){setting_user_idx += ",";};
            setting_user_name += userList.get(i).getUser_name();
            if (i != userList.size() - 1){setting_user_name += ",";};
            setting_user_color += userList.get(i).getUser_color();
            if (i != userList.size() - 1){setting_user_color += ",";};
        }
        String count = "";
        int tmpCount;
        for (int i = 0; i < userList.size(); i++) {
            tmpCount = 0;
            for (int j = 0; j < mainList.size(); j++) {
                if (mainList.get(j).getUser_idx() == userList.get(i).getUser_idx()) {
                    tmpCount++;
                }
            }
            count += tmpCount + ",";
        }
        System.out.println(count);

        List<WakeupDto> settingList = wakeupDao.selectSetting();
        m.addAttribute("user_idx", user_idx);
        m.addAttribute("event_date", event_date);
        m.addAttribute("setting_user_idx",setting_user_idx);
        m.addAttribute("setting_user_name", setting_user_name);
        m.addAttribute("setting_user_color", setting_user_color);
        m.addAttribute("count", count);
        m.addAttribute("setting_money", settingList.get(0).getMoney_per());
        m.addAttribute("setting_count", settingList.get(0).getLevelup_count());
        return "admin";
    }

    @PostMapping("/sendUser")
    @ResponseBody
    public int updateUser(@RequestBody Map map) {
        System.out.println(map);
        return wakeupDao.updateUser(map);
    }

    @PostMapping("/sendSetting")
    @ResponseBody
    public int sendSetting(@RequestBody Map map) {
        return wakeupDao.updateSetting(map);
    }
}
