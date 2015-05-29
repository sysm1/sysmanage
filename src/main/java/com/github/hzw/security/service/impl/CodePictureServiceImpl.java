package com.github.hzw.security.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.CodePicture;
import com.github.hzw.security.mapper.CodePictureMapper;
import com.github.hzw.security.service.CodePictureService;

@Transactional
@Service("codePictureService")
public class CodePictureServiceImpl implements CodePictureService {
	
	@Autowired
	private CodePictureMapper codePictureMapper;

	@Override
	public PageView query(PageView pageView, CodePicture t) {
		return null;
	}

	@Override
	public List<CodePicture> queryAll(CodePicture t) {
		return codePictureMapper.queryAll(t);
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<CodePicture> queryAllCode(HttpServletRequest request) {
		List<CodePicture> cps=new ArrayList<CodePicture>();
		Object list=request.getSession().getAttribute("CodePictures");
		if(null==list){
			cps=codePictureMapper.queryAll(null);
			request.getSession().setAttribute("CodePictures", cps);
		}else{
			cps=(List<CodePicture>) list;
		}
		return cps;
	}

	@Override
	public void delete(String id) throws Exception {

	}

	@Override
	public void update(CodePicture t) throws Exception {
		codePictureMapper.update(t);
	}

	@Override
	public CodePicture getById(String id) {
		return codePictureMapper.getById(id);
	}

	@Override
	public void add(CodePicture t) throws Exception {
		codePictureMapper.add(t);
	}

}
