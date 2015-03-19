package com.github.hzw.service.test;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.Notebook;
import com.github.hzw.security.service.NotebookService;
import com.github.hzw.util.DateUtil;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath*:spring-application.xml")
public class NotebookServiceTest {

	@Resource
	private NotebookService notebookService;
	
	@Test
	public void addTest() throws Exception {
		Notebook t = new Notebook();
		t.setContent("content20");
		t.setCreateTime(new Date());
		t.setTime(DateUtil.date2Str(new Date(), "yyyy-MM-dd"));
		t.setTitle("title20");
		t.setUserid(1);
		notebookService.add(t);
	}
	
	@Test
	public void testGetById() {
		Notebook t = notebookService.getById("1");
		System.out.println(t);
	}
	
	@Test
	public void testGetByTime() {
		Notebook t = notebookService.getByTime("2015-03-20");
		System.out.println(t);
	}
	
	@Test
	public void testQueryAll() {
		Notebook t = new Notebook();
		t.setUserid(1);
		List<Notebook> list = notebookService.queryAll(t);
		System.out.println(list);
	}
	
	
	@Test
	public void testQuery() {
		Notebook t = new Notebook();
		t.setUserid(1);
		t.setContent("content");
		PageView pageView = new PageView(2,1);
		pageView = notebookService.query(pageView, t);
		System.out.println(pageView.getRowCount());
		System.out.println(pageView.getRecords());
		
		
	}
}
