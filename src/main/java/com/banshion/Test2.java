package com.banshion;

import org.junit.Test;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.Resource;

import java.io.IOException;

/**
 * @author 低调式男
 * @email 597926661@qq.com
 * 2016-12
 */
public class Test2
{

    @Test
    public void test() throws IOException {
//        Resource resource = new ClassPathResource("logback.xml");
//        System.out.println(resource.exists());
//        System.out.println(resource.contentLength());
        System.out.println(System.getProperty("file.encoding"));
    }
}
