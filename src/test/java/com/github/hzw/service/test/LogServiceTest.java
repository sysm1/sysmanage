package com.github.hzw.service.test;

import java.util.Date;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.github.hzw.security.entity.Log;
import com.github.hzw.security.service.LogService;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath*:spring-application.xml")
public class LogServiceTest {
	
	@Resource
	private LogService logService;
	
	@Test
	public void saveTest() throws Exception{
		
		Log log = new Log();
		log.setUsername("un111111s");
		log.setModule("d");
		log.setAction("de");
		log.setActionTime("21");
		log.setUserIP("12");
		log.setOperTime(new Date());
		
		logService.add(log);
		
	}
	
	
}
