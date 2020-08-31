package com.zzqa.util;

import java.io.UnsupportedEncodingException;

/*****
 * 字符串样式处理
 * @author louph
 *
 */
public class FormTransform {
	static byte bytes[] = {(byte) 0xC2,(byte) 0xA0};//替换的空格 utf-8
	//转换回车符
	public String transRNToBR(String str){
		if(str!=null){
			return str.replace("\r\n", "<br/>").replace("\n\r", "<br/>").replace("\r", "<br/>").replace("\n", "<br/>");
		}
		return "";
	}
	public String transRNToBR_O(String str){
		if(str!=null){
			return str.replace("<", "&lt;").replace("\r\n", "<br/>").replace("\n\r", "<br/>").replace("\r", "<br/>").replace("\n", "<br/>").replace("&nbsp;", " ");
		}
		return "";
	}
	public String removeRN(String str){
		if(str!=null){
			return str.replace("\r\n", "").replace("\n\r", "").replace("\r", "").replace("\n", "");
		}
		return "";
	}
	public String transHtml(String str){
		if(str!=null){
			return str.replace("<", "&lt;");
		}
		return "";
	}
	public String showOnTextArea(String str){
		if(str!=null){
			 String UTFSpace;
			try {
				UTFSpace = new String(bytes,"utf-8");
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return "\r\n"+str.replace("<br/>", "\r\n").replace(" ", " ").replace("？", " ");
			}
			return "\r\n"+str.replace("<br/>", "\r\n").replace(" ", " ");
		}
		return "";
	}
}
