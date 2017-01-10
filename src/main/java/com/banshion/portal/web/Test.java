package com.banshion.portal.web;

import com.alibaba.fastjson.JSON;
import com.banshion.portal.web.sys.dao.SysMenuMapper;
import com.banshion.portal.web.sys.domain.SysMenu;
import com.banshion.portal.web.sys.service.impl.MenuTreeNode;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.*;

/**
 * 测试用例  Spring-test
 * @author 低调式男
 * @email 597926661@qq.com
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:applicationContext.xml" })
//"file:/WEB-INF/spring-mvc.xml",
public class Test
{

    //private static final Logger LOGGER = Logger
    //        .getLogger(TestUserService.class);

    @Autowired
    private SysMenuMapper menuDao;

    @org.junit.Test
    public void testQueryById1() {
        List<SysMenu> list = menuDao.selectByExample(null);
        HashMap<String,MenuTreeNode> nodemap = new HashMap<String, MenuTreeNode>();

        for( SysMenu menu : list ){
            MenuTreeNode node = new MenuTreeNode();
            node.setId(menu.getId());
            node.setName(menu.getName());
            node.setParentId(menu.getParentId());
            node.setUrl(menu.getUrl());
            nodemap.put(menu.getId() , node);
        }

        Set entrySet = nodemap.entrySet();
        MenuTreeNode root = null;
        for(Iterator it = entrySet.iterator(); it.hasNext();){
            MenuTreeNode node = (MenuTreeNode)((Map.Entry)it.next()).getValue();
            if( node.getParentId() == null || "".equals(node.getParentId())){
                root = node;
            }else{
                ((MenuTreeNode) nodemap.get(node.getParentId())).addChildNode(node);
            }
        }

        System.out.println(root);
        System.out.println(JSON.toJSON(root.getChildren()));

    }

}
