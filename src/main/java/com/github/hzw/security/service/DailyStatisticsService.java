package com.github.hzw.security.service;

import java.util.Date;
import java.util.List;

import com.github.hzw.base.BaseService;
import com.github.hzw.security.entity.DailyStatistics;

public interface DailyStatisticsService extends BaseService<DailyStatistics>{

	/**
	 * 查询当天的统计信息
	 * @param today
	 * @return
	 */
	public List<DailyStatistics> queryToday(String today);
}
