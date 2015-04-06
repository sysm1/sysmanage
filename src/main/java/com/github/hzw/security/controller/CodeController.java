package com.github.hzw.security.controller;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.FlowerAdditional;
import com.github.hzw.security.entity.FlowerInfo;
import com.github.hzw.security.entity.Resources;
import com.github.hzw.security.service.FlowerAdditionalService;
import com.github.hzw.security.service.FlowerInfoService;
import com.github.hzw.util.Common;

@Controller
@RequestMapping("/background/code/")
public class CodeController extends BaseController {

	@Resource
	private FlowerInfoService flowerInfoService;

	@Inject
	private FlowerAdditionalService flowerAdditionalService;

	@RequestMapping("list")
	public String listCode(Model model, Resources menu, String pageNow,
			String pagesize, HttpServletRequest request) {
		String code = request.getParameter("code");
		if (StringUtils.isNotEmpty(code)) {
			pageView = flowerInfoService.queryCode(
					getPageView(pageNow, pagesize), code);
			model.addAttribute("pageView", pageView);
		}
		return Common.BACKGROUND_PATH + "/code/list";
	}

	@ResponseBody
	@RequestMapping("query")
	public PageView queryCode(HttpServletRequest request, String pageNow,
			String pagesize) {
		String code = request.getParameter("code");
		if (StringUtils.isEmpty(code))
			return getPageView(pageNow, pagesize);
		pageView = flowerInfoService.queryCode(getPageView(pageNow, pagesize),
				code);
		return pageView;
	}

	@RequestMapping("picture")
	public String picture(Model model, String id) {
		FlowerInfo info = flowerInfoService.getById(id);
		// model.addAttribute("flower", info);
		if (info != null && info.getPicture() != null) {
			model.addAttribute("picture", info.getPicture().split("[|]")[1]);
		}
		return Common.BACKGROUND_PATH + "/code/image";
	}

	@RequestMapping("detailColor")
	public String detailColor(Model model, String id) {
		System.out.println("id:" + id);
		FlowerInfo info = flowerInfoService.getById(id);
		String factoryCode = info.getFactoryCode();
		if (StringUtils.isNotEmpty(factoryCode)) {
			String[] codes = factoryCode.split("[,]");
			List<FlowerAdditional> list = new ArrayList<FlowerAdditional>();
			for (String code : codes) {
				FlowerAdditional add = new FlowerAdditional();
				add.setFactoryCode(code);
				List<FlowerAdditional> tmp = flowerAdditionalService
						.queryFind(add);
				list.addAll(tmp);
			}
			model.addAttribute("list", list);
		}
		return Common.BACKGROUND_PATH + "/code/color";
	}

}
