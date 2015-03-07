package com.github.hzw.security.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.entity.SampleAdditional;
import com.github.hzw.security.entity.SampleInput;
import com.github.hzw.security.mapper.SampleInputMapper;
import com.github.hzw.security.service.SampleInputService;
import com.github.hzw.security.service.SampleAdditionalService;

@Transactional
@Service("sampleInputService")
public class SampleInputServiceImpl implements SampleInputService {

	@Autowired
	private SampleInputMapper sampleInputMapper;
	
	@Autowired
	private SampleAdditionalService sampleAdditionalService;
	
	@Override
	public PageView query(PageView pageView, SampleInput t) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<SampleInput> list = sampleInputMapper.query(map);
		pageView.setRecords(list);
		return pageView;
	}

	
	@Override
	public List<SampleInput> queryAll(SampleInput t) {
		return sampleInputMapper.queryAll(t);
	}

	@Override
	public void delete(String id) throws Exception {
		sampleInputMapper.delete(id);		
	}
	

	@Override
	public void update(SampleInput t) throws Exception {
		this.sampleInputMapper.update(t);
		
	}

	@Override
	public SampleInput getById(String id) {
		return this.sampleInputMapper.getById(id);
	}

	@Override
	public void add(SampleInput t) throws Exception {
		this.sampleInputMapper.add(t);
	}
	
	@Override
	public void saveTemp(HttpServletRequest request,SampleInput sampleInput){
		SampleInput bean=new SampleInput();
		bean=getById(sampleInput.getId()+"");
		if(null!=sampleInput.getMyCompanyCode()){
			bean.setMyCompanyCode(sampleInput.getMyCompanyCode());
		}
		
		String factoryCode1=request.getParameter("factoryCode1");
		String factoryCode2=request.getParameter("factoryCode2");
		String[] colors=request.getParameterValues("factoryColor1");
		String[] colors2=request.getParameterValues("factoryColor2");
		//先清除表中的数据在往表中插入数据
		sampleAdditionalService.deleteBySampleId(sampleInput.getId()+"");
		SampleAdditional sampleAdditional=null;
		try {
			if(!"".equals(factoryCode1)&&null!=factoryCode1){
				int i=0;
				sampleAdditional=new SampleAdditional();
				sampleAdditional.setFactoryCode(factoryCode1);
				sampleAdditional.setSampleId(sampleInput.getId());
				for(String color:colors){
					if(!"".endsWith(color)&&null!=color){
						sampleAdditional.setFactoryColor(color);
						sampleAdditionalService.add(sampleAdditional);
						i++;
					}
				}
				if(i==0){
					sampleAdditionalService.add(sampleAdditional);
				}
				
			}if(!"".equals(factoryCode2)&&null!=factoryCode2){
				int i=0;
				sampleAdditional=new SampleAdditional();
				sampleAdditional.setFactoryCode(factoryCode2);
				sampleAdditional.setSampleId(sampleInput.getId());
				for(String color:colors2){
					if(!"".endsWith(color)&&null!=color){
						sampleAdditional.setFactoryColor(color);
						sampleAdditionalService.add(sampleAdditional);
						i++;
					}
				}
				if(i==0){
					sampleAdditionalService.add(sampleAdditional);
				}
			}
			bean.setStatus(sampleInput.getStatus());
			update(bean);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
