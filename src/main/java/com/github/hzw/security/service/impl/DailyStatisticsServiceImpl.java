package com.github.hzw.security.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.DailyStatistics;
import com.github.hzw.security.mapper.DailyStatisticsMapper;
import com.github.hzw.security.service.DailyStatisticsService;

@Transactional
@Service("dailyStatisticsService")
public class DailyStatisticsServiceImpl implements DailyStatisticsService{

	@Autowired
	private DailyStatisticsMapper dailyStatisticsMapper;
	
	/**
	 * 查询当天的统计信息
	 * @param today
	 * @return
	 */
	@Override
	public List<DailyStatistics> queryToday(String today){
		return dailyStatisticsMapper.queryToday(today);
	}
	
	@Override
	public PageView query(PageView pageView, DailyStatistics t) {
		return null;
	}

	@Override
	public List<DailyStatistics> queryAll(DailyStatistics t) {
		return null;
	}

	@Override
	public void delete(String id) throws Exception {
		
	}

	@Override
	public void update(DailyStatistics t) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public DailyStatistics getById(String id) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void add(DailyStatistics t) throws Exception {
		// TODO Auto-generated method stub
		
	}

}
