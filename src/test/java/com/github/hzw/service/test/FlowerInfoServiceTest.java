package com.github.hzw.service.test;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.FlowerAdditional;
import com.github.hzw.security.entity.FlowerInfo;
import com.github.hzw.security.service.FlowerAdditionalService;
import com.github.hzw.security.service.FlowerInfoService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath*:spring-application.xml")
public class FlowerInfoServiceTest {

	@Resource
	private FlowerInfoService flowerInfoService;
	@Resource
	private FlowerAdditionalService flowerAdditionalService;
	
	@Test
	public void testSave() throws Exception {
		FlowerInfo info = new FlowerInfo();
		info.setClothId(1);
		info.setFactoryId(1);
		info.setFileColor("fileColor2");
		info.setMyCompanyCode("myCompanyCode2");
		info.setStatus(1);
		
		info.setTechnologyId(2);
		info.setPicture("http://www.baidu.com/img/bdlogo.png");
		List<FlowerAdditional> list = new ArrayList<FlowerAdditional>();
		FlowerAdditional fadd =  new FlowerAdditional();
		fadd.setFactoryColor("factoryColor-2");
		fadd.setFactoryCode("factoryCode2");
		fadd.setMyCompanyColor("myCompanyColor-2");
		list.add(fadd);
		fadd =  new FlowerAdditional();
		fadd.setFactoryColor("factoryColor-3");
		fadd.setFactoryCode("factoryCode3");
		fadd.setMyCompanyColor("myCompanyColor-3");
		list.add(fadd);
		
		info.setList(list);
		
		flowerInfoService.add(info);
		System.out.println(info.getId());
		
	}
	
	@Test
	public void testQuery() {
		PageView pageView = new PageView(10, 1);
		pageView = flowerInfoService.queryFind(pageView, null);
		List list = pageView.getRecords();
		System.out.println(list);
		System.out.println(pageView.getRowCount());
	}
	
	@Test
	public void testSaveFAd() throws Exception{
		FlowerAdditional fadd = new FlowerAdditional();
		fadd.setFactoryCode("fc");
		fadd.setFactoryColor("factoryColor");
		fadd.setFlowerId(1);
		fadd.setMyCompanyCode("myCompanyCode");
		fadd.setMyCompanyColor("myCompanyColor");
		flowerAdditionalService.add(fadd);
		System.out.println(fadd.getId());
	}
	
	
	@Test
	public void testDeleFAd() throws Exception{
		flowerAdditionalService.deleteByFlowerId("1");
	}
	
	@Test
	public void testfindByFlowerId() {
		List<FlowerAdditional> list = flowerAdditionalService.findByFlowerId(9);
		System.out.println(list);
	}
	
	@Test
	public void testgetById() {
		// getById
		FlowerInfo info = flowerInfoService.getById(9 + "");
		System.out.println(info);
	}
	
}
