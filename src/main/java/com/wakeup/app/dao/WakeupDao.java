package com.wakeup.app.dao;

import com.wakeup.app.domain.WakeupDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
public class WakeupDao {
    @Autowired
    SqlSession session;
    private static String namespace = "com.wakeup.app.dao.WakeupMapper.";

    public List<WakeupDto> selectRecord() {
        return session.selectList(namespace+"selectRecord");
    }
    public List<WakeupDto> selectUser() {
        return session.selectList(namespace+"selectUser");
    }
    public List<WakeupDto> selectSetting() {
        return session.selectList(namespace+"selectSetting");
    }

    public int insertEvent(Map map) {
        return session.insert(namespace+"insertRecord", map);
    }
    public int updateUser(Map map) {
        return session.update(namespace+"updateUser", map);
    }

    public int updateSetting(Map map) {
        return session.update(namespace+"updateSetting", map);
    }

}