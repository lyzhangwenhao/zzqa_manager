package com.zzqa.service.impl.resumption;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.zzqa.dao.interfaces.flow.IFlowDAO;
import com.zzqa.dao.interfaces.leave.ILeaveDAO;
import com.zzqa.dao.interfaces.permissions.IPermissionsDAO;
import com.zzqa.dao.interfaces.position_user.IPosition_userDAO;
import com.zzqa.dao.interfaces.resumption.IResumptionDAO;
import com.zzqa.dao.interfaces.travel.ITravelDAO;
import com.zzqa.dao.interfaces.user.IUserDAO;
import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.leave.Leave;
import com.zzqa.pojo.position_user.Position_user;
import com.zzqa.pojo.product_procurement.Product_procurement;
import com.zzqa.pojo.project_procurement.Project_procurement;
import com.zzqa.pojo.resumption.Resumption;
import com.zzqa.pojo.travel.Travel;
import com.zzqa.pojo.user.User;
import com.zzqa.service.interfaces.resumption.ResumptionManager;
import com.zzqa.servlet.DelayEmailServlet;
import com.zzqa.util.DataUtil;
@Component("resumptionManager")
public class ResumptionManagerImpl implements ResumptionManager {
	@Autowired
	private IResumptionDAO resumptionDAO;
	@Autowired
	private IUserDAO userDAO;
	@Autowired
	private IFlowDAO flowDAO;
	@Autowired
	private IPosition_userDAO position_userDAO;
	@Autowired
	private IPermissionsDAO permissionsDAO;
	@Autowired
	private ITravelDAO travelDAO;
	@Autowired
	private ILeaveDAO leaveDAO;

	@Override
	public void updateResumption(Resumption resumption) {
		// TODO Auto-generated method stub
		resumptionDAO.updateResumption(resumption);
	}

	@Override
	public void insertResumption(Resumption resumption) {
		// TODO Auto-generated method stub
		resumptionDAO.insertResumption(resumption);
	}


	@Override
	public Resumption getResumptionByID(int id) {
		// TODO Auto-generated method stub
		Resumption resumption = resumptionDAO.getResumptionByID(id);
		if(resumption==null){
			return null;
		}
		resumption.setCreate_name(userDAO.getUserNameByID(resumption.getCreate_id()));
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy年MM月dd日 HH:mm:ss");
		SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM-dd");
		long starttime = resumption.getStarttime();
		long reback_time = resumption.getReback_time();
		if (reback_time > 0) {
			String rebackDate = sdf.format(reback_time);
			resumption.setReback_date(rebackDate.substring(0, 11)
					+ ("0".equals(rebackDate.substring(12, 13)) ? "上午" : "下午"));
		}
		if (resumption.getType() == 1) {
			// 出差
			Travel travel = travelDAO.getTravelByID(resumption.getForeign_id());
			if (travel == null) {
				resumption = null;// 关联的单据找不到就不显示销假单
			} else {
				String startDate = sdf.format(travel.getStarttime());
				String endDate = sdf.format(travel.getEndtime());
				if ("0".equals(startDate.substring(12, 13))) {
					startDate = startDate.substring(0, 11) + "上午";
					resumption.setHalfDay1(0);
				} else {
					startDate = startDate.substring(0, 11) + "下午";
					resumption.setHalfDay1(1);
				}
				if ("0".equals(endDate.substring(12, 13))) {
					endDate = endDate.substring(0, 11) + "上午";
					resumption.setHalfDay2(0);
				} else {
					endDate = endDate.substring(0, 11) + "下午";
					resumption.setHalfDay2(1);
				}
				resumption.setForeign_name(new StringBuilder().append("出差单-")
						.append(startDate).append("至").append(endDate)
						.toString());
				resumption.setMinDate(sdf2.format(travel.getStarttime()));
				resumption.setMaxDate(sdf2.format(travel.getEndtime()));
			}
		} else {
			// 请假
			Leave leave = leaveDAO.getLeaveByID(resumption.getForeign_id());
			if (leave == null) {
				resumption = null;// 关联的单据找不到就不显示销假单
			} else {
				long start = resumption.getStarttime();
				if (start > 0) {
					String date1 = sdf.format(start);
					resumption.setStartdate(date1.substring(0, 11)
							+ ("0".equals(date1.substring(12, 13)) ? "上午"
									: "下午"));
				} else {
					resumption.setStarttime(start);
					String date1 = sdf.format(leave.getStarttime());
					resumption.setStartdate(date1.substring(0, 11)
							+ ("0".equals(date1.substring(12, 13)) ? "上午"
									: "下午"));
				}
				String startDate = sdf.format(leave.getStarttime());
				String endDate = sdf.format(leave.getEndtime());
				if ("0".equals(startDate.substring(12, 13))) {
					startDate = startDate.substring(0, 11) + "上午";
					resumption.setHalfDay1(0);
				} else {
					startDate = startDate.substring(0, 11) + "下午";
					resumption.setHalfDay1(1);
				}
				if ("0".equals(endDate.substring(12, 13))) {
					endDate = endDate.substring(0, 11) + "上午";
					resumption.setHalfDay2(0);
				} else {
					endDate = endDate.substring(0, 11) + "下午";
					resumption.setHalfDay2(1);
				}
				resumption.setForeign_name(new StringBuilder().append("请假单-")
						.append(startDate).append("至").append(endDate)
						.toString());
				resumption.setMinDate(sdf2.format(leave.getStarttime()));
				resumption.setMaxDate(sdf2.format(leave.getEndtime()));
			}
		}
		return resumption;
	}

	@Override
	public Resumption getNewResumptionByCreateID(int create_id) {
		// TODO Auto-generated method stub
		return resumptionDAO.getNewResumptionByCreateID(create_id);
	}

	@Override
	public List getAllResumptionlList() {
		// TODO Auto-generated method stub
		return resumptionDAO.getAllResumptionlList();
	}

	private long lastFlowTime(int operation, List<Flow> flowList) {
		Flow flow = null;
		int len = flowList.size();
		for (int i = 0; i < len; i++) {
			if (flowList.get(len - i - 1).getOperation() == operation) {
				return flowList.get(len - i - 1).getCreate_time();
			}
		}
		return flowList.size() > 0 ? flowList.get(flowList.size() - 2)
				.getOperation() : 0;// 找不到就用上一步的时间（主要针对老版本没有上级审批的情况）
	}

	@Override
	public Map<String, String> getResumptionFlowForDraw(Resumption resumption,
			Flow flow) {
		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		int operation = flow.getOperation();
		List<Flow> flowList = flowDAO.getFlowListByCondition(9,
				resumption.getId());
		SimpleDateFormat dft = new SimpleDateFormat("yyyy-MM-dd*HH:mm:ss");
		boolean isNewVersion = true;// 老版本没有上级审批，兼容旧版本的出差销假单，老旧版本分开处理
		if ((operation == 3 || operation == 4)&&flowList.get(flowList.size() - 2).getOperation() == 2) {
			isNewVersion = false;
		}
		if (isNewVersion) {
			String class1_1 = "";
			String style11 = "";
			String style12 = "";
			String style13 = "";
			String style14 = "";
			String style15 = "";
			String style16 = "";
			String style17 = "";
			String class1_2 = "";
			String img1 = "";
			String img2 = "";
			String img3 = "";
			String img4 = "";
			String img5 = "";
			String img6 = "";
			String img7 = "";
			String style21 = "";
			String style22 = "";
			String style23 = "";
			String style24 = "";
			String style25 = "";
			String style26 = "";
			String class1_3 = "";
			String time1 = "";
			String time2 = "";
			String time3 = "";
			String time4 = "";
			String time5 = "";
			String time6 = "";
			String time7 = "";
			int num = getApprovalNum(resumption);
			if (operation == 1) {
				if (num == 1) {
					// 1次审批
					class1_1 = "td2_div1_1_4";
					style11 = "style='color:#42c652;'";// pass
					style12 = "style='color:#5C5C5C'";// nodid
					style13 = "style='color:#5C5C5C'";// nodid
					style16 = "style='color:#5C5C5C'";// nodid
					style17 = "style='color:#5C5C5C'";// nodid
					class1_2 = "td2_div1_2_4";
					img1 = "images/pass.png";
					img2 = "images/go.png";
					img3 = "images/notdid.png";
					img4 = "images/notdid.png";
					img5 = "images/notdid.png";
					style21 = "style='background-color:#42C752;'";// agree
					style22 = "style='background-color:#E1EAEF;'";// nodid
					style23 = "style='background-color:#E1EAEF;'";// nodid
					style24 = "style='background-color:#E1EAEF;'";// nodid
					class1_3 = "td2_div1_3_4";
					time1 = dft.format(lastFlowTime(1, flowList)).replace("*",
							"<br/>");
				} else if (num == 2) {
					// 两次审批
					class1_1="td2_div1_1_5";
					style11 = "style='color:#42c652;'";// pass
					style12 = "style='color:#5C5C5C'";// nodid
					style13 = "style='color:#5C5C5C'";// nodid
					style14 = "style='color:#5C5C5C'";// nodid
					style16 = "style='color:#5C5C5C'";// nodid
					style17 = "style='color:#5C5C5C'";// nodid
					class1_2 = "td2_div1_2_5";
					img1 = "images/pass.png";
					img2 = "images/go.png";
					img3 = "images/notdid.png";
					img4 = "images/notdid.png";
					img5 = "images/notdid.png";
					img6 = "images/notdid.png";
					style21 = "style='background-color:#42C752;'";// agree
					style22 = "style='background-color:#E1EAEF;'";// nodid
					style23 = "style='background-color:#E1EAEF;'";// nodid
					style24 = "style='background-color:#E1EAEF;'";// nodid
					style25 = "style='background-color:#E1EAEF;'";// nodid
					class1_3 = "td2_div1_3_5";
					time1 = dft.format(lastFlowTime(1, flowList)).replace("*",
							"<br/>");
				} else {
					class1_1 = "td2_div1_1_6";
					style11 = "style='color:#42c652;'";// pass
					style12 = "style='color:#5C5C5C'";// nodid
					style13 = "style='color:#5C5C5C'";// nodid
					style14 = "style='color:#5C5C5C'";// nodid
					style15 = "style='color:#5C5C5C'";// nodid
					style16 = "style='color:#5C5C5C'";// nodid
					style17 = "style='color:#5C5C5C'";// nodid
					class1_2 = "td2_div1_2_6";
					img1 = "images/pass.png";
					img2 = "images/go.png";
					img3 = "images/notdid.png";
					img4 = "images/notdid.png";
					img5 = "images/notdid.png";
					img6 = "images/notdid.png";
					img7 = "images/notdid.png";
					style21 = "style='background-color:#42C752;'";// agree
					style22 = "style='background-color:#E1EAEF;'";// nodid
					style23 = "style='background-color:#E1EAEF;'";// nodid
					style24 = "style='background-color:#E1EAEF;'";// nodid
					style25 = "style='background-color:#E1EAEF;'";// nodid
					style26 = "style='background-color:#E1EAEF;'";// nodid
					class1_3 = "td2_div1_3_6";
					time1 = dft.format(lastFlowTime(1, flowList)).replace("*",
							"<br/>");
				}
			} else if (operation == 2) {
				if (num == 1) {
					// 1次审批
					class1_1 = "td2_div1_1_4";
					style11 = "style='color:#42c652;'";// pass
					style12 = "style='color:#42c652'";// nodid
					style13 = "style='color:#5C5C5C'";// nodid
					style16 = "style='color:#5C5C5C'";// nodid
					style17 = "style='color:#5C5C5C'";// nodid
					class1_2 = "td2_div1_2_4";
					img1 = "images/pass.png";
					img2 = "images/pass.png";
					img3 = "images/go.png";
					img4 = "images/notdid.png";
					img5 = "images/notdid.png";
					style21 = "style='background-color:#42C752;'";// agree
					style22 = "style='background-color:#42C752;'";// nodid
					style23 = "style='background-color:#E1EAEF;'";// nodid
					style24 = "style='background-color:#E1EAEF;'";// nodid
					class1_3 = "td2_div1_3_4";
					time1 = dft.format(lastFlowTime(1, flowList)).replace("*",
							"<br/>");
					time2 = dft.format(lastFlowTime(2, flowList)).replace("*",
							"<br/>");
				} else if (num == 2) {
					// 两次审批
					class1_1 = "td2_div1_1_5";
					style11 = "style='color:#42c652;'";// pass
					style12 = "style='color:#42c652'";// pass
					style13 = "style='color:#5C5C5C'";// nodid
					style14 = "style='color:#5C5C5C'";// nodid
					style16 = "style='color:#5C5C5C'";// nodid
					style17 = "style='color:#5C5C5C'";// nodid
					class1_2 = "td2_div1_2_5";
					img1 = "images/pass.png";
					img2 = "images/pass.png";
					img3 = "images/go.png";
					img4 = "images/notdid.png";
					img5 = "images/notdid.png";
					img6 = "images/notdid.png";
					style21 = "style='background-color:#42C752;'";// agree
					style22 = "style='background-color:#42C752;'";// agree
					style23 = "style='background-color:#E1EAEF;'";// nodid
					style24 = "style='background-color:#E1EAEF;'";// nodid
					style25 = "style='background-color:#E1EAEF;'";// nodid
					class1_3 = "td2_div1_3_5";
					time1 = dft.format(lastFlowTime(1, flowList)).replace("*",
							"<br/>");
					time2 = dft.format(lastFlowTime(2, flowList)).replace("*",
							"<br/>");
				} else {
					class1_1 = "td2_div1_1_6";
					style11 = "style='color:#42c652;'";// pass
					style12 = "style='color:#42c652'";// nodid
					style13 = "style='color:#5C5C5C'";// nodid
					style14 = "style='color:#5C5C5C'";// nodid
					style15 = "style='color:#5C5C5C'";// nodid
					style16 = "style='color:#5C5C5C'";// nodid
					style17 = "style='color:#5C5C5C'";// nodid
					class1_2 = "td2_div1_2_6";
					img1 = "images/pass.png";
					img2 = "images/pass.png";
					img3 = "images/go.png";
					img4 = "images/notdid.png";
					img5 = "images/notdid.png";
					img6 = "images/notdid.png";
					img7 = "images/notdid.png";
					style21 = "style='background-color:#42C752;'";// agree
					style22 = "style='background-color:#42C752;'";// nodid
					style23 = "style='background-color:#E1EAEF;'";// nodid
					style24 = "style='background-color:#E1EAEF;'";// nodid
					style25 = "style='background-color:#E1EAEF;'";// nodid
					style26 = "style='background-color:#E1EAEF;'";// nodid
					class1_3 = "td2_div1_3_6";
					time1 = dft.format(lastFlowTime(1, flowList)).replace("*",
							"<br/>");
					time2 = dft.format(lastFlowTime(2, flowList)).replace("*",
							"<br/>");
				}
			} else if (operation == 5) {
				if (num == 1) {
					// 1次审批
					class1_1 = "td2_div1_1_4";
					style11 = "style='color:#42c652;'";// pass
					style12 = "style='color:#42c652'";// pass
					style13 = "style='color:#42c652'";// pass
					style16 = "style='color:#5C5C5C'";// nodid
					style17 = "style='color:#5C5C5C'";// nodid
					class1_2 = "td2_div1_2_4";
					img1 = "images/pass.png";
					img2 = "images/pass.png";
					img3 = "images/pass.png";
					img4 = "images/go.png";
					img5 = "images/notdid.png";
					style21 = "style='background-color:#42C752;'";// agree
					style22 = "style='background-color:#42C752;'";// agree
					style23 = "style='background-color:#42C752;'";// agree
					style24 = "style='background-color:#E1EAEF;'";// nodid
					class1_3 = "td2_div1_3_4";
					time1 = dft.format(lastFlowTime(1, flowList)).replace("*",
							"<br/>");
					time2 = dft.format(lastFlowTime(2, flowList)).replace("*",
							"<br/>");
					time3 = dft.format(lastFlowTime(5, flowList)).replace("*",
							"<br/>");
				} else if (num == 2) {
					// 两次审批
					class1_1 = "td2_div1_1_5";
					style11 = "style='color:#42c652;'";// pass
					style12 = "style='color:#42c652'";// pass
					style13 = "style='color:#42c652'";// pass
					style14 = "style='color:#5C5C5C'";// nodid
					style16 = "style='color:#5C5C5C'";// nodid
					style17 = "style='color:#5C5C5C'";// nodid
					class1_2 = "td2_div1_2_5";
					img1 = "images/pass.png";
					img2 = "images/pass.png";
					img3 = "images/pass.png";
					img4 = "images/go.png";
					img5 = "images/notdid.png";
					img6 = "images/notdid.png";
					style21 = "style='background-color:#42C752;'";// agree
					style22 = "style='background-color:#42C752;'";// agree
					style23 = "style='background-color:#42C752;'";// agree
					style24 = "style='background-color:#E1EAEF;'";// nodid
					style25 = "style='background-color:#E1EAEF;'";// nodid
					class1_3 = "td2_div1_3_5";
					time1 = dft.format(lastFlowTime(1, flowList)).replace("*",
							"<br/>");
					time2 = dft.format(lastFlowTime(2, flowList)).replace("*",
							"<br/>");
					time3 = dft.format(lastFlowTime(5, flowList)).replace("*",
							"<br/>");
				} else {
					// 三次审批
					class1_1 = "td2_div1_1_6";
					style11 = "style='color:#42c652;'";// pass
					style12 = "style='color:#42c652'";// pass
					style13 = "style='color:#42c652'";// pass
					style14 = "style='color:#5C5C5C'";// nodid
					style15 = "style='color:#5C5C5C'";// nodid
					style16 = "style='color:#5C5C5C'";// nodid
					style17 = "style='color:#5C5C5C'";// nodid
					class1_2 = "td2_div1_2_6";
					img1 = "images/pass.png";
					img2 = "images/pass.png";
					img3 = "images/pass.png";
					img4 = "images/go.png";
					img5 = "images/notdid.png";
					img6 = "images/notdid.png";
					img7 = "images/notdid.png";
					style21 = "style='background-color:#42C752;'";// agree
					style22 = "style='background-color:#42C752;'";// agree
					style23 = "style='background-color:#42C752;'";// agree
					style24 = "style='background-color:#E1EAEF;'";// nodid
					style25 = "style='background-color:#E1EAEF;'";// nodid
					style26 = "style='background-color:#E1EAEF;'";// nodid
					class1_3 = "td2_div1_3_6";
					time1 = dft.format(lastFlowTime(1, flowList)).replace("*",
							"<br/>");
					time2 = dft.format(lastFlowTime(2, flowList)).replace("*",
							"<br/>");
					time3 = dft.format(lastFlowTime(5, flowList)).replace("*",
							"<br/>");
				}
			} else if (operation == 6) {
				class1_1 = "td2_div1_1_3";
				style11 = "style='color:#42c652;'";// pass
				style12 = "style='color:#42c652;'";// pass
				style13 = "style='color:#FF4401'";// nopass
				style17 = "style='color:#5C5C5C'";// nodid
				class1_2 = "td2_div1_2_3";
				img1 = "images/pass.png";
				img2 = "images/pass.png";
				img3 = "images/error.png";
				img4 = "images/notdid.png";
				style21 = "style='background-color:#42C752;'";// agree
				style22 = "style='background-color:#FF4401;'";// disagree
				style23 = "style='background-color:#E1EAEF;'";// nodid
				class1_3 = "td2_div1_3_3";
				time1 = dft.format(lastFlowTime(1, flowList)).replace("*",
						"<br/>");
				time2 = dft.format(lastFlowTime(2, flowList)).replace("*",
						"<br/>");
				time3 = dft.format(lastFlowTime(6, flowList)).replace("*",
						"<br/>");
			} else if (operation == 7) {
				// 两次审批通过
				if (num == 2) {
					class1_1 = "td2_div1_1_5";
					style11 = "style='color:#42c652;'";// pass
					style12 = "style='color:#42c652'";// pass
					style13 = "style='color:#42c652'";// pass
					style14 = "style='color:#42c652'";// pass
					style16 = "style='color:#5C5C5C'";// nodid
					style17 = "style='color:#5C5C5C'";// nodid
					class1_2 = "td2_div1_2_5";
					img1 = "images/pass.png";
					img2 = "images/pass.png";
					img3 = "images/pass.png";
					img4 = "images/pass.png";
					img5 = "images/go.png";
					img6 = "images/notdid.png";
					style21 = "style='background-color:#42C752;'";// agree
					style22 = "style='background-color:#42C752;'";// agree
					style23 = "style='background-color:#42C752;'";// agree
					style24 = "style='background-color:#42C752;'";// agree
					style25 = "style='background-color:#E1EAEF;'";// nodid
					class1_3 = "td2_div1_3_5";
					time1 = dft.format(lastFlowTime(1, flowList)).replace("*",
							"<br/>");
					time2 = dft.format(lastFlowTime(2, flowList)).replace("*",
							"<br/>");
					time3 = dft.format(lastFlowTime(5, flowList)).replace("*",
							"<br/>");
					time4 = dft.format(lastFlowTime(7, flowList)).replace("*",
							"<br/>");
				} else {
					// 三次审批
					class1_1 = "td2_div1_1_6";
					style11 = "style='color:#42c652;'";// pass
					style12 = "style='color:#42c652'";// pass
					style13 = "style='color:#42c652'";// pass
					style14 = "style='color:#42c652'";// pass
					style15 = "style='color:#5C5C5C'";// nodid
					style16 = "style='color:#5C5C5C'";// nodid
					style17 = "style='color:#5C5C5C'";// nodid
					class1_2 = "td2_div1_2_6";
					img1 = "images/pass.png";
					img2 = "images/pass.png";
					img3 = "images/pass.png";
					img4 = "images/pass.png";
					img5 = "images/go.png";
					img6 = "images/notdid.png";
					img7 = "images/notdid.png";
					style21 = "style='background-color:#42C752;'";// agree
					style22 = "style='background-color:#42C752;'";// agree
					style23 = "style='background-color:#42C752;'";// agree
					style24 = "style='background-color:#42C752;'";// agree
					style25 = "style='background-color:#E1EAEF;'";// nodid
					style26 = "style='background-color:#E1EAEF;'";// nodid
					class1_3 = "td2_div1_3_6";
					time1 = dft.format(lastFlowTime(1, flowList)).replace("*",
							"<br/>");
					time2 = dft.format(lastFlowTime(2, flowList)).replace("*",
							"<br/>");
					time3 = dft.format(lastFlowTime(5, flowList)).replace("*",
							"<br/>");
					time4 = dft.format(lastFlowTime(7, flowList)).replace("*",
							"<br/>");
				}
			} else if (operation == 8) {
				// 第二次审批未通过
				class1_1 = "td2_div1_1_no4";
				style11 = "style='color:#42c652;'";// pass
				style12 = "style='color:#42c652'";// pass
				style13 = "style='color:#42c652'";// pass
				style14 = "style='color:#FF4401'";// nopass
				style17 = "style='color:#5C5C5C'";// nodid
				class1_2 = "td2_div1_2_4";
				img1 = "images/pass.png";
				img2 = "images/pass.png";
				img3 = "images/pass.png";
				img4 = "images/error.png";
				img5 = "images/notdid.png";
				style21 = "style='background-color:#42C752;'";// agree
				style22 = "style='background-color:#42C752;'";// agree
				style23 = "style='background-color:#FF4401;'";// disagree
				style24 = "style='background-color:#E1EAEF;'";// nodid
				class1_3 = "td2_div1_3_4";
				time1 = dft.format(lastFlowTime(1, flowList)).replace("*",
						"<br/>");
				time2 = dft.format(lastFlowTime(2, flowList)).replace("*",
						"<br/>");
				time3 = dft.format(lastFlowTime(5, flowList)).replace("*",
						"<br/>");
				time4 = dft.format(lastFlowTime(8, flowList)).replace("*",
						"<br/>");
			} else if (operation == 3) {
				if (num == 1) {
					// 1次审批
					class1_1 = "td2_div1_1_4";
					style11 = "style='color:#42c652;'";// pass
					style12 = "style='color:#42c652'";// pass
					style13 = "style='color:#42c652'";// pass
					style16 = "style='color:#42c652'";// pass
					style17 = "style='color:#42c652'";// pass
					class1_2 = "td2_div1_2_4";
					img1 = "images/pass.png";
					img2 = "images/pass.png";
					img3 = "images/pass.png";
					img4 = "images/pass.png";
					img5 = "images/pass.png";
					style21 = "style='background-color:#42C752;'";// agree
					style22 = "style='background-color:#42C752;'";// agree
					style23 = "style='background-color:#42C752;'";// agree
					style24 = "style='background-color:#42C752;'";// agree
					class1_3 = "td2_div1_3_4";
					time1 = dft.format(lastFlowTime(1, flowList)).replace("*",
							"<br/>");
					time2 = dft.format(lastFlowTime(2, flowList)).replace("*",
							"<br/>");
					time3 = dft.format(lastFlowTime(5, flowList)).replace("*",
							"<br/>");
					time4 = dft.format(lastFlowTime(3, flowList)).replace("*",
							"<br/>");
					time5 = time4;
				} else if (num == 2) {
					// 两次审批
					class1_1 = "td2_div1_1_5";
					style11 = "style='color:#42c652;'";// pass
					style12 = "style='color:#42c652;'";// pass
					style13 = "style='color:#42c652;'";// pass
					style14 = "style='color:#42c652;'";// pass
					style16 = "style='color:#42c652;'";// pass
					style17 = "style='color:#42c652;'";// pass
					class1_2 = "td2_div1_2_5";
					img1 = "images/pass.png";
					img2 = "images/pass.png";
					img3 = "images/pass.png";
					img4 = "images/pass.png";
					img5 = "images/pass.png";
					img6 = "images/pass.png";
					style21 = "style='background-color:#42C752;'";// agree
					style22 = "style='background-color:#42C752;'";// agree
					style23 = "style='background-color:#42C752;'";// agree
					style24 = "style='background-color:#42C752;'";// agree
					style25 = "style='background-color:#42C752;'";// agree
					class1_3 = "td2_div1_3_5";
					time1 = dft.format(lastFlowTime(1, flowList)).replace("*",
							"<br/>");
					time2 = dft.format(lastFlowTime(2, flowList)).replace("*",
							"<br/>");
					time3 = dft.format(lastFlowTime(5, flowList)).replace("*",
							"<br/>");
					time4 = dft.format(lastFlowTime(7, flowList)).replace("*",
							"<br/>");
					time5 = dft.format(lastFlowTime(3, flowList)).replace("*",
							"<br/>");
					time6 = time5;
				} else {
					class1_1 = "td2_div1_1_6";
					style11 = "style='color:#42c652;'";// pass
					style12 = "style='color:#42c652'";// pass
					style13 = "style='color:#42c652'";// pass
					style14 = "style='color:#42c652'";// pass
					style15 = "style='color:#42c652'";// pass
					style16 = "style='color:#42c652'";// pass
					style17 = "style='color:#42c652'";// pass
					class1_2 = "td2_div1_2_6";
					img1 = "images/pass.png";
					img2 = "images/pass.png";
					img3 = "images/pass.png";
					img4 = "images/pass.png";
					img5 = "images/pass.png";
					img6 = "images/pass.png";
					img7 = "images/pass.png";
					style21 = "style='background-color:#42C752;'";// agree
					style22 = "style='background-color:#42C752;'";// agree
					style23 = "style='background-color:#42C752;'";// agree
					style24 = "style='background-color:#42C752;'";// agree
					style25 = "style='background-color:#42C752;'";// agree
					style26 = "style='background-color:#42C752;'";// agree
					class1_3 = "td2_div1_3_6";
					time1 = dft.format(lastFlowTime(1, flowList)).replace("*",
							"<br/>");
					time2 = dft.format(lastFlowTime(2, flowList)).replace("*",
							"<br/>");
					time3 = dft.format(lastFlowTime(5, flowList)).replace("*",
							"<br/>");
					time4 = dft.format(lastFlowTime(7, flowList)).replace("*",
							"<br/>");
					time5 = dft.format(lastFlowTime(9, flowList)).replace("*",
							"<br/>");
					time6 = dft.format(lastFlowTime(3, flowList)).replace("*",
							"<br/>");
					time7 = time6;
				}
			} else if (operation == 9) {
				class1_1 = "td2_div1_1_6";
				style11 = "style='color:#42c652;'";// pass
				style12 = "style='color:#42c652'";// pass
				style13 = "style='color:#42c652'";// pass
				style14 = "style='color:#42c652'";// pass
				style15 = "style='color:#42c652'";// pass
				style16 = "style='color:#5C5C5C'";// nodid
				style17 = "style='color:#5C5C5C'";// nodid
				class1_2 = "td2_div1_2_6";
				img1 = "images/pass.png";
				img2 = "images/pass.png";
				img3 = "images/pass.png";
				img4 = "images/pass.png";
				img5 = "images/pass.png";
				img6 = "images/go.png";
				img7 = "images/notdid.png";
				style21 = "style='background-color:#42C752;'";// agree
				style22 = "style='background-color:#42C752;'";// agree
				style23 = "style='background-color:#42C752;'";// agree
				style24 = "style='background-color:#42C752;'";// agree
				style25 = "style='background-color:#42C752;'";// agree
				style26 = "style='background-color:#E1EAEF;'";// nodid
				class1_3 = "td2_div1_3_6";
				time1 = dft.format(lastFlowTime(1, flowList)).replace("*",
						"<br/>");
				time2 = dft.format(lastFlowTime(2, flowList)).replace("*",
						"<br/>");
				time3 = dft.format(lastFlowTime(5, flowList)).replace("*",
						"<br/>");
				time4 = dft.format(lastFlowTime(7, flowList)).replace("*",
						"<br/>");
				time6 = dft.format(lastFlowTime(9, flowList)).replace("*",
						"<br/>");
			} else if (operation == 10) {
				// 第三次审批失败
				class1_1 = "td2_div1_1_5no";
				style11 = "style='color:#42c652;'";// pass
				style12 = "style='color:#42c652'";// pass
				style13 = "style='color:#42c652'";// pass
				style14 = "style='color:#42c652'";// pass
				style15 = "style='color:#FF4401'";// nopass
				style17 = "style='color:#5C5C5C'";// nodid
				class1_2 = "td2_div1_2_5";
				img1 = "images/pass.png";
				img2 = "images/pass.png";
				img3 = "images/pass.png";
				img4 = "images/pass.png";
				img5 = "images/error.png";
				img6 = "images/notdid.png";
				style21 = "style='background-color:#42C752;'";// agree
				style22 = "style='background-color:#42C752;'";// agree
				style23 = "style='background-color:#42C752;'";// agree
				style24 = "style='background-color:#FF4401;'";// disagree
				style25 = "style='background-color:#E1EAEF;'";// nodid
				class1_3 = "td2_div1_3_5";
				time1 = dft.format(lastFlowTime(1, flowList)).replace("*",
						"<br/>");
				time2 = dft.format(lastFlowTime(2, flowList)).replace("*",
						"<br/>");
				time3 = dft.format(lastFlowTime(5, flowList)).replace("*",
						"<br/>");
				time4 = dft.format(lastFlowTime(7, flowList)).replace("*",
						"<br/>");
				time5 = dft.format(lastFlowTime(10, flowList)).replace("*",
						"<br/>");
			}
			map.put("class1_1", class1_1);
			map.put("class1_2", class1_2);
			map.put("class1_3", class1_3);

			map.put("style11", style11);
			map.put("style12", style12);
			map.put("style13", style13);
			map.put("style14", style14);
			map.put("style15", style15);
			map.put("style16", style16);
			map.put("style17", style17);

			map.put("img1", img1);
			map.put("img2", img2);
			map.put("img3", img3);
			map.put("img4", img4);
			map.put("img5", img5);
			map.put("img6", img6);
			map.put("img7", img7);

			map.put("style21", style21);
			map.put("style22", style22);
			map.put("style23", style23);
			map.put("style24", style24);
			map.put("style25", style25);
			map.put("style26", style26);

			map.put("time1", time1);
			map.put("time2", time2);
			map.put("time3", time3);
			map.put("time4", time4);
			map.put("time5", time5);
			map.put("time6", time6);
			map.put("time7", time7);
		} else {
			String class11 = "";
			String class12 = "";
			String class13 = "";
			String class14 = "";
			String img1 = "";
			String img2 = "";
			String img3 = "";
			String img4 = "";
			String time1 = "";
			String time2 = "";
			String time3 = "";
			String time4 = "";
			String class22 = "";
			String class24 = "";
			String class26 = "";
			if (operation == 1) {
				// 关联单据
				class11 = "td2_div11_pass";
				class12 = "td2_div12_nodid";
				class13 = "td2_div13_nodid";
				class14 = "td2_div14_nodid";
				img1 = "pass.png";
				img2 = "go.png";
				img3 = "notdid.png";
				img4 = "notdid.png";
				time1 = dft.format(resumption.getCreate_time()).replace("*",
						"<br/>");
				time2 = "";
				time3 = "";
				time4 = "";
				class22 = "td2_div2_agree";
				class24 = "td2_div2_nodid";
				class26 = "td2_div2_nodid";
			} else if (operation == 2) {
				// 填写销假
				class11 = "td2_div11_pass";
				class12 = "td2_div12_pass";
				class13 = "td2_div13_nodid";
				class14 = "td2_div14_nodid";
				img1 = "pass.png";
				img2 = "pass.png";
				img3 = "go.png";
				img4 = "notdid.png";
				time1 = dft.format(resumption.getCreate_time()).replace("*",
						"<br/>");
				time2 = dft.format(lastFlowTime(2, flowList)).replace("*",
						"<br/>");
				time3 = "";
				time4 = "";
				class22 = "td2_div2_agree";
				class24 = "td2_div2_agree";
				class26 = "td2_div2_nodid";
			} else if (operation == 3) {
				// 审核通过
				class11 = "td2_div11_pass";
				class12 = "td2_div12_pass";
				class13 = "td2_div13_pass";
				class14 = "td2_div14_pass";
				img1 = "pass.png";
				img2 = "pass.png";
				img3 = "pass.png";
				img4 = "pass.png";
				time1 = dft.format(resumption.getCreate_time()).replace("*",
						"<br/>");
				time2 = dft.format(lastFlowTime(2, flowList)).replace("*",
						"<br/>");
				time3 = dft.format(lastFlowTime(3, flowList)).replace("*",
						"<br/>");
				time4 = time3;
				class22 = "td2_div2_agree";
				class24 = "td2_div2_agree";
				class26 = "td2_div2_agree";
			} else if (operation == 4) {
				// 审核未通过
				class11 = "td2_div11_pass";
				class12 = "td2_div12_pass";
				class13 = "td2_div13_nopass";
				class14 = "td2_div14_nodid";
				img1 = "pass.png";
				img2 = "pass.png";
				img3 = "error.png";
				img4 = "notdid.png";
				time1 = dft.format(resumption.getCreate_time()).replace("*",
						"<br/>");
				time2 = dft.format(lastFlowTime(2, flowList)).replace("*",
						"<br/>");
				time3 = dft.format(lastFlowTime(4, flowList)).replace("*",
						"<br/>");
				time4 = "";
				class22 = "td2_div2_agree";
				class24 = "td2_div2_disagree";
				class26 = "td2_div2_nodid";
			} else if (operation == 5) {
				// 结束
				class11 = "td2_div11_pass";
				class12 = "td2_div12_pass";
				class13 = "td2_div13_pass";
				class14 = "td2_div14_pass";
				img1 = "pass.png";
				img2 = "pass.png";
				img3 = "pass.png";
				img4 = "pass.png";
				time1 = dft.format(resumption.getCreate_time()).replace("*",
						"<br/>");
				time2 = dft.format(lastFlowTime(2, flowList)).replace("*",
						"<br/>");
				time3 = dft.format(lastFlowTime(3, flowList)).replace("*",
						"<br/>");
				time4 = time3;
				class22 = "td2_div2_agree";
				class24 = "td2_div2_agree";
				class26 = "td2_div2_agree";
			}
			map.put("class11", class11);
			map.put("class12", class12);
			map.put("class13", class13);
			map.put("class14", class14);

			map.put("img1", img1);
			map.put("img2", img2);
			map.put("img3", img3);
			map.put("img4", img4);

			map.put("time1", time1);
			map.put("time2", time2);
			map.put("time3", time3);
			map.put("time4", time4);

			map.put("class22", class22);
			map.put("class24", class24);
			map.put("class26", class26);
		}
		return map;
	}

	/****
	 * 检查请假单审核次数
	 * 
	 * @param operation
	 * @param leave
	 * @return 审核次数
	 */
	private int getApprovalNum(Resumption resumption) {
		int flag = 1;
		Leave leave = leaveDAO.getLeaveByID(resumption.getForeign_id());
		if (leave == null) {
			return flag;
		}
		User user1 = userDAO.getUserByID(leave.getCreate_id());
		if (user1 == null) {
			return flag;
		}
		double alldays = DataUtil.getLeaveDays(resumption.getStarttime(), resumption.getReback_time()-43200000l,leave.getLeave_type());
		if(resumption.getReback_time()==0){//只绑定未填写销假时间时，以原请假时间为准
			alldays=DataUtil.getLeaveDays(leave.getStarttime(), leave.getEndtime(),leave.getLeave_type());
		}
		/****
		 * 1.只有一级领导,审批后直接考勤备案 2.有两级领导的，1.1：两级领导为总经理,一级领导天数限制为3天;
		 * 1.2：总经理非两级领导时，一级领导天数限制为1天
		 */
		if (position_userDAO.getPositionByID(user1.getPosition_id())
				.getParent() == 0) {
			// 总经理自己不需要备案
		} else if (position_userDAO.getPositionByID(
				position_userDAO.getPositionByID(user1.getPosition_id())
						.getParent()).getParent() == 0) {
			// 总经理为上级领导的,一次审批后考勤备案
		} else if (position_userDAO.getPositionByID(
				position_userDAO.getPositionByID(
						position_userDAO
								.getPositionByID(user1.getPosition_id())
								.getParent()).getParent()).getParent() == 0) {
			// 领导的领导为总经理
			if (alldays > 3) {
				// 一级领导审批3天内 下一步考勤备份
				flag = 2;
			}
		} else {
			// 存在两级以上领导
			if (alldays > 7) {
				flag = 3;
			} else if (alldays > 1) {
				// 一级领导审批3天内 下一步考勤备份
				flag = 2;
			}
		}
		return flag;
	}

	@Override
	public List<Resumption> getResumptionListByUID(User user) {
		// TODO Auto-generated method stub
		List<Resumption> resumptionList = resumptionDAO
				.getAllRunningResumption();// 查询所有流程
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
		String[] flowArray9 = DataUtil.getFlowArray(9);
		List<Resumption> list=new ArrayList<Resumption>();
		int len=resumptionList.size();
		for(int i=0;i<len;i++){
			Resumption resumption = resumptionList.get(i);
			User userByID = userDAO.getUserByID(resumption.getCreate_id());
			if(userByID==null || userByID.getPosition_id()==56){
				continue;
			}
			int op=resumption.getOperation();
			long update_time=resumption.getUpdate_time();
			//Flow flow = flowDAO.getNewFlowByFID(9, resumption.getId());// 查询最新流程
			if (checkMyOperation(op, user, resumption)) {
				String process = sdf.format(update_time)
						+ flowArray9[op];
				if(op==5){
					process+=getApprovalNum(resumption)>1?",等待分管审批":",等待考勤备案";
				}else if(op==7){
					process+=getApprovalNum(resumption)>2?",等待总经理审批":",等待考勤备案";
				}
				resumption.setName(DataUtil.getNameByTime(9,
						resumption.getCreate_time()));
				resumption.setProcess(process);
				list.add(resumption);
			}
		}
		return list;
	}

	public boolean checkMyOperation(int operation, User user,
			Resumption resumption) {
		boolean flag=false;
		User user1=userDAO.getUserByID(resumption.getCreate_id());
		Leave leave=leaveDAO.getLeaveByID(resumption.getForeign_id());
		if(user1==null||leave==null){
			return flag;
		}
		resumption.setCreate_name(DataUtil.getUserNameByUser(user1));
		int position_id=user.getPosition_id();
		if(position_id==0){
			return flag;
		}
		Position_user position_user=position_userDAO.getPositionByID(user1.getPosition_id());
		if(position_user==null){
			return flag;
		}
		double alldays=DataUtil.getLeaveDays(resumption.getStarttime(), resumption.getReback_time()-43200000l,leave.getLeave_type());
		try {
			switch (operation) {
			case 1:
				flag = user.getId() == resumption.getCreate_id();
				break;
			case 2:
				//请假先由上级领导审批
				flag=position_id==position_userDAO.getPositionByID(user1.getPosition_id()).getParent();
				break;
			case 5:
				/****
				 * 1.只有一级领导,审批后直接考勤备案
				 * 2.有两级领导的，1.1：两级领导为总经理,一级领导天数限制为3天;
				 * 							   1.2：总经理非两级领导时，一级领导天数限制为1天，两级领导天数限制为7天
				 */
				if(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()==0){
					//总经理自己不需要审批
				}else if(position_userDAO.getPositionByID(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()).getParent()==0){
					//总经理为上级领导的,一次审批后考勤备案
					flag=permissionsDAO.checkPermission(position_id, 30);
					if(flag){
						resumption.setCanBack(true);
					}
				}else if(position_userDAO.getPositionByID(position_userDAO.getPositionByID(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()).getParent()).getParent()==0){
					//领导的领导为总经理
					if(alldays>3){
						//一级领导天数限制为3天
						flag=position_userDAO.getPositionByID(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()).getParent()==user.getPosition_id();
					}else{
						//考勤备案
						flag=permissionsDAO.checkPermission(position_id, 30);
						if(flag){
							resumption.setCanBack(true);
						}
					}
				}else{
					//存在两级以上领导
					if(alldays>1){
						//一级领导天数限制为1天
						flag=position_userDAO.getPositionByID(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()).getParent()==user.getPosition_id();
					}else{
						//考勤备案
						flag=permissionsDAO.checkPermission(position_id, 30);
						if(flag){
							resumption.setCanBack(true);
						}
					}
				}
				break;
			case 7:
				/****
				 * 1.只有一级领导,审批后直接考勤备案
				 * 2.有两级领导的，1.1：两级领导为总经理,一级领导天数限制为3天;
				 * 							   1.2：总经理非两级领导时，一级领导天数限制为1天，两级领导天数限制为7天
				 */
				if(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()==0){

				}else if(position_userDAO.getPositionByID(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()).getParent()==0){
					//领导是在总经理
					flag=permissionsDAO.checkPermission(position_id, 30);
					if(flag){
						resumption.setCanBack(true);
					}
				}else if(position_userDAO.getPositionByID(position_userDAO.getPositionByID(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()).getParent()).getParent()==0){
					flag=permissionsDAO.checkPermission(position_id, 30);
					if(flag){
						resumption.setCanBack(true);
					}
				}else{
					//存在两级以上领导
					flag=(alldays>7&&position_userDAO.getPositionByID(user.getPosition_id()).getParent()==0)||(alldays<=7&&permissionsDAO.checkPermission(position_id, 30));
					if(flag){
						resumption.setCanBack(true);
					}
				}
				break;
			case 9:
				//考勤备案
				flag=permissionsDAO.checkPermission(position_id, 30);
				if(flag){
					resumption.setCanBack(true);
				}
				break;
			default:
				break;
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return flag;
		}
		return flag;
	}

	@Override
	public Resumption getResumptionByID2(int id) {
		// TODO Auto-generated method stub
		Resumption resumption = resumptionDAO.getResumptionByID(id);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd");
		Flow flow = flowDAO.getNewFlowByFID(9, id);// 查询最新流程
		String process = sdf.format(flow.getCreate_time())
				+ DataUtil.getFlowArray(9)[flow.getOperation()];
		int op=flow.getOperation();
		if(op==5){
			process+=getApprovalNum(resumption)>1?",等待分管审批":",等待考勤备案";
		}else if(op==7){
			process+=getApprovalNum(resumption)>2?",等待总经理审批":",等待考勤备案";
		}
		resumption.setName(DataUtil.getNameByTime(9,
				resumption.getCreate_time()));
		resumption.setProcess(process);
		resumption.setCreate_name(userDAO.getUserNameByID(resumption.getCreate_id()));
		return resumption;
	}

	public void delResumptionByID(int id) {
		resumptionDAO.delResumptionByID(id);
	}

	@Override
	public boolean checkResumptionCan(int operation, Resumption resumption,
			User user) {
		// TODO Auto-generated method stub
		boolean flag=false;
		User user1=userDAO.getUserByID(resumption.getCreate_id());
		Leave leave=leaveDAO.getLeaveByID(resumption.getForeign_id());
		if(user1==null||leave==null){
			return false;//用户不存在无法审批
		}
		int position_id=user.getPosition_id();
		if(position_id==0){
			return flag;
		}
		double realdays=DataUtil.getLeaveDays(resumption.getStarttime(), resumption.getReback_time()-43200000l,leave.getLeave_type());
		switch (operation) {
		case 2:
			//销假先由上级领导审批
			flag=position_id==position_userDAO.getPositionByID(user1.getPosition_id()).getParent();
			break;
		case 5:
			/****
			 * 1.只有一级领导,审批后直接考勤备案
			 * 2.有两级领导的，1.1：两级领导为总经理,一级领导天数限制为3天;
			 * 							   1.2：总经理非两级领导时，一级领导天数限制为1天，二级领导7天
			 */
			if(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()==0){
				//总经理自己不需要审批
			}else if(position_userDAO.getPositionByID(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()).getParent()==0){
				//总经理为上级领导的,一次审批后考勤备案
			}else if(position_userDAO.getPositionByID(position_userDAO.getPositionByID(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()).getParent()).getParent()==0){
				//领导的领导为总经理,一级领导天数限制为3天
				flag=realdays>3&&position_userDAO.getPositionByID(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()).getParent()==user.getPosition_id();
			}else{
				//存在两级以上领导,一级领导天数限制为1天
				flag=realdays>1&&position_userDAO.getPositionByID(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()).getParent()==user.getPosition_id();
			}
			break;
		case 7:
			//已经审批了2次
			if(position_userDAO.getPositionByID(position_userDAO.getPositionByID(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()).getParent()).getParent()!=0){
				//有三级领导且超过7天的还需总经理审批
				flag=realdays>7&&position_userDAO.getPositionByID(user.getPosition_id()).getParent()==0;
			}
			break;
		default:
			break;
		}
		return flag;
	}
	//检查是否可以备案
	public boolean checkResumptionBackUp(int operation,Resumption resumption,User user){
		boolean flag=false;
		User user1=userDAO.getUserByID(resumption.getCreate_id());
		Leave leave=leaveDAO.getLeaveByID(resumption.getForeign_id());
		if(user1==null||leave==null){
			return flag;//用户不存在，无法备案;
		}
		int position_id=user.getPosition_id();
		if(position_id==0){
			return flag;
		}
		double alldays=DataUtil.getLeaveDays(resumption.getStarttime(), resumption.getReback_time()-43200000l,leave.getLeave_type());
		try {
			switch (operation) {
			case 5:
				/****
				 * 1.只有一级领导,审批后直接考勤备案
				 * 2.有两级领导的，1.1：两级领导为总经理,一级领导天数限制为3天;
				 * 							   1.2：总经理非两级领导时，一级领导天数限制为1天
				 */
				if(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()==0){
					//总经理自己不需要备案
				}else if(position_userDAO.getPositionByID(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()).getParent()==0){
					//总经理为上级领导的,一次审批后考勤备案
					flag=permissionsDAO.checkPermission(position_id, 30);
				}else if(position_userDAO.getPositionByID(position_userDAO.getPositionByID(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()).getParent()).getParent()==0){
					//领导的领导为总经理，一级领导审批上限3天，不超过3天的下一步考勤备份
					flag=alldays<=3&&permissionsDAO.checkPermission(position_id, 30);
				}else{
					//存在两级以上领导
					if(alldays<=1){
						//一级领导天数限制为1天
						flag=permissionsDAO.checkPermission(position_id, 30);
					}
				}
				break;
			case 7:
				if(position_userDAO.getPositionByID(position_userDAO.getPositionByID(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()).getParent()).getParent()==0){
					//领导领导为总经理的，下一步必为备案
					flag=permissionsDAO.checkPermission(position_id, 30);
				}else{
					//存在两级以上领导，7天及以内的只需2次审批
					flag=alldays<=7&&permissionsDAO.checkPermission(position_id, 30);
				}
				break;
			case 9:
				flag=permissionsDAO.checkPermission(position_id, 30);
				break;
			default:
				break;
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			return flag;
		}
		return flag;
	}

	@Override
	public Resumption getFinishedResumption(int type, int foreign_id) {
		// TODO Auto-generated method stub
		Resumption resumption=resumptionDAO.getFinishedResumption(type, foreign_id);
		if(resumption==null){
			return null;
		}
		resumption.setCreate_name(userDAO.getUserNameByID(resumption.getCreate_id()));
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd HH");
		long starttime = resumption.getStarttime();
		long reback_time = resumption.getReback_time();
		if(starttime==0||reback_time==0){
			if(type==2){
				Leave leave=leaveDAO.getLeaveByID(foreign_id);
				if(starttime==0){
					starttime=leave.getStarttime();
					resumption.setStarttime(starttime);
				}
				if(reback_time==0){
					reback_time=leave.getEndtime()+43200000l;
					resumption.setReback_time(reback_time);
				}
			}else{
				//return null;
			}
		}
		String date = sdf.format(starttime);//最后时间为时间请假的最后时间
		resumption.setStartdate(date.substring(0, 10)+" "
				+ ("0".equals(date.substring(11, 12)) ? "上午" : "下午"));
		date = sdf.format(reback_time-43200000l);//最后时间为时间请假的最后时间
		resumption.setReback_date(date.substring(0, 10)+" "
				+ ("0".equals(date.substring(11, 12)) ? "上午" : "下午"));
		return resumption;
	}

}