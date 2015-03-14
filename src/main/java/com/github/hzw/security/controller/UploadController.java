package com.github.hzw.security.controller;

import java.io.File;
import java.util.Map;

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

@Controller
@RequestMapping(value = "/background/")
public class UploadController {

	/** 日志对象*/
	private Log logger = LogFactory.getLog(this.getClass());

	private static final long serialVersionUID = 1L;

	/** 上传目录名*/
	private static final String uploadFolderName = "uploadFiles";

	/** 允许上传的扩展名*/
	private static final String [] extensionPermit = {"txt", "xls", "zip"};

	@RequestMapping(value = "upload", method = RequestMethod.POST)
	public @ResponseBody Map<String, Object> fileUpload(@RequestParam("file") CommonsMultipartFile file, 
			HttpSession session, HttpServletRequest request, HttpServletResponse response) throws Exception{
		logger.info("UploadController#fileUpload() start");

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
				throw new NoSupportExtensionException("No Support extension.");
			}
			file.transferTo(new File(saveDirectory, fileName));
		}

		logger.info("UploadController#fileUpload() end");
		return State.OK.toMap();
	}

}
