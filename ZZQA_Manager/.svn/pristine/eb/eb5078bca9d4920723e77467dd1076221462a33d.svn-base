package com.zzqa.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.springframework.web.context.support.WebApplicationContextUtils;

import com.zzqa.dao.interfaces.device.IDeviceDAO;
import com.zzqa.dao.interfaces.material.IMaterialDAO;
import com.zzqa.dao.interfaces.procurement.IProcurementDAO;
import com.zzqa.util.ant.GB2Alpha;

public class AutocompleteServlet extends HttpServlet {
	
	private IProcurementDAO procurementDAO;
	private IDeviceDAO deviceDAO;
	private IMaterialDAO materialDAO;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String typename=request.getParameter("typename");
		String term=new String(request.getParameter("term").getBytes("iso-8859-1"), "utf-8");
		List<String> list=new ArrayList<String>();
		List<String> tempList=null;
		if("procure".equals(typename)){
			int type=Integer.parseInt(request.getParameter("type"));
			switch (type) {
			case 1:
				tempList = procurementDAO.getProcurementName();
				break;
			case 2:
				tempList = procurementDAO.getProcurementAgent();
				break;
			case 3:
				tempList = procurementDAO.getProcurementModel();
				break;
			case 4:
				tempList = procurementDAO.getProcurementUnit();
				break;
			default:
				break;
			}
		}else if("device".equals(typename)){
			tempList = deviceDAO.getDeviceSN();
		}else if("material".equals(typename)){
			//添加修改设备
			int type=Integer.parseInt(request.getParameter("type"));
			switch (type) {
			case 1:
				tempList = materialDAO.getSNByType(1);
				break;
			case 2:
				tempList = materialDAO.getModelByType(1);
				break;
			case 3:
				tempList = materialDAO.getSNByType(2);
				break;
			case 4:
				tempList = materialDAO.getModelByType(2);
				break;
			case 5:
				tempList = materialDAO.getSNByType(3);
				break;
			case 6:
				tempList = materialDAO.getModelByType(3);
				break;
			case 7:
				tempList = materialDAO.getSNByType(4);
				break;
			case 8:
				tempList = materialDAO.getModelByType(4);
				break;
			case 9:
				tempList = materialDAO.getSNByType(5);
				break;
			case 10:
				tempList = materialDAO.getModelByType(5);
				break;
			case 11:
				tempList = materialDAO.getSNByType(6);
				break;
			case 12:
				tempList = materialDAO.getModelByType(6);
				break;
			default:
				break;
			}
		}
		for (String str : tempList) {
			GB2Alpha alpha=new GB2Alpha();
			String tempString=alpha.String2Alpha(str).toLowerCase();
			if (str.indexOf(term)!=-1||tempString.indexOf(term)!=-1) {
				list.add(str);
			}
		}
		//去除重复值
		List<String> list1 = new ArrayList<String>();
        for(String str:list){
            if(!list1.contains(str)){   //查看新集合中是否有指定的元素，如果没有则加入
                list1.add(str);
            }
        }
		JSONArray jsonArray = new JSONArray();  
        jsonArray.addAll(list1);  
        response.setContentType("text/json"); 
        response.setCharacterEncoding("UTF-8"); 
        PrintWriter out = response.getWriter();  
        out.print(jsonArray);  
	}
	
	@Override
	public void init() throws ServletException {
		procurementDAO = (IProcurementDAO) WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext()).getBean("procurementDAO");
		deviceDAO=(IDeviceDAO)WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext()).getBean("deviceDAO");
		materialDAO=(IMaterialDAO)WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext()).getBean("materialDAO");
	}
}
