package com.github.hzw.security.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.hzw.security.entity.Password;
import com.github.hzw.security.entity.Resources;
import com.github.hzw.security.service.PasswordService;
import com.github.hzw.util.Common;

@Controller
@RequestMapping("/background/password/")
public class PasswordController extends BaseController{

	private static Logger logger = LoggerFactory.getLogger(PasswordController.class);
	
	@Inject
	private PasswordService passwordService;
	
	@RequestMapping("list")
	public String list(Model model, Resources menu, String pageNow) {
		List<Password> list = passwordService.queryAll(null);
		model.addAttribute("passwd", list.get(0).getPasswd());
		model.addAttribute("num", list.get(1).getNum());
		return Common.BACKGROUND_PATH+"/password/list";
	}
	
	
	@ResponseBody
	@RequestMapping("updatePasswd")
	public Map<String, Object> updatePasswd(HttpServletRequest request, Password info) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(info.getId() != 1) {
			map.put("flag", "false");
			logger.error("id error");
			return map;
		}
		
		if(StringUtils.isEmpty(info.getPasswd())) {
			map.put("flag", "false");
			logger.error("passwd error");
			return map;
		}
		
		try{
			passwordService.update(info);
			map.put("flag", "true");
			return map;
		}catch(Exception e){
			logger.error("", e);
			map.put("flag", "false");
			return map;
		}
	}
	
	@ResponseBody
	@RequestMapping("updateNum")
	public Map<String, Object> updateNum(HttpServletRequest request, Password info) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		if(info.getId() != 2) {
			map.put("flag", "false");
			logger.error("id error");
			return map;
		}
		
		try{
			passwordService.update(info);
			map.put("flag", "true");
			return map;
		}catch(Exception e){
			logger.error("", e);
			map.put("flag", "false");
			return map;
		}
	}
	
}
