package com.github.hzw.security.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.Notebook;
import com.github.hzw.security.mapper.NotebookMapper;
import com.github.hzw.security.service.NotebookService;

@Transactional
@Service("notebookService")
public class NotebookServiceImpl implements NotebookService {

	@Autowired
	private NotebookMapper notebookMapper;
	
	@Override
	public PageView query(PageView pageView, Notebook t) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<Notebook> list = notebookMapper.query(map);
		pageView.setRecords(list);
		return pageView;
	}

	
	@Override
	public List<Notebook> queryAll(Notebook t) {
		return notebookMapper.queryAll(t);
	}

	@Override
	public void delete(String id) throws Exception {
		notebookMapper.delete(id);
		
	}

	@Override
	public void update(Notebook t) throws Exception {
		// this.add(t);
		this.notebookMapper.update(t);
	}

	@Override
	public Notebook getById(String id) {
		return this.notebookMapper.getById(id);
	}

	@Override
	public void add(Notebook t) throws Exception {
		String time = t.getTime();
		Notebook book = this.notebookMapper.getByTime(time);
		if(book == null) {
			this.notebookMapper.add(t);
		} else {
			book.setTitle(t.getTitle());
			book.setContent(book.getContent() + t.getContent());
			book.setCreateTime(new Date());
			this.notebookMapper.update(book);
		}
		
		
	}


	public Notebook getByTime(String time) {
		return this.notebookMapper.getByTime(time);
	}
	
}
