package com.github.hzw.security.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.github.hzw.base.BaseService;
import com.github.hzw.security.entity.CodePicture;

public interface CodePictureService extends BaseService<CodePicture>{
	
	public List<CodePicture> queryAllCode(HttpServletRequest request);

}
