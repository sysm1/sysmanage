package com.github.hzw.security.entity;

public class SampleAdditional {

	private Integer id;

    private Integer sampleId;

    private String factoryCode;

    private String factoryColor;
    
    /***0 未回  1已回**/
    private Integer type;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getSampleId() {
        return sampleId;
    }

    public void setSampleId(Integer sampleId) {
        this.sampleId = sampleId;
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

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}
}