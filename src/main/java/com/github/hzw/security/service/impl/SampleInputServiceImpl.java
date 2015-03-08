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
	
	public List<SampleInput> queryList(SampleInput t){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("t", t);
		List<SampleInput> list = sampleInputMapper.query(map);
		return list;
	}

	/**
	 * 查询已回开版进度
	 * @param pageView
	 * @param t
	 * @return
	 */
	@Override
	public PageView queryReplay(PageView pageView,SampleInput t){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<SampleInput> list = sampleInputMapper.queryReplay(map);
		pageView.setRecords(list);
		return pageView;
	}
	
	/**
	 * 查询新版数据  如果不存在相同的我司编号 为新版
	 * @param pageView
	 * @param t
	 * @return 
	 */
	public PageView queryXinBan(PageView pageView,SampleInput t){
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("paging", pageView);
		map.put("t", t);
		List<SampleInput> list = sampleInputMapper.queryReplay(map);
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
		String type=request.getParameter("type");
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
				sampleAdditional.setType(Integer.parseInt("1".equals(type)?"1":"0"));
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
				sampleAdditional.setType(Integer.parseInt("1".equals(type)?"1":"0"));
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
			bean.setReplyDate(sampleInput.getReplyDate());
			bean.setReplyMark(sampleInput.getReplyMark());
			bean.setType(0);//默认值为0  未回状态
			//已回时 判断其状态
			
			if("1".equals(type)){
				bean.setType(1);//已回
				//判断新版
				SampleInput si=new SampleInput();
				si.setMyCompanyCode(sampleInput.getMyCompanyCode());
				si.setType(1);
				List<SampleInput> slist= queryList(si);
				if(slist.size()==0){//新版  先判断新版 再到后面判断是否是其他状态
					sampleInput.setStatus(1);
				}
				//判断其他状态
				SampleAdditional sampleAdd=new SampleAdditional();
				sampleAdd.setFactoryCode(factoryCode1);
				sampleAdd.setType(1);
				List<SampleAdditional> list=sampleAdditionalService.queryAll(sampleAdd);
				if(list.size()>0){
					boolean newColor=true;
					if(!checkNewColor(list,colors)){
						newColor=false;
					}
					sampleAdd.setFactoryCode(factoryCode2);
					list=sampleAdditionalService.queryAll(sampleAdd);
					if(list.size()==0){
						bean.setStatus(2);//新厂
					}else{
						if(!checkNewColor(list,colors)){
							newColor=false;
						}
					}
					if(newColor){
						bean.setStatus(3);//新色
					}else{
						bean.setStatus(4);//重复
					}
				}else{
					bean.setStatus(2);//新厂
				}
			}
			update(bean);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 验证是否有相同的数据
	 * @param list
	 * @param stra
	 * @return
	 */
	public boolean checkNewColor(List<SampleAdditional> list,String[] stra){
		for(SampleAdditional sm:list){
			for(String color:stra){
				if(sm.getFactoryColor().equals(color)){
					return false;
				}
			}
			
		}
		return true;
	}
}
