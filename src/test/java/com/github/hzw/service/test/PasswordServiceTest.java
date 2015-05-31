package com.github.hzw.service.test;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.Password;
import com.github.hzw.security.service.PasswordService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath*:spring-application.xml")
public class PasswordServiceTest {

	@Resource
	private PasswordService passwordService;
	
	@Test
	public void addtest() throws Exception {
		Password p = new Password();
		p.setId(2);
		p.setNum(5);
		p.setPasswd("");
		this.passwordService.add(p);
	}
	
	@Test
	public void listTest() {
		PageView pageView = new PageView(1,1);
		pageView = passwordService.query(pageView, null);
		System.out.println(pageView.getPageSize());
		System.out.println(pageView.getRecords());
	}
	
	@Test
	public void allTest() {
		PageView pageView = new PageView(1,1);
		List<Password> list = passwordService.queryAll(null);
		System.out.println(list);
	}
	
	
}
