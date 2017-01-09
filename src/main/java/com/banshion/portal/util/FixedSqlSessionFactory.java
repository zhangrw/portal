package com.banshion.portal.util;

import org.apache.ibatis.executor.ErrorContext;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;

import java.io.IOException;

/**
 *  Mybatis自带SqlSessionFactoryBean在抛出异常时异常信息打印不全容易丢失定位问题xml的错误信息
 *  通过继承重写输出异常信息，方便快速定位异常位置
 */
public class FixedSqlSessionFactory extends SqlSessionFactoryBean {
    @Override
    protected SqlSessionFactory buildSqlSessionFactory() throws IOException {
        try {
            return super.buildSqlSessionFactory();
        }catch (Exception e){
            // 输出异常信息
            e.printStackTrace();
        }finally {
            ErrorContext.instance().reset();
        }
        return null;
    }
}
