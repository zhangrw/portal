package com.banshion.portal.util.intf;

import org.springframework.stereotype.Component;

import java.lang.annotation.*;

/**
 * 自定义注解  使得Spring可以扫描组装注入Mybatis的Dao
 */

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.TYPE)
@Documented
@Component
public @interface MyBatisRepository {
    String value() default "";
}