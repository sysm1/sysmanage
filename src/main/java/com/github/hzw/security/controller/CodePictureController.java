package com.github.hzw.security.controller;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.hzw.security.entity.CodePicture;
import com.github.hzw.security.service.CodePictureService;

@Controller
@RequestMapping("/background/codePicture/")
public class CodePictureController extends BaseController{

	@Resource
	private CodePictureService codePictureService;
	
	@ResponseBody
	@RequestMapping("queryPicture")
	public String[] queryPicture(String code){
		String[] stra=null;
		CodePicture codePicture=codePictureService.getById(code);
		if(null!=codePicture){
			stra=new String[2];
			stra[0]=codePicture.getPicture();
			stra[1]=codePicture.getSmallPicture();
		}
		return stra;
	}
}
