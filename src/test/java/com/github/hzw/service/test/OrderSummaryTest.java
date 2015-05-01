package com.github.hzw.service.test;

import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.OrderSummary;
import com.github.hzw.security.service.OrderSummaryService;
import com.github.hzw.util.DateUtil;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath*:spring-application.xml")
public class OrderSummaryTest {

	@Resource
	private OrderSummaryService orderSummaryService;

	@Test
	public void testAdd() throws Exception {
		for (int i = 0; i < 10; i++) {
			OrderSummary summary = new OrderSummary();
			summary.setBalance(i);
			summary.setOrderCode("orderCode" + i);
			summary.setOrderDate(new Date());
			summary.setClothId(1);
			summary.setFactoryId(4);
			summary.setTechnologyId(2);
			summary.setMyCompanyCode("myCompanyCode"+ i);
			summary.setMyCompanyColor("myCompanyColor"+ i);
			summary.setFactoryCode("factoryCode"+ i);
			summary.setFactoryColor("factoryColor"+ i);
			summary.setClothNum(10);
			summary.setNum(2.0);
			summary.setStandard("规格"+ i);
			summary.setPackingStyle("packingStyle"+ i);
			summary.setSalesmans("1|2|"+ i);
			summary.setMark("mark"+ i);
			summary.setPrintStatus(0);
			summary.setPrintNum(0);
			summary.setStatus("新厂");
			summary.setReturnStatus(1);
			summary.setCreateTime(new Date());
			orderSummaryService.add(summary);
		}
	}
	
	@Test
	public void testQuery() {
		PageView pageview = new PageView(1, 5);
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("printNum", 0);
		
		map.put("beginTime", DateUtil.beginDate(new Date()));
		map.put("endTime", DateUtil.endDate(null));
		
		map.put("printStatus", "2");
		pageview = orderSummaryService.queryPrint(pageview, map);
		
		System.out.println(pageview.getPageCount());
		System.out.println(pageview.getRecords());
		
	}

	@Test
	public void testCancel() {
		orderSummaryService.cancel("10");
	}
	
	
	@Test
	public void testQueryList() {
		
		List<OrderSummary> list = orderSummaryService.query("13");
		System.out.println(list);
	}
	
}
