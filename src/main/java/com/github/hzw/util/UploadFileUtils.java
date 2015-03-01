package com.github.hzw.util;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

/**
 * 文件上传
 * @author wuyb
 *
 */
public class UploadFileUtils {

	/**
	 * 保存上传文件
	 * @param request
	 * @return
	 */
	public static String saveUploadFile(HttpServletRequest request){
		MultipartHttpServletRequest multipartRequest  =  (MultipartHttpServletRequest) request;  
        //  获得第1张图片（根据前台的name名称得到上传的文件）   
        MultipartFile myFile =  multipartRequest.getFile("myFile");
        final int BUFFER_SIZE = 16 * 1024 ;
        OutputStream out = null ;
        InputStream in=null;
        File  dst=null;
        //图片保存目标路径
        String dstPath=PropertiesUtils.findPropertiesKey("pic_path");
        File path=new File(dstPath);
        if(!path.exists()){
        	path.mkdirs();
        }
        String picName=myFile.getOriginalFilename();
        String dstPicPath=dstPath+picName;
        dst=new File(dstPicPath);
        try {
        	in =myFile.getInputStream();
        	out = new BufferedOutputStream( new FileOutputStream(dst), BUFFER_SIZE);
        	byte [] buffer = new byte [BUFFER_SIZE];
        	while (in.read(buffer) > 0 ) {
        		out.write(buffer);
        	}
		} catch (IOException e1) {
			e1.printStackTrace();
		}finally{
			try {
				if ( null != in) {
				in.close();
				}
				if ( null != out) {
					out.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
        return dstPicPath;
	}
}
