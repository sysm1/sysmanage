package com.github.hzw.security.mapper;


import com.github.hzw.base.BaseMapper;
import com.github.hzw.security.entity.Dic;

public interface DicMapper extends BaseMapper<Dic>{
	public Dic isExist(Dic dic);
}
