package com.b5m.cpsx.utils;

import java.io.IOException;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.PostMethod;
import org.apache.commons.httpclient.methods.multipart.ByteArrayPartSource;
import org.apache.commons.httpclient.methods.multipart.FilePart;
import org.apache.commons.httpclient.methods.multipart.MultipartRequestEntity;
import org.apache.commons.httpclient.methods.multipart.Part;
import org.apache.commons.httpclient.methods.multipart.StringPart;
import org.springframework.web.multipart.MultipartFile;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

/**
 * @ClassName: ImageUploadUtil
 * @Description: TODO
 * @author feitian
 * @date 2015年10月23日 下午1:41:33
 * 
 */
public class ImageUploadUtil {
	public static String createImageName(String userName, String topic,
			byte[] imageData) {
		HttpClient hc = new HttpClient();
		PostMethod pm = new PostMethod("http://10.30.99.38:8999/imageUpload");
		final String uuid = String.valueOf(System.currentTimeMillis());
		Part[] parts = { new StringPart("userName", userName),
				new StringPart("topic", topic),
				new FilePart(uuid, new ByteArrayPartSource("", imageData)) };
		try {
			MultipartRequestEntity mre = new MultipartRequestEntity(parts,
					pm.getParams());
			pm.setRequestEntity(mre);
			hc.executeMethod(pm);
			String body = pm.getResponseBodyAsString();
			String name = readImgName(uuid, body);
			return name;
		} catch (IOException e) {
			throw new RuntimeException(e);
		} finally {
			pm.releaseConnection();
		}
	}

	/**
	 * @Title: readImgName
	 * @Description: TODO
	 * @param @param uuid
	 * @param @param body
	 * @param @return
	 * @return String
	 * @throws
	 */
	private static String readImgName(String uuid, String body) {
		JSONObject parseObject = JSONObject.parseObject(body);
		String jsonStr = parseObject.getString("data");
		JSONArray jArray = JSONObject.parseArray(jsonStr);
		for (int i = 0; i < jArray.size(); i++) {
			JSONObject jObject = jArray.getJSONObject(i);
			if (jObject.containsKey("data")) {
				return String.valueOf(jObject.getJSONObject("data").get(uuid));
			}
		}
		return null;
	}

	/** 
	 * @Title: ValidateImgFile 
	 * @Description: TODO
	 * @param @param imgFile
	 * @param @return
	 * @return boolean
	 * @throws 
	 */
	public static String ValidateImgFile(MultipartFile imgFile) {
		Long size = imgFile.getSize();
		if(size > 1024 * 1024) {
			return "图片尺寸不得大于1M！";
		} else {
			return "图片上传成功！";
		}

	}
}
