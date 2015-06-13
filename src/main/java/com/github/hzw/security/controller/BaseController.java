package com.github.hzw.security.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.Account;
import com.github.hzw.security.entity.City;
import com.github.hzw.security.service.CityService;
import com.github.hzw.util.Common;


public class BaseController {
	PageView pageView = null;
	public PageView getPageView(String pageNow,String pagesize) {
		
		if(null!=pageNow&&!"".equals(pageNow)){
			if(Integer.parseInt(pageNow)<=0){
				pageNow="1";
			}
		}
		
		if("-1".equals(pageNow)){
			pageNow="1";
		}
		
		if (Common.isEmpty(pageNow)) {
			pageView = new PageView(1);
		} else {
			pageView = new PageView(Integer.parseInt(pageNow));
		}
		if (Common.isEmpty(pagesize)) {
			pagesize = "10";
		} 
		pageView.setPageSize(Integer.parseInt(pagesize));
		return pageView;
	}
	
	/**
	 * @ModelAttribute
	 * 这个注解作用.每执行controllor前都会先执行这个方法
	 */
	/*@ModelAttribute
	public void init(HttpServletRequest request){
		String path = Common.BACKGROUND_PATH;
		Object ep = request.getSession().getAttribute("basePath");
		if(ep!=null){
			if(!path.endsWith(ep.toString())){
				Common.BACKGROUND_PATH = "/WEB-INF/jsp/background"+ep;
			}
		}
		
	}*/
}