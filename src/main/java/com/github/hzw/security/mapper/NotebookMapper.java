package com.github.hzw.security.mapper;

import com.github.hzw.base.BaseMapper;
import com.github.hzw.security.entity.Notebook;


public interface NotebookMapper extends BaseMapper<Notebook>{

	public Notebook getByTime(String time);
	
}
