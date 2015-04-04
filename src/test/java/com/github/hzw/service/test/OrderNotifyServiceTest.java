package com.github.hzw.service.test;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.OrderSummary;
import com.github.hzw.security.service.OrderNotifyInfoService;
import com.github.hzw.util.DateUtil;



@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath*:spring-application.xml")
public class OrderNotifyServiceTest {

	@Resource
	private OrderNotifyInfoService  orderNotifyInfoService;
	
	@Test
	public void testQueryFind() {
		Map<String, Object> map = new HashMap<String, Object>();
		PageView pageView = new PageView(10,1);
		// map.put("beginTime", "2015-04-01 00:00:00");
		// map.put("endTime", "2015-04-10 00:00:00");
		
		// map.put("beginTime", "2015-04-01");
		// map.put("endTime", "2015-04-10");
		
		map.put("beginTime", DateUtil.str2Date("2015-04-01", "yyyy-MM-dd"));
		map.put("endTime", DateUtil.str2Date("2015-04-10", "yyyy-MM-dd"));
		
		pageView = orderNotifyInfoService.queryFind(pageView, map);
		System.out.println(pageView.getRowCount());
		System.out.println(pageView.getRecords());
		
	}
	
	
	
}
