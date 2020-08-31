package com.zzqa.util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class PurchaseNum {
	
	/**
	 * 月份对应字符
	 */
	private static final String[] stringMonth=new String[]{"","1","2","3","4","5","6","7","8","9","O","N","D"};
	/**
	 * 申请单序号第一位
	 */
	private static final String[] purchaseNumFirst=new String[]{"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","N","T","U","V","W","X","Y","Z"};
	/**
	 * 申请单序号第二位
	 */
	private static final String[] purchaseNumSecond=new String[]{"0","1","2","3","4","5","6","7","8","9"};
	
	/**
	 * 老版采购单编号
	 * @param num
	 * @return
	 */
	public static String getPurchaseNum(int num) {
		if(num<0){
			return null;
		}
		StringBuffer buffer = new StringBuffer("ZZQA-HSG");
		String time = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		String[] array=time.split("-");
		String year=array[0].substring(2, 4);
		int month=Integer.valueOf(array[1]);
		int day = Integer.valueOf(array[2]);
		int num1=(num+1)/10;
		int num2=(num+1)%10;
		String purchaseNum = buffer.append(year).append(stringMonth[month]).append(day).append("(").append(purchaseNumFirst[num1]).append(purchaseNumSecond[num2]).append(")").toString();
        return purchaseNum;
    }
	
	/**
	 * 最新采购单编号
	 * @param num
	 * @return
	 */
	public static String getD_PurchaseNum(int num) {
		if(num<0){
			return null;
		}
		String purchaseNum =null;
		StringBuffer buffer = new StringBuffer("CG");
		String time = new SimpleDateFormat("yyyyMMdd").format(new Date());
		if(num<10){
			purchaseNum = buffer.append(time).append(0).append(num).toString();
		}else{
			purchaseNum = buffer.append(time).append(num).toString();
		}
        return purchaseNum;
    }
}
