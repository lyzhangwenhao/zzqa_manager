package com.zzqa.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.web.context.support.WebApplicationContextUtils;
import com.zzqa.service.interfaces.flow.FlowManager;

public class FilePermissionServlet extends HttpServlet{
	private FlowManager flowManager;
	@Override
	public void init() throws ServletException {
		// TODO Auto-generated method stub
		flowManager = (FlowManager) WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext())
				.getBean("flowManager");
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String id = req.getParameter("id");
		int flag=3;
		Object uObject=req.getSession().getAttribute("uid");
		if(uObject!=null){
			int uid = (Integer) uObject;
			flag=flowManager.checkLoadFilePermission(Integer.parseInt(id),uid);
		}
		resp.setCharacterEncoding("UTF-8"); 
		resp.setContentType("application/text;charset=utf-8");
		resp.setHeader("pragma","no-cache");
		resp.setHeader("cache-control","no-cache");
		PrintWriter out=resp.getWriter();
		out.print(flag);
		out.flush();
	}
}
