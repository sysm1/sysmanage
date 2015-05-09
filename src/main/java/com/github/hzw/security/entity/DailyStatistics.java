package com.github.hzw.security.entity;

import java.util.Date;

/**
 * 每日统计
 * @author wuyb
 *
 */
public class DailyStatistics implements java.io.Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -4641157121951280908L;

	private Integer id;
	
	/**当日现金**/
	private Double cash;
	
	/**当日销售额**/
	private Double sales;
	
	/**当日合计欠款**/
	private Double arrears;
	
	/***昨日实际结余**/
	private Double balanceYesterday;
	
	/**当日应结余现金**/
	private Double balanceToday;
	
	/**当日实际结余**/
	private Double balanceActual;
	
	/**当日应结实结金额**/
	private Double balanceShouldActual;
	
	/**日期***/
	private String today;
	
	private String company;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	/**当日现金**/
	public Double getCash() {
		return cash;
	}
	/**当日现金**/
	public void setCash(Double cash) {
		this.cash = cash;
	}

	public Double getSales() {
		return sales;
	}

	public void setSales(Double sales) {
		this.sales = sales;
	}
	/**当日合计欠款**/
	public Double getArrears() {
		return arrears;
	}
	/**当日合计欠款**/
	public void setArrears(Double arrears) {
		this.arrears = arrears;
	}
	/***昨日实际结余**/
	public Double getBalanceYesterday() {
		return balanceYesterday;
	}
	/***昨日实际结余**/
	public void setBalanceYesterday(Double balanceYesterday) {
		this.balanceYesterday = balanceYesterday;
	}

	/**当日应结余现金**/
	public Double getBalanceToday() {
		return balanceToday;
	}

	/**当日应结余现金**/
	public void setBalanceToday(Double balanceToday) {
		this.balanceToday = balanceToday;
	}

	public Double getBalanceActual() {
		return balanceActual;
	}

	public void setBalanceActual(Double balanceActual) {
		this.balanceActual = balanceActual;
	}
	/**当日应结实结金额**/
	public Double getBalanceShouldActual() {
		return balanceShouldActual;
	}
	/**当日应结实结金额**/
	public void setBalanceShouldActual(Double balanceShouldActual) {
		this.balanceShouldActual = balanceShouldActual;
	}

	public String getToday() {
		return today;
	}

	public void setToday(String today) {
		this.today = today;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}
}
