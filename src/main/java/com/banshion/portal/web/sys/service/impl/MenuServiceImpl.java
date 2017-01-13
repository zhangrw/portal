package com.banshion.portal.web.sys.service.impl;

import com.banshion.portal.exception.ServiceException;
import com.banshion.portal.web.sys.domain.SysMenuExample;
import com.banshion.portal.web.sys.domain.SysPermission;
import com.banshion.portal.web.sys.dao.SysMenuMapper;
import com.banshion.portal.web.sys.dao.SysPermissionMapper;
import com.banshion.portal.web.sys.domain.SysMenu;
import com.banshion.portal.web.sys.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * @author 低调式男
 * @email 597926661@qq.com
 */
@Service
public class MenuServiceImpl implements MenuService {

    @Autowired
    private SysMenuMapper menumapper;

    @Autowired
    private SysPermissionMapper permissionmapper;

    public List<SysMenu> getAllMenu() {
        return menumapper.selectByExample(null);
    }

    public List<SysMenu> getMenuByPID(String id) {

        SysMenuExample se = new SysMenuExample();
        se.createCriteria().andParentIdEqualTo(id);
        se.setOrderByClause(" menu_order asc");
        return menumapper.selectByExample(se);
    }

    public List<SysPermission> getAllPermission() {
        // 此处可以增加适当到过滤条件
        return permissionmapper.selectByExample(null);
    }

    public Integer getOrderCount(String parentId) {

        menumapper.getOrderCount(parentId);

        return null;
    }

    public SysMenu checkNameExists(SysMenu menu) {
        return menumapper.checkNameExists(menu);
    }

    public void save(SysMenu menu) {
        try {
            menu.setId(UUID.randomUUID().toString());
            menumapper.insert(menu);
        }catch (Exception e){
            e.printStackTrace();
            throw new ServiceException("保存菜单失败", e);
        }
    }

    public void delete(String id) {
        try {
            menumapper.deleteByPrimaryKey(id);
        }catch (Exception e){
            e.printStackTrace();
            throw new ServiceException("删除菜单失败", e);
        }
    }

    public void update(SysMenu menu) {
        try {
            menumapper.updateByPrimaryKeySelective(menu);
        }catch (Exception e){
            e.printStackTrace();
            throw new ServiceException("更新菜单失败", e);
        }
    }

    public void updateMenuOrder(String menuOrderParam) {
        try{
            String[] str = menuOrderParam.split(";");
            for(int i=0;i<str.length;i++){
                String[] menu = str[i].split(":");
                menumapper.updateMenuOder(menu[0], menu[1]);
            }
        }catch(Exception e){
            e.printStackTrace();
            throw new ServiceException("更新排序失败！",e);
        }
    }

    @Cacheable(value = "menuCache")
    public List<SysMenu> getAllMenus() {
        try {
            List<SysMenu> list = menumapper.selectByExample(null);
            return list;
        } catch (Exception e) {
            throw new ServiceException("查询菜单失败", e);
        }
    }

    @Cacheable(value = "menuCache" ,key = "#userId")
    public List<SysMenu> getMenuByUserId(String userId) {
    try{
        List<SysMenu> list = menumapper.getMenuByUserId(userId);
        return list;
    } catch (Exception e) {
        throw new ServiceException("查询菜单失败", e);
    }
    }

    /**
     *
     * 通过访问地址拼接菜单全路径的名字
     * @param url 访问路径
     * @return
     */
    @Override
    public String menuFullName(String url) {

        List<SysMenu> ms = menumapper.selectByExample(null);
        List<String> ns = new ArrayList<String>();
        for ( SysMenu m : ms ){
            if ( m.getUrl() != null && m.getUrl().equals(url)){
                ns.add( m.getName());
                menuName(ns , m , ms);
                break;
            }
        }
        if ( ns != null && ns.size() > 0 ){
            StringBuffer sb = new StringBuffer();
            for ( String n : ns ){
                sb.append("<li class=\"active\">");
                sb.append(n);
                sb.append("</li>");
            }
            return sb.toString();
        }
        return null;
    }

    /**
     * 递归拼接名字
     * @param ns
     * @param m
     * @param ms
     */
    private void menuName ( List<String> ns , SysMenu m, List<SysMenu> ms){
        if (m.getParentId().equals("0"))
            return ;
        for ( SysMenu mm : ms ){
            if ( mm.getId().equals(m.getParentId())){
                ns.add( 0 , mm.getName());
                menuName(ns , mm , ms);
                break;
            }
        }
    }

}
