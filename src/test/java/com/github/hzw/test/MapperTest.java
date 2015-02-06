package com.github.hzw.test;

import java.util.Date;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.github.hzw.security.entity.Log;
import com.github.hzw.security.mapper.LogMapper;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath*:spring-application.xml")
public class MapperTest {

	@Resource
	private LogMapper logMapper;
	
	/**
	 * private String username;
	private String module;
	private String action;
	private String actionTime;
	private String userIP;
	private Date operTime;
	 * @throws Exception 
	 */
	
	@Test
	public void save() throws Exception {
		Log log = new Log();
		log.setUsername("un");
		log.setModule("d");
		log.setAction("de");
		log.setActionTime("21");
		log.setUserIP("12");
		log.setOperTime(new Date());
		logMapper.add(log);
	}
	
}
