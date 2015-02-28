package com.github.hzw.service.test;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.github.hzw.security.entity.FactoryInfo;
import com.github.hzw.security.service.FactoryInfoService;
import com.github.hzw.util.PinyinUtil;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath*:spring-application.xml")
public class FactoryInfoServiceTest {

	@Resource
	private FactoryInfoService factoryInfoService;
	
	@Test
	public void saveTest() throws Exception{
		FactoryInfo info = new FactoryInfo();
		String name = "北京公司mmabc";
		info.setName(name);
		info.setPinyin(PinyinUtil.getPinYinHeadChar(name));
		info.setMark("mark....");
		factoryInfoService.add(info);
	}
	
	@Test
	public void queryPinyin() {
		String name = "BJG";
		List<FactoryInfo> list = factoryInfoService.queryPinyin(name);
		for(FactoryInfo i : list) {
			System.out.println(i);
		}
	}
	
	
	
}
