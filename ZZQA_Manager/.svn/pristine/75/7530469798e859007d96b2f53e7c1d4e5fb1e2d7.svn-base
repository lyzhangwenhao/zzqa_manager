package com.zzqa.util;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * ClassName: DateTrans
 * Description:
 *
 * @author 张文豪
 * @date 2020/8/4 13:07
 */
public class DateTrans {
    public static String transitionDate(Long createTime){
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat();

        simpleDateFormat.applyPattern("yyyy-MM-dd HH:mm:ss");
        Date date = new Date();
        date.setTime(createTime);
        String format = simpleDateFormat.format(date);
        return format;
    }
}
