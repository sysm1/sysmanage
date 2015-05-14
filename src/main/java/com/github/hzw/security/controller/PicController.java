package com.github.hzw.security.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.hzw.security.entity.SampleInput;
import com.github.hzw.security.service.SampleInputService;

@Controller
@RequestMapping("/background/pic/")
public class PicController extends BaseController{
	
	@Inject
	private SampleInputService sampleInputService;//开版录入service
	
	/**
	 * 获取原图片
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("getPic")
	public String getPic(HttpServletRequest request,HttpServletResponse response) {
		String id=request.getParameter("id");
		SampleInput bean=sampleInputService.getById(id);
        FileInputStream hFile;
		try {
			if(!new File(bean.getPicture()).exists()){
				bean.setPicture(request.getSession().getServletContext().getRealPath("")+bean.getPicture());
			}
			hFile = new FileInputStream(bean.getPicture());
			int i;
			i = hFile.available();
			//得到文件大小   
	        byte data[]=new byte[i];   
	        hFile.read(data);  //读数据   
	        response.setContentType("image/*"); //设置返回的文件类型   
	        OutputStream toClient=response.getOutputStream(); //得到向客户端输出二进制数据的对象   
	        toClient.write(data);  //输出数据   
	        toClient.flush();  
	        toClient.close();   
	        hFile.close();   
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} // 以byte流的方式打开文件 d:\1.gif   
		catch (IOException e) {
			e.printStackTrace();
		}
        return null;  
    }
	
	/**
	 * 获取缩略图
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("getSmallPic")
	public String getSmallPic(HttpServletRequest request,HttpServletResponse response) throws Exception {
		String id=request.getParameter("id");
		SampleInput bean=sampleInputService.getById(id);
        FileInputStream hFile = new FileInputStream(bean.getSmallPicture()); // 以byte流的方式打开文件 d:\1.gif   
        int i=hFile.available(); //得到文件大小   
        byte data[]=new byte[i];   
        hFile.read(data);  //读数据   
        response.setContentType("image/*"); //设置返回的文件类型   
        OutputStream toClient=response.getOutputStream(); //得到向客户端输出二进制数据的对象   
        toClient.write(data);  //输出数据   
        toClient.flush();  
        toClient.close();   
        hFile.close();   
        return null;  
    }

}
