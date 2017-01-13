package com.banshion.portal.web.sys.service;

import com.banshion.portal.web.sys.domain.SysMenu;
import com.banshion.portal.web.sys.domain.SysPermission;

import java.util.List;

/**
 *
 */
public interface MenuService {
    List<SysMenu> getAllMenu();

    List<SysMenu> getMenuByPID(String id);

    List<SysPermission> getAllPermission();

    Integer getOrderCount(String parentId);

    SysMenu checkNameExists(SysMenu menu);

    void save(SysMenu menu);

    void delete(String id);

    void update(SysMenu menu);

    void updateMenuOrder(String menuOrderParam);

    List<SysMenu> getAllMenus();

    List<SysMenu> getMenuByUserId(String userId);

    String menuFullName(String url);
}
