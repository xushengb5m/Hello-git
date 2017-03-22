package com.b5m.cpsx.utils;

import java.io.UnsupportedEncodingException;

import org.apache.commons.codec.binary.Hex;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.lang3.CharEncoding;
import org.apache.commons.lang3.StringUtils;

/**
 * @author janwen Apr 2, 2013 3:18:46 PM
 * 
 */
public class DigestUtils {

	/**
	 * 
	 @author janwen
	 * @param source
	 * @return md5加密后返回16进制
	 */
	public static String getMD5Hex(String source) {
		if (StringUtils.isNotBlank(source)) {
			try {
				return DigestUtils.md5Hex(source.getBytes(CharEncoding.UTF_8));
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
				return "";
			}
		} else {
			return "";
		}
	}

	public static void main(String[] args) {
		System.out.println(getMD5Hex(getMD5Hex(getMD5Hex(getMD5Hex("111111") + getMD5Hex("ali@b5m.com"))) + getMD5Hex("ali@b5m.com")));
	}

	/**
	 * 
	 @author janwen
	 * @param source
	 * @return 字符串转换ASCII字符，以16进制输出
	 */
	public static String str2ASCIIHex(String source) {
		if (StringUtils.isNotBlank(source)) {
			try {
				return Hex.encodeHexString(source.getBytes(CharEncoding.UTF_8));
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		return source;
	}

}
