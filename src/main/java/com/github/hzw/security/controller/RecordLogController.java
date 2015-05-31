package com.github.hzw.security.controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.hzw.security.service.RecordLogService;
import com.github.hzw.util.Common;
import com.github.hzw.util.DateUtil;


@Controller
@RequestMapping("/background/recordLog/")
public class RecordLogController extends BaseController {

	@Inject
	private RecordLogService recordLogService;
	
	@ResponseBody
	@RequestMapping("count")
	public Map<String, Object> count(String model, String opType) {
		
		String username = Common.findAuthenticatedUsername();
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("username", username);
		map.put("model", model);
		map.put("opType", opType);
		map.put("opDate", DateUtil.date2Str(new Date(), "yyyy-MM-dd"));
		
		HashMap<String, Object> remap = new HashMap<String, Object>();
		
		try{
			int re = recordLogService.sum(map);
			remap.put("count", re);
			remap.put("code", 0);
			return remap;
		}catch(Exception ex) {
			ex.printStackTrace();
			remap.put("code", 1);
			return remap;
		}
	}

}
