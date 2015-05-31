package com.github.hzw.security.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.Password;
import com.github.hzw.security.mapper.PasswordMapper;
import com.github.hzw.security.service.PasswordService;


@Transactional
@Service("passwordService")
public class PasswordServiceImpl implements PasswordService {

	@Autowired
	private PasswordMapper passwordMapper;
	
	@Override
	public PageView query(PageView pageView, Password t) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<Password> list = passwordMapper.query(map);
		pageView.setRecords(list);
		return pageView;
	}

	@Override
	public List<Password> queryAll(Password t) {
		return passwordMapper.queryAll(t);
	}

	@Override
	public void delete(String id) throws Exception {
		passwordMapper.delete(id);
		
	}

	@Override
	public void update(Password t) throws Exception {
		passwordMapper.update(t);
		
	}

	@Override
	public Password getById(String id) {
		return passwordMapper.getById(id);
	}

	@Override
	public void add(Password t) throws Exception {
		passwordMapper.add(t);
		
	}

	@Override
	public int getNum() {
		return this.getById("2").getNum();
	}

	@Override
	public String getPasswd() {
		return this.getById("1").getPasswd();
	}
	
}
