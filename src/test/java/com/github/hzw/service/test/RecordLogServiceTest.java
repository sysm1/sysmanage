package com.github.hzw.service.test;

import java.util.Date;
import java.util.HashMap;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.github.hzw.security.entity.RecordLog;
import com.github.hzw.security.service.RecordLogService;
import com.github.hzw.util.DateUtil;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath*:spring-application.xml")
public class RecordLogServiceTest {
	
	@Resource
	private RecordLogService recordLogService;
	
	@Test
	public void addTest() throws Exception {
		RecordLog log = new RecordLog();
		log.setCreateTime(new Date());
		log.setModel("model");
		log.setOpDate(DateUtil.date2Str(new Date(), "yyyy-MM-dd"));
		log.setOpType("delete");
		log.setUsername("root");
		recordLogService.add(log);
	}
 	
	@Test
	public void queryTest() {
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("username", "root");
		map.put("opType", "delete");
		map.put("model", "model");
		map.put("opDate", "2015-05-31");
		int count = recordLogService.sum(map);
		System.out.println("count:" + count);
	}
	
}
