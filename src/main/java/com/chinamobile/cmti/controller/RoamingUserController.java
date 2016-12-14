package com.chinamobile.cmti.controller;

import com.chinamobile.cmti.model.*;
import com.chinamobile.cmti.service.RoamingUserManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.support.SessionStatus;

import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;
import javax.validation.ValidatorFactory;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Controller
@RequestMapping("/roamingusers/showdetails")
@SessionAttributes("roaming")
public class RoamingUserController {
    @Autowired
    RoamingUserManager manager;

    @RequestMapping(method = RequestMethod.POST)
    public String submitForm(@ModelAttribute("roaming") RoamingUser roamingUser,
                             BindingResult result, SessionStatus status) {
        StringBuilder sb = new StringBuilder();
        if(sb.length() != 0)
        // Mark Session Complete
        status.setComplete();
        return "redirect:showdetails/showmap";
    }
}
