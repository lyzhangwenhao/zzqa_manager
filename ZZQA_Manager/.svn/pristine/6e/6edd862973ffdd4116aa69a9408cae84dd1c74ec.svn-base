package com.zzqa.servlet;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import javax.print.attribute.HashAttributeSet;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionAttributeListener;
import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import org.springframework.web.context.support.WebApplicationContextUtils;

import com.zzqa.service.interfaces.permissions.PermissionsManager;

public class OnLineSessionListener implements HttpSessionListener {
	/****
	 * key:sessionid_uid
	 */
	protected static Map<String,HttpSession> sessMap=new ConcurrentHashMap<String,HttpSession>();
	@Override
	public void sessionCreated(HttpSessionEvent arg0) {
		// TODO Auto-generated method stub
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent arg0) {
		// TODO Auto-generated method stub
		String sid=arg0.getSession().getId();
		for(String key:sessMap.keySet()){
			if(key.startsWith(sid)){
				sessMap.remove(key);
				break;
			}
		}
	}
}
