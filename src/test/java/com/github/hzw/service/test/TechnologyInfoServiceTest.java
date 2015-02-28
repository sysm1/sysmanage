package com.github.hzw.service.test;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.github.hzw.security.entity.TechnologyInfo;
import com.github.hzw.security.service.TechnologyInfoService;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath*:spring-application.xml")
public class TechnologyInfoServiceTest {

	@Resource
	private TechnologyInfoService technologyInfoService;
	
	
	
	@Test
	public void queryPinyin() {
		String name = "GYM";
		List<TechnologyInfo> list = technologyInfoService.queryPinyin(name);
		for(TechnologyInfo i : list) {
			System.out.println(i);
		}
	}
	
	
	
	
	
}
