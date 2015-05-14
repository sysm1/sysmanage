package com.github.hzw.security.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.github.hzw.pulgin.mybatis.plugin.PageView;
import com.github.hzw.security.VO.SampleInputVO;
import com.github.hzw.security.entity.FlowerAdditional;
import com.github.hzw.security.entity.FlowerInfo;
import com.github.hzw.security.entity.SampleAdditional;
import com.github.hzw.security.entity.SampleInput;
import com.github.hzw.security.mapper.SampleInputMapper;
import com.github.hzw.security.service.FlowerAdditionalService;
import com.github.hzw.security.service.FlowerInfoService;
import com.github.hzw.security.service.SampleAdditionalService;
import com.github.hzw.security.service.SampleInputService;
@Transactional
@Service("sampleInputService")
public class SampleInputServiceImpl implements SampleInputService {

	@Autowired
	private SampleInputMapper sampleInputMapper;
	
	@Autowired
	private SampleAdditionalService sampleAdditionalService;
	
	@Autowired
	private FlowerInfoService flowerInfoService;
	
	@Autowired
	private FlowerAdditionalService flowerAdditionalService;
	
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
	 * 查询拖延单数
	 * @param dates
	 * @return
	 */
	public String queryDelayDates(String dates){
		return sampleInputMapper.queryDelayDates(dates);
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
	public List<FlowerInfo> queryXinBan(PageView pageView,FlowerInfo t){
		List<FlowerInfo> list = flowerInfoService.queryAll(t);
		return list;
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
		sampleAdditionalService.deleteBySampleId(t.getId()+"");
		SampleAdditional sampleAdditional=new SampleAdditional();
		sampleAdditional.setSampleId(t.getId());
		sampleAdditional.setFactoryCode(t.getFactoryCode());
		sampleAdditional.setMyCompanyCode(t.getMyCompanyCode());
		sampleAdditionalService.add(sampleAdditional);
	}
	
	@Override
	public void saveTemp(HttpServletRequest request,SampleInput sampleInput){
		String type=request.getParameter("type");
		SampleInput bean=new SampleInput();
		bean=getById(sampleInput.getId()+"");
		bean.setPicture(sampleInput.getPicture());
		bean.setSmallPicture(sampleInput.getSmallPicture());
		bean.setFileCode(sampleInput.getFileCode());
		if(null!=sampleInput.getMyCompanyCode()){
			bean.setMyCompanyCode(sampleInput.getMyCompanyCode());
		}
		String factoryCode1=request.getParameter("factoryCode1");
		String factoryCode2=request.getParameter("factoryCode2");
		String[] colors=request.getParameterValues("factoryColor1");
		String[] colors2=request.getParameterValues("factoryColor2");
		
		//点击已回按钮时 判断其状态    从花号基本资料里判断		
		if("1".equals(type)){
			//判断新版
			FlowerInfo t=new FlowerInfo();
			t.setMyCompanyCode(sampleInput.getMyCompanyCode());
			List<FlowerInfo> flist = flowerInfoService.queryAll(t);
			
			if(flist.size()==0){//新版  先判断新版 再到后面判断是否是其他状态
				bean.setStatus(1);
			}else{
				//判断其他状态 是否是新厂
				t.setMyCompanyCode(sampleInput.getMyCompanyCode());
				t.setFactoryId(sampleInput.getFactoryId());
				flist = flowerInfoService.queryAll(t);
				if(flist.size()==0){
					bean.setStatus(2);
				}else{
					FlowerAdditional fa=new FlowerAdditional();
					Integer id=flist.get(0).getId();
					fa.setFlowerId(id);
					List<FlowerAdditional> falist=flowerAdditionalService.queryAll(fa);
					if(checkNewColor(falist,colors,colors2)){
						bean.setStatus(3);//新色			
					}else{
						bean.setStatus(4);//重复
					}
				}
			}
		}
		
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
			bean.setReplyDate(sampleInput.getReplyDate());
			bean.setReplyMark(sampleInput.getReplyMark());
			update(bean);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void updateStatus(String[] idsa){
		sampleInputMapper.updateStatus(idsa);
	}
	
	/**
	 * 是否是新色
	 * @param list
	 * @param stra
	 * @return true 是新色
	 */
	public boolean checkNewColor(List<FlowerAdditional> list,String[] stra,String[] stra2){
		if(null!=stra){
			for(String str:stra){
				int size=0;
				for(FlowerAdditional fa:list){
					if(!str.equals(fa.getFactoryColor())){
						size++;
					}
				}
				if(size>0){
					return true;//新色
				}
			}
		}
		if(null!=stra2){
			for(String str:stra2){
				int size=0;
				for(FlowerAdditional fa:list){
					if(!str.equals(fa.getFactoryColor())){
						size++;
					}
				}
				if(size>0){
					return true;//新色
				}
			}
		}
		return false;
	}
	
	
	public List<SampleInputVO> queryReport(Map<String, Object> map){
		return this.sampleInputMapper.queryReport(map);
	}

}
