package com.github.hzw.service.test;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.github.hzw.security.entity.ClothInfo;
import com.github.hzw.security.entity.FactoryInfo;
import com.github.hzw.security.service.ClothInfoService;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath*:spring-application.xml")
public class ClothInfoTest {

	
	@Resource
	private ClothInfoService clothInfoService;
	
	
	@Test
	public void queryPinyin() {
		String name = "BZMC";
		List<ClothInfo> list = clothInfoService.queryPinyin(name);
		for(ClothInfo i : list) {
			System.out.println(i);
		}
	}
	
}
