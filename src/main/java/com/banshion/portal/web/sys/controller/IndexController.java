package com.banshion.portal.web.sys.controller;

import com.banshion.portal.sys.authentication.ShiroUser;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresAuthentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

/**
 * 首页控制器 可实现跳转控制、数据填充等
 * @author 低调式男
 * @email 597926661@qq.com
 */
@Controller
@RequestMapping("/index")
public class IndexController
{
    @RequestMapping
    public String login(Model  model , HttpServletRequest req){
        ShiroUser su =  (ShiroUser) SecurityUtils.getSubject().getPrincipal();
        model.addAttribute("user", su );
        return "index";
    }
}
