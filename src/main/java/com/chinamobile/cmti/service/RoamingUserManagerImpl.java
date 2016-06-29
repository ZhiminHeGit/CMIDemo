package com.chinamobile.cmti.service;

import com.chinamobile.cmti.dao.RoamingUserDAO;
import com.chinamobile.cmti.model.RoamingUser;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

public class RoamingUserManagerImpl implements RoamingUserManager {

    @Autowired
    RoamingUserDAO roamingUserDAO;

    public List<RoamingUser> getAllRoamingUser() {
        return roamingUserDAO.getAllRoamingUsers();
    }
}
