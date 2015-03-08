package com.github.hzw.service.test;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.github.hzw.security.entity.ClothAllowance;
import com.github.hzw.security.service.ClothAllowanceService;
import com.github.hzw.util.DateUtil;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath*:spring-application.xml")
public class ClothAllowanceServiceTest {

	@Resource
	private ClothAllowanceService clothAllowanceService;
	
	@Test
	public void test1(){
		// ClothAllowance ae = new ClothAllowance();
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("clothId", 4);
		map.put("factoryId", 4);
		ClothAllowance ae = clothAllowanceService.queryByClothAndFactory(1, 1);
		System.out.println(ae);
	}
	
	
	@Test
	public void testSave() throws Exception {
		ClothAllowance ae = new ClothAllowance();
		// ae.setAllowance(12.0);
		ae.setChangeSum(-20.0);
		ae.setClothId(4);
		ae.setFactoryId(4);
		ae.setCreateTime(new Date());
		// ae.setOldSum(8.0);
		ae.setMark("mark....");
		// Date temp = new Date();
		//ae.setInputDate(DateUtil.str2Date("2015-01-01", "yyyy-MM-dd"));
		ae.setInputDate("2015-01-01");
		ae.setUnit("cm");
		clothAllowanceService.add(ae);
	}
	
	@Test
	public void quertTest() {
		List<ClothAllowance> list = clothAllowanceService.queryAll(null);
		for(ClothAllowance allowance : list) {
			System.out.println(allowance);
		}
	}
	

}
