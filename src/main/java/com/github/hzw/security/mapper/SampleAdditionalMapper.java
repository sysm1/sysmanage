package com.github.hzw.security.mapper;

import com.github.hzw.base.BaseMapper;
import com.github.hzw.security.entity.SampleAdditional;

public interface SampleAdditionalMapper extends BaseMapper<SampleAdditional> {
	
	public void deleteBySampleId(String sampleId);

}
