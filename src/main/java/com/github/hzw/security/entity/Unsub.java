package com.github.hzw.security.entity;

import java.util.Date;

import org.codehaus.jackson.map.annotate.JsonSerialize;

import com.github.hzw.util.JsonDate4YYYYMMDD;

/**
 * 退货
 * @author wuyb
 *
 */
@SuppressWarnings("serial")
public class Unsub implements java.io.Serializable{
	
	private Integer id;
	
	/**退货日期**/
	private Date unsubdate;
	
	/**退货日期 开始时间**/
	private Date unsubdates;
	
	/**退货日期 结束时间**/
	private Date unsubdatee;
	
	/**工艺ID**/
	private Integer technologyId;
	
	private String technologyName;
	
	private Integer clothId;
	
	private Integer ysnum;
	
	private String ysresult;
	
	private String clothName;
	
	private String myCompanyCode;
	
	private String myCompanyColor;
	
	private Integer num;
	
	/***客户反映质量问题**/
	private String qualityProblem;
	
	private Integer factoryId;
	
	private String factoryName;
	
	private String factoryCode;

    private String factoryColor;
    
    private Date returnDate;
    
    private Date returnDates;
    
    private Date returnDatee;
    
    private String rdate;
    
    private Date updatetime;
    
    /****我司验货报告**/
    private String myCompanyReport;
    
    /**工厂交涉情况**/
    private String negotiate;
    
    @JsonSerialize(using=JsonDate4YYYYMMDD.class)
	public Date getUnsubdate() {
		return unsubdate;
	}

	public void setUnsubdate(Date unsubdate) {
		this.unsubdate = unsubdate;
	}

	public Integer getClothId() {
		return clothId;
	}

	public void setClothId(Integer clothId) {
		this.clothId = clothId;
	}

	public String getMyCompanyCode() {
		return myCompanyCode;
	}

	public void setMyCompanyCode(String myCompanyCode) {
		this.myCompanyCode = myCompanyCode;
	}

	public String getMyCompanyColor() {
		return myCompanyColor;
	}

	public void setMyCompanyColor(String myCompanyColor) {
		this.myCompanyColor = myCompanyColor;
	}

	public Integer getNum() {
		return num;
	}

	public void setNum(Integer num) {
		this.num = num;
	}

	public String getQualityProblem() {
		return qualityProblem;
	}

	public void setQualityProblem(String qualityProblem) {
		this.qualityProblem = qualityProblem;
	}

	public Integer getFactoryId() {
		return factoryId;
	}

	public void setFactoryId(Integer factoryId) {
		this.factoryId = factoryId;
	}

	public String getFactoryCode() {
		if(null==factoryCode){
			factoryCode="";
		}
		return factoryCode;
	}

	public void setFactoryCode(String factoryCode) {
		this.factoryCode = factoryCode;
	}

	public String getFactoryColor() {
		if(null==factoryColor){
			factoryColor="";
		}
		return factoryColor;
	}

	public void setFactoryColor(String factoryColor) {
		this.factoryColor = factoryColor;
	}

	@JsonSerialize(using=JsonDate4YYYYMMDD.class)
	public Date getReturnDate() {
		return returnDate;
	}

	public String getRdate() {
		if(null==returnDate){
			rdate="";
		}else{
			getReturnDate().toString();
		}
		return rdate;
	}

	public void setRdate(String rdate) {
		this.rdate = rdate;
	}

	public void setReturnDate(Date returnDate) {
		this.returnDate = returnDate;
	}

	public String getMyCompanyReport() {
		if(null==myCompanyReport){
			myCompanyReport="";
		}
		return myCompanyReport;
	}

	public void setMyCompanyReport(String myCompanyReport) {
		this.myCompanyReport = myCompanyReport;
	}

	/**工厂交涉情况**/
	public String getNegotiate() {
		if(null==negotiate){
			negotiate="";
		}
		return negotiate;
	}

	/**工厂交涉情况**/
	public void setNegotiate(String negotiate) {
		this.negotiate = negotiate;
	}

	public Date getUnsubdates() {
		return unsubdates;
	}

	public void setUnsubdates(Date unsubdates) {
		this.unsubdates = unsubdates;
	}

	public Date getUnsubdatee() {
		return unsubdatee;
	}

	public void setUnsubdatee(Date unsubdatee) {
		this.unsubdatee = unsubdatee;
	}

	public Date getReturnDates() {
		return returnDates;
	}

	public void setReturnDates(Date returnDates) {
		this.returnDates = returnDates;
	}

	public Date getReturnDatee() {
		return returnDatee;
	}

	public void setReturnDatee(Date returnDatee) {
		this.returnDatee = returnDatee;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getClothName() {
		return clothName;
	}

	public void setClothName(String clothName) {
		this.clothName = clothName;
	}

	public String getFactoryName() {
		if(null==factoryName){
			factoryName="";
		}
		return factoryName;
	}

	public void setFactoryName(String factoryName) {
		this.factoryName = factoryName;
	}

	public Integer getTechnologyId() {
		return technologyId;
	}

	public void setTechnologyId(Integer technologyId) {
		this.technologyId = technologyId;
	}

	public String getTechnologyName() {
		return technologyName;
	}

	public void setTechnologyName(String technologyName) {
		this.technologyName = technologyName;
	}

	public Integer getYsnum() {
		return ysnum;
	}

	public void setYsnum(Integer ysnum) {
		this.ysnum = ysnum;
	}

	public String getYsresult() {
		return ysresult;
	}

	public void setYsresult(String ysresult) {
		this.ysresult = ysresult;
	}

	public Date getUpdatetime() {
		return updatetime;
	}

	public void setUpdatetime(Date updatetime) {
		if(null==updatetime){
			updatetime=new Date();
		}
		this.updatetime = updatetime;
	}

}
