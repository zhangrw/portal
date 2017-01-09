package com.banshion.portal.web.upload.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.util.HashMap;
import java.util.Map;

/**
 * uploadify批量上传控制器
 * @author 低调式男
 * @email 597926661@qq.com
 * 2017-01
 */
@Controller
@RequestMapping("upload")
public class FileUploadController {

    /**
     * 文件上传方法
     * @param file 上传文件
     * @param id    扩展数据ID
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "uploadtest", method = RequestMethod.POST)
    @ResponseBody
    public ResponseEntity<?> upload(@RequestParam("file") MultipartFile file, @RequestParam("id") String id,
                                    HttpServletRequest request, HttpServletResponse response) {
        Map<String, Object> result = new HashMap<String, Object>();
        String ctxPath = request.getSession().getServletContext().getRealPath("/") + "uploadfiles\\";
        File dirPath = new File(ctxPath);
        if (!dirPath.exists()) {
            dirPath.mkdir();
        }
        String oldFileName = file.getOriginalFilename();
        String fileName = oldFileName;

        File newFilePath = new File(ctxPath + "/" + fileName);
        try {
            file.transferTo(newFilePath);
            result.put("success", true);
        } catch (Exception e) {
            if(newFilePath.isFile()&&newFilePath.exists()){
                newFilePath.delete();
            }
            result.put("success", false);
        }
        return new ResponseEntity(result, HttpStatus.OK);
    }

    /**
     * 删除上传的文件
     * @param fileName
     * @param request
     * @return
     */
    @RequestMapping(value = "deletefile", method = RequestMethod.POST, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<?> deleteFile(String fileName,HttpServletRequest request) {
        Map<String, Object> result = new HashMap<String, Object>();
        String ctxPath = request.getSession().getServletContext().getRealPath("/") + "uploadfiles\\";
        String filepath = ctxPath + fileName;
        try{
            if(filepath!=null){
                File file = new File(filepath);
                if(file.isFile() && file.exists()){
                    file.delete();
                    result.put("success", true);
                }else{
                    result.put("success", false);
                    result.put("msg","删除失败");
                }
            }
        }catch(Exception e){
            result.put("success", false);
            result.put("msg","删除异常");
        }
        return new ResponseEntity(result, HttpStatus.OK);
    }
}
