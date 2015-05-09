package com.github.hzw.security.controller;

import java.util.Date;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.Account;
import com.github.hzw.security.entity.DailyStatistics;
import com.github.hzw.security.entity.Resources;
import com.github.hzw.security.service.DailyStatisticsService;
import com.github.hzw.util.Common;
import com.github.hzw.util.DateUtil;

/**
 * 每日统计
 * @author wuyb
 */
@Controller
@RequestMapping("/background/dailyStatistics/")
public class DailyStatisticsController extends BaseController{
	
	@Inject
	private DailyStatisticsService dailyStatisticsService;
	
	@RequestMapping("list")
	public String list(Model model, Resources menu, String pageNow) {
		return Common.BACKGROUND_PATH+"/dailyStatistics/list";
	}
	
	/**
	 * @param model
	 * 存放返回界面的model
	 * @return
	 */
	@ResponseBody
	@RequestMapping("query")
	public PageView query(Account account,String pageNow,String pagesize) {
		List<DailyStatistics> list= dailyStatisticsService.queryToday(DateUtil.date2Str(new Date(), "yyyy-MM-dd"));
		pageView=new PageView();
		pageView.setRecords(list);
		pageView.setStartPage(1);
		pageView.setPageSize(1);
		return pageView;
	} 
	 

}
