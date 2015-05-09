package com.github.hzw.security.service;

import java.util.List;


public interface ReportService {

	public void importFlower(List<List<String>> list) throws Exception;
	
	public void importAllowance(List<List<String>> list) throws Exception;
	
	public void importSummary(List<List<String>> list);
}
