package com.github.hzw.security.controller;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.Account;
import com.github.hzw.security.entity.City;
import com.github.hzw.security.service.AccountService;
import com.github.hzw.security.service.CityService;
import com.github.hzw.util.Common;
import com.github.hzw.util.Md5Tool;
import com.github.hzw.util.POIUtils;


@Controller
@RequestMapping("/background/account/")
public class AccountController extends BaseController{
	@Inject
	private AccountService accountService;
	
	@Inject
	private CityService cityService;
	
	@RequestMapping("list")
	public String list(Model model, Account account,String pageNow,String pagesize) {
		pageView = accountService.query(getPageView(pageNow,pagesize), account);
		model.addAttribute("pageView", pageView);
		return Common.BACKGROUND_PATH+"/account/list";
	}
	/**
	 * @param model
	 * 存放返回界面的model
	 * @return
	 */
	@ResponseBody
	@RequestMapping("query")
	public PageView query(Account account,String pageNow,String pagesize) {
		pageView = accountService.query(getPageView(pageNow,pagesize), account);
		return pageView;
	}
	
	@RequestMapping("exportExcel")
	public void exportExcel(HttpServletResponse response,Account account) {
		 List<Account> acs =accountService.queryAll(account);
		POIUtils.exportToExcel(response, "账号报表", acs, Account.class, "账号", acs.size());
	}
	/**
	 * 保存数据
	 * 
	 * @param model
	 * @param videoType
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("add")
	@ResponseBody
	public Map<String, Object> add(Account account) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			account.setPassword(Md5Tool.getMd5(account.getPassword()));
			accountService.add(account);
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
		}
		return map;
	}
	
	/**
	 * 跑到新增界面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("addUI")
	public String addUI(HttpServletRequest request) {
		List<City> citys=cityService.getCitys(request);
		request.setAttribute("citys", citys);
		return Common.BACKGROUND_PATH+"/account/add";
	}
	
	/**
	 * 账号角色页面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("accRole")
	public String accRole(Model model,String accountName,String roleName,String id) {
		Account account=accountService.getById(id);
		model.addAttribute("accountName", account.getAccountName());
		model.addAttribute("roleName", account.getRoleName());
		return Common.BACKGROUND_PATH+"/account/acc_role";
	}
	
	/**
	 * 跑到新增界面
	 * 
	 * @param model
	 * @return
	 */
	@RequestMapping("editUI")
	public String editUI(Model model,String accountId,HttpServletRequest request) {
		List<City> citys=cityService.getCitys(request);
		Account account = accountService.getById(accountId);
		model.addAttribute("account", account);
		model.addAttribute("citys", citys);
		return Common.BACKGROUND_PATH+"/account/edit";
	}
	
	/**
	 * 验证账号是否存在
	 * @param name
	 * @return
	 */
	@RequestMapping("isExist")
	@ResponseBody
	public boolean isExist(String name){
		Account account = accountService.isExist(name);
		if(account == null){
			return true;
		}else{
			return false;
		}
	}
	/**
	 * 删除
	 * 
	 * @param model
	 * @param videoTypeId
	 * @return
	 * @throws Exception 
	 */
	@ResponseBody
	@RequestMapping("deleteById")
	public Map<String, Object> deleteById(Model model, String ids) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String id[] = ids.split(",");
			for (String string : id) {
				if(!Common.isEmpty(string)){
				accountService.delete(string);
				}
			}
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
		}
		return map;
	}
	/**
	 * 删除
	 * 
	 * @param model
	 * @param videoTypeId
	 * @return
	 * @throws Exception 
	 */
	@ResponseBody
	@RequestMapping("updateState")
	public Map<String, Object> updateState(Model model, String ids,String state) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			String id[] = ids.split(",");
			for (String string : id) {
				if(!Common.isEmpty(string)){
					Account account = new Account();
					account.setId(Integer.parseInt(string));
					account.setState(state);
					accountService.update(account);
				}
			}
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
		}
		return map;
	}
	/**
	 * 更新类型
	 * 
	 * @param model
	 * @return
	 * @throws Exception 
	 */
	@ResponseBody
	@RequestMapping("update")
	public Map<String, Object> update(Model model, Account account) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
	
			account.setPassword(Md5Tool.getMd5(account.getPassword()));
			accountService.update(account);
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
		}
		return map;
	}
}