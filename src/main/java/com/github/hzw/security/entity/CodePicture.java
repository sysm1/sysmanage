package com.github.hzw.security.entity;

/**
 * 我司编号和图片的对应关系
 * @author wuyb
 *
 */
@SuppressWarnings("serial")
public class CodePicture implements java.io.Serializable{
	
	private String code;
	
	private String picture;
	
	private String smallPicture;

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	public String getSmallPicture() {
		return smallPicture;
	}

	public void setSmallPicture(String smallPicture) {
		this.smallPicture = smallPicture;
	}
	
	

}
