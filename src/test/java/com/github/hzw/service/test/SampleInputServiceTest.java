package com.github.hzw.service.test;

import java.util.Date;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.github.hzw.security.service.SampleInputService;
import com.github.hzw.util.DateUtil;

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
	
	@Test
	public void queryReportTest() {
		
		// DateUtil.str2Date("2015-04-03 10:20:10"), new Date()
		sampleInputService.queryReport(null);
	}
	
	
}
