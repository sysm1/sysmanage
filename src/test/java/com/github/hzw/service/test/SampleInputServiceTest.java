package com.github.hzw.service.test;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.github.hzw.security.entity.SalesmanInfo;
import com.github.hzw.security.service.SampleInputService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath*:spring-application.xml")
public class SampleInputServiceTest {

	@Resource
	private SampleInputService sampleInputService;
	
	@Test
	public void saveTemp() throws Exception{
		//HttpServletRequest request = ServletActionContext.getRequest();
		
		//sampleInputService.saveTemp(request, sampleInput);
		
		
		
	}
	
}
