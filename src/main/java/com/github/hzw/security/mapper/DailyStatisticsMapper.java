package com.github.hzw.security.mapper;

import java.util.List;

import com.github.hzw.base.BaseMapper;
import com.github.hzw.security.entity.DailyStatistics;

public interface DailyStatisticsMapper extends BaseMapper<DailyStatistics>{

	public List<DailyStatistics> queryToday(String today);
	
}
