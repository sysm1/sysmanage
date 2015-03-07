package com.github.hzw.service.test;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.github.hzw.security.entity.ClothInfo;
import com.github.hzw.security.service.ClothInfoService;
import com.github.hzw.util.PinyinUtil;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath*:spring-application.xml")
public class ClothInfoServiceTest {

	
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
	
	
	@Test
	public void testSave() throws Exception {
		ClothInfo info = new ClothInfo();
		info.setClothName("cloth-name1");
		info.setCreateTime(new Date());
		info.setMark("mark...");
		info.setOrderName("下单名称。。");
		info.setPinyin(PinyinUtil.getPinYinHeadChar(info.getClothName()).toUpperCase());
		clothInfoService.add(info);
	}
	
}
