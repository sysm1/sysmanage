package com.github.hzw.service.test;

import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.SalesmanInfo;
import com.github.hzw.security.service.SalesmanInfoService;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath*:spring-application.xml")
public class SalesmanInfoServiceTest {

	@Resource
	private SalesmanInfoService salesmanInfoService;
	
	@Test
	public void saveTest() throws Exception{
		for(int i = 10; i < 100; i++){
			SalesmanInfo info = new SalesmanInfo();
			//info.setCode(i + "");
			info.setMark("mark...");
			info.setName("sale" + i);
			this.salesmanInfoService.add(info);
			System.out.println(info);
		}
	}
	
	@Test
	public void queryTest() {
		PageView view = new PageView(10, 3);
		SalesmanInfo info = new SalesmanInfo();
		info.setMark("mark");
		view = salesmanInfoService.query(view, info);
		System.out.println(view.getPageCount());
		System.out.println(view.getRowCount());
		System.out.println(view.getRecords().size());
		for(Object o: view.getRecords()) {
			SalesmanInfo si = (SalesmanInfo)o;
			System.out.println(si);
		}
	}
	
	@Test
	public void queryAllTest() {
		List<SalesmanInfo> list = salesmanInfoService.queryAll(null);
		System.out.println(list.size());
	}
	
	@Test
	public void deleteTest() throws Exception {
		String id = "1";
		salesmanInfoService.delete(id);
		
	}
	
	@Test
	public void getByIdTest() {
		String id = "3";
		SalesmanInfo si = salesmanInfoService.getById(id);
		System.out.println(si);
	}
	
	@Test
	public void updateTest() throws Exception{
		String id = "3";
		SalesmanInfo si = salesmanInfoService.getById(id);
		System.out.println(si);
		si.setMark("3");
		salesmanInfoService.update(si);
		System.out.println(si);
	}
}
