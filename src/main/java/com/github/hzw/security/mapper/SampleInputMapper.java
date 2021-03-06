package com.github.hzw.security.mapper;

import java.util.List;
import java.util.Map;

import com.github.hzw.base.BaseMapper;
import com.github.hzw.security.VO.SampleInputVO;
import com.github.hzw.security.entity.FlowerInfo;
import com.github.hzw.security.entity.SampleInput;

public interface SampleInputMapper extends BaseMapper<SampleInput>{
	
	public List<SampleInput>  queryReplay(Map<String, Object> map);
	
	public List<SampleInputVO> queryXinBan(Map<String, Object> map);
	
	/**
	 * 查询拖延单数
	 * @param dates
	 * @return
	 */
	public String queryDelayDates(String dates);
	
	public void updateStatus(String[] idsa);

	public List<SampleInputVO> queryReport(Map<String, Object> map);
	
}
