package com.github.hzw.service.test;

import java.util.Date;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.github.hzw.security.service.DateVersionService;
import com.github.hzw.util.Common;
import com.github.hzw.util.DateUtil;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath*:spring-application.xml")
public class DateVersionServiceTest {

	@Resource	
	private DateVersionService dateVersionService;
	
	@Test
	public void testGetValue() throws Exception {
		Date date = new Date();
		String dateK = DateUtil.date2Str(date, "yyyyMMdd");
		int i = this.dateVersionService.getValue("printsummary", dateK);
		System.out.println(dateK + Common.prefixFillChar(5, i+"", "0"));
	}
	
}
