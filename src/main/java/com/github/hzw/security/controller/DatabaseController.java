package com.github.hzw.security.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.hzw.security.entity.Account;
import com.github.hzw.security.entity.Resources;
import com.github.hzw.util.Common;
import com.github.hzw.util.Md5Tool;
import com.github.hzw.util.MysqlUtils;


@Controller
@RequestMapping("/background/db/")
public class DatabaseController extends BaseController {
	
	@RequestMapping("list")
	public String list(Model model, Resources menu, String pageNow) {
		return Common.BACKGROUND_PATH+"/db/list";
	}
	
	@RequestMapping("exportAll")
	@ResponseBody
	public Map<String, Object> exportAll() {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			MysqlUtils.export("system-manage", "", "all.sql");
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
		}
		return map;
	}
	
	
	@RequestMapping("importAll")
	@ResponseBody
	public Map<String, Object> importAll() {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			MysqlUtils.importAll("system-manage", "", "all.sql");
			map.put("flag", "true");
		} catch (Exception e) {
			map.put("flag", "false");
		}
		return map;
	}
	
}
