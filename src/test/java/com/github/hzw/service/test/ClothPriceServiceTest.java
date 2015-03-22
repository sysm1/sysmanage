package com.github.hzw.service.test;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.ClothPrice;
import com.github.hzw.security.service.ClothPriceService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath*:spring-application.xml")
public class ClothPriceServiceTest {


	@Resource
	private ClothPriceService clothPriceService;
	
	@Test
	public void testAdd() throws Exception {
		for(int i = 2; i< 21; i++) {
			ClothPrice price = new ClothPrice();
			price.setClothId(i);
			price.setCreateTime(new Date());
			price.setPrice(2.0 + i);
			price.setStandard("stand...." + i);
			clothPriceService.add(price);
		}
	}
	
	@Test
	public void testQuery() {
		ClothPrice price = new ClothPrice();
		// price.setClothId(1);
		price.setStandard("stand");
		PageView pageview = clothPriceService.query(new PageView(5,1), price);
		System.out.println(pageview.getRowCount());
		System.out.println(pageview.getRecords());
	}
	
	@Test
	public void testQueryByClothId() {
		String clothId = "1";
		ClothPrice price = clothPriceService.getById(clothId);
		System.out.println(price);
	}
	
	@Test
	public void testQueryAll() {
		ClothPrice price = null;
		price = new ClothPrice();
		price.setStandard("stand....2");
		List<ClothPrice> list = clothPriceService.queryAll(price);
		System.out.println(list);
	}
	
	
}
