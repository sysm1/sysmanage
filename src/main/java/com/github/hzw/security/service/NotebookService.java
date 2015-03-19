package com.github.hzw.security.service;

import com.github.hzw.base.BaseService;
import com.github.hzw.security.entity.Notebook;


public interface NotebookService extends BaseService<Notebook> {

	public Notebook getByTime(String time);
	
}
