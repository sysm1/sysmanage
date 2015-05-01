package com.github.hzw.test;

import org.junit.Test;

import com.github.hzw.util.MysqlUtils;

public class MysqlTest {

	
	@Test
	public void backupTest() {
		MysqlUtils.backup("system-manage");
	}
	
	@Test
	public void loadTest() {
		MysqlUtils.load("system-manage1");
	}
}
