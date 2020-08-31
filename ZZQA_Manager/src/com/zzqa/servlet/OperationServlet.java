package com.zzqa.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class OperationServlet extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		req.setCharacterEncoding("UTF-8");
		resp.setCharacterEncoding("UTF-8");
		String type = req.getParameter("type");
		if("filter".equals(type)){
			String nowpage_log = req.getParameter("nowpage_log");
			String keywords_log = req.getParameter("keywords_log");
			String name_log = req.getParameter("name_log");
			String position_log = req.getParameter("position_log");
			String newtime_log = req.getParameter("newtime_log");
			String starttime_log = req.getParameter("starttime_log");
			String endtime_log = req.getParameter("endtime_log");
			req.getSession().setAttribute("nowpage_log", nowpage_log);
			req.getSession().setAttribute("keywords_log", keywords_log);
			req.getSession().setAttribute("name_log", name_log);
			req.getSession().setAttribute("position_log", position_log);
			if("on".equals(newtime_log)){
				req.getSession().setAttribute("newtime_log", 1);
			}else{
				req.getSession().setAttribute("newtime_log", 0);
			}
			String ifposition_log = req.getParameter("ifposition_log");
			if("on".equals(ifposition_log)){
				req.getSession().setAttribute("ifposition_log", 1);
			}else{
				req.getSession().setAttribute("ifposition_log", 0);
			}
			req.getSession().setAttribute("starttime_log", starttime_log);
			req.getSession().setAttribute("endtime_log", endtime_log);
			resp.sendRedirect("log/log.jsp");
			return;
		}
	}
}
