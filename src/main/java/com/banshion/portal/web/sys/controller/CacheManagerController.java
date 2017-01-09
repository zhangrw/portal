package com.banshion.portal.web.sys.controller;

import net.sf.ehcache.Cache;
import net.sf.ehcache.CacheException;
import net.sf.ehcache.CacheManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

/**
 * @author 低调式男
 * @email 597926661@qq.com
 * 2017-01
 * Ehcache缓存手动查询、展示、删除
 */
@Controller
@RequestMapping("sys/cache")
public class CacheManagerController {
    private final static Logger log = LoggerFactory.getLogger(CacheManagerController.class);

    @RequestMapping
    public String index(){
        return "sys/cache/list";
    }

    /**
     * 按名称清除对应缓存
     * @param Names 缓存名称
     * @return
     */
    @RequestMapping(value="cleanByName",produces="application/json")
    public  @ResponseBody
    ResponseEntity CleanCacheByName(String Names){
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            String cacheNames[] = Names.split(",");
            CacheManager manager = CacheManager.getInstance();
            for(String name : cacheNames){
                Cache cache = manager.getCache(name);
                cache.removeAll();
            }
            result.put("success", true);
        } catch (Exception e) {
            result.put("success", false);
            e.printStackTrace();
            log.error("缓存清除异常："+e.getMessage());
        }
        return new ResponseEntity(result, HttpStatus.OK);
    }

    /**
     * 清除所有缓存
     * @return
     */
    @RequestMapping(value="cleanAll",produces="application/json")
    public @ResponseBody ResponseEntity CleanAll(){
        Map<String, Object> result = new HashMap<String, Object>();
        try {
            CacheManager manager = CacheManager.getInstance();
            manager.removalAll();
            result.put("success", true);
        } catch (CacheException e) {
            result.put("success", false);
            e.printStackTrace();

        }
        return new ResponseEntity(result, HttpStatus.OK);
    }

    /**
     * 实时展示缓存使用信息
     * @return
     */
    @RequestMapping(value="list",produces="application/json")
    public  @ResponseBody  List list(){
        List list = new ArrayList();

        CacheManager manager = CacheManager.getInstance();

        String[] names = manager.getCacheNames();
        for(String name:names){
            Map map = new HashMap();
            map.put("name", name);
            Cache cache = manager.getCache(name);
            long sum = cache.getSize ();//cache.getStatistics().getObjectCount();
            map.put("use", sum);
            long hit = cache.getStatistics().getInMemoryHits();
            map.put("hit", hit);
            list.add(map);
        }
        return list;
    }

}
