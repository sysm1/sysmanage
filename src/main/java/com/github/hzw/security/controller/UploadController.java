package com.github.hzw.security.controller;

import java.io.File;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.ArrayUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.github.hzw.util.ImageUtils;

@Controller
@RequestMapping(value = "/background/")
public class UploadController {

	/** 日志对象*/
	private Log logger = LogFactory.getLog(this.getClass());

	/** 上传目录名*/
	private static final String uploadFolderName = "uploadFiles";

	/** 允许上传的扩展名*/
	private static final String [] extensionPermit = {"jpg", "png", "jpeg"};

	@RequestMapping(value = "upload", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> fileUpload(@RequestParam("file") CommonsMultipartFile file, 
			HttpSession session, HttpServletRequest request, HttpServletResponse response) {
		logger.info("UploadController#fileUpload() start");
		String myCompanyCode=request.getParameter("myCompanyCode");
		if(null==myCompanyCode||"".equals(myCompanyCode)){
			myCompanyCode="";
		}
		String factoryCode1=request.getParameter("factoryCode1");
		if(null==factoryCode1||"".equals(factoryCode1)){
			factoryCode1="";
		}
		String factoryCode2=request.getParameter("factoryCode2");
		if(null==factoryCode2||"".equals(factoryCode2)){
			factoryCode2="";
		}
		String fileCode=request.getParameter("fileCode");
		if(null==fileCode||"".equals(fileCode)){
			fileCode="";
		}
		Map<String, Object> map = new HashMap<String, Object>();
		try{
			//清除上次上传进度信息
			String curProjectPath = session.getServletContext().getRealPath("/");
			String saveDirectoryPath = curProjectPath + "/" + uploadFolderName;
			File saveDirectory = new File(saveDirectoryPath);
			logger.debug("Project real path [" + saveDirectory.getAbsolutePath() + "]");
	
			// 判断文件是否存在
			if (!file.isEmpty()) {
				String fileName = file.getOriginalFilename();
				String fileExtension = FilenameUtils.getExtension(fileName);
				if(!ArrayUtils.contains(extensionPermit, fileExtension)) {
					// throw new NoSupportExtensionException("No Support extension.");
					map.put("code", "0");
					map.put("msg", "请选择正确的文件类型");
					return map;
				}
				/***图片文件名称 以我司编号 工厂编号和分色文件号命名***/
				String srcname = "src="+myCompanyCode+","+factoryCode1+"_"+factoryCode2+","+fileCode+ "." + fileExtension;
				String smallname = "small="+myCompanyCode+","+factoryCode1+"_"+factoryCode2+","+fileCode+ "." + fileExtension;
				file.transferTo(new File(saveDirectory, srcname)); // 保存
				ImageUtils.scale2(saveDirectory+"/"+srcname, saveDirectory+"/" + smallname, 200, 200, true);
				map.put("code", "1");
				map.put("url", "/" + uploadFolderName + "/" + smallname);
				map.put("picture", "/" + uploadFolderName + "/" + srcname + "|" + "/" + uploadFolderName + "/" + smallname);
			} else {
				map.put("code", "0");
				map.put("msg", "请选择文件");
			}
			logger.info("UploadController#fileUpload() end");
		}catch(Exception ex) {
			map.put("code", "0");
			map.put("msg", "error:" + ex.getMessage());
		}
		logger.info(map);
		return map;
	}

}
