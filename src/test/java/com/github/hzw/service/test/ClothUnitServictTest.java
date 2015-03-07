package com.github.hzw.service.test;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.github.hzw.security.entity.ClothUnit;
import com.github.hzw.security.service.ClothUnitService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath*:spring-application.xml")
public class ClothUnitServictTest {
	
	@Resource
	private ClothUnitService clothUnitService;
	
	@Test
	public void test1() {
		ClothUnit unit = clothUnitService.queryClothId(1);
		System.out.println(unit);
	}
	
	@Test
	public void testSave() throws Exception {
		ClothUnit unit = new ClothUnit();
		unit.setClothId(4);
		unit.setCm(2.3);
		unit.setKg(5.4);
		unit.setItem(1);
		unit.setYard(10.333333);
		clothUnitService.add(unit);
	}
	
	
}
