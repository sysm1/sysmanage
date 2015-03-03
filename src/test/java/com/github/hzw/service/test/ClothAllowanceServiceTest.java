package com.github.hzw.service.test;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.github.hzw.security.entity.ClothAllowance;
import com.github.hzw.security.service.ClothAllowanceService;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath*:spring-application.xml")
public class ClothAllowanceServiceTest {

	@Resource
	private ClothAllowanceService clothAllowanceService;
	
	@Test
	public void test1(){
		// ClothAllowance ae = new ClothAllowance();
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("clothId", 1);
		map.put("factoryId", 1);
		ClothAllowance ae = clothAllowanceService.queryByClothAndFactory(1, 1);
		System.out.println(ae);
	}
	
	
	@Test
	public void testSave() throws Exception {
		ClothAllowance ae = new ClothAllowance();
		ae.setAllowance(12);
		ae.setChangeSum(20);
		ae.setClothId(1);
		ae.setFactoryId(2);
		ae.setCreateTime(new Date());
		ae.setOldSum(8);
		ae.setMark("mark....");
		ae.setUnit("item");
		clothAllowanceService.add(ae);
	}
	
	
	

}
