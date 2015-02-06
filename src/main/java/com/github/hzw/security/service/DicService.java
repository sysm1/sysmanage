package com.github.hzw.security.service;

import com.github.hzw.base.BaseService;
import com.github.hzw.security.entity.Dic;



public interface DicService extends BaseService<Dic>{
	public Dic isExist(Dic dic);
}
