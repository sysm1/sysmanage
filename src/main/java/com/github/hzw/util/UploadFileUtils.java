package com.github.hzw.util;

import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.github.hzw.security.controller.UploadController;

/**
 * 文件上传
 * @author wuyb
 *
 */
public class UploadFileUtils {
	
	 private final static float FINAL_SCALE = 0.5f; // 默认压缩比为0.5
	 private final static String OUTPUT_PATH_NAME = "e:\\new\\newImg.JPG"; // 输出图文件路径+文件名
	 private final static int MAX_WIDTH = 100; // 输出图片最大宽 度 
	 private final static int MAX_HEIGHT = 100; // 输出图片最大宽 度 

	/**
	 * 保存上传文件
	 * @param request
	 * @return
	 */
	public static String[] saveUploadFile(HttpServletRequest request){
		MultipartHttpServletRequest multipartRequest  =  (MultipartHttpServletRequest) request;  
        //  获得第1张图片（根据前台的name名称得到上传的文件）   
        List<MultipartFile> myFiles =  multipartRequest.getFiles("myFile");
        String[] myCompanyCode=request.getParameterValues("");
        String[] destPaths=new String[myFiles.size()];
        int size=0;
        
        final int BUFFER_SIZE = 16 * 1024 ;
        OutputStream out = null ;
        InputStream in=null;
        File  dst=null;
        //图片保存目标路径
        String dstPath=PropertiesUtils.findPropertiesKey("pic_path");
        String curProjectPath = request.getSession().getServletContext().getRealPath("/");
		dstPath = curProjectPath + "/" + UploadController.getUploadfoldername();
        try {
	        for(MultipartFile myFile:myFiles){
	        	if(null==myFile){
	            	return null;
	            }
	            File path=new File(dstPath);
	            if(!path.exists()){
	            	path.mkdirs();
	            }
	            String picName=myFile.getOriginalFilename();
	            if("".equals(picName)){
	            	return null;
	            }
	            String dstPicPath=dstPath+picName;
	            dst=new File(dstPicPath);
	            
            	in =myFile.getInputStream();
            	out = new BufferedOutputStream( new FileOutputStream(dst), BUFFER_SIZE);
            	byte [] buffer = new byte [BUFFER_SIZE];
            	while (in.read(buffer) > 0 ) {
            		out.write(buffer);
            	}
            	destPaths[size++]=dstPicPath;
            }
		} catch (IOException e1) {
			e1.printStackTrace();
		}finally{
			try {
				if ( null != in) {
				in.close();
				}
				if ( null != out) {
					out.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
        return destPaths;
	}
	
	 
	 
	 /** 
	  * 图片压缩处理
	  * @param inputFilePath 输入图文件路径
	  * @return
	  * 
	  */
	public static String compressPicture(String inputFilePath) {
		File file = null;
		try {
	   // 获得源文件
	   file = new File(inputFilePath);
	   if (!file.exists()) {
	    return "";
	   }
	   Image img = ImageIO.read(file);
	   // 判断图片格式是否正确
	   if (img.getWidth(null) == -1) {
	    System.out.println(" can't read,retry!" + "<BR>");
	    return "no";
	   } else {
	    int newWidth;
	    int newHeight;
	 
	    // 输出的图片宽度
	    newWidth = img.getWidth(null);
	    // 输出的图片高度
	    newHeight = img.getHeight(null);
	 
        // 按比例计算出来的压缩比
        float realscale = getRatio(newWidth, newHeight);
        float finalScale = Math.min(FINAL_SCALE, realscale);// 取压缩比最小的进行压缩
        newWidth = (int) (finalScale * newWidth);
        newHeight = (int) (finalScale * newHeight); 
	             
	    BufferedImage newImg = new BufferedImage((int) newWidth, (int) newHeight, BufferedImage.TYPE_INT_RGB);
	    
	    // 根据图片尺寸压缩比得到新图的尺寸
	    newImg.getGraphics().drawImage(img.getScaledInstance(newWidth, newHeight,Image.SCALE_SMOOTH), 0, 0, null);
	    
	    // 调用方法输出图片文件  
	    OutImage(newImg); 
	    
	    FileOutputStream out = new FileOutputStream(OUTPUT_PATH_NAME);
	    out.close();
	   }
	  } catch (IOException ex) {
	   ex.printStackTrace();
	  }
	  return OUTPUT_PATH_NAME;
	 }
	 
	 /** 
	  * 将图片文件输出到指定的路径
	  * @param newImg  
	  * per 
	  */  
	 private static void OutImage(BufferedImage newImg) {  
		// 判断输出的文件夹路径是否存在，不存在则创建  
		File file = new File(OUTPUT_PATH_NAME);  
		if (!file.getParentFile().exists()) {
			file.getParentFile().mkdirs();
		}// 输出到文件流  
		try {
			ImageIO.write(newImg, OUTPUT_PATH_NAME.substring(OUTPUT_PATH_NAME.lastIndexOf(".") + 1), new File(OUTPUT_PATH_NAME));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	 }
	 
	 /** 
	  * 获得压缩比率
	  * @param width 图片宽 度
	  * @param height 图片高 度
	  * @return 压缩比率
	  */
	  private static float getRatio(int width, int height) {
	         float Ratio = 1.0f;
	         float widthRatio;
	         float heightRatio;
	         widthRatio = (float) MAX_WIDTH / width;
	         heightRatio = (float) MAX_HEIGHT / height;
	         if (widthRatio < 1.0 || heightRatio < 1.0) {
	             Ratio = widthRatio <= heightRatio ? widthRatio : heightRatio;
	         }
	         return Ratio;
	 }

	  /** 
	   * 获得图片大小
	   * @param path 图片路径
	   * @return 图片大小
	   */
	  public long getPicSize(String path) {
	   File file = new File(path);
	   return file.length();
	  }
	
}
