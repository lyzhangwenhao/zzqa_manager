package com.zzqa.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
/*******
 * md5加密
 * @author louph
 *
 */
public class MD5Util {
	/*public static void main(String[] args) {
		//windit2010-->bd1f5b242d26164690b938917e66e732
		//insert into user values(null,'admin','bd1f5b242d26164690b938917e66e732','超级管理员','',0,1462342077832,1462342077832)
		System.out.println(System.currentTimeMillis());
		System.out.println(new MD5Util().getMd5("windit2010"));
	}*/
	StringBuffer suffix=new StringBuffer("manager");
	public String getMD5(byte[] source) {
        String s = null;
        char[] hexDigits = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
                'a', 'b', 'c', 'd', 'e', 'f'};
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(source);
            byte[] tmp = md.digest();
            char[] str = new char[16 * 2];
            int k = 0;
            for (int i = 0; i < 16; i++) {
                byte byte0 = tmp[i];
                str[k++] = hexDigits[byte0 >>> 4 & 0xf];
                str[k++] = hexDigits[byte0 & 0xf];
            }
            s = new String(str);
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        }
        return s;
    }
    public String getMd5(String plainText ) {
        StringBuffer buf =null;
        try {
        	suffix.append(plainText);
            MessageDigest md = MessageDigest.getInstance("MD5");
            md.update(suffix.toString().getBytes());
            byte b[] = md.digest();
            int i;
            buf = new StringBuffer("");
            for (int offset = 0; offset < b.length; offset++) {
                i = b[offset];
                if(i<0) i+= 256;
                if(i<16)
                    buf.append("0");
                buf.append(Integer.toHexString(i));
            }
//            System.out.println("16位的加密: " + buf.toString().substring(8,24));//16位的加密
        } catch (NoSuchAlgorithmException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return buf.toString();
    }
}
