package com.github.hzw.security.controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.github.hzw.security.entity.Resources;
import com.github.hzw.util.Common;

/**
 * 坯布采购
 * @author wuyb
 *
 */
public class ClothPurchaseController extends BaseController {
	
	@RequestMapping("list")
	public String list(Model model, Resources menu, String pageNow) {
		return Common.BACKGROUND_PATH+"/account/list";
	}
}
