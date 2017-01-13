package com.banshion.portal.web;

import com.banshion.portal.web.sys.dao.SysMenuMapper;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

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

    }

}
