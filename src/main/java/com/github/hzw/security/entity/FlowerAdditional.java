package com.github.hzw.security.entity;

public class FlowerAdditional {
   
	private Integer id;

    private Integer flowerId;

    private String factoryCode;

    private String factoryColor;

    private String myCompanyCode;

    private String myCompanyColor;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getFlowerId() {
        return flowerId;
    }

    public void setFlowerId(Integer flowerId) {
        this.flowerId = flowerId;
    }

    public String getFactoryCode() {
        return factoryCode;
    }

    public void setFactoryCode(String factoryCode) {
        this.factoryCode = factoryCode;
    }

    public String getFactoryColor() {
        return factoryColor;
    }

    public void setFactoryColor(String factoryColor) {
        this.factoryColor = factoryColor;
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

	@Override
	public String toString() {
		return "FlowerAdditional [id=" + id + ", flowerId=" + flowerId
				+ ", factoryCode=" + factoryCode + ", factoryColor="
				+ factoryColor + ", myCompanyCode=" + myCompanyCode
				+ ", myCompanyColor=" + myCompanyColor + "]";
	}
    
    
}