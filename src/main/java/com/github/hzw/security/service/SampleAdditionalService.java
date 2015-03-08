package com.github.hzw.security.service;

import java.util.List;

import com.github.hzw.base.BaseService;
import com.github.hzw.security.entity.SampleAdditional;

public interface SampleAdditionalService extends BaseService<SampleAdditional> {
	
	/**
	 * 删除开版进度附属信息
	 * @param sampleId 开版进度ID
	 */
	public void deleteBySampleId(String sampleId);
	
	public List<SampleAdditional> queryByMyCompCode(SampleAdditional SampleAdditional);

}
