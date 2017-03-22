/**   
 * @Title: ImageController.java 
 * @Package com.b5m.cpsx.ctrl.banx 
 * @Description: TODO
 * @author feitian  
 * @date 2016年6月14日 下午7:59:20 
 * @version V1.0   
 */
package com.b5m.cpsx.ctrl.banx;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.b5m.cpsx.utils.ImageUploadUtil;

/** 
 * @ClassName: ImageController 
 * @Description: TODO
 * @author feitian
 * @date 2016年6月14日 下午7:59:20 
 *  
 */
@Controller
@RequestMapping(value = "/banx/img")
public class ImageController {
	
	@RequestMapping("/image")
	@ResponseBody
	public List<String> getImageUrl(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		MultipartFile imgFile = multipartRequest.getFile("imgFile");
		List<String> data = new ArrayList<String>();
		data.add(ImageUploadUtil.ValidateImgFile(imgFile));
		byte[] imageData = imgFile.getBytes();
		String imgUrl = "http://upm01.b5m.com/"
				+ ImageUploadUtil.createImageName("b5m_dmp", "b5m_dmp",
						imageData);
		data.add(imgUrl);
		return data;
	}

}
