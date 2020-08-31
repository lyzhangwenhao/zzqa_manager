package com.zzqa.service.impl.flow;

import java.io.File;
import java.security.acl.Permission;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.StringTokenizer;

import javax.annotation.Resource;
import javax.servlet.jsp.tagext.FunctionInfo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.zzqa.dao.interfaces.aftersales_task.IAftersales_taskDAO;
import com.zzqa.dao.interfaces.customer_data.ICustomer_dataDAO;
import com.zzqa.dao.interfaces.deliver.IDeliverDAO;
import com.zzqa.dao.interfaces.departmentPuchase.IDepartPuchaseDao;
import com.zzqa.dao.interfaces.file_path.IFile_pathDAO;
import com.zzqa.dao.interfaces.flow.IFlowDAO;
import com.zzqa.dao.interfaces.leave.ILeaveDAO;
import com.zzqa.dao.interfaces.linkman.ILinkmanDAO;
import com.zzqa.dao.interfaces.manufacture.IManufactureDAO;
import com.zzqa.dao.interfaces.outsource_product.IOutsource_productDAO;
import com.zzqa.dao.interfaces.performance.IPerformanceDAO;
import com.zzqa.dao.interfaces.permissions.IPermissionsDAO;
import com.zzqa.dao.interfaces.position_user.IPosition_userDAO;
import com.zzqa.dao.interfaces.product_info.IProduct_infoDAO;
import com.zzqa.dao.interfaces.product_procurement.IProduct_procurementDAO;
import com.zzqa.dao.interfaces.project_procurement.IProject_procurementDAO;
import com.zzqa.dao.interfaces.purchase_contract.IPurchase_contractDAO;
import com.zzqa.dao.interfaces.purchase_note.IPurchase_noteDAO;
import com.zzqa.dao.interfaces.resumption.IResumptionDAO;
import com.zzqa.dao.interfaces.sales_contract.ISales_contractDAO;
import com.zzqa.dao.interfaces.seal.ISealDAO;
import com.zzqa.dao.interfaces.shipments.IShipmentsDAO;
import com.zzqa.dao.interfaces.shipping.IShippingDAO;
import com.zzqa.dao.interfaces.task.ITaskDAO;
import com.zzqa.dao.interfaces.task_conflict.ITask_conflictDAO;
import com.zzqa.dao.interfaces.task_updateflow.ITask_updateflowDAO;
import com.zzqa.dao.interfaces.track.ITrackDAO;
import com.zzqa.dao.interfaces.travel.ITravelDAO;
import com.zzqa.dao.interfaces.user.IUserDAO;
import com.zzqa.dao.interfaces.vehicle.IVehicleDAO;
import com.zzqa.dao.interfaces.work.IWorkDAO;
import com.zzqa.pojo.aftersales_task.Aftersales_task;
import com.zzqa.pojo.customer_data.Customer_data;
import com.zzqa.pojo.deliver.Deliver;
import com.zzqa.pojo.departmentPuchase.DepartmentPuchase;
import com.zzqa.pojo.file_path.File_path;
import com.zzqa.pojo.flow.Flow;
import com.zzqa.pojo.leave.Leave;
import com.zzqa.pojo.manufacture.Manufacture;
import com.zzqa.pojo.outsource_product.Outsource_product;
import com.zzqa.pojo.performance.Performance;
import com.zzqa.pojo.position_user.Position_user;
import com.zzqa.pojo.product_info.Product_info;
import com.zzqa.pojo.product_procurement.Product_procurement;
import com.zzqa.pojo.project_procurement.Project_procurement;
import com.zzqa.pojo.purchase_contract.Purchase_contract;
import com.zzqa.pojo.purchase_note.Purchase_note;
import com.zzqa.pojo.resumption.Resumption;
import com.zzqa.pojo.sales_contract.Sales_contract;
import com.zzqa.pojo.seal.Seal;
import com.zzqa.pojo.shipments.Shipments;
import com.zzqa.pojo.shipping.Shipping;
import com.zzqa.pojo.task.Task;
import com.zzqa.pojo.task_updateflow.Task_updateflow;
import com.zzqa.pojo.track.Track;
import com.zzqa.pojo.travel.Travel;
import com.zzqa.pojo.user.User;
import com.zzqa.pojo.vehicle.Vehicle;
import com.zzqa.pojo.work.Work;
import com.zzqa.service.interfaces.flow.FlowManager;
import com.zzqa.service.interfaces.purchase_contract.Purchase_contractManager;
import com.zzqa.util.DataUtil;
import com.zzqa.util.FileUploadUtil;
import com.zzqa.util.FormTransform;
import com.zzqa.util.SendMessage;
@Component("flowManager")
public class FlowManagerImpl implements FlowManager{
	@Autowired
	private IFlowDAO flowDAO;
	@Autowired
	private IPosition_userDAO position_userDAO;
	@Autowired
	private IUserDAO userDAO;
	@Autowired
	private ILinkmanDAO linkmanDAO;
	@Autowired
	private IFile_pathDAO file_pathDAO;
	@Autowired
	private ITask_conflictDAO task_conflictDAO;
	@Autowired
	private ITaskDAO taskDAO;
	@Autowired
	private IProduct_procurementDAO product_procurementDAO;
	@Autowired
	private IProject_procurementDAO project_procurementDAO;
	@Autowired
	private IOutsource_productDAO outsource_productDAO;
	@Autowired
	private IManufactureDAO manufactureDAO;
	@Autowired
	private IShipmentsDAO shipmentsDAO;
	@Autowired
	private IPermissionsDAO permissionsDAO;
	@Autowired
	private ITravelDAO travelDAO;
	@Autowired
	private ILeaveDAO leaveDAO;
	@Autowired
	private IResumptionDAO resumptionDAO;
	@Autowired
	private ITrackDAO trackDAO;
	@Autowired
	private ISales_contractDAO sales_contractDAO;
	@Autowired
	private IProduct_infoDAO product_infoDAO;
	@Autowired
	private IPurchase_noteDAO purchase_noteDAO;
	@Autowired
	private ICustomer_dataDAO customer_dataDAO;
	@Autowired
	private IPurchase_contractDAO purchase_contractDAO;
	@Autowired
	private IAftersales_taskDAO aftersales_taskDAO;
	@Autowired
	private ISealDAO sealDAO;
	@Autowired
	private IVehicleDAO vehicleDAO;
	@Autowired
	private IWorkDAO workDAO;
	@Autowired
	private Purchase_contractManager purchase_contractManager;
	@Autowired
	private IShippingDAO shippingDAO;
	@Autowired
	private IPerformanceDAO performanceDAO;
	@Autowired
	private IDeliverDAO deliverDAO;
	@Autowired
	private ITask_updateflowDAO task_updateflowDAO;
	@Autowired
	private IDepartPuchaseDao departPuchaseDao;
	public List getFlowListByCondition(int type,int foreign) {
		// TODO Auto-generated method stub
		return flowDAO.getFlowListByCondition(type,foreign);
	}
	//删除流程
	public void  deleteByCondition(int type,int foreign_id){
		flowDAO.deleteByCondition(type, foreign_id);
	};
	@Override
	public void deleteRecentOperat(int type, int foreign_id, int operation) {
		// TODO Auto-generated method stub
		flowDAO.deleteRecentOperat(type, foreign_id,operation);
	}
	/****
	 * 发送邮件提醒下一步操作的用户
	 *  * @param permissions_id
	 * @param flow_type 流程类型
	 * @param user
	 * @param content
	 * @param flag true表示发送给user
	 */
	public void sendMail(int permissions_id,int flow_type,User user,String content,boolean flag){
		String title="OA办公系统邮件提醒";
		String tomail="";
		String msg="";
		String address="<br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;内网链接：http://10.100.0.2/ZZQA_Manager<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;外网链接：http://oa.windit.com.cn";
		if(flag){
			if(user!=null&&(tomail=user.getEmail())!=null&&tomail.length()>0&&canSend(flow_type,user.getSendEmail())){
				msg=new StringBuilder().append(user.getTruename()).append(" 您好：").append("<br/><br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;")
					.append(content).append(address).toString();
				tomail=user.getEmail();
				SendMessage sendMessage=new SendMessage(title,msg,tomail);
				new Thread(sendMessage).start();
			}
		}else{
			List <User> userList=userDAO.getUserListByPermissionsID(permissions_id);
			for(User u:userList){
				tomail=u.getEmail();
				if(tomail!=null&&tomail.length()>0&&canSend(flow_type,u.getSendEmail())){
					msg=new StringBuilder().append(u.getTruename()).append(" 您好：")
							.append(content).append(address).toString();
					SendMessage sendMessage=new SendMessage(title,msg,tomail);
					new Thread(sendMessage).start();
				}
			}
		}
	}
	/***
	 * 是否接受邮件
	 * @param type
	 * @param sendEmail
	 * @return
	 */
	private boolean canSend(int type,String sendEmail){
		if(sendEmail!=null){
			int index=type*2-2;
			if(index<sendEmail.length()&&sendEmail.charAt(index)=='1'){
				return false;
			}
		}
		return true;
	}
	//改变流程时不需要提醒（如：生产单创建时自动出库，不提醒仓库管理员）
	public void insertFlow2(Flow flow) {
		flowDAO.insertFlow(flow);
	}
	//改变流程时发生邮件提醒
	public void insertFlow(Flow flow) {
		// TODO Auto-generated method stub
		handeMessage(flow);
	}
	public void handeMessage(Flow flow){
		int type=flow.getType();
		int operation=flow.getOperation();
		int create_id=0;
		int project_type=0;
		int foreign_id=flow.getForeign_id();
		int uid=0;
		switch (type) {
			case 1:
				Task task=taskDAO.getTaskByID(foreign_id);
				if(task==null){
					return;
				}
				create_id=task.getCreate_id();
				project_type=task.getProject_type();
				int project_category=task.getProject_category();
				int project_case=task.getProject_case();
				if (operation==1) {
					if(task.getProduct_type()==10){
						sendMail(DataUtil.getPCategoryPIDArray(project_category),type,null,new StringBuilder().append("您有新的项目任务单（").append(task.getProject_name())
								.append("）需要审核。").toString(),false);
					}else {
						if(task.getProject_category()==5){	//新产品试装项目（尹旭晔）
							sendMail(163,type,null,new StringBuilder().append("您有新的新产品试装项目任务单（").append(task.getProject_name())
									.append("）需要审核。").toString(),false);
						}else{
							sendMail(DataUtil.getBussinessPIDArray(project_category),type,null,new StringBuilder().append("您有新的项目任务单（").append(task.getProject_name())
									.append("）需要审核。").toString(),false);
							sendMail(110,type,null,new StringBuilder().append("有新的项目任务单（").append(task.getProject_name())
									.append("）生成，请注意查看。").toString(),false);
						}
					}
				}else if(operation==2){
					if(task.getProject_category()==5){
						sendMail(163,type,null,new StringBuilder().append("您有新的新产品试装项目任务单（").append(task.getProject_name())
								.append("）需要审核。").toString(),false);
					}else{
						sendMail(DataUtil.getPCategoryPIDArray(project_category),type,null,new StringBuilder().append("您有新的项目任务单（").append(task.getProject_name())
								.append("）需要审核。").toString(),false);
					}
				}else if(operation==13){
					if(task.getProject_category()==5){
						sendMail(create_id,type,userDAO.getUserByID(create_id),new StringBuilder().append("您的新产品试装项目任务单（").append(task.getProject_name())
								.append("）需要上传文件。").toString(),true);
					}else if((task.getProject_category()==6||task.getProject_category()==7||task.getProject_category()==8) && project_type != 2){
							sendMail(171,type,null,new StringBuilder().append("您有新的项目任务单（").append(task.getProject_name())
									.append("）需要审核。").toString(),false);
					}else{
						if(project_case==0){//普项
							if(project_type == 2){
								sendMail(158,type,null,new StringBuilder().append("您有新的项目任务单（").append(task.getProject_name())
										.append("）需要审核。").toString(),false);						
							}else {		//50：工程审核权限
								sendMail(50,type,null,new StringBuilder().append("您有新的项目任务单（").append(task.getProject_name())
										.append("）需要审核。").toString(),false);
							}
						}else{//急项
							sendMail(create_id,type,userDAO.getUserByID(create_id),new StringBuilder().append("您的项目任务单（").append(task.getProject_name())
									.append("）已完成。").toString(),true);
							sendMail(3,type,null,new StringBuilder().append("项目任务单（").append(task.getProject_name())
									.append("）已完成，可以创建项目采购单").toString(),false);
							//项目任务单走完之后需要邮件提醒 107：项目预算表提交权限的人创建预算表
							sendMail(107,type,null,new StringBuilder().append("项目任务单（").append(task.getProject_name())
									.append("）已完成，可以创建项目预算表").toString(),false);
						}
					}
				}else if(operation==14){
					if(task.getProject_category()==5){
						sendMail(create_id,type,userDAO.getUserByID(create_id),new StringBuilder().append("项目任务单（").append(task.getProject_name())
								.append("）因产品经理审核未通过，需要您修改后重新审核。").toString(),true);
					}else {
						sendMail(create_id,type,userDAO.getUserByID(create_id),new StringBuilder().append("项目任务单（").append(task.getProject_name())
								.append("）因商务助理审核未通过，需要您修改后重新审核。").toString(),true);
					}
				}else if(operation==24){
					if(project_case==0){//普项
						sendMail(157,type,null,new StringBuilder().append("您有新的项目任务单（").append(task.getProject_name())
								.append("）需要审核。").toString(),false);
					}else {
						sendMail(DataUtil.getBussinessPIDArray(project_category),type,null,new StringBuilder().append("您有新的项目任务单（").append(task.getProject_name())
								.append("）需要审核。").toString(),false);
					}
				}else if(operation==25){
					sendMail(create_id,type,userDAO.getUserByID(create_id),new StringBuilder().append("项目任务单（").append(task.getProject_name())
							.append("）因诊断审核未通过，需要您修改后重新审核。").toString(),true);
				}else if(operation==26){
					sendMail(173,type,null,new StringBuilder().append("您有新的项目任务单（").append(task.getProject_name())
							.append("）需要审核。").toString(),false);
				}else if(operation==27){
					sendMail(create_id,type,userDAO.getUserByID(create_id),new StringBuilder().append("项目任务单（").append(task.getProject_name())
							.append("）因工程经理审核未通过，需要您修改后重新审核。").toString(),true);
				}else if(operation==17){
					if(task.getProject_category()==5){
						sendMail(163,type,null,new StringBuilder().append("您有新的新产品试装项目任务单（").append(task.getProject_name())
								.append("）需要审核。").toString(),false);
					}else if(project_case==0){//普项
						sendMail(DataUtil.getPCategoryPIDArray(project_category),type,null,new StringBuilder().append("您有新的项目任务单（").append(task.getProject_name())
									.append("）需要审核。").toString(),false);
					}else{//急项
						if(project_type == 2){
							sendMail(158,type,null,new StringBuilder().append("您有新的项目任务单（").append(task.getProject_name())
									.append("）需要审核。").toString(),false);						
						}else {
							sendMail(DataUtil.getBussinessPIDArray(project_category),type,null,new StringBuilder().append("您有新的项目任务单（").append(task.getProject_name())
									.append("）需要审核。").toString(),false);
						}
					}
				}else if(operation==18){
					if(task.getProject_category()==5){
						sendMail(create_id,type,userDAO.getUserByID(create_id),new StringBuilder().append("项目任务单（").append(task.getProject_name())
								.append("）因文件上传失败，需要您修改后重新审核。").toString(),true);
					}else {
						if(project_type == 2){
							sendMail(create_id,type,userDAO.getUserByID(create_id),new StringBuilder().append("项目任务单（").append(task.getProject_name())
									.append("）因售后审核未通过，需要您修改后重新审核。").toString(),true);
						}else {
							sendMail(create_id,type,userDAO.getUserByID(create_id),new StringBuilder().append("项目任务单（").append(task.getProject_name())
									.append("）因工程审核未通过，需要您修改后重新审核。").toString(),true);
						}
					}
				}else if(operation==19){
					if(task.getProject_category()==5){
						sendMail(9,type,null,new StringBuilder().append("您有新的新产品试装项目任务单（").append(task.getProject_name())
								.append("）需要审核。").toString(),false);
					}else{
						sendMail(9,type,null,new StringBuilder().append("您有新的项目任务单（").append(task.getProject_name())
								.append("）需要审核。").toString(),false);
					}
				}else if(operation==20){
					if(task.getProject_category()==5){
						sendMail(create_id,type,userDAO.getUserByID(create_id),new StringBuilder().append("项目任务单（").append(task.getProject_name())
								.append("）因产品经理审核未通过，需要您修改后重新审核。").toString(),true);
					}else {
						sendMail(create_id,type,userDAO.getUserByID(create_id),new StringBuilder().append("项目任务单（").append(task.getProject_name())
								.append("）因销售经理审核未通过，需要您修改后重新审核。").toString(),true);
					}
				} else if(operation==21){
					if(task.getProduct_type()==10){
						sendMail(create_id,type,userDAO.getUserByID(create_id),new StringBuilder().append("您的项目任务单（").append(task.getProject_name())
								.append("）已完成。").toString(),true);
						sendMail(2,type,null,new StringBuilder().append("项目任务单（").append(task.getProject_name())
								.append("）已完成，可以创建生产采购单").toString(),false);
					}else if(task.getProject_category()==5){
						sendMail(create_id,type,userDAO.getUserByID(create_id),new StringBuilder().append("您的新产品试装项目任务单（").append(task.getProject_name())
								.append("）已完成。").toString(),true);
						sendMail(3,type,null,new StringBuilder().append("新产品试装项目任务单（").append(task.getProject_name())
								.append("）已完成，可以创建项目采购单").toString(),false);
						//项目任务单走完之后需要邮件提醒 107：项目预算表提交权限的人创建预算表
//						sendMail(107,type,null,new StringBuilder().append("项目任务单（").append(task.getProject_name())
//								.append("）已完成，可以创建项目预算表").toString(),false);
					}else{
						if(project_case==0){//普项
							sendMail(create_id,type,userDAO.getUserByID(create_id),new StringBuilder().append("您的项目任务单（").append(task.getProject_name())
									.append("）已完成。").toString(),true);
							sendMail(3,type,null,new StringBuilder().append("项目任务单（").append(task.getProject_name())
									.append("）已完成，可以创建项目采购单").toString(),false);
							//项目任务单走完之后需要邮件提醒 107：项目预算表提交权限的人创建预算表
//							sendMail(107,type,null,new StringBuilder().append("项目任务单（").append(task.getProject_name())
//									.append("）已完成，可以创建项目预算表").toString(),false);
						}else{//急项
							if(project_type == 2){
								sendMail(157,type,null,new StringBuilder().append("您有新的项目任务单（").append(task.getProject_name())
										.append("）需要审核。").toString(),false);	
							}else{
								if(task.getProject_category()==6||task.getProject_category()==7||task.getProject_category()==8){
									sendMail(171,type,null,new StringBuilder().append("您有新的项目任务单（").append(task.getProject_name())
											.append("）需要审核。").toString(),false);
								}else{
									sendMail(50,type,null,new StringBuilder().append("您有新的项目任务单（").append(task.getProject_name())
											.append("）需要审核。").toString(),false);
								}
							}
						}
					}
				}else if(operation==22){
					sendMail(create_id,type,userDAO.getUserByID(create_id),new StringBuilder().append("项目任务单（").append(task.getProject_name())
							.append("）因总经理审核未通过，需要您修改后重新审核。").toString(),true);
				}else if(operation==12){
					List<Flow> pre_flowList=flowDAO.getFlowListByCondition(1, task.getId());
					HashSet<Integer> UIDSet =   new HashSet<Integer>();//移除重复的用户
					//通知下一步需要审批的人
					int lastOpera=pre_flowList.get(pre_flowList.size()-1).getOperation();
					if(task.getProduct_type()==10){
						if(lastOpera==1 || lastOpera==2){
							List<User> uList=userDAO.getUserListByPermissionsID(DataUtil.getPCategoryPIDArray(project_category));
							for (User user : uList) {
								UIDSet.add(user.getId());
							}
						}else if(lastOpera==19){
							List<User> uList=userDAO.getUserListByPermissionsID(9);
							for (User user : uList) {
								UIDSet.add(user.getId());
							}
						}
					}else{
						if(lastOpera==1){
							List<User> uList=userDAO.getUserListByPermissionsID(DataUtil.getBussinessPIDArray(project_category));
							for (User user : uList) {
								UIDSet.add(user.getId());
							}
						}else if(lastOpera==2){
							List<User> uList=userDAO.getUserListByPermissionsID(DataUtil.getPCategoryPIDArray(project_category));
							for (User user : uList) {
								UIDSet.add(user.getId());
							}
						}else if(lastOpera==13){
							if(project_case==0){//普项
								List<User> uList=userDAO.getUserListByPermissionsID(50);
								for (User user : uList) {
									UIDSet.add(user.getId());
								}
							}else{//急项
								List<User> uList=userDAO.getUserListByPermissionsID(3);
								for (User user : uList) {
									UIDSet.add(user.getId());
								}
							}
						}else if(lastOpera==17){
							List<User> uList=userDAO.getUserListByPermissionsID(DataUtil.getPCategoryPIDArray(project_category));
							uList.addAll(userDAO.getUserListByPermissionsID(DataUtil.getBussinessPIDArray(project_category)));
							for (User user : uList) {
								UIDSet.add(user.getId());
							}
						}else if(lastOpera==19){
							List<User> uList=userDAO.getUserListByPermissionsID(9);
							for (User user : uList) {
								UIDSet.add(user.getId());
							}
						}else if(lastOpera==21){
							if(project_case==0){//普项
								List<User> uList=userDAO.getUserListByPermissionsID(3);
								for (User user : uList) {
									UIDSet.add(user.getId());
								}
							}else{//急项
								List<User> uList=userDAO.getUserListByPermissionsID(50);
								for (User user : uList) {
									UIDSet.add(user.getId());
								}
							}
						}
					}
					for (Flow pre_flow : pre_flowList) {
						int opera=pre_flow.getOperation();
						if((opera>2&&opera<9)||opera==13||opera==17||opera==19||opera==21||opera==23){
							UIDSet.add(pre_flow.getUid());
						}
						if(opera==5||opera==8||opera==23){
							//已完成的任务单，撤销后需要追加提醒生产主管
							List<User> uList=userDAO.getUserListByPermissionsID(3);
							for (User user : uList) {
								UIDSet.add(user.getId());
							}
						}
					}
					if(taskDAO.checkTaskBind(task.getId())){
						//绑定采购或发货 已经绑定采购单或发货单的任务单撤销时需要追加提醒采购人员
						List<User> uList=userDAO.getUserListByPermissionsID(21);
						for (User user : uList) {
							UIDSet.add(user.getId());
						}
					}
					Iterator iterator=UIDSet.iterator();
					while (iterator.hasNext()) {
						uid = ((Integer) iterator.next()).intValue();
						sendMail(uid,type,userDAO.getUserByID(uid),new StringBuilder().append("项目任务单（").append(task.getProject_name())
								.append("）已撤销。").toString(),true);
					}
				}
				break;
			case 2:
				Product_procurement pp=product_procurementDAO.getProduct_procurementByID(foreign_id);
				if(pp==null){
					return;
				}
				create_id=pp.getCreate_id();
				if(operation==1){
					sendMail(17,type,null,"您有新的生产采购单需要审核。",false);
				}else if(operation==3){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的生产采购单因审核未通过，需要您修改。",true);
				}else if(operation==2){
					sendMail(21,type,null,"您有新的生产采购单需要确认。",false);
				}else if(operation==4){
					sendMail(22,type,null,"生产采购已确认采购，请密切关注到货动态并及时验货。",false);
				}else if(operation==5){
					//sendMail(pp.getCreate_id(),"采购已完成，请及时确认收货。",true);
				}else if(operation==6){
					//sendMail(pp.getCreate_id(),"您的生产采购单已确认收货，请及时验货。",true);
				}else if(operation==7){
					sendMail(23,type,null,"您有新的生产采购单需要入库。",false);
				}else if(operation==8){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的生产采购单已完成。",true);
				}
				break;
			case 3:
				Project_procurement project_p=project_procurementDAO.getProject_procurementByID(foreign_id);
				if(project_p==null){
					return;
				}
				create_id=project_p.getCreate_id();
				if(operation==16){
					Task task2_16=taskDAO.getTask2ByID(project_p.getTask_id());
					if(task2_16!=null){
						sendMail(0,1,userDAO.getUserByID(task2_16.getCreate_id()),"您的项目任务单（"+task2_16.getProject_name()+"）被项目采购单绑定。",true);
					}
				}else if(operation==1){
					Task task2_16=taskDAO.getTaskByID(project_p.getTask_id());
					if(task2_16!=null){
						sendMail(0,1,userDAO.getUserByID(task2_16.getCreate_id()),"您的项目任务单（"+task2_16.getProject_name()+"）被项目采购单绑定。",true);
						sendMail(DataUtil.getPurchasePIDArray(task2_16.getType(), task2_16.getProject_category()),type,null,"您有新的项目采购预算表需要审核。",false);
					}
				}else if (operation == 18){		//采购单销售经理审核
//					sendMail(48, type, null, "您有新的项目采购预算表需要审核",false);
					Task task2_16=taskDAO.getTaskByID(project_p.getTask_id());
					if(task2_16!=null){
						sendMail(DataUtil.getPurchaseMarketPIDArray(task2_16.getType(),task2_16.getProject_category()),type,null,"您有新的采购需求单需要审核。", false);
					}
				}else if (operation==19){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的项目采购预算表因销售经理审核未通过，需要您修改。",true);
				}else if(operation==2){
//					Task task2_16=taskDAO.getTaskByID(project_p.getTask_id());
//					if(task2_16!=null){
//						sendMail(DataUtil.getOfficerPIDArray(task2_16.getType(), task2_16.getProject_category()),type,null,"您有新的项目采购预算表需要审核。",false);
//					}
					sendMail(16,type,null,"您有新的项目采购预算表需要审核。",false);
				}else if(operation==12){
					sendMail(16,type,null,"您有新的项目采购预算表需要审核。",false);
				}else if(operation==14){
					sendMail(3,type,null,"项目采购预算表已经审核通过，请提交项目采购需求单。",false);
				}else if(operation==3){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的项目采购预算表因部门审核未通过，需要您修改。",true);
				}else if(operation==13){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的项目采购预算表因运营审核未通过，需要您修改。",true);
				}else if(operation==15){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的项目采购预算表因总经理审核未通过，需要您修改。",true);
				}else if(operation==4){
					sendMail(17,type,null,"您有新的项目采购需求单需要审核。",false);
				}else if(operation==5){
					sendMail(21,type,null,"您有新的项目采购需求单需要确认。",false);
				}else if(operation==6){
					Flow flow_4=new Flow();
					flow_4.setForeign_id(foreign_id);
					flow_4.setType(3);
					flow_4.setOperation(4);
					flow_4=flowDAO.getFlowByOperation(flow_4);
					if(flow_4!=null){
						sendMail(0,type,userDAO.getUserByID(flow_4.getUid()),"您的项目采购需求单审核未通过，需要您修改。",true);
					}
				}else if(operation==7){
					sendMail(22,type,null,"项目采购单已确认采购，请密切关注到货动态并及时验货。",false);
				}else if(operation==8){
					//sendMail(create_id,"您的项目采购单已经在采购中，请及时确认收货。",true);
					sendMail(22, type, null, "项目采购已经完成，请尽快完成验货。",false);
				}else if(operation==9){
					//sendMail(create_id,"您的项目采购已确认收货，请及时验货。",true);
				}else if(operation==10){
					sendMail(23,type,null,"您有新的项目采购需要入库。",false);
				}else if(operation==11){
					Flow flow_4=new Flow();
					flow_4.setForeign_id(foreign_id);
					flow_4.setType(3);
					flow_4.setOperation(4);
					flow_4=flowDAO.getFlowByOperation(flow_4);
					if(flow_4!=null){
						//发送给预算单发起者
//						sendMail(0,type,userDAO.getUserByID(flow_4.getUid()),"您的项目采购单已完成。",true);
						//发送给所有相关的人
						List<Integer> list = getUidByForeignId(foreign_id);
						User user = null;
						Project_procurement proPc = project_procurementDAO.getProject_procurementByID(foreign_id);
						String project_name = null;
						if (proPc!=null){
							int task_id = proPc.getTask_id();
							Task taskByID = taskDAO.getTaskByID(task_id);
							if (taskByID!=null){
								project_name = taskByID.getProject_name();
							}
						}

						for (Integer l:list){
							user = userDAO.getUserByID(l);
							if (user!=null){

								sendMail(0, type, user, project_name!=null?"您参与的项目："+project_name+"已经完成采购。":"您参与的项目采购流程已经完成。",true);
							}
						}

					}
				}else if(operation==17){
					//通知审批过的人
					if(project_p.getProject_pid()==0){
						List<Flow> flows=flowDAO.getFlowListByCondition(3, foreign_id);
						Set<Integer> set=new HashSet<Integer>();
						for (Flow flow2 : flows) {
							int op=flow2.getOperation();
							if(op==2||op==3||op==12||op==13||op==15){
								if(!set.contains(flow2.getUid())){
									set.add(flow2.getUid());
									sendMail(0,type,userDAO.getUserByID(flow2.getUid()),"项目采购单已撤销。",true);
								}
							}
						}
						Flow last_flow=flowDAO.getNewFlowByFID(3, foreign_id);
						int op=last_flow.getOperation();
						if(op==1){
							Task task2_16=taskDAO.getTaskByID(project_p.getTask_id());
							List<User> users=userDAO.getUserListByPermissionsID(DataUtil.getPurchasePIDArray(task2_16.getType(), task2_16.getProject_category()));
							for (User user : users) {
								if(!set.contains(user.getId())){
									sendMail(0,type,userDAO.getUserByID(user.getId()),"项目采购单已撤销。",true);
								}
							}
						}else if(op==2){
							Task task2_16=taskDAO.getTaskByID(project_p.getTask_id());
							List<User> users=userDAO.getUserListByPermissionsID(DataUtil.getOfficerPIDArray(task2_16.getType(), task2_16.getProject_category()));
							for (User user : users) {
								if(!set.contains(user.getId())){
									sendMail(0,type,userDAO.getUserByID(user.getId()),"项目采购单已撤销。",true);
								}
							}
						}else if(op==12){
							List<User> users=userDAO.getUserListByPermissionsID(16);
							for (User user : users) {
								if(!set.contains(user.getId())){
									sendMail(0,type,userDAO.getUserByID(user.getId()),"项目采购单已撤销。",true);
								}
							}
						}
					}
				}
				break;
			case 4:
				Outsource_product op=outsource_productDAO.getOutsource_productByID(foreign_id);
				if(op==null){
					return;
				}
				create_id=op.getCreate_id();
				if(operation==1){
					sendMail(23,type,null,"新的外协生产单生成，需要您确认原料出库。",false);
				}else if(operation==2){
					sendMail(21,type,null,"外协生产单已确认出库，请及时进行原料发货。",false);
				}else if(operation==3){
					sendMail(22,type,null,"外协生产单已在生产，请及时确认到货。",false);
				}else if(operation==4){
					sendMail(22,type,null,"外协生产单已确认到货，请及时验货。",false);
				}else if(operation==5){
					sendMail(23,type,null,"外协生产单已验货，请确认入库。",false);
				}else if(operation==6){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的外协生产单已完成。",true);
				}
				break;
			case 5:
				if(operation==1){
					Manufacture mf=manufactureDAO.getManufactureByID(foreign_id);
					sendMail(24,type,null,"新的生产单已创建，请提醒仓库管理员出库。",false);
					Task task5_1=taskDAO.getTask2ByID(mf.getTask_id());
					if(task5_1!=null){
						sendMail(0,1,userDAO.getUserByID(task5_1.getCreate_id()),"您的项目任务单（"+task5_1.getProject_name()+"）被生产单绑定。",true);
					}
				}else if(operation==5){
					sendMail(23,type,null,"您有新的生产单需要确认出库。",false);
				}else if(operation==2){
					sendMail(24,type,null,"您有新的生产单需要生产。",false);
				}else if(operation==3){
					sendMail(23,type,null,"您有新的生产单需要确认入库。",false);
				}else if(operation==4){
					Manufacture mf=manufactureDAO.getManufactureByID(foreign_id);
					if(mf==null){
						return;
					}
					create_id=mf.getCreate_id();
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的生产单已完成。",true);
				}
				break;
			case 6:
				Shipments ship=shipmentsDAO.getShipmentsByID(foreign_id);
				if(ship==null){
					return;
				}
				create_id=ship.getCreate_id();
				if(operation==1){
					sendMail(23,type,null,"您有新的发货单需要确认出库。",false);
					Task task6_1=taskDAO.getTask2ByID(ship.getTask_id());
					if(task6_1!=null){
						sendMail(0,1,userDAO.getUserByID(task6_1.getCreate_id()),"您的项目任务单（"+task6_1.getProject_name()+"）被发货单绑定。",true);
					}
				}else if(operation==2){
					sendMail(154,type,null,"有一个发货单需要上传发货单据。",false);
				}else if(operation==7){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"有一个发货单需要上传发货单据。",true);
					//sendMail(27,type,null,"您有新的发货单需要处理。",false);
				}else if(operation==3){
					sendMail(27,type,null,"发货单据已上传，请及时发货",false);
				}else if(operation==4){
					sendMail(27,type,null,"发货单已发出，请及时确认到货。",false);//由发货人自己填写到货及上传回执单
				}else if(operation==5){
					sendMail(27,type,null,"您有一个发货单已确认到货，请及时上传现场开箱验货报告回执单。",false);//由发货人填写到货及上传回执单
				}else if(operation==6){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的发货单已完成。",true);
				}
				break;
			case 7:
				Travel travel=travelDAO.getTravelByID(foreign_id);
				if(travel==null){
					return;
				}
				create_id=travel.getCreate_id();
				if(operation==1){
					List<User> list=userDAO.getParentListByChildUid(travel.getCreate_id());
					for(User travel_user:list){
						sendMail(travel_user.getId(),type,userDAO.getUserByID(travel_user.getId()),"您有新的出差单需要审批。",true);//您有新的出差单需要审批
					}	
				}else if(operation==2){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的出差单上级领导审批通过。备注："+flow.getReason(),true);//出差单领导审批过了要邮件提醒
					sendMail(32,type,null,"您有新的出差单需要备案。",false);//考勤备案
				}else if(operation==3){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的出差单审批未通过。备注："+flow.getReason(),true);//审批失败
				}else if(operation==4){
					sendMail(31,type,null,"您有新的出差单需要备案。",false);//财务备案
				}else if(operation==5){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的出差单审批完成。",true);//审批成功
				}else if(operation==6){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"考勤备案时发现您本次出差未能按时返回，需要您延长出差时间。",true);//出差延时，要求修改结束时间
				}else if(operation==60){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的出差单审批未通过，请修改出差返回时间",true);//上级审批失败，要求修改结束时间，老版本后期可删除
					flow.setOperation(6);
				}else if(operation==7){
					List<Flow> list=flowDAO.getFlowListByCondition(7, foreign_id);
					int uid1=0;
					int uid2=0;
					for (Flow flow2 : list) {
						if(flow2.getOperation()==2){
							uid1=flow2.getUid();
						}
						if(flow2.getOperation()==4){
							uid2=flow2.getUid();
						}
					}
					Set<Integer> set=new HashSet<Integer>();
					if(uid1>0){//上级审批通过，也要提醒备案人员
						if(!set.contains(uid1)){
							User u=userDAO.getUserByID(uid1);
							sendMail(uid1,type,u,u.getTruename()+"的出差单已撤销。",true);//撤销需要提醒审批过的人
							set.add(uid1);
						}
						if(uid2>0){
							//若备案过，只通知该备案人，但需通知财务备案人
							if(!set.contains(uid2)){
								User u=userDAO.getUserByID(uid2);
								sendMail(uid2,type,u,u.getTruename()+"的出差单已撤销。",true);//撤销需要提醒考勤备案的人
								set.add(uid2);
							}
							List<User> u_list=userDAO.getUserListByPermissionsID(31);
							for (User user : u_list) {
								int u_id=user.getId();
								if(!set.contains(u_id)){
									set.add(u_id);
									User u=userDAO.getUserByID(u_id);
									sendMail(u_id,type,u,u.getTruename()+"的出差单已撤销。",true);//提醒财务备案
								}
							}
							u_list.clear();
							u_list=null;
						}else{
							List<User> u_list=userDAO.getUserListByPermissionsID(32);
							for (User user : u_list) {
								int u_id=user.getId();
								if(!set.contains(u_id)){
									set.add(u_id);
									User u=userDAO.getUserByID(u_id);
									sendMail(u_id,type,u,u.getTruename()+"的出差单已撤销。",true);//考勤备案
								}
							}
							u_list.clear();
							u_list=null;
						}
					}else{
						List<User> li=userDAO.getParentListByChildUid(travel.getCreate_id());
						if(li.size()>0){
							int u_id=li.get(0).getId();
							if(!set.contains(u_id)){
								User u=userDAO.getUserByID(u_id);
								sendMail(u_id,type,u,u.getTruename()+"的出差单已撤销。",true);//撤销需要提醒上级，因为新建时发过待审批邮件
								set.add(u_id);
							}
							li.clear();
							li=null;
						}
					}
				}else if(operation==400){
					sendMail(31,type,null,"您有新的出差单需要备案。",false);//无需备案未通过
					flow.setOperation(4);
				}else if(operation==8){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您有一个出差单需要本人确认。",true);//无需备案需要本人确认
					flow.setOperation(8);
				}
				break;
			case 8:
				Leave leave=leaveDAO.getLeaveByID(foreign_id);
				if(leave==null){
					return;
				}
				create_id=leave.getCreate_id();
				if(operation==1){
					List<User> list=userDAO.getParentListByChildUid(create_id);
					if(list.size()>0){
						sendMail(0,type,list.get(0),"您有新的请假单需要审批。",true);//您有新的请假单需要审批
					}
				}else if(operation==2){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的请假单部门领导审批通过。备注："+flow.getReason(),true);//请假单领导审批过了要邮件提醒
					int num=getApprovalNum(DataUtil.getLeaveDays(leave.getStarttime(), leave.getEndtime(),leave.getLeave_type()),create_id);
					if(num>1){
						//1次以上审批
						List<User> list=userDAO.getParentListByChildUid(create_id);
						if(list.size()>0){
							List<User> list2=userDAO.getParentListByChildUid(list.get(0).getId());
							if(list2.size()>0){
								sendMail(0,type,list2.get(0),"您有新的请假单需要审批。",true);//您有新的请假单需要审批
							}
						}
					}else{
						//一次审批
						sendMail(30,type,null,"您有新的请假单需要备案。",false);//考勤备案
					}
				}else if(operation==3){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的请假单部门领导审批未通过。备注："+flow.getReason(),true);//审批失败
				}else if(operation==4){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的请假单分管领导审批通过。备注："+flow.getReason(),true);//请假单领导审批过了要邮件提醒
					int num=getApprovalNum(DataUtil.getLeaveDays(leave.getStarttime(), leave.getEndtime(),leave.getLeave_type()),create_id);
					if(num>2){
						//三次审批
						User user=userDAO.getTopUser();
						sendMail(0,type,user,"您有新的请假单需要审批。",true);//您有新的请假单需要审批
					}else{
						sendMail(30,type,null,"您有新的请假单需要备案。",false);//考勤备案
					}
				}else if(operation==5){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的请假单分管领导审批未通过。备注："+flow.getReason(),true);//审批失败
				}else if(operation==6){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的请假单审批完成。",true);//审批成功
				}else if(operation==7){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的请假单总经理审批通过。备注："+flow.getReason(),true);//请假单领导审批过了要邮件提醒
					sendMail(30,type,null,"您有新的请假单需要备案。",false);//考勤备案
				}else if(operation==8){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的请假单总经理审批未通过。备注："+flow.getReason(),true);//审批成功
				}else if(operation==9){
					List<User> list=userDAO.getParentListByChildUid(create_id);
					if(list.size()>0){
						sendMail(0,type,list.get(0),"有一个请假单已撤销。",true);//已撤销
					}
				}
				break;
			case 9:
				Resumption resumption=resumptionDAO.getResumptionByID(foreign_id);
				if(resumption==null){
					return;
				}
				Leave leave_rsp=leaveDAO.getLeaveByID(resumption.getForeign_id());
				if(leave_rsp==null){
					return;
				}
				create_id=resumption.getCreate_id();
				int num=getApprovalNum(DataUtil.getLeaveDays(resumption.getStarttime(), resumption.getReback_time()-43200000l,leave_rsp.getLeave_type()),create_id);
				if(operation==1){
					//自己填，无需提醒
				}else if(operation==2){
					List<User> list=userDAO.getParentListByChildUid(create_id);
					if(list.size()>0){
						sendMail(0,type,list.get(0),"您有新的销假单需要审批。",true);
					}
				}else if(operation==5){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的销假单部门领导审批通过。备注："+flow.getReason(),true);//销假单领导审批过了要邮件提醒
					if(num>1){
						//1次以上审批
						List<User> list=userDAO.getParentListByChildUid(create_id);
						if(list.size()>0){
							List<User> list2=userDAO.getParentListByChildUid(list.get(0).getId());
							if(list2.size()>0){
								sendMail(0,type,list2.get(0),"您有新的销假单需要审批。",true);
							}
						}
					}else{
						//一次审批
						sendMail(30,type,null,"您有新的销假单需要备案。",false);//考勤备案
					}
				}else if(operation==6){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的销假单部门领导审批未通过。备注："+flow.getReason(),true);//审批失败
				}else if(operation==7){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的销假单分管领导审批通过。备注："+flow.getReason(),true);//销假单领导审批过了要邮件提醒
					if(num>2){
						//三次审批
						User user=userDAO.getTopUser();
						sendMail(0,type,user,"您有新的销假单需要审批。",true);//您有新的销假单需要审批
					}else{
						sendMail(30,type,null,"您有新的销假单需要备案。",false);//考勤备案
					}
				}else if(operation==8){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的销假单分管领导审批未通过。备注："+flow.getReason(),true);//审批失败
				}else if(operation==3){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的销假单审批完成。",true);//审批成功
				}else if(operation==9){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的销假单总经理审批通过，备注："+flow.getReason(),true);//销假单领导审批过了要邮件提醒
					sendMail(30,type,null,"您有新的销假单需要备案。",false);//考勤备案
				}else if(operation==10){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的销假单总经理审批未通过。备注："+flow.getReason(),true);//审批成功
				}
				break;
			case 10:
				Track track=trackDAO.getTrackByID(foreign_id);
				if(track==null){
					return;
				}
				create_id=track.getCreate_id();
				if(operation==1){
					List<User> track_users_parent=userDAO.getParentListByChildUid(create_id);
					if(track_users_parent.size()>0){
						sendMail(0,type,track_users_parent.get(0),"您有新的状态跟踪表需要审批。",true);
					}
				}else if(operation==2){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的状态跟踪表审批通过。",true);//等待审批 修改已结束的状态跟踪表未通过，返回到结束状态
				}else if(operation==3){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的状态跟踪表审批未通过。",true);//等待审批
				}
				break;
			case 11:
				Flow flow13=getFlowByOperation(11, foreign_id, 13);//撤销步骤
				Sales_contract sales_contract=sales_contractDAO.getSales_contractByID(foreign_id);
				boolean hasFile=sales_contract.getContract_file()==0;
				int applyNum=getApplyNum(sales_contract);
				if(sales_contract==null){
					return;
				}
				create_id=sales_contract.getCreate_id();
				if(operation==1){
					if(hasFile){
						sendMail(58,type,null,"您有新的客户合同需要审批。",false);
					}else{
						sendMail(59,type,null,"您有新的销售合同需要审批。",false);
					}
				}else if(operation==2){
					sendMail(59,type,null,"您有新的销售合同需要审批。",false);
					//sendMail(create_id,"您的客户合同审批通过。",true);
				}else if(operation==3){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的客户合同审批未通过。",true);
				}else if(operation==4){
					/*if(flow13!=null){
						sendMail(create_id,"您请求撤销的销售合同商务审批通过。",true);
					}else{
						sendMail(create_id,"您的销售合同商务审批通过。",true);
					}*/
					sendMail(60,type,null,"您有新的销售合同需要审批。",false);
				}else if(operation==5){
					if(flow13!=null){
						//撤销失败
						sendMail(create_id,type,userDAO.getUserByID(create_id),"您的销售合同撤销失败,商务审批不通过，备注："+flow.getReason(),true);
						Map map=new HashMap();
						map.put("type", 11);
						map.put("foreign_id", foreign_id);
						map.put("starttime", flow13.getCreate_time());
						map.put("endtime", flow.getCreate_time());
						flowDAO.delSomeFlow(map);
						return;
					}else{
						sendMail(create_id,type,userDAO.getUserByID(create_id),"您的销售合同商务审批未通过。",true);
					}
				}else if(operation==6){
					if(applyNum>1){
						/*if(flow13!=null){
							sendMail(create_id,"您请求撤销的销售合同部门经理审批通过。",true);
						}else{
							sendMail(create_id,"您的销售合同部门经理审批通过。",true);
						}*/
						sendMail(61,type,null,"您有新的销售合同需要审批。",false);
					}else{
						if(flow13==null){
							sendMail(117,type,null,"有一个销售合同需要商务盖章。",false);
						}
					}
				}else if(operation==7){
					if(flow13!=null){
						//撤销失败
						sendMail(create_id,type,userDAO.getUserByID(create_id),"您的销售合同撤销失败,部门经理审批不通过，备注："+flow.getReason(),true);
						Map map=new HashMap();
						map.put("type", 11);
						map.put("foreign_id", foreign_id);
						map.put("starttime", flow13.getCreate_time());
						map.put("endtime", flow.getCreate_time());
						flowDAO.delSomeFlow(map);
						return;
					}else{
						sendMail(create_id,type,userDAO.getUserByID(create_id),"您的销售合同部门经理审批未通过。",true);
					}
				}else if(operation==8){
					if(applyNum>2){
						/*if(flow13!=null){
							sendMail(create_id,"您请求撤销的销售合同运营总监审批通过。",true);
						}else{
							sendMail(create_id,"您的销售合同运营总监审批通过。",true);
						}*/
						sendMail(62,type,null,"您有新的销售合同需要审批。",false);
					}else{
						if(flow13==null){
							sendMail(117,type,null,"有一个销售合同需要商务盖章。",false);
						}
					}
				}else if(operation==9){
					if(flow13!=null){
						//撤销失败
						sendMail(create_id,type,userDAO.getUserByID(create_id),"您的销售合同撤销失败,运营总监审批不通过，备注："+flow.getReason(),true);
						Map map=new HashMap();
						map.put("type", 11);
						map.put("foreign_id", foreign_id);
						map.put("starttime", flow13.getCreate_time());
						map.put("endtime", flow.getCreate_time());
						flowDAO.delSomeFlow(map);
						return;
					}else{
						sendMail(create_id,type,userDAO.getUserByID(create_id),"您的销售合同运营总监审批未通过。",true);
					}
				}else if(operation==10){
					if(flow13==null){
						sendMail(117,type,null,"有一个销售合同需要商务盖章。",false);
					}
				}else if(operation==11){
					if(flow13!=null){
						//撤销失败
						sendMail(create_id,type,userDAO.getUserByID(create_id),"您的销售合同撤销失败,总经理审批不通过，备注："+flow.getReason(),true);
						Map map=new HashMap();
						map.put("type", 11);
						map.put("foreign_id", foreign_id);
						map.put("starttime", flow13.getCreate_time());
						map.put("endtime", flow.getCreate_time());
						flowDAO.delSomeFlow(map);
						return;
					}else{
						sendMail(create_id,type,userDAO.getUserByID(create_id),"您的销售合同总经理审批未通过。",true);
					}
				}else if(operation==12){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的销售合同已完成。",true);
				}else if(operation==13){
					int sales_id=foreign_id;
					if(flow.getId()==1){
						//审批结束后撤销，则类似修改，需要填写撤销理由，相关人员重新审批通过
					}else if(flow.getId()==2){
						//未审批完之前撤销，可直接撤销，通知相关人员
						Set<Integer> uidSet=new HashSet<Integer>();
						Flow flow_before=flowDAO.getNewFlowByFID(11, foreign_id);//先通知下一步的人
						if(flow_before!=null){
							int opera=flow_before.getOperation();
							if(opera==1){
								List<User> list=null;
								if(hasFile){
									list=userDAO.getUserListByPermissionsID(58);
								}else{
									list=userDAO.getUserListByPermissionsID(59);
								}
								for (User user : list) {
									int uid_before=user.getId();
									if(!uidSet.contains(uid_before)){
										sendMail(0,type,user,"有一个销售合同被撤销",true);
										uidSet.add(uid_before);
									}
								}
							}else if(opera==2){
								List<User> list=null;
								list=userDAO.getUserListByPermissionsID(59);
								for (User user : list) {
									int uid_before=user.getId();
									if(!uidSet.contains(uid_before)){
										sendMail(0,type,user,"有一个销售合同被撤销",true);
										uidSet.add(uid_before);
									}
								}
							}else if(opera==4){
								List<User> list=null;
								list=userDAO.getUserListByPermissionsID(60);
								for (User user : list) {
									int uid_before=user.getId();
									if(!uidSet.contains(uid_before)){
										sendMail(0,type,user,"有一个销售合同被撤销",true);
										uidSet.add(uid_before);
									}
								}
							}else if(opera==6){
								if(applyNum>1){
									List<User> list=userDAO.getUserListByPermissionsID(61);
									for (User user : list) {
										int uid_before=user.getId();
										if(!uidSet.contains(uid_before)){
											sendMail(0,type,user,"有一个销售合同被撤销",true);
											uidSet.add(uid_before);
										}
									}
								}else{
									List<User> list=userDAO.getUserListByPermissionsID(117);
									for (User user : list) {
										int uid_before=user.getId();
										if(!uidSet.contains(uid_before)){
											sendMail(0,type,user,"有一个销售合同被撤销",true);
											uidSet.add(uid_before);
										}
									}
								}
							}else if(opera==8){
								if(applyNum>2){
									List<User> list=userDAO.getUserListByPermissionsID(62);
									for (User user : list) {
										int uid_before=user.getId();
										if(!uidSet.contains(uid_before)){
											sendMail(0,type,user,"有一个销售合同被撤销",true);
											uidSet.add(uid_before);
										}
									}
								}else if(applyNum==2){
									List<User> list=userDAO.getUserListByPermissionsID(117);
									for (User user : list) {
										int uid_before=user.getId();
										if(!uidSet.contains(uid_before)){
											sendMail(0,type,user,"有一个销售合同被撤销",true);
											uidSet.add(uid_before);
										}
									}
								}
							}else if(opera==10){
								List<User> list=userDAO.getUserListByPermissionsID(117);
								for (User user : list) {
									int uid_before=user.getId();
									if(!uidSet.contains(uid_before)){
										sendMail(0,type,user,"有一个销售合同被撤销",true);
										uidSet.add(uid_before);
									}
								}
							}
						}
						Map map=new HashMap();
						map.put("type", 11);
						map.put("foreign_id", sales_id);
						map.put("starttime", sales_contract.getCreate_time());
						map.put("endtime", flow.getCreate_time());
						List<Flow> flowList=flowDAO.getSomeFlow(map);
						for (Flow flow_temp : flowList) {
							int uid_temp=flow_temp.getUid();
							int opera=flow_temp.getOperation();
							if(!uidSet.contains(uid_temp)&&(opera>1&&opera<12)){
								sendMail(0,type,userDAO.getUserByID(uid_temp),"有一个销售合同被撤销",true);
								uidSet.add(uid_temp);
							}
						}
						flowList.clear();
						flowList=null;
						uidSet.clear();
						uidSet=null;
					}else if(flow.getId()==3){
						//撤销成功
						sendMail(create_id,type,userDAO.getUserByID(create_id),"您的销售合同撤销成功",true);
					}		
				}
				break;
			case 12:
				Flow flow11=getFlowByOperation(12, foreign_id, 11);//撤销步骤
				Purchase_contract purchase_contract=purchase_contractDAO.getPurchase_contractByID(foreign_id);
				int purchaseApplyNum=getPurchaseApplyNum(purchase_contract);
				if(purchase_contract==null){
					return;
				}
				create_id=purchase_contract.getCreate_id();
				
				if(operation==1){
					sendMail(72,type,null,"您有新的采购合同需要审批",false);
				}else if(operation==2){
					/*if(flow11!=null){
						sendMail(create_id,"您请求撤销的采购合同商务审批通过。",true);
					}else{
						sendMail(create_id,"您的采购合同商务审批通过。",true);
					}*/
					sendMail(73,type,null,"您有新的采购合同需要审批",false);
				}else if(operation==3){
					if(flow11!=null){
						//撤销失败
						sendMail(create_id,type,userDAO.getUserByID(create_id),"您的采购合同撤销失败,商务审批不通过，备注："+flow.getReason(),true);
						Map map=new HashMap();
						map.put("type", 12);
						map.put("foreign_id", foreign_id);
						map.put("starttime", flow11.getCreate_time());
						map.put("endtime", flow.getCreate_time());
						flowDAO.delSomeFlow(map);//删除中间的流程
						purchase_noteDAO.reSetHasBuyNum(foreign_id);
						return;
					}else{
						sendMail(create_id,type,userDAO.getUserByID(create_id),"您的采购合同商务审批未通过。",true);
					}
				}else if(operation==4){
					if(purchaseApplyNum>2){
						/*if(flow11!=null){
							sendMail(create_id,"您请求撤销的采购合同部门经理审批通过。",true);
						}else{
							sendMail(create_id,"您的采购合同部门经理审批通过。",true);
						}*/
						sendMail(74,type,null,"您有新的采购合同需要审批",false);
					}else{
						if(flow11==null){
							sendMail(118,type,null,"您有新的采购合同需要采购",false);
						}
					}
				}else if(operation==5){
					if(flow11!=null){
						//撤销失败
						sendMail(create_id,type,userDAO.getUserByID(create_id),"您的采购合同撤销失败,部门经理审批不通过，备注："+flow.getReason(),true);
						Map map=new HashMap();
						map.put("type", 12);
						map.put("foreign_id", foreign_id);
						map.put("starttime", flow11.getCreate_time());
						map.put("endtime", flow.getCreate_time());
						flowDAO.delSomeFlow(map);
						purchase_noteDAO.reSetHasBuyNum(foreign_id);
						return;
					}else{
						sendMail(create_id,type,userDAO.getUserByID(create_id),"您的采购合同部门经理审批未通过。",true);
					}
				}else if(operation==6){
					if(purchaseApplyNum>3){
						/*if(flow11!=null){
							sendMail(create_id,"您请求撤销的采购合同运营总监审批通过。",true);
						}else{
							sendMail(create_id,"您的采购合同运营总监审批通过。",true);
						}*/
						sendMail(75,type,null,"您有新的采购合同需要审批",false);
					}else{
						if(flow11==null){
							sendMail(118,type,null,"您有新的采购合同需要采购",false);
						}
					}
				}else if(operation==7){
					if(flow11!=null){
						//撤销失败
						sendMail(create_id,type,userDAO.getUserByID(create_id),"您的采购合同撤销失败,运营总监审批不通过，备注："+flow.getReason(),true);
						Map map=new HashMap();
						map.put("type", 12);
						map.put("foreign_id", foreign_id);
						map.put("starttime", flow11.getCreate_time());
						map.put("endtime", flow.getCreate_time());
						flowDAO.delSomeFlow(map);
						purchase_noteDAO.reSetHasBuyNum(foreign_id);
						return;
					}else{
						sendMail(create_id,type,userDAO.getUserByID(create_id),"您的采购合同运营总监审批未通过。",true);
					}
				}else if(operation==8){
					if(flow11==null){
						sendMail(118,type,null,"您有新的采购合同需要采购",false);
					}
				}else if(operation==9){
					if(flow11!=null){
						//撤销失败
						sendMail(create_id,type,userDAO.getUserByID(create_id),"您的采购合同撤销失败,总经理审批不通过，备注："+flow.getReason(),true);
						Map map=new HashMap();
						map.put("type", 12);
						map.put("foreign_id", foreign_id);
						map.put("starttime", flow11.getCreate_time());
						map.put("endtime", flow.getCreate_time());
						flowDAO.delSomeFlow(map);
						purchase_noteDAO.reSetHasBuyNum(foreign_id);
						return;
					}else{
						sendMail(create_id,type,userDAO.getUserByID(create_id),"您的采购合同总经理审批未通过。",true);
					}
				}else if(operation==11){
					if(flow.getId()==1){
						//审批结束后撤销，则类似修改，需要填写撤销理由，相关人员重新审批通过
					}else if(flow.getId()==2){
						//未审批完之前撤销，可直接撤销，通知相关人员
						Set<Integer> uidSet=new HashSet<Integer>();
						//下一步的人也要提醒
						Flow flow_before=flowDAO.getNewFlowByFID(12, foreign_id);
						if(flow_before!=null){
							int opera=flow_before.getOperation();
							if(opera==1){
								List<User> list=userDAO.getUserListByPermissionsID(72);
								for (User user : list) {
									int uid_before=user.getId();
									if(!uidSet.contains(uid_before)){
										sendMail(0,type,user,"有一个采购合同被撤销",true);
										uidSet.add(uid_before);
									}
								}
							}else if(opera==2){
								List<User> list=userDAO.getUserListByPermissionsID(73);
								for (User user : list) {
									int uid_before=user.getId();
									if(!uidSet.contains(uid_before)){
										sendMail(0,type,user,"有一个采购合同被撤销",true);
										uidSet.add(uid_before);
									}
								}
							}else if(opera==4){
								if(purchaseApplyNum>2){
									List<User> list=userDAO.getUserListByPermissionsID(74);
									for (User user : list) {
										int uid_before=user.getId();
										if(!uidSet.contains(uid_before)){
											sendMail(0,type,user,"有一个采购合同被撤销",true);
											uidSet.add(uid_before);
										}
									}
								}else if(purchaseApplyNum==2){
									List<User> list=userDAO.getUserListByPermissionsID(118);
									for (User user : list) {
										int uid_before=user.getId();
										if(!uidSet.contains(uid_before)){
											sendMail(0,type,user,"有一个采购合同被撤销",true);
											uidSet.add(uid_before);
										}
									}
								}
							}else if(opera==6){
								if(purchaseApplyNum>3){
									List<User> list=userDAO.getUserListByPermissionsID(75);
									for (User user : list) {
										int uid_before=user.getId();
										if(!uidSet.contains(uid_before)){
											sendMail(0,type,user,"有一个采购合同被撤销",true);
											uidSet.add(uid_before);
										}
									}
								}else if(purchaseApplyNum==3){
									List<User> list=userDAO.getUserListByPermissionsID(118);
									for (User user : list) {
										int uid_before=user.getId();
										if(!uidSet.contains(uid_before)){
											sendMail(0,type,user,"有一个采购合同被撤销",true);
											uidSet.add(uid_before);
										}
									}
								}
							}else if(opera==8){
								List<User> list=userDAO.getUserListByPermissionsID(118);
								for (User user : list) {
									int uid_before=user.getId();
									if(!uidSet.contains(uid_before)){
										sendMail(0,type,user,"有一个采购合同被撤销",true);
										uidSet.add(uid_before);
									}
								}
							}else if(opera==12){
								List<User> list=userDAO.getUserListByPermissionsID(119);
								for (User user : list) {
									int uid_before=user.getId();
									if(!uidSet.contains(uid_before)){
										sendMail(0,type,user,"有一个采购合同被撤销",true);
										uidSet.add(uid_before);
									}
								}
							}else if(opera==13){
								List<User> list=userDAO.getUserListByPermissionsID(120);
								for (User user : list) {
									int uid_before=user.getId();
									if(!uidSet.contains(uid_before)){
										sendMail(0,type,user,"有一个采购合同被撤销",true);
										uidSet.add(uid_before);
									}
								}
							}
						}
						Map map=new HashMap();
						map.put("type", 12);
						map.put("foreign_id", foreign_id);
						map.put("starttime", purchase_contract.getCreate_time());
						map.put("endtime", flow.getCreate_time());
						List<Flow> flowList=flowDAO.getSomeFlow(map);//审批过的都发一遍
						for (Flow flow_temp : flowList) {
							int uid_temp=flow_temp.getUid();
							int opera=flow_temp.getOperation();
							if(!uidSet.contains(uid_temp)&&opera>1&&opera<10){
								sendMail(0,type,userDAO.getUserByID(uid_temp),"有一个采购合同被撤销",true);
								uidSet.add(uid_temp);
							}
						}
						flowList.clear();
						flowList=null;
						uidSet.clear();
						uidSet=null;
					}else if(flow.getId()==3){
						//撤销成功
						sendMail(create_id,type,userDAO.getUserByID(create_id),"您的采购合同撤销成功",true);
					}		
				}else if(operation==12){
					sendMail(119,type,null,"有一个采购合同确认采购,请密切关注并及时更新到货信息",false);
				}else if(operation==13){
					sendMail(120,type,null,"有一个采购合同需要入库",false);
				}else if(operation==10){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的采购合同已完成",true);
				}
				break;
			case 13:
				Aftersales_task aftersales_task=aftersales_taskDAO.getAlterSales_TaskByID(foreign_id);
				if( aftersales_task==null){
					break;
				}
				int afterSale_pcategory=aftersales_task.getProject_category();
				create_id=aftersales_task.getCreate_id();
				if(operation==1){
					sendMail(DataUtil.getAfterSaleApproveArray()[afterSale_pcategory],type,null,"您有新的售后任务单需要审批",false);
				}else if(operation==2){
					sendMail(DataUtil.getAfterSaleAssistantArray()[afterSale_pcategory],type,null,"您有新的售后任务单需要确认",false);
				}else if(operation==3){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的售后任务单审批未通过",true);
				}else if(operation==4){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的售后任务单现场服务助理已确认,需要您确认完成情况",true);
				}else if(operation==5){
					sendMail(DataUtil.getAfterSaleAssistantArray()[afterSale_pcategory],type,null,"您有新的售后任务单需要确认",false);
				}else if(operation==6){
					sendMail(DataUtil.getAfterSaleApproveArray()[afterSale_pcategory],type,null,"您有新的售后任务单需要审批",false);
				}else if(operation==7){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的售后任务单已完成",true);
				}else if(operation==8){
					sendMail(DataUtil.getAfterSaleAssistantArray()[afterSale_pcategory],type,null,"您的售后任务单审批未通过",false);
				}else if(operation==9){
					Flow flow_before=flowDAO.getNewFlowByFID(13, foreign_id);
					Set<Integer> userSet=new HashSet<Integer>();
					List<User> users=userDAO.getUserListByPermissionsID(DataUtil.getAfterSaleApproveArray()[afterSale_pcategory]);
					if(flow_before!=null){
						int opera=flow_before.getOperation();
						if(opera==2||opera==4){
							users.addAll(userDAO.getUserListByPermissionsID(DataUtil.getAfterSaleAssistantArray()[afterSale_pcategory]));
						}
						for (User user : users) {
							int uid_before=user.getId();
							if(!userSet.contains(uid_before)){
								userSet.add(uid_before);
								sendMail(0,type,user,"有一个售后任务单被撤销",true);
							}
						}
					}
				}else if(operation==10){
					if(uid == create_id){
						sendMail(DataUtil.getAfterSaleAssistantArray()[afterSale_pcategory],type,null,"您有挂起的售后任务单需要确认",false);
					}else{
					//	sendMail(create_id,type,userDAO.getUserByID(create_id),"您的售后任务单挂起后现场服务助理已经上传文件",true);
					}
				}
				break;
			case 14:
				Seal seal=sealDAO.getSealByID(foreign_id);
				if( seal==null){
					break;
				}
				int sealType = seal.getType();
				int apply_d = seal.getApply_department();
				boolean flag=(apply_d>8 && apply_d<16 && apply_d!=14 && (sealType==0 || sealType==1));
				create_id=seal.getCreate_id();
				if(operation==1){
//					int sealType=flow.getId();
//					if(sealType>0&&--sealType!=seal.getType()){
//						//修改了用印类型
//						int pid=DataUtil.getSealApprovePermissionID(seal.getApply_department(),sealType);
//						if(pid>0){
//							sendMail(pid,type,null,"有一个"+DataUtil.getSealArray()[sealType][0]+"用印申请已取消",false);
//						}else{
//							User user=userDAO.getTopUser();
//							if(user!=null){
//								sendMail(0,type,user,"有一个"+DataUtil.getSealArray()[sealType][0]+"用印申请已取消",true);
//							}
//						}
//					}
					int pid=DataUtil.getSealApprovePermissionID(seal.getApply_department(), seal.getType());
					if(pid>0){
						sendMail(pid,type,userDAO.getUserByID(create_id),"您有新的用印申请表需要审批",false);
					}else{
						User user=userDAO.getTopUser();
						if(user!=null){
							sendMail(0,type,user,"您有新的用印申请表需要审批",true);
						}
					}
				}else if(operation==2){
					if(flag){
						sendMail(9,type,null,"您有新的用印申请表需要审批",false);
					}else{
						sendMail(DataUtil.getSealManagerPermission(seal.getType()),type,null,"您有新的用印申请表需要确认",false);
					}
				}else if(operation==3){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的用印申请表审批未通过",true);
				}else if(operation==4){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的用印申请表已完成",true);
				}else if(operation==6){
						sendMail(DataUtil.getSealManagerPermission(seal.getType()),type,null,"您有新的用印申请表需要确认",false);
				}else if(operation==7){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的用印申请表审批未通过",true);
				}else if(operation==5){
					Flow flow_before=flowDAO.getNewFlowByFID(14, foreign_id);
					Set<Integer> userSet=new HashSet<Integer>();
					List<User> users=new ArrayList<User>();
					if(flow_before!=null){
						int pid=DataUtil.getSealApprovePermissionID(seal.getApply_department(), seal.getType());
						if(pid>0){
							users.addAll(userDAO.getUserListByPermissionsID(pid));
						}else{
							User user=userDAO.getTopUser();
							if(user!=null){
								users.add(user);
							}
						}
						 if(flow_before.getOperation()==2){//印章管理人接收邮件
							 users.addAll(userDAO.getUserListByPermissionsID(DataUtil.getSealManagerPermission(seal.getType())));
						}
						for (User user : users) {
							int uid_before=user.getId();
							if(!userSet.contains(uid_before)){
								userSet.add(uid_before);
								sendMail(0,type,user,"有一个用印申请表被撤销",true);
							}
						}
					}
				}
				break;
			case 15:
				Vehicle vehicle=vehicleDAO.getVehicleByID(foreign_id);
				if( vehicle==null){
					break;
				}
				create_id=vehicle.getCreate_id();
				if(operation==1){
					sendMail(82,type,null,"您有新的用车申请表需要审批",false);
				}else if(operation==2){//operation==4无需邮件提醒
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的用车申请表需要您确认信息",true);
				}else if(operation==10){
					sendMail(flow.getDriver(),type,userDAO.getUserByID(flow.getDriver()),"车辆归还信息需要您填写",true);
				}else if(operation==3){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的用车申请表审批未通过",true);
				}else if(operation==4){
					sendMail(83,type,null,"您有新的用车归还申请需要您确认",false);
				}else if(operation==5){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的用车申请表已完成",true);
				}else if(operation==6){
					Flow flow_before=flowDAO.getNewFlowByFID(15, foreign_id);
					Set<Integer> userSet=new HashSet<Integer>();
					List<User> users=new ArrayList<User>();
					if(flow_before!=null){
						users.addAll(userDAO.getUserListByPermissionsID(82));
						int opera=flow_before.getOperation();
						if(opera==2||opera==4){
							users.addAll(userDAO.getUserListByPermissionsID(83));
						}
						for (User user : users) {
							int uid_before=user.getId();
							if(!userSet.contains(uid_before)){
								userSet.add(uid_before);
								sendMail(0,type,user,"有一个用车申请表被撤销",true);
							}
						}
					}
				}
				break;
				/*case 16:
				/*Work work=workDAO.getWorkByID(foreign_id);
				if( work==null){
					break;
				}
				create_id=work.getCreate_id();
				if(operation==1){
					List<User> list=userDAO.getParentListByChildUid(create_id);
					for(User work_user:list){
						sendMail(0,type,work_user,"您有新的工时统计安排表需要审批。",true);
					}					
				}else if(operation==2){
					List<User> list=userDAO.getParentListByChildUid(create_id);
					for(User work_user:list){
						sendMail(0,type,work_user,"有一个工时统计安排表的整月信息已全部提交，需要您审批。",true);
					}			
				}else if(operation==3){
					sendMail(create_id,type,userDAO.getUserByID(create_id),"您的工时统计安排表审批完成。",true);
				}
				break;*/
			case 17:
				task=taskDAO.getTaskByID(foreign_id);
				if(task==null){
					return;
				}
				create_id=task.getCreate_id();
				if (operation==1) {
					sendMail(113,type,null,new StringBuilder().append("您有新的项目启动任务单（").append(task.getProject_name())
							.append("）需要审核。").toString(),false);
					sendMail(110,type,null,new StringBuilder().append("有新的项目启动任务单（").append(task.getProject_name())
							.append("）生成，请注意查看。").toString(),false);
				}else if(operation==2){
					sendMail(114,type,null,new StringBuilder().append("您有新的项目启动任务单（").append(task.getProject_name())
							.append("）需要审核。").toString(),false);
				}else if(operation==3){
					sendMail(create_id,type,userDAO.getUserByID(create_id),new StringBuilder().append("项目启动任务单（").append(task.getProject_name())
							.append("）因技术负责人审核未通过，需要您修改后重新审核。").toString(),true);
				}else if(operation==4){
					sendMail(9,type,null,new StringBuilder().append("您有新的项目启动任务单（").append(task.getProject_name())
							.append("）需要审核。").toString(),false);
				}else if(operation==5){
					sendMail(create_id,type,userDAO.getUserByID(create_id),new StringBuilder().append("项目启动任务单（").append(task.getProject_name())
							.append("）因部门经理审核未通过，需要您修改后重新审核。").toString(),true);
				}else if(operation==6){
					sendMail(create_id,type,userDAO.getUserByID(create_id),new StringBuilder().append("项目启动任务单（").append(task.getProject_name())
							.append("）因总经理审核未通过，需要您修改后重新审核。").toString(),true);
				}else if(operation==7||operation==9){
					sendMail(create_id,type,userDAO.getUserByID(create_id),new StringBuilder().append("您的项目启动任务单（").append(task.getProject_name())
							.append("）已完成。").toString(),true);
					sendMail(3,type,null,new StringBuilder().append("项目启动任务单（").append(task.getProject_name())
							.append("）已完成，可以创建项目采购单").toString(),false);
				}else if(operation==8){
					List<Flow> pre_flowList=flowDAO.getFlowListByCondition(17, task.getId());
					HashSet<Integer> UIDSet =   new HashSet<Integer>();//移除重复的用户
					//通知下一步需要审批的人
					int lastOpera=pre_flowList.get(pre_flowList.size()-1).getOperation();
					if(lastOpera==1){
						List<User> uList=userDAO.getUserListByPermissionsID(113);
						for (User user : uList) {
							UIDSet.add(user.getId());
						}
					}else if(lastOpera==2){
						List<User> uList=userDAO.getUserListByPermissionsID(114);
						for (User user : uList) {
							UIDSet.add(user.getId());
						}
					}else if(lastOpera==4){
						List<User> uList=userDAO.getUserListByPermissionsID(9);
						for (User user : uList) {
							UIDSet.add(user.getId());
						}
					}else if(lastOpera==7){
						List<User> uList=userDAO.getUserListByPermissionsID(3);
						for (User user : uList) {
							UIDSet.add(user.getId());
						}
					}else if(lastOpera==11){
						List<User> uList=userDAO.getUserListByPermissionsID(155);
						for (User user : uList) {
							UIDSet.add(user.getId());
						}
					}
					for (Flow pre_flow : pre_flowList) {
						int opera=pre_flow.getOperation();
						if(opera==2||opera==4||opera==7){
							UIDSet.add(pre_flow.getUid());
						}
						if(opera==7||opera==9){
							//已完成的任务单，撤销后需要追加提醒生产主管
							List<User> uList=userDAO.getUserListByPermissionsID(3);
							for (User user : uList) {
								UIDSet.add(user.getId());
							}
						}
					}
					if(taskDAO.checkTaskBind(task.getId())){
						//绑定采购或发货 已经绑定采购单或发货单的任务单撤销时需要追加提醒采购人员
						List<User> uList=userDAO.getUserListByPermissionsID(21);
						for (User user : uList) {
							UIDSet.add(user.getId());
						}
					}
					Iterator iterator=UIDSet.iterator();
					while (iterator.hasNext()) {
						 uid = ((Integer) iterator.next()).intValue();
						sendMail(uid,type,userDAO.getUserByID(uid),new StringBuilder().append("项目启动任务单（").append(task.getProject_name())
								.append("）已撤销。").toString(),true);
					}
				}else if(operation==10){
					sendMail(create_id,type,userDAO.getUserByID(create_id),new StringBuilder().append("项目启动任务单（").append(task.getProject_name())
							.append("）总经理审核通过，需要您上传合同。").toString(),true);
				}else if(operation==11){
					sendMail(155,type,null,new StringBuilder().append("您有新的项目启动任务单（").append(task.getProject_name())
							.append("）需要审核。").toString(),false);
				}else if(operation==12){
					sendMail(create_id,type,userDAO.getUserByID(create_id),new StringBuilder().append("项目启动任务单（").append(task.getProject_name())
							.append("）因合同审核未通过，需要您修改后重新审核。").toString(),true);
				}
				break;
			case 18:
				Shipping shipping=shippingDAO.getShippingById(foreign_id);
				if(shipping==null){
					return;
				}
				Flow flow18_del=getFlowByOperation(type, foreign_id, 7);
				create_id=shipping.getCreate_id();
				if(operation==1){
					sendMail(127,type,null,new StringBuilder().append("您有新的出货单需要审核。").toString(),false);
				}else if(operation==2){
					if(flow18_del==null){
						sendMail(128,type,null,new StringBuilder().append("您有新的出货单需要领料。").toString(),false);
					}else{
						return;
					}
				}else if(operation==3){
					if(flow18_del!=null){
						sendMail(0,type,userDAO.getUserByID(create_id),"您的出货单撤销失败,部门领导审批不通过，备注："+flow.getReason(),true);
						Map map=new HashMap();
						map.put("type", 18);
						map.put("foreign_id", foreign_id);
						map.put("starttime", flow18_del.getCreate_time());
						map.put("endtime", flow.getCreate_time());
						flowDAO.delSomeFlow(map);//删除中间的流程
						return;
					}else{
						sendMail(0,type,userDAO.getUserByID(create_id),new StringBuilder().append("您的出货单因部门领导审核未通过，需要您修改后重新审核。").toString(),true);
					}
				}else if(operation==4){
					sendMail(129,type,userDAO.getUserByID(create_id),new StringBuilder().append("您有新的出货单需要发货。").toString(),false);
				}else if(operation==5){
					//本人
					sendMail(129,type,userDAO.getUserByID(create_id),new StringBuilder().append("出货单已发出，请及时输入信息反馈。").toString(),false);
				}else if(operation==6){
					sendMail(0,type,userDAO.getUserByID(create_id),new StringBuilder().append("您的出货单已完成。").toString(),true);
				}else if(operation==7){
					if(flow.getId()==1){
						//审批结束后撤销，则类似修改，需要填写撤销理由，相关人员重新审批通过
					}else if(flow.getId()==2){
						//未审批完之前撤销，可直接撤销，通知相关人员
						Set<Integer> uidSet=new HashSet<Integer>();
						//下一步的人也要提醒
						Flow flow_before=flowDAO.getNewFlowByFID(12, foreign_id);
						if(flow_before!=null){
							int opera=flow_before.getOperation();
							if(opera==1){
								List<User> list=userDAO.getUserListByPermissionsID(127);
								for (User user : list) {
									int uid_before=user.getId();
									if(!uidSet.contains(uid_before)){
										sendMail(0,type,user,"有一个出货单被撤销",true);
										uidSet.add(uid_before);
									}
								}
							}else if(opera==2){
								List<User> list=userDAO.getUserListByPermissionsID(128);
								for (User user : list) {
									int uid_before=user.getId();
									if(!uidSet.contains(uid_before)){
										sendMail(0,type,user,"有一个出货单被撤销",true);
										uidSet.add(uid_before);
									}
								}
							}
						}
						Map map=new HashMap();
						map.put("type", 18);
						map.put("foreign_id", foreign_id);
						map.put("starttime", shipping.getCreate_time());
						map.put("endtime", flow.getCreate_time());
						List<Flow> flowList=flowDAO.getSomeFlow(map);//审批过的都发一遍
						for (Flow flow_temp : flowList) {
							int uid_temp=flow_temp.getUid();
							int opera=flow_temp.getOperation();
							if(!uidSet.contains(uid_temp)&&opera>1&&opera<7){
								sendMail(0,type,userDAO.getUserByID(uid_temp),"有一个出货单被撤销",true);
								uidSet.add(uid_temp);
							}
						}
						flowList.clear();
						flowList=null;
						uidSet.clear();
						uidSet=null;
					}else if(flow.getId()==3){
						//撤销成功
						sendMail(create_id,type,userDAO.getUserByID(create_id),"您的出货单撤销成功",true);
					}	
				}
				break;
			case 19:
				/*******
				  * 1.保存计划；2：提交计划；3：计划表已批阅；4.保存考核；5：提交考核；6：考核完成，结束；7：计划驳回；8：考核驳回；
				  */
				String operas=flow.getFlowcode();
				if(!operas.endsWith("_")){
					//计划
					String[] operaArray=operas.split("_");
					create_id=Integer.parseInt(operaArray[0]);
					int leader=Integer.parseInt(operaArray[1]);
					if(operation==2){
						sendMail(0,type,userDAO.getUserByID(leader),"您有新的考核需要审批",true);
					}else if(operation==7){
						sendMail(0,type,userDAO.getUserByID(create_id),"您的计划被驳回",true);
					}
				}else{
					
				}
				break;
			case 20:
				create_id=flow.getId();
				if(operation==1){
					List<User> parents=userDAO.getParentListByChildUid(create_id);
					if(parents!=null&&parents.size()>0){
						sendMail(0,type,parents.get(0),"您有新的出库单需要审批",true);
					}
				}else if(operation==2){
					sendMail(149,type,null,"您有新的出库单需要审批",false);
				}else if(operation==3){
					sendMail(0,type,userDAO.getUserByID(create_id),"您的出库单领导审批未通过",true);
				}else if(operation==4){
					sendMail(0,type,userDAO.getUserByID(create_id),"您的出库单已完成",true);
				}else if(operation==5){
					sendMail(0,type,userDAO.getUserByID(create_id),"您的出库单仓管审批未通过",true);
				}else if(operation==6){
					Map map=new HashMap();
					map.put("type", 20);
					map.put("foreign_id", foreign_id);
					map.put("starttime", 0);
					map.put("endtime", flow.getCreate_time());
					List<Flow> flowList=flowDAO.getSomeFlow(map);//审批过的都发一遍
					Set<Integer> uidSet=new HashSet<Integer>();
					for (Flow flow_temp : flowList) {
						int uid_temp=flow_temp.getUid();
						int opera=flow_temp.getOperation();
						if(!uidSet.contains(uid_temp)&&opera!=1){
							sendMail(0,type,userDAO.getUserByID(uid_temp),"有一个出库单被撤销",true);
							uidSet.add(uid_temp);
						}
					}
					Flow flow2=flowDAO.getNewFlowByFID(type, foreign_id);
					if(flow2.getOperation()==1){
						//告知领导
						List<User> users=userDAO.getParentListByChildUid(create_id);
						if(users.size()>0&&!uidSet.contains(users.get(0).getId())){
							sendMail(0,type,users.get(0),"有一个出库单被撤销",true);
							uidSet.add(users.get(0).getId());
						}
					}
					if(flow2.getOperation()==2||flow2.getOperation()==4){
						List<User> users=userDAO.getUserListByPermissionsID(149);
						for (User user : users) {
							if(!uidSet.contains(user.getId())){
								sendMail(0,type,user,"有一个出库单被撤销",true);
								uidSet.add(user.getId());
							}
						}
					}
				}
				break;
			case 21:
				if(operation!=1 && operation!=2 && operation!=4 && operation!=6 ){
					create_id=task_updateflowDAO.getTask_updateflowById(foreign_id).getCreate_id();
				}
				if(operation==1){
					sendMail(160,type,null,"您有新的项目启动任务单修改申请需要审批",false);
				}else if(operation==2){
					sendMail(161,type,null,"您有新的项目启动任务单修改申请需要审批",false);
				}else if(operation==3){
					sendMail(0,type,userDAO.getUserByID(create_id),"您的项目启动任务单修改申请审批未通过",true);
				}else if(operation==4){
					sendMail(162,type,null,"您有新的项目启动任务单修改申请需要审批",false);
				}else if(operation==5){
					sendMail(0,type,userDAO.getUserByID(create_id),"您的项目启动任务单修改申请审批未通过",true);
				}else if(operation==6){
					sendMail(9,type,null,"您有新的项目启动任务单修改申请需要审批",false);
				}else if(operation==7){
					sendMail(0,type,userDAO.getUserByID(create_id),"您的项目启动任务单修改申请审批未通过",true);
				}else if(operation==8){
					sendMail(0,type,userDAO.getUserByID(create_id),"您的项目启动任务单修改申请全部审批通过",true);
				}else if(operation==9){
					sendMail(0,type,userDAO.getUserByID(create_id),"您的项目启动任务单修改申请审批未通过",true);
				}
				break;
			case 22:
				create_id=flow.getId();
				if(operation==1){
					List<User> parents=userDAO.getParentListByChildUid(create_id);
					if(parents!=null&&parents.size()>0){
						sendMail(0,type,parents.get(0),"您有新的部门采购单需要审批",true);
					}
				}else if(operation==2){
					sendMail(0,type,userDAO.getUserByID(create_id),"您的部门采购单领导审批未通过，需要修改后重新审批",true);
				}else if(operation==3){
					sendMail(17,type,null,"您有新的部门采购单需要审批",false);
				}else if(operation==4){
					sendMail(0,type,userDAO.getUserByID(create_id),"您的部门采购单采购审批未通过，需要修改后重新审批",true);
//				}else if(operation==5){
//					sendMail(21,type,null,"您有新的部门采购单需要采购",false);
				}else if(operation==10){
//					sendMail(21,type,null,"您有新的部门采购单需要采购",false);
					sendMail(181,type,null,"您有新的部门采购单需要采购",false);
				}else if(operation==11){
					sendMail(0,type,userDAO.getUserByID(create_id),"您新的部门采购单已经保存",true);
				}else if(operation==7){
					sendMail(0,type,userDAO.getUserByID(create_id),"您的部门采购单已完成",true);
				}else if(operation==8){
					sendMail(0,type,userDAO.getUserByID(create_id),"您的部门采购单采购失败，需要您修改后重新审批",true);
				}else if(operation==9){
					sendMail(22,type,null,"部门采购单已确认采购，请密切关注到货动态并及时验货。",false);
				}else if(operation==6){
					Map<String,Object> map=new HashMap<String,Object>();
					map.put("type", 22);
					map.put("foreign_id", foreign_id);
					map.put("starttime", 0);
					map.put("endtime", flow.getCreate_time());
					List<Flow> flowList=flowDAO.getSomeFlow(map);//审批过的都发一遍
					Set<Integer> uidSet=new HashSet<Integer>();
					for (Flow flow_temp : flowList) {
						int uid_temp=flow_temp.getUid();
						int opera=flow_temp.getOperation();
						if(!uidSet.contains(uid_temp)&&opera!=1){
							sendMail(0,type,userDAO.getUserByID(uid_temp),"有一个部门采购单被撤销",true);
							uidSet.add(uid_temp);
						}
					}
					Flow flow2=flowDAO.getNewFlowByFID(type, foreign_id);
					if(flow2.getOperation()==1){
						//告知领导
						List<User> users=userDAO.getParentListByChildUid(create_id);
						if(users.size()>0&&!uidSet.contains(users.get(0).getId())){
							sendMail(0,type,users.get(0),"有一个部门采购单被撤销",true);
							uidSet.add(users.get(0).getId());
						}
					}
					//告知下一步审核的人
					if(flow2.getOperation()==3||flow2.getOperation()==5){
						List<User> users=null;
						if(flow2.getOperation()==3){
							users=userDAO.getUserListByPermissionsID(17);
						}else {
							users=userDAO.getUserListByPermissionsID(21);
						}
						for (User user : users) {
							if(!uidSet.contains(user.getId())){
								sendMail(0,type,user,"有一个部门采购单被撤销",true);
								uidSet.add(user.getId());
							}
						}
					}
				}
				break;
			default:
				break;
		}
		if(flow != null && flow.getType()==-3){
			flow.setType(19);
		}
		flowDAO.insertFlow(flow);
	}
	/*****
	 * 销售合同审批次数（商务审批不计）
	 * @param
	 * @param sales_contract
	 * @return
	 */
	public int getApplyNum(Sales_contract sales_contract) {
		// TODO Auto-generated method stub
		List<Product_info> product_infos=product_infoDAO.getProduct_infos(sales_contract.getId());
		final float prices=500000.0f;//不含税金额50w
		final float gross_profit=0.12f;//整单毛利12%
		int days=0;//账期
		int payment_method=sales_contract.getPayment_method();
		String payment_value= sales_contract.getPayment_value();
		if(payment_method==1){
			days=Integer.parseInt(payment_value.split("の")[0]);
		}else if(payment_method==3){
			days=Integer.parseInt(payment_value);
		}
		if(days>90){
			return 3;
		}
		float all_prices=0.0f;//不含税金额总和
		float all_gross_profit=0.0f;//整单毛利
		float all_pvt=0.0f;//预计含税金额总和
		for (Product_info product_info : product_infos) {
			int num=product_info.getNum();
			all_prices+=product_info.getUnit_price_taxes()*num;
			all_pvt+=product_info.getPredict_costing_taxes()*num;
		}
		all_gross_profit=(all_prices-all_pvt)/all_prices;
		if(all_prices>prices||all_gross_profit<gross_profit){
			return 3;
		}else if(days>=60||all_prices>prices||all_gross_profit<=gross_profit){
			return 2;
		}
		return 1;
	}
	/*****
	 * 采购合同审批次数
	 * @param purchase_contract
	 * @return
	 */
	public int getPurchaseApplyNum(Purchase_contract purchase_contract) {
		// TODO Auto-generated method stub
		int moxa=purchase_contract.getMoxa();//0:为moxa厂家；1：预付款；2：不需要
		if(moxa==1){
			return 3;//预付款（moxa厂家没有预付款选项）
		}
		List<Purchase_note> noteList=purchase_noteDAO.getPurchase_notesByPID(purchase_contract.getId());
		float all_prices=0.0f;//不含税金额总和
		for (Purchase_note purchase_note : noteList) {
			all_prices+=purchase_note.getUnit_price_taxes()*purchase_note.getNum();
		}
		all_prices/=1.17f;
		//
		/****
		 * moxa 是   运营总监：50w<不含税金额<=80w ;总经理：不含税金额>80w
		 * 			  否	运营总监：不含税金额>20w||不需要预付款
		 */
		if(moxa==0){
			if(all_prices>800000){
				return 4;
			}else if(all_prices<500000){
				return 2;
			}else{
				return 3;
			}
		}else{
			return all_prices>200000?3:2;
		}
	}
	/****
	 * 检查请假单或销假单的审核次数
	 * @param
	 * @param
	 * @return 审核次数
	 */
	private int getApprovalNum(double alldays,int create_id){
		int flag=1;
		User user1=userDAO.getUserByID(create_id);
		if(user1==null){
			return flag;
		}
		/****
		 * 1.只有一级领导,审批后直接考勤备案
		 * 2.有两级领导的，1.1：两级领导为总经理,一级领导天数限制为3天;
		 * 							   1.2：总经理非两级领导时，一级领导天数限制为1天
		 */
		if(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()==0){
			//总经理自己不需要备案
		}else if(position_userDAO.getPositionByID(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()).getParent()==0){
			//总经理为上级领导的,一次审批后考勤备案
		}else if(position_userDAO.getPositionByID(position_userDAO.getPositionByID(position_userDAO.getPositionByID(user1.getPosition_id()).getParent()).getParent()).getParent()==0){
			//领导的领导为总经理
			if(alldays>3){
				//一级领导审批3天内 下一步考勤备份
				flag=2;
			}
		}else{
			//存在两级以上领导
			if(alldays>7){
				flag=3;
			}else if(alldays>1){
				//一级领导审批3天内 下一步考勤备份
				flag=2;
			}
		}
		return flag;
	}
	public void updateFlow(Flow flow) {
		// TODO Auto-generated method stub
		flowDAO.updateFlow(flow);
	}
	public Flow getNewFlowByFID(int type ,int foreign_id){
		return flowDAO.getNewFlowByFID(type,foreign_id);
	}
	public boolean checkTaskCanDo(int create_id,int project_type,int project_category,int project_case,int product_type,User user,int operation) {
		int  position_id=user.getPosition_id();
		if(project_category==5){
			if(operation==1||operation==14){
				return permissionsDAO.checkPermission(position_id, 163);
			}else if(operation==13||operation==18){
				return create_id==user.getId();
			}else if(operation==17||operation==20){
				return permissionsDAO.checkPermission(position_id, 163);
			}else if(operation==19||operation==22){
				return permissionsDAO.checkPermission(position_id, 9);
			}
		}else if((project_category==6 || project_category==7 || project_category==8) && project_type != 2){
			if(project_case==0){
				if(operation==13||operation==18){
					return permissionsDAO.checkPermission(position_id, 171);
				}
			}else {
				if(operation==21||operation==18){
					return permissionsDAO.checkPermission(position_id, 171);
				}
			}
		}
		if(product_type==10){
			if(operation==1||operation==2||operation==20){
				return permissionsDAO.checkPermission(position_id, DataUtil.getPCategoryPIDArray(project_category));
			}else if(operation==19||operation==22){
				return permissionsDAO.checkPermission(position_id, 9);
			}
		}
		if(project_case==0){
			//普项
			if(project_type == 2){//售后
				if(operation==1||operation==14){
					return permissionsDAO.checkPermission(position_id, DataUtil.getBussinessPIDArray(project_category));
				}else if(operation==13||operation==25){
					return permissionsDAO.checkPermission(position_id, 158);
				}else if(operation==24||operation==18){
					return permissionsDAO.checkPermission(position_id, 157);
				}else if(operation==17||operation==20){
					return permissionsDAO.checkPermission(position_id, DataUtil.getPCategoryPIDArray(project_category));
				}else if(operation==19||operation==22){
					return permissionsDAO.checkPermission(position_id, 9);
				}else if(operation==26||operation==27){
					return permissionsDAO.checkPermission(position_id, 173);
				}
			}else {
				if(operation==1||operation==14){
					return permissionsDAO.checkPermission(position_id, DataUtil.getBussinessPIDArray(project_category));
				}else if(operation==13||operation==18){
					return permissionsDAO.checkPermission(position_id, 50);
				}else if(operation==17||operation==20){
					return permissionsDAO.checkPermission(position_id, DataUtil.getPCategoryPIDArray(project_category));
				}else if(operation==19||operation==22){
					return permissionsDAO.checkPermission(position_id, 9);
				}else if(operation==26||operation==27){
					return permissionsDAO.checkPermission(position_id, 173);
				}
			}
		}else{
			//急项
			if (project_type == 2) {
				if(operation==2||operation==20){
					return permissionsDAO.checkPermission(position_id, DataUtil.getPCategoryPIDArray(project_category));
				}else if(operation==19||operation==22){
					return permissionsDAO.checkPermission(position_id, 9);
				}else if(operation==21||operation==18){
					return permissionsDAO.checkPermission(position_id, 157);
				}else if(operation==17||operation==25){
					return permissionsDAO.checkPermission(position_id, 158);
				}else if(operation==24||operation==14){
					return permissionsDAO.checkPermission(position_id, DataUtil.getBussinessPIDArray(project_category));
				}else if(operation==26||operation==27){
					return permissionsDAO.checkPermission(position_id, 173);
				}
			} else {
				if(operation==2||operation==20){
					return permissionsDAO.checkPermission(position_id, DataUtil.getPCategoryPIDArray(project_category));
				}else if(operation==19||operation==22){
					return permissionsDAO.checkPermission(position_id, 9);
				}else if(operation==21||operation==18){
					return permissionsDAO.checkPermission(position_id, 50);
				}else if(operation==17||operation==14){
					return permissionsDAO.checkPermission(position_id, DataUtil.getBussinessPIDArray(project_category));
				}else if(operation==26||operation==27){
					return permissionsDAO.checkPermission(position_id, 173);
				}
			}
		}
		return false;
	}
	@Override
	public boolean checkProjectPurchaseCanDo(Task task, User user, int operation) {
		// TODO Auto-generated method stub
		int  position_id=user.getPosition_id();
		if(operation==1||operation==3){
			return permissionsDAO.checkPermission(position_id, DataUtil.getPurchasePIDArray(task.getType(), task.getProject_category()));
		}else if(operation==6){
			if(task.getProject_category()==5){
				return permissionsDAO.checkPermission(position_id, 17);
			}
			return permissionsDAO.checkPermission(position_id, DataUtil.getOfficerPIDArray(task.getType(), task.getProject_category()));
		}else if(operation==12||operation==15 ||operation==2||operation==13){
			return permissionsDAO.checkPermission(position_id, 16);
		}else if(operation==4){
			return permissionsDAO.checkPermission(position_id, 17);
		}else if (operation==18 || operation==19){ //销售经理权限判定
			return permissionsDAO.checkPermission(position_id,DataUtil.getPurchaseMarketPIDArray(task.getType(), task.getProject_category()));
		}
		return false;
	}
	public boolean checkCanDo(int type,User user, int operation) {
		// TODO Auto-generated method stub
		int position_id=user.getPosition_id();
		if(type==2){
			if(operation==1||operation==3){
//				return permissionsDAO.checkPermission(position_id, 17);
				return permissionsDAO.checkPermission(position_id, 182);
			}
		}else if(type==17){
			if(operation==1){
				return permissionsDAO.checkPermission(position_id, 113);
			}else if(operation==2){
				return permissionsDAO.checkPermission(position_id, 114);
			}else if(operation==3){
				return permissionsDAO.checkPermission(position_id, 113);
			}else if(operation==4){
				return permissionsDAO.checkPermission(position_id, 9);
			}else if(operation==5){
				return permissionsDAO.checkPermission(position_id, 114);
			}else if(operation==6){
				return permissionsDAO.checkPermission(position_id, 9);
			}else if(operation==11||operation==12){
				return permissionsDAO.checkPermission(position_id, 155);
			}
		}else if(type==18){
			if(operation==1||operation==3){
				return permissionsDAO.checkPermission(position_id, 127);
			}
		}
		return false;
	}

	public List<Flow> getReasonList(int type, int foreign_id) {
		// TODO Auto-generated method stub
		List<Flow> flowList=flowDAO.getReasonList(type, foreign_id);
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");
		FormTransform ft=new FormTransform();
		for(Flow flow:flowList){
			flow.setCreate_date(sdf.format(flow.getCreate_time()));
			flow.setUsername(userDAO.getUserNameByID(flow.getUid()));
			flow.setReason(ft.transRNToBR(ft.transHtml(flow.getReason())));
		}
		return flowList;
	}
	public void finishFlow(int type, int foreign_id) {
		// TODO Auto-generated method stub
		if(type==1||type==17){
			Task task=new Task();
			task.setId(foreign_id);
			task.setIsedited(0);
			task.setUpdate_time(System.currentTimeMillis());
			taskDAO.updateEdited(task);
			task_conflictDAO.delTask_conflictByID(foreign_id);
			
			Map map=new HashMap();
			map.put("type",type);
			map.put("foreign_id", foreign_id);
			map.put("linkman_case", 0);
			map.put("state", 1);
			linkmanDAO.deleteLinkmanLimit(map);
			
			Map map2=new HashMap();
			map2.put("type",type);
			map2.put("foreign_id", foreign_id);
			map2.put("file_type", 0);
			map2.put("state", 1);
			List<File_path> fList=file_pathDAO.getAllFileByCondition(map2);
			for(File_path file_path:fList){
				file_path.setState(0);
				if(!file_pathDAO.checkNowFileExists(file_path)){
					//该文件没有记录啦，可以从硬盘中删除
					File file = new File(FileUploadUtil.getFilePath()+file_path.getPath_name());
					if (file.isFile() && file.exists()) {
						file.delete();
					}
				}
			}
		}
	}
	private boolean[] getPermissions(int position_id,boolean isAdmin){
		int[] permissionIDs={0,10,19,18,20,25,26,29,28,40,54,63,69,79,85,81,104,115,126,146,148,165,166,168};//对应查看权限id 
		int plen=DataUtil.getFlowNameArray().length;
		boolean[] permissions=new boolean[plen];
		if(isAdmin){
			for (int i = 1; i <plen; i++) {
				permissions[i]=true;
			}
		}else{
			List<Integer> psList=permissionsDAO.getPIDsByPositionID(position_id);
			for (int i = 1; i <plen; i++) {
				if(psList.contains(permissionIDs[i])){
					permissions[i]=true;
				}
			}
		}
		return permissions;
	}
	private List<Integer> getPermissionsType(int position_id){
		int[] permissionIDs={0,10,19,18,20,25,26,29,28,40,54,63,69,79,85,81,104,115,126,146,148,165,166,168};//对应查看权限id 
		int plen=DataUtil.getFlowNameArray().length;
		boolean[] permissions=new boolean[plen];
		ArrayList<Integer> list = new ArrayList<Integer>();
			List<Integer> psList=permissionsDAO.getPIDsByPositionID(position_id);
			for (int i = 1; i <plen; i++) {
				if(psList.contains(permissionIDs[i])){
					list.add(i);
				}
			}
//			if(list == null){
//				return null;
//			}
//			int size = list.size();
//			ArrayList<Integer> fixedList = new ArrayList<Integer>(size);
//			for (int i = 0; i < size; i++) {
//				fixedList.add(list.get(i));
//			}
		return list;
	}
	private Map<String,Object> getFlowsMap(boolean typeArray[]){
		Map<String,Object> flowsMap=new HashMap<String, Object>();
		if(typeArray[1]||typeArray[3]||typeArray[5]||typeArray[6]||typeArray[17]){
			List<Task> list=taskDAO.getAllList();
			for (Task obj : list) {
				flowsMap.put("1_"+obj.getId(), obj);
			}
		}
		if(typeArray[2]||typeArray[4]){
			List<Product_procurement> list=product_procurementDAO.getAllList();
			for (Product_procurement obj : list) {
				flowsMap.put("2_"+obj.getId(), obj);
			}
		}
		if(typeArray[3]){
			List<Project_procurement> list=project_procurementDAO.getAllList();
			for (Project_procurement obj : list) {
				flowsMap.put("3_"+obj.getId(), obj);
			}
		}
		if(typeArray[4]){
			List<Outsource_product> list=outsource_productDAO.getAllList();
			for (Outsource_product obj : list) {
				flowsMap.put("4_"+obj.getId(), obj);
			}
		}
		if(typeArray[5]){
			List<Manufacture> list=manufactureDAO.getAllList();
			for (Manufacture obj : list) {
				flowsMap.put("5_"+obj.getId(), obj);
			}
		}
		if(typeArray[6]){
			List<Shipments> list=shipmentsDAO.getAllList();
			for (Shipments obj : list) {
				flowsMap.put("6_"+obj.getId(), obj);
			}
		}
		if(typeArray[7]){
			List<Travel> list=travelDAO.getAllList();
			for (Travel obj : list) {
				flowsMap.put("7_"+obj.getId(), obj);
			}
		}
		if(typeArray[8]||typeArray[9]){
			List<Leave> list=leaveDAO.getAllList();
			for (Leave obj : list) {
				flowsMap.put("8_"+obj.getId(), obj);
			}
		}
		if(typeArray[9]){
			List<Resumption> list=resumptionDAO.getAllList();
			for (Resumption obj : list) {
				flowsMap.put("9_"+obj.getId(), obj);
			}
		}
		if(typeArray[10]){
			List<Track> list=trackDAO.getAllList();
			for (Track obj : list) {
				flowsMap.put("10_"+obj.getId(), obj);
			}
		}
		if(typeArray[11]||typeArray[18]){
			List<Sales_contract> list=sales_contractDAO.getAllList();
			for (Sales_contract obj : list) {
				flowsMap.put("11_"+obj.getId(), obj);
			}
		}
		if(typeArray[12]){
			List<Purchase_contract> list=purchase_contractDAO.getAllList();
			for (Purchase_contract obj : list) {
				flowsMap.put("12_"+obj.getId(), obj);
			}
		}
		if(typeArray[13]){
			List<Aftersales_task> list=aftersales_taskDAO.getAllList();
			for (Aftersales_task obj : list) {
				flowsMap.put("13_"+obj.getId(), obj);
			}
		}
		if(typeArray[14]){
			List<Seal> list=sealDAO.getAllList();
			for (Seal obj : list) {
				flowsMap.put("14_"+obj.getId(), obj);
			}
		}
		if(typeArray[15]){
			List<Vehicle> list=vehicleDAO.getAllList();
			for (Vehicle obj : list) {
				flowsMap.put("15_"+obj.getId(), obj);
			}
		}
		if(typeArray[16]){
			List<Work> list=workDAO.getAllList();
			for (Work obj : list) {
				flowsMap.put("16_"+obj.getId(), obj);
			}
		}
		if(typeArray[18]){
			List<Shipping> list=shippingDAO.getAllList();
			for (Shipping obj : list) {
				flowsMap.put("18_"+obj.getId(), obj);
			}
		}
		if(typeArray[19]){
			List<Performance> list=performanceDAO.getAllList();
			for (Performance obj : list) {
				flowsMap.put("19_"+obj.getId(), obj);
			}
		}
		if(typeArray[20]){
			List<Deliver> list=deliverDAO.getAllList();
			for (Deliver obj : list) {
				flowsMap.put("20_"+obj.getId(), obj);
			}
		}
		if(typeArray[21]){
			List<Task_updateflow> list=task_updateflowDAO.getAllList();
			for (Task_updateflow obj : list) {
				flowsMap.put("21_"+obj.getId(), obj);
			}
		}
		if(typeArray[22]){
			List<DepartmentPuchase> list=departPuchaseDao.getAllList();
			for (DepartmentPuchase obj : list) {
				flowsMap.put("22_"+obj.getId(), obj);
			}
		}
		return flowsMap;
	}
	/***
	 * 印章管理权限
	 * @param
	 * @param position_id
	 * @param
	 * @return
	 */
	private boolean[] getSealManagerPermission(int position_id,boolean permission14){
		boolean[] array=new boolean[DataUtil.sealManagerPermission.length];
		if(!permission14){
			//没有印章查看权限
			for(int i=0;i<array.length;i++){
				array[i]=permissionsDAO.checkPermission(position_id, DataUtil.sealManagerPermission[i]);
			}
		}
		return array;
	}
	/****
	 * key type_foreignid
	 * @return
	 */
	public Map<String,Object> getFlowPaging(int nowpage,String keywords,int newtime_flows,int nowtime_flows,
			String type_flows,String starttime1_flows,String endtime1_flows,String starttime2_flows,
			String endtime2_flows,int isjoin,int process,int handUp,int stage,User user) {
		// TODO Auto-generated method stub
		Map flowMap=new HashMap<String,Object>();
		List<Flow> flowList =null;
		List<Flow> flowList2=new ArrayList<Flow>(32);//每页显示20条
		SimpleDateFormat format = new SimpleDateFormat( "yyyy.MM.dd" );
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
		SimpleDateFormat sdf_performance = new SimpleDateFormat( "yyyy年M月" );
		boolean[] typeArray=new boolean[DataUtil.getFlowTypeArray().length];//type从 1开始
		StringTokenizer tokenizer=new StringTokenizer(type_flows,"-");
		char[] watchFlowArray=type_flows.toCharArray();
		byte index=1;
		for (char c : watchFlowArray) {
			typeArray[index++]='1'==c;
		}
		int start=nowpage*20-19;
		int num=0;//总数
		String[] flowTypeArray=DataUtil.getFlowTypeArray();
		String[] flowNameArray=DataUtil.getFlowNameArray();
		String projectName=null;//流程名称
		String flowprocess=null;
		String flowcode=null;
		String username=null;
		try {
			long starttime1 = sdf.parse(starttime1_flows).getTime();
			long endtime1=sdf.parse(endtime1_flows).getTime()+24*3600*1000;
			long starttime2=sdf.parse(starttime2_flows).getTime();
			long endtime2=sdf.parse(endtime2_flows).getTime()+24*3600*1000;
			Task task=null;
			Product_procurement product_p=null;
			Project_procurement project_p=null;
			Outsource_product out_p=null;
			Manufacture mf=null;
			Shipments sp=null;
			Travel travel=null;
			Leave leave=null;
			Resumption resumption=null;
			Track track=null;
			Sales_contract sales_contract=null;
			Customer_data customer_data=null;
			Purchase_contract purchase_contract=null;
			Aftersales_task aftersales_task=null;
			Seal seal=null;
			Vehicle vehicle=null;
			Work work=null;
			Shipping shipping=null;
			Performance performance=null;
			Deliver deliver=null;
			Task_updateflow task_updateflow=null;
			DepartmentPuchase departmentPuchase=null;
			//key type 或 type_foreignid
			Map<String,Object> flowsMap=getFlowsMap(typeArray);
			int position_id=user.getPosition_id();
			int uid = user.getId();
			boolean ifAdmin=("admin".equals(user.getName()) || position_userDAO.getParentByPositionId(user.getPosition_id()));
			List<Integer> flowTypes = getPermissionsType(position_id);//查看权限
			List<Integer> fidList =null;//该uid自己所有参与流程列表
			List<Integer> foidList =null; //该uid所属人员考核和工时统计列表
//			flowList=flowDAO.getAllFlowList();
			long query_time = 0L;
			long startTime=System.currentTimeMillis();
			if(startTime<starttime1){
				query_time=startTime;
			}else{
				query_time=starttime1;
			}
			if(ifAdmin){//如果是管理员则可以查看所有流程记录
				flowList=flowDAO.getAllFlowList();
			}else if(isjoin == 1 && flowTypes.size()>0){//查看权限记录和自己参与过的和下属全部记录
				fidList = flowDAO.getForeignIDByUid(uid);
				foidList = flowDAO.getFidByPositionID(position_id);
				flowList = flowDAO.getJoinPermissionFlowList(flowTypes,fidList,foidList,query_time-31536000000L);
			}else if(isjoin == 2){//查看自己参与过的流程记录
				fidList = flowDAO.getForeignIDByUid(uid);
				flowList = flowDAO.getAllJoinableFlowList(fidList);
			}else if(isjoin ==3){//查看权限记录和下属 但是自己没有参加过全部记录
				foidList = flowDAO.getFidByPositionID(position_id);
				flowList = flowDAO.getAllPermissionFlowList(flowTypes,foidList,uid,query_time-31536000000L);
			}else if(isjoin == 1 && flowTypes.size()==0){//没有查看权限只能看自己记录和所属人员考核记录
				fidList = flowDAO.getForeignIDByUid(uid);
				foidList = flowDAO.getFidByPositionID(position_id);
				flowList = flowDAO.getJoinFlowwerFlowList(fidList,foidList,query_time-31536000000L);
			}
			long finTime = System.currentTimeMillis();
			System.out.println("查询结束时间==="+(finTime-startTime));
			ArrayList<Integer> brotherUids=new ArrayList<Integer>();
			boolean brotherPermission=permissionsDAO.checkPermission(position_id,116);
			if(brotherPermission){
				brotherUids.addAll(userDAO.getSonListByParentPosition(position_userDAO.getPositionByID(position_id).getParent()));
			}
			boolean[] permissions=getPermissions(position_id,ifAdmin);
	//		int[] sealManager=new int[DataUtil.getSealArray().length];//最多10个印章，超过需要扩容 1：表示有管理权限；2：没有；0：未检查
			List<Integer> UIDs=new ArrayList<Integer>();
			if((!permissions[16]&&permissionsDAO.checkPermission(position_id, 103))||
					(!permissions[20])){
				//工时统计或考核没有查看权限的，需要检查是否为创建者的上级
				UIDs=userDAO.getSonListByParentPosition(position_id);
			}
			boolean[] sealManagerPermission=getSealManagerPermission(position_id,permissions[15]);
			if(flowList !=null){
					for(int k=0, f_len=flowList.size();k<f_len;k++ ){
						Flow flow=flowList.get(k);
						long nowtime=flow.getCreate_time();//最近一步的时间
						int flowtype=flow.getType();
						int operation=flow.getOperation();
						int foreign_id=flow.getForeign_id();
						flow.setUid(uid);
						if(!typeArray[flowtype]){
							continue;
						}
						switch (flowtype) {
						case 1:
							if(permissions[1]||(isjoin!=3&&joinFilter(2,flow))){
								task=(Task)flowsMap.get("1_"+foreign_id);
								if(task==null||task.getType()==1){
									continue;
								}
							}else{
								continue;
							}
							username=task.getCreate_name()==null?"":task.getCreate_name();
							flowcode=task.getProject_id();
							if(task.getProduct_type()==10 && (operation==1 || operation==2)){
								flowprocess=sdf.format(nowtime)+"提交，等待销售经理审核";
							}else if(task.getProject_category()==5){
								flowprocess=sdf.format(nowtime)+DataUtil.getFlowArray(151)[operation];
							}else{
								if(task.getProject_type()==2 && operation==26){
									flowprocess=sdf.format(nowtime)+"售后审核通过";
								}else if(task.getProject_type()==2 && operation==18){
									flowprocess=sdf.format(nowtime)+"售后审核不通过";
								}else{
									flowprocess=sdf.format(nowtime)+DataUtil.getFlowArray(1)[operation];
								}
							}
							projectName=task.getProject_name();
							String factory = null;
							factory = task.getFactory()==null?"":task.getFactory();
							if(keywords.length()==0||(flowprocess.contains(keywords)||flowTypeArray[1].contains(keywords)||username.contains(keywords)||flowcode.contains(keywords)||projectName.contains(keywords)||factory.contains(keywords))){
								if(timeFilter(newtime_flows,starttime1,endtime1,task.getCreate_time())&&
										timeFilter(nowtime_flows,starttime2,endtime2,nowtime)&&
										finishFilter(process,flowtype,operation)&&
										joinFilter(isjoin,flow)){
									num++;
									if(num>(start-1)&&num<(start+20)){
										flow.setUsername(username);
										flow.setId(1);
										flow.setType(1);
										flow.setFlowcode(flowcode);
										flow.setReason(flowprocess);
										flow.setJump_id(foreign_id);
										flow.setFlowname(projectName);
										flowList2.add(flow);
									}
									continue;
								}
							}
							break;
						case 2:
							if(permissions[2]||(isjoin!=3&&joinFilter(2,flow))){
								product_p=(Product_procurement)flowsMap.get("2_"+foreign_id);
								if(product_p==null){
									continue;
								}
							}else{
								continue;
							}
							username=product_p.getCreate_name()==null?"":product_p.getCreate_name();
							flowcode=Integer.toString(product_p.getId());
							flowprocess=sdf.format(nowtime)+DataUtil.getFlowArray(2)[operation];
							projectName=DataUtil.getNameByProductNameAndTime(product_p.getProduct_name(),2, product_p.getCreate_time());
							if(keywords.length()==0||(flowprocess.contains(keywords)||flowTypeArray[2].contains(keywords)||username.contains(keywords)||flowcode.contains(keywords)||projectName.contains(keywords))){
								if(timeFilter(newtime_flows,starttime1,endtime1,product_p.getCreate_time())&&
										timeFilter(nowtime_flows,starttime2,endtime2,nowtime)&&
										finishFilter(process,flowtype,operation)&&
										joinFilter(isjoin,flow)){
									num++;
									if(num>(start-1)&&num<(start+20)){
										flow.setUsername(username);
										flow.setId(2);
										flow.setFlowcode(flowcode);
										flow.setReason(flowprocess);
										flow.setJump_id(foreign_id);
										flow.setFlowname(projectName);
										flowList2.add(flow);
									}
									continue;
								}
							}
							break;
						case 3:
							project_p=(Project_procurement)flowsMap.get("3_"+foreign_id);
							if(project_p==null){
								continue;
							}
							task=(Task)flowsMap.get("1_"+project_p.getTask_id());
							//销售可以看到自己创建的项目任务单相关联的项目采购
							if(task==null||!(permissions[3]||uid==task.getCreate_id()||joinFilter(2,flow))){
								continue;
							}
							username=project_p.getCreate_name()==null?"":project_p.getCreate_name();
							flowcode=Integer.toString(project_p.getId());
							flowprocess=sdf.format(nowtime)+DataUtil.getFlowArray(3)[operation];
							projectName=flowNameArray[3]+"-"+task.getProject_name();
							if(keywords.length()==0||(flowprocess.contains(keywords)||flowTypeArray[3].contains(keywords)||username.contains(keywords)||flowcode.contains(keywords)||projectName.contains(keywords))){
								if(timeFilter(newtime_flows,starttime1,endtime1,project_p.getCreate_time())&&
										timeFilter(nowtime_flows,starttime2,endtime2,nowtime)&&
										finishFilter(process,flowtype,operation)&&
										joinFilter(isjoin,flow)){
									num++;
									if(num>(start-1)&&num<(start+20)){
										flow.setUsername(username);
										flow.setId(3);
										flow.setFlowcode(flowcode);
										flow.setReason(flowprocess);
										flow.setJump_id(foreign_id);
										flow.setFlowname(projectName);
										flowList2.add(flow);
									}
									continue;
								}
							}
							break;
						case 4:
							out_p=(Outsource_product)flowsMap.get("4_"+foreign_id);
							if(out_p==null){
								continue;
							}
							product_p=(Product_procurement)flowsMap.get("2_"+out_p.getProduct_pid());
							//可以看见自己创建的生产单相关联的外协
							if(product_p==null||!(permissions[4]||uid==product_p.getCreate_id()||joinFilter(2,flow))){
								continue;
							}
							username=out_p.getCreate_name()==null?"":out_p.getCreate_name();
							flowcode=Integer.toString(out_p.getId());
							flowprocess=sdf.format(nowtime)+DataUtil.getFlowArray(4)[operation];
							projectName=DataUtil.getNameByTime(4, out_p.getCreate_time());
							if(keywords.length()==0||(flowprocess.contains(keywords)||flowTypeArray[4].contains(keywords)||username.contains(keywords)||flowcode.contains(keywords)||projectName.contains(keywords))){
								if(timeFilter(newtime_flows,starttime1,endtime1,out_p.getCreate_time())&&
										timeFilter(nowtime_flows,starttime2,endtime2,nowtime)&&
										finishFilter(process,flowtype,operation)&&
										joinFilter(isjoin,flow)){
									num++;
									if(num>(start-1)&&num<(start+20)){
										flow.setUsername(username);
										flow.setId(4);
										flow.setFlowcode(flowcode);
										flow.setReason(flowprocess);
										flow.setJump_id(foreign_id);
										flow.setFlowname(projectName);
										flowList2.add(flow);
									}
									continue;
								}
							}
							break;
						case 5:
							mf=(Manufacture)flowsMap.get("5_"+foreign_id);
							if(mf==null){
								continue;
							}
							int task_id=mf.getTask_id();
							if(task_id>0){
								task=(Task)flowsMap.get("1_"+task_id);
								if(task==null||!(permissions[5]||uid==task.getCreate_id()||joinFilter(2,flow))){
									continue;
								}
								projectName=task.getProject_name();
							}else{
								if(!(permissions[5]||(isjoin!=3&&joinFilter(2,flow)))){
									continue;
								}
								projectName=DataUtil.getNameByTime(5, mf.getCreate_time());
							}
							username=mf.getCreate_name()==null?"":mf.getCreate_name();
							flowcode=Integer.toString(mf.getId());
							flowprocess=sdf.format(nowtime)+DataUtil.getFlowArray(5)[operation];
							if(keywords.length()==0||(flowprocess.contains(keywords)||flowTypeArray[5].contains(keywords)||username.contains(keywords)||flowcode.contains(keywords)||projectName.contains(keywords))){
								if(timeFilter(newtime_flows,starttime1,endtime1,mf.getCreate_time())&&
										timeFilter(nowtime_flows,starttime2,endtime2,nowtime)&&
										finishFilter(process,flowtype,operation)&&
										joinFilter(isjoin,flow)){
									num++;
									if(num>(start-1)&&num<(start+20)){
										flow.setUsername(username);
										flow.setId(5);
										flow.setFlowcode(flowcode);
										flow.setReason(flowprocess);
										flow.setJump_id(foreign_id);
										flow.setFlowname(projectName);
										flowList2.add(flow);
									}
									continue;
								}
							}
							break;
						case 6:
							sp=(Shipments)flowsMap.get("6_"+foreign_id);
							if(sp==null){
								continue;
							}
							task=(Task)flowsMap.get("1_"+sp.getTask_id());
							//可以看见自己创建的项目任务单相关联的发货单
							if(task==null||!(permissions[6]||uid==task.getCreate_id()||joinFilter(2,flow))){
								continue;
							}
							username=sp.getCreate_name()==null?"":sp.getCreate_name();
							flowcode=Integer.toString(sp.getId());
							flowprocess=sdf.format(nowtime)+DataUtil.getFlowArray(6)[operation];
							projectName=flowNameArray[6]+"-"+task.getProject_name();
							if(keywords.length()==0||(flowprocess.contains(keywords)||flowTypeArray[6].contains(keywords)||username.contains(keywords)||flowcode.contains(keywords)||projectName.contains(keywords))){
								if(timeFilter(newtime_flows,starttime1,endtime1,sp.getCreate_time())&&
										timeFilter(nowtime_flows,starttime2,endtime2,nowtime)&&
										finishFilter(process,flowtype,operation)&&
										joinFilter(isjoin,flow)){
									num++;
									if(num>(start-1)&&num<(start+20)){
										flow.setUsername(username);
										flow.setId(6);
										flow.setFlowcode(flowcode);
										flow.setReason(flowprocess);
										flow.setJump_id(foreign_id);
										flow.setFlowname(projectName);
										flowList2.add(flow);
									}
									continue;
								}
							}
							break;
						case 7:
							travel=(Travel)flowsMap.get("7_"+foreign_id);
							if(travel!=null&&(permissions[7]||(brotherPermission&&brotherUids.contains(travel.getCreate_id()))||(isjoin!=3&&joinFilter(2,flow)))){
								
							}else{
								continue;
							}
							username=travel.getCreate_name()==null?"":travel.getCreate_name();
							flowcode=Integer.toString(travel.getId());
							flowprocess=sdf.format(nowtime)+DataUtil.getFlowArray(7)[operation];
							projectName=DataUtil.getNameByTravel(travel.getAddress(),travel.getStarttime(),travel.getEndtime());
							if(keywords.length()==0||(flowprocess.contains(keywords)||flowTypeArray[7].contains(keywords)||username.contains(keywords)||flowcode.contains(keywords)||projectName.contains(keywords))){
								if(timeFilter(newtime_flows,starttime1,endtime1,travel.getCreate_time())&&
										timeFilter(nowtime_flows,starttime2,endtime2,nowtime)&&
										finishFilter(process,flowtype,operation)&&
										joinFilter(isjoin,flow)){
									num++;
									if(num>(start-1)&&num<(start+20)){
										flow.setUsername(username);
										flow.setId(7);
										flow.setFlowcode(flowcode);
										flow.setReason(flowprocess);
										flow.setJump_id(foreign_id);
										flow.setFlowname(projectName);
										flowList2.add(flow);
									}
									continue;
								}
							}
							break;
						case 8:
							leave=(Leave)flowsMap.get("8_"+foreign_id);
							if(leave!=null&&(permissions[8]||(brotherPermission&&brotherUids.contains(leave.getCreate_id()))||(isjoin!=3&&joinFilter(2,flow)))){
								
							}else{
								continue;
							}
							username=leave.getCreate_name()==null?"":leave.getCreate_name();
							flowcode=Integer.toString(leave.getId());
							flowprocess=sdf.format(nowtime)+DataUtil.getFlowArray(8)[operation];
							if(operation==2){
								flowprocess+=getApprovalNum(DataUtil.getLeaveDays(leave.getStarttime(), leave.getEndtime(),leave.getLeave_type()),leave.getCreate_id())>1?",等待分管审批":",等待考勤备案";
							}else if(operation==4){
								flowprocess+=getApprovalNum(DataUtil.getLeaveDays(leave.getStarttime(), leave.getEndtime(),leave.getLeave_type()),leave.getCreate_id())>2?",等待总经理审批":",等待考勤备案";
							}
							projectName=DataUtil.getNameByTime(8, leave.getCreate_time());
							if(keywords.length()==0||(flowprocess.contains(keywords)||flowTypeArray[8].contains(keywords)||username.contains(keywords)||flowcode.contains(keywords)||projectName.contains(keywords))){
								if(timeFilter(newtime_flows,starttime1,endtime1,leave.getCreate_time())&&
										timeFilter(nowtime_flows,starttime2,endtime2,nowtime)&&
										finishFilter(process,flowtype,operation)&&
										joinFilter(isjoin,flow)){
									num++;
									if(num>(start-1)&&num<(start+20)){
										flow.setUsername(username);
										flow.setId(8);
										flow.setReason(flowprocess);
										flow.setType(8);//重置flow_type
										flow.setFlowcode(flowcode);
										flow.setJump_id(foreign_id);
										flow.setFlowname(projectName);
										flowList2.add(flow);
									}
									continue;
								}
							}
							break;
						case 9:
							resumption=(Resumption)flowsMap.get("9_"+foreign_id);
							if(resumption==null||resumption.getType()==1){
								continue;
							}
							leave=(Leave)flowsMap.get("8_"+resumption.getForeign_id());
							if(leave==null){
								continue;
							}
							if(permissions[9]||(brotherPermission&&brotherUids.contains(leave.getCreate_id()))||(isjoin!=3&&joinFilter(2,flow))){
								
							}else{
								//参与过请假单操作
								flow.setType(8);
								flow.setForeign_id(leave.getId());
								if(!joinFilter(2,flow)){
									continue;
								}
							}
							username=resumption.getCreate_name()==null?"":resumption.getCreate_name();
							flowcode=Integer.toString(resumption.getId());
							flowprocess = sdf.format(nowtime) + DataUtil.getFlowArray(9)[operation];
							if(operation==5&&leave!=null){//新版本销假只能绑定请假单，op==5||op==7只可能是关联了请假单
								flowprocess+=getApprovalNum(DataUtil.getLeaveDays(resumption.getStarttime(), resumption.getReback_time()-43200000l,leave.getLeave_type()),resumption.getCreate_id())>1?",等待分管审批":",等待考勤备案";
							}else if(operation==7&&leave!=null){
								flowprocess+=getApprovalNum(DataUtil.getLeaveDays(resumption.getStarttime(), resumption.getReback_time()-43200000l,leave.getLeave_type()),resumption.getCreate_id())>2?",等待总经理审批":",等待考勤备案";
							}			
							projectName=DataUtil.getNameByTime(9, resumption.getCreate_time());
							if(keywords.length()==0||(flowprocess.contains(keywords)||flowTypeArray[9].contains(keywords)||username.contains(keywords)||flowcode.contains(keywords)||projectName.contains(keywords))){
								if(timeFilter(newtime_flows,starttime1,endtime1,resumption.getCreate_time())&&
										timeFilter(nowtime_flows,starttime2,endtime2,nowtime)&&
										finishFilter(process,flowtype,operation)&&
										joinFilter(isjoin,flow)){
									num++;
									if(num>(start-1)&&num<(start+20)){
										flow.setUsername(username);
										flow.setId(9);
										flow.setType(9);//重置flow_type
										flow.setFlowcode(flowcode);
										flow.setReason(flowprocess);
										flow.setJump_id(foreign_id);
										flow.setFlowname(projectName);
										flowList2.add(flow);
									}
									continue;
								}
							}
							break;
						case 10:
							if(permissions[10]||(isjoin!=3&&joinFilter(2,flow))){
								track=(Track)flowsMap.get("10_"+foreign_id);
								if(track==null){
									continue;
								}
							}else{
								continue;
							}
							username=track.getCreate_name()==null?"":track.getCreate_name();
							flowcode=Integer.toString(track.getId());
							flowprocess=sdf.format(nowtime)+DataUtil.getFlowArray(10)[operation];
							projectName=DataUtil.getNameByTime(10, track.getCreate_time());
							if(keywords.length()==0||(flowprocess.contains(keywords)||flowTypeArray[10].contains(keywords)||username.contains(keywords)||flowcode.contains(keywords)||projectName.contains(keywords))){
								if(timeFilter(newtime_flows,starttime1,endtime1,track.getCreate_time())&&
										timeFilter(nowtime_flows,starttime2,endtime2,nowtime)&&
										finishFilter(process,flowtype,operation)&&
										joinFilter(isjoin,flow)){
									num++;
									if(num>(start-1)&&num<(start+20)){
										flow.setUsername(username);
										flow.setId(17);//此处type表示页面跳转的标记
										flow.setFlowcode(flowcode);
										flow.setReason(flowprocess);
										flow.setJump_id(foreign_id);
										flow.setFlowname(projectName);
										flowList2.add(flow);
									}
									continue;
								}
							}
							break;
						case 11:
							if(permissions[11]||(isjoin!=3&&joinFilter(2,flow))){
								sales_contract=(Sales_contract)flowsMap.get("11_"+foreign_id);
								if(sales_contract==null){
									continue;
								}
							}else{
								continue;
							}
							customer_data=customer_dataDAO.getCustomer_dataByCustomerID(sales_contract.getCustomer_id());
							if(customer_data==null){
								continue;
							}
							username=sales_contract.getCreate_name()==null?"":sales_contract.getCreate_name();
							flowcode=sales_contract.getContract_no();
							flowprocess=sdf.format(nowtime)+DataUtil.getFlowArray(11)[operation];
							projectName=customer_data.getCompany_name();
							if(keywords.length()==0||(flowprocess.contains(keywords)||flowTypeArray[11].contains(keywords)||username.contains(keywords)||flowcode.contains(keywords)||projectName.contains(keywords))){
								if(timeFilter(newtime_flows,starttime1,endtime1,sales_contract.getCreate_time())&&
										timeFilter(nowtime_flows,starttime2,endtime2,nowtime)&&
										finishFilter(process,flowtype,operation)&&
										joinFilter(isjoin,flow)){
									num++;
									if(num>(start-1)&&num<(start+20)){
										flow.setUsername(username);
										flow.setId(19);
										flow.setFlowcode(flowcode);
										flow.setFlowname(projectName);
										flow.setReason(flowprocess);
										flow.setJump_id(foreign_id);
										flowList2.add(flow);
									}
									continue;
								}
							}
							break;
						case 12:
							if(permissions[12]||(isjoin!=3&&joinFilter(2,flow))){
								purchase_contract=(Purchase_contract)flowsMap.get("12_"+foreign_id);
								if(purchase_contract==null){
									continue;
								}
							}else{
								continue;
							}
							Customer_data customer_data2=customer_dataDAO.getCustomer_dataByCustomerID(purchase_contract.getSupplier());
							if(customer_data2==null){
								continue;
							}
							username=purchase_contract.getCreate_name()==null?"":purchase_contract.getCreate_name();
							flowcode=purchase_contract.getContract_no();
							flowprocess=sdf.format(nowtime)+DataUtil.getFlowArray(12)[operation];
							projectName=customer_data2.getCompany_name();
							if(keywords.length()==0||(flowprocess.contains(keywords)||flowTypeArray[12].contains(keywords)||username.contains(keywords)||flowcode.contains(keywords)||projectName.contains(keywords))){
								if(timeFilter(newtime_flows,starttime1,endtime1,purchase_contract.getCreate_time())&&
										timeFilter(nowtime_flows,starttime2,endtime2,nowtime)&&
										finishFilter(process,flowtype,operation)&&
										joinFilter(isjoin,flow)){
									num++;
									if(num>(start-1)&&num<(start+20)){
										flow.setUsername(username);
										flow.setId(20);
										flow.setFlowcode(flowcode);
										flow.setReason(flowprocess);
										flow.setJump_id(foreign_id);
										flow.setFlowname(projectName);
										flowList2.add(flow);
									}
									continue;
								}
							}
							break;
						case 13:
							if(permissions[13]||(isjoin!=3&&joinFilter(2,flow))){
								aftersales_task=(Aftersales_task)flowsMap.get("13_"+foreign_id);
								if(aftersales_task==null){
									continue;
								}
							}else {
								continue;
							}
							username=aftersales_task.getCreate_name()==null?"":aftersales_task.getCreate_name();
							flowcode=Integer.toString(aftersales_task.getId());
							flowprocess=sdf.format(nowtime)+DataUtil.getFlowArray(13)[operation];
							projectName=aftersales_task.getProject_name()+"-"+aftersales_task.getProject_id();
							if(keywords.length()==0||(flowprocess.contains(keywords)||flowTypeArray[13].contains(keywords)||username.contains(keywords)||flowcode.contains(keywords)||projectName.contains(keywords))){
								if(timeFilter(newtime_flows,starttime1,endtime1,aftersales_task.getCreate_time())&&
										timeFilter(nowtime_flows,starttime2,endtime2,nowtime)&&
										finishFilter(process,flowtype,operation)&&
										joinFilter(isjoin,flow)&&hangUp(handUp,flow)){
									num++;
									if(num>(start-1)&&num<(start+20)){
										flow.setUsername(username);
										flow.setId(21);
										flow.setFlowcode(flowcode);
										flow.setReason(flowprocess);
										flow.setJump_id(foreign_id);
										flow.setFlowname(projectName);
										flowList2.add(flow);
									}
									continue;
								}
							}
							break;
						case 14:
							seal=(Seal)flowsMap.get("14_"+foreign_id);
							if(seal!=null&&(permissions[14]||sealManagerPermission[seal.getType()]||(brotherPermission&&brotherUids.contains(seal.getCreate_id()))||(isjoin!=3&&joinFilter(2,flow)))){
								//印章管理者可以看到他所管理的印章的申请
							}else{
								//印章管理者可以看到他所管理的印章的申请
								continue;
							}
							username=seal.getCreate_name()==null?"":seal.getCreate_name();
							flowcode=Integer.toString(seal.getId());
							flowprocess=sdf.format(nowtime)+DataUtil.getFlowArray(14)[operation];
							projectName=DataUtil.getNameBySealUserAndTime(seal.getSeal_user(),14, seal.getCreate_time());
							if(keywords.length()==0||(flowprocess.contains(keywords)||flowTypeArray[14].contains(keywords)||username.contains(keywords)||flowcode.contains(keywords)||projectName.contains(keywords))){
								if(timeFilter(newtime_flows,starttime1,endtime1,seal.getCreate_time())&&
										timeFilter(nowtime_flows,starttime2,endtime2,nowtime)&&
										finishFilter(process,flowtype,operation)&&
										joinFilter(isjoin,flow)){
									num++;
									if(num>(start-1)&&num<(start+20)){
										flow.setUsername(username);
										flow.setId(22);
										flow.setFlowcode(flowcode);
										flow.setReason(flowprocess);
										flow.setJump_id(foreign_id);
										flow.setFlowname(projectName);
										flowList2.add(flow);
									}
									continue;
								}
							}
							break;
						case 15:
							vehicle=(Vehicle)flowsMap.get("15_"+foreign_id);
							if(vehicle!=null&&(permissions[15]||(brotherPermission&&brotherUids.contains(vehicle.getCreate_id()))||(isjoin!=3&&joinFilter(2,flow)))){
								
							}else{
								continue;
							}
							username=vehicle.getCreate_name()==null?"":vehicle.getCreate_name();
							flowcode=Integer.toString(vehicle.getId());
							flowprocess=sdf.format(nowtime)+DataUtil.getFlowArray(15)[operation];
							projectName=DataUtil.getNameByTime(15, vehicle.getCreate_time());
							if(keywords.length()==0||(flowprocess.contains(keywords)||flowTypeArray[15].contains(keywords)||username.contains(keywords)||flowcode.contains(keywords)||projectName.contains(keywords))){
								if(timeFilter(newtime_flows,starttime1,endtime1,vehicle.getCreate_time())&&
										timeFilter(nowtime_flows,starttime2,endtime2,nowtime)&&
										finishFilter(process,flowtype,operation)&&
										joinFilter(isjoin,flow)){
									num++;
									if(num>(start-1)&&num<(start+20)){
										flow.setUsername(username);
										flow.setId(23);
										flow.setFlowcode(flowcode);
										flow.setReason(flowprocess);
										flow.setJump_id(foreign_id);
										flow.setFlowname(projectName);
										flowList2.add(flow);
									}
									continue;
								}
							}
							break;
						case 16:
							if(permissions[16]||(isjoin!=3&&joinFilter(2,flow))){
								work=(Work)flowsMap.get("16_"+foreign_id);
								if(work==null){
									continue;
								}
							}else{
								if(UIDs.size()>0){
									work=(Work)flowsMap.get("16_"+foreign_id);
									if(work==null||!UIDs.contains(work.getCreate_id())){
										continue;
									}
								}else{
									continue;
								}
							}
							username=work.getCreate_name()==null?"":work.getCreate_name();
							flowcode=Integer.toString(work.getId());
							flowprocess=sdf.format(nowtime)+DataUtil.getFlowArray(16)[operation];
							projectName=DataUtil.getNameByTime(16, work.getWorkmonth());
							if(keywords.length()==0||(flowprocess.contains(keywords)||flowTypeArray[16].contains(keywords)||username.contains(keywords)||flowcode.contains(keywords)||projectName.contains(keywords))){
								if(timeFilter(newtime_flows,starttime1,endtime1,work.getCreate_time())&&
										timeFilter(nowtime_flows,starttime2,endtime2,nowtime)&&
										finishFilter(process,flowtype,operation)&&
										joinFilter(isjoin,flow)){
									num++;
									if(num>(start-1)&&num<(start+20)){
										flow.setUsername(username);
										flow.setId(24);
										flow.setFlowcode(flowcode);
										flow.setReason(flowprocess);
										flow.setJump_id(foreign_id);
										flow.setFlowname(projectName);
										flowList2.add(flow);
									}
									continue;
								}
							}
							break;
						case 17:
							if(permissions[17]||(isjoin!=3&&joinFilter(2,flow))){
								task=(Task)flowsMap.get("1_"+foreign_id);//type 1和17的taskid不重复
								if(task!=null&&task.getType()==1&&(stage==0||task.getStage()==stage)){
									
								}else{
									continue;
								}
							}else{
								continue;
							}
							username=task.getCreate_name()==null?"":task.getCreate_name();
							flowcode=task.getProject_id();
							flowprocess=sdf.format(nowtime)+DataUtil.getFlowArray(17)[operation];
							projectName=task.getProject_name()+'-'+DataUtil.getStageArray2()[task.getStage()];
							if(keywords.length()==0||(flowprocess.contains(keywords)||flowTypeArray[17].contains(keywords)||username.contains(keywords)||flowcode.contains(keywords)||projectName.contains(keywords))){
								if(timeFilter(newtime_flows,starttime1,endtime1,task.getCreate_time())&&
										timeFilter(nowtime_flows,starttime2,endtime2,nowtime)&&
										finishFilter(process,flowtype,operation)&&
										joinFilter(isjoin,flow)){
									num++;
									if(num>(start-1)&&num<(start+20)){
										flow.setUsername(username);
										flow.setId(25);
										flow.setType(17);
										flow.setFlowcode(flowcode);
										flow.setReason(flowprocess);
										flow.setJump_id(foreign_id);
										flow.setFlowname(projectName);
										flowList2.add(flow);
									}
									continue;
								}
							}
							break;
						case 18:
							if(permissions[18]||(isjoin!=3&&joinFilter(2,flow))){
								shipping=(Shipping)flowsMap.get("18_"+foreign_id);
								if(shipping==null){
									continue;
								}
							}else{
								continue;
							}
							sales_contract=(Sales_contract)flowsMap.get("11_"+shipping.getSales_id());
							if(sales_contract==null){
								continue;
							}
							customer_data=customer_dataDAO.getCustomer_dataByCustomerID(sales_contract.getCustomer_id());
							if(customer_data==null){
								continue;
							}
							username=shipping.getCreate_name()==null?"":shipping.getCreate_name();
							flowcode=sales_contract.getContract_no();//编号
							flowprocess=sdf.format(nowtime)+DataUtil.getFlowArray(18)[operation];
							projectName=customer_data.getCompany_name();
							if(keywords.length()==0||(flowprocess.contains(keywords)||flowTypeArray[18].contains(keywords)||username.contains(keywords)||flowcode.contains(keywords)||projectName.contains(keywords))){
								if(timeFilter(newtime_flows,starttime1,endtime1,sales_contract.getCreate_time())&&
										timeFilter(nowtime_flows,starttime2,endtime2,nowtime)&&
										finishFilter(process,flowtype,operation)&&
										joinFilter(isjoin,flow)){
									num++;
									if(num>(start-1)&&num<(start+20)){
										flow.setUsername(username);
										flow.setId(28);
										flow.setFlowcode(flowcode);
										flow.setFlowname(projectName);
										flow.setReason(flowprocess);
										flow.setJump_id(foreign_id);
										flowList2.add(flow);
									}
									continue;
								}
							}
							break;
						case 19:
							performance=(Performance)flowsMap.get("19_"+foreign_id);
//							User leader=null;
							boolean b=false;
							if(performance!=null){
								List<User> userList=userDAO.getParentListByChildUid(performance.getLeader());
//								leader = userDAO.getUserByID(performance.getLeader());
								if (userList!=null&&userList.size()>0) {
									for (User user2 : userList) {
										if(user2.getId()==user.getId()){
											b=true;
										}
									}
								}
							}
							if(performance!=null&&(permissions[19]||(isjoin!=3&&joinFilter(2,flow))||performance.getLeader()==user.getId()||b)){
								
							}else{
								continue;
							}
							username=performance.getCreate_name()==null?"":performance.getCreate_name();
							flowcode=Integer.toString(performance.getId());
							flowprocess=sdf.format(nowtime)+DataUtil.getFlowArray(19)[operation];
							projectName=sdf_performance.format(performance.getPerformance_month());
							if(operation<4||operation==7){
								projectName+="计划";
							}else{
								projectName+="考核";
							}
							
							if(keywords.length()==0||(flowprocess.contains(keywords)||flowTypeArray[19].contains(keywords)||username.contains(keywords)||flowcode.contains(keywords)||projectName.contains(keywords))){
								if(timeFilter(newtime_flows,starttime1,endtime1,performance.getCreate_time())&&
										timeFilter(nowtime_flows,starttime2,endtime2,nowtime)&&
										finishFilter(process,flowtype,operation)&&
										joinFilter(isjoin,flow)){
									num++;
									if(num>(start-1)&&num<(start+20)){
										flow.setUsername(username);
										flow.setId(32);
										flow.setFlowcode(flowcode);
										flow.setFlowname(projectName);
										flow.setReason(flowprocess);
										flow.setJump_id(performance.getId());
										flowList2.add(flow);
									}
									continue;
								}
							}
							break;
						case 20:
							deliver=(Deliver)flowsMap.get("20_"+foreign_id);
							if(deliver==null){
								continue;
							}
							if((permissions[20]||(isjoin!=3&&joinFilter(2,flow)))){
								
							}else{
								if(UIDs.size()>0){
									if(!UIDs.contains(deliver.getCreate_id())){
										continue;
									}
								}else{
									continue;
								}
							}
							username=deliver.getCreate_name()==null?"":deliver.getCreate_name();
							flowcode=deliver.getProject_id();
							flowprocess=sdf.format(nowtime)+DataUtil.getFlowArray(20)[operation];
							projectName=deliver.getProject_name();
							
							if(keywords.length()==0||(flowprocess.contains(keywords)||flowTypeArray[20].contains(keywords)||username.contains(keywords)||flowcode.contains(keywords)||projectName.contains(keywords))){
								if(timeFilter(newtime_flows,starttime1,endtime1,deliver.getCreate_time())&&
										timeFilter(nowtime_flows,starttime2,endtime2,nowtime)&&
										finishFilter(process,flowtype,operation)&&
										joinFilter(isjoin,flow)){
									num++;
									if(num>(start-1)&&num<(start+20)){
										flow.setUsername(username);
										flow.setId(33);
										flow.setFlowcode(flowcode);
										flow.setFlowname(projectName);
										flow.setReason(flowprocess);
										flow.setJump_id(deliver.getId());
										flowList2.add(flow);
									}
									continue;
								}
							}
							break;
						case 21:
							task_updateflow=(Task_updateflow)flowsMap.get("21_"+foreign_id);
							if(task_updateflow==null){
								continue;
							}
							if(permissions[21]||(isjoin!=3&&joinFilter(2,flow))){
								
							}else{
								continue;
							}
							username=task_updateflow.getCreate_name()==null?"":task_updateflow.getCreate_name();
							flowcode="21_"+task_updateflow.getId();
							flowprocess=sdf.format(nowtime)+DataUtil.getFlowArray(21)[operation];
							projectName="项目启动任务单修改申请流程";
							
							if(keywords.length()==0||(flowprocess.contains(keywords)||flowTypeArray[21].contains(keywords)||username.contains(keywords)||flowcode.contains(keywords)||projectName.contains(keywords))){
								if(timeFilter(newtime_flows,starttime1,endtime1,task_updateflow.getCreate_time())&&
										timeFilter(nowtime_flows,starttime2,endtime2,nowtime)&&
										finishFilter(process,flowtype,operation)&&
										joinFilter(isjoin,flow)){
									num++;
									if(num>(start-1)&&num<(start+20)){
										flow.setUsername(username);
										flow.setId(41);
										flow.setFlowcode(flowcode);
										flow.setFlowname(projectName);
										flow.setReason(flowprocess);
										flow.setJump_id(task_updateflow.getId());
										flowList2.add(flow);
									}
									continue;
								}
							}
							break;
						case 22:
							departmentPuchase=(DepartmentPuchase)flowsMap.get("22_"+foreign_id);
							if(departmentPuchase==null){
								continue;
							}
							if(permissions[22]||(isjoin!=3&&joinFilter(2,flow))){
								
							}else{
								continue;
							}
							username=departmentPuchase.getPurchaseName()==null?"":departmentPuchase.getPurchaseName();
							flowcode=departmentPuchase.getPurchaseNum();
							flowprocess=sdf.format(nowtime)+DataUtil.getFlowArray(22)[operation];
							projectName="其他部门采购单-"+flowcode;
							
							if(keywords.length()==0||(flowprocess.contains(keywords)||flowTypeArray[20].contains(keywords)||username.contains(keywords)||flowcode.contains(keywords)||projectName.contains(keywords))){
								if(timeFilter(newtime_flows,starttime1,endtime1,departmentPuchase.getCreate_time())&&
										timeFilter(nowtime_flows,starttime2,endtime2,nowtime)&&
										finishFilter(process,flowtype,operation)&&
										joinFilter(isjoin,flow)){
									num++;
									if(num>(start-1)&&num<(start+20)){
										flow.setUsername(username);
										flow.setId(36);
										flow.setFlowcode(flowcode);
										flow.setFlowname(projectName);
										flow.setReason(flowprocess);
										flow.setJump_id(departmentPuchase.getId());
										flowList2.add(flow);
									}
									continue;
								}
							}
							break;
						default:
							break;
						}
					}
		}
			System.out.println("循环结束时间==="+(System.currentTimeMillis()-finTime));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(flowList!=null){
			flowList.clear();
		}
		flowList=null;
		flowMap.put("data", flowList2);
		flowMap.put("num", num);
		return flowMap;
	}
	/*****
	 * 时间筛选
	 */
	private boolean timeFilter(int time_flows,long starttime,long endtime,long comparetime){
		if(time_flows==1){
			return comparetime> starttime&&comparetime<endtime;
		}
		return true;
	}
	/*****
	 * 是否挂起
	 */
	private boolean hangUp(int hangUp,Flow flow){
		if(hangUp==1){
			return true;
		}
		if(flow.getType()==13){
			if(hangUp==2){//挂起
				return flow.getOperation()==10;
			}else{
				return flow.getOperation()!=10;
			}
		}
		return false;
	}
	/*****
	 * 是否参与
	 */
	private boolean joinFilter(int isjoin,Flow flow){
		if(isjoin==1){
			return true;
		}
		//参与
		if(isjoin==2&&flowDAO.checkIsJoin(flow)){
			return true;
		}else if(isjoin==3&&!flowDAO.checkIsJoin(flow)){
			//未参与的
			return true;
		}
		return false;
	}
	/*****
	 * 是否已完成
	 */
	private boolean finishFilter(int process,int type,int operation){
		//筛选全部
		if(process==1){
			return true;
		}
		switch (type) {
		case 1:
			//未完成
			if(process==2&&operation!=5&&operation!=8&&operation!=12&&operation!=23){
				return true;
			}else if(process==3&&(operation==5||operation==8||operation==12||operation==23)){
				//完成
				return true;
			}else if(process==4&&(operation==5||operation==8||operation==23)){
				//完成
				return true;
			}
			break;
		case 2:
			//未完成
			if(process==2&&operation!=8){
				return true;
			}else if((process==3||process==4)&&operation==8){
				//完成
				return true;
			}
			break;
		case 3:
			//未完成
			if(process==2&&operation!=11&operation!=17){
				return true;
			}else if(process==3&&(operation==11||operation==17)){
				//完成
				return true;
			}else if(process==4&&operation==11){
				//完成
				return true;
			}
			break;
		case 4:
			//未完成
			if(process==2&&operation!=6){
				return true;
			}else if((process==3||process==4)&&operation==6){
				//完成
				return true;
			}
			break;
		case 5:
			//未完成
			if(process==2&&operation!=4){
				return true;
			}else if((process==3||process==4)&&operation==4){
				//完成
				return true;
			}
			break;
		case 6:
			//未完成
			if(process==2&&operation!=6){
				return true;
			}else if((process==3||process==4)&&operation==6){
				//完成
				return true;
			}
			break;
		case 7:
			//未完成
			if(process==2&&operation!=3&&operation!=5&&operation!=7){
				return true;
			}else if(process==3&&(operation==3||operation==5||operation==7)){
				//完成
				return true;
			}else if(process==4&&(operation==3||operation==5)){
				//完成
				return true;
			}
			break;
		case 8:
			//未完成
			if(process==2&&operation!=3&&operation!=5&&operation!=6&&operation!=8&&operation!=9){
				return true;
			}else if(process==3&&(operation==3||operation==5||operation==6||operation==8||operation==9)){
				//完成
				return true;
			}else if(process==4&&(operation==3||operation==5||operation==6||operation==8)){
				//完成
				return true;
			}
			break;
		case 9:
			if(process==2&&operation!=3&&operation!=4&&operation!=6&&operation!=8&&operation!=10){
				//未完成
				return true;
			}else if(process==3&&(operation==3||operation==4||operation==6||operation==8||operation==10)){
				//完成
				return true;
			}
			break;
		case 10:
			if(process==2&&operation!=2){
				//未完成
				return true;
			}else if((process==3||process==4)&&operation==2){
				//完成
				return true;
			}
			break;
		case 11:
			if(process==2&&(operation!=12&&operation!=13)){
				//未完成
				return true;
			}else if(process==3&&(operation==12||operation==13)){
				//完成
				return true;
			}else if(process==4&&(operation==12)){
				//完成
				return true;
			}
			break;
		case 12:
			if(process==2&&(operation!=10&&operation!=11)){
				//未完成
				return true;
			}else if(process==3&&(operation==10||operation==11)){
				//完成
				return true;
			}else if(process==4&&(operation==10)){
				//完成
				return true;
			}
			break;
		case 13:
			if(process==2&&(operation!=7&&operation!=9)){
				//未完成
				return true;
			}else if(process==3&&(operation==7||operation==9)){
				//完成
				return true;
			}else if(process==4&&(operation==7)){
				//完成
				return true;
			}
			break;
		case 14:
			if(process==2&&(operation!=4&&operation!=5)){
				//未完成
				return true;
			}else if(process==3&&(operation==4||operation==5)){
				//完成
				return true;
			}else if(process==4&&(operation==4)){
				//完成
				return true;
			}
			break;
		case 15:
			if(process==2&&(operation!=5&&operation!=6)){
				//未完成
				return true;
			}else if(process==3&&(operation==5||operation==6)){
				//完成
				return true;
			}else if(process==4&&(operation==5)){
				//完成
				return true;
			}
			break;
		case 16:
			return process<3;
		case 17:
			if(process==2&&(operation!=7&&operation!=8&&operation!=9)){
				//未完成
				return true;
			}else if(process==3&&(operation==7||operation==8||operation==9)){
				//完成
				return true;
			}else if(process==4&&(operation==7||operation==9)){
				//完成
				return true;
			}
			break;
		case 18:
			if(process==2&&(operation!=6&&operation!=7)){
				//未完成
				return true;
			}else if(process==3&&(operation==6||operation==7)){
				//完成
				return true;
			}else if(process==4&&(operation==6)){
				//完成
				return true;
			}
			break;
		case 19:
			if(process==2&&operation!=6){
				//未完成
				return true;
			}else if((process==3||process==4)&&operation==6){
				//完成
				return true;
			}
			break;
		case 20:
			if(process==2&&operation!=4&&operation!=6){
				//未完成
				return true;
			}else if(process==3&&(operation==4||operation==6)){
				//完成
				return true;
			}else if(process==4&&(operation==4)){
				//完成
				return true;
			}
			break;
		default:
			break;
		}
		return false;
	}
	public int checkLoadFilePermission(int fileID,int uid) {
		// TODO Auto-generated method stub
		//文件权限
		int flag=0;//没有访问权限
		File_path file_path = file_pathDAO.getFileByID(fileID);
		File file=new File(FileUploadUtil.getFilePath()+file_path.getPath_name());
		//判断文件是否存在
		User user=userDAO.getUserByID(uid);
		if(file.isFile()&&user!=null){
			int position_id=user.getPosition_id();
			if("admin".equals(user.getName())){
				flag=1;//有权限且文件存在
			}else{
				if(file_path.getType()==1){
					int file_type=file_path.getFile_type();
					if(file_type==3){
						if(permissionsDAO.checkPermission(position_id, 13)){//查看项目配置单
							flag=1;//有权限且文件存在
						}
					}else{
						flag=1;//有权限且文件存在,能点进来，说明就能看
					}
				}else{
					flag=1;//有权限且文件存在
				}
			}
		}else{
			flag=2;//文件不存在
		}
		return flag;
	}
	@Override
	public Flow getFlowByOperation(int type,int foreign_id,int operation){
		// TODO Auto-generated method stub
		Flow flow=new Flow();
		flow.setOperation(operation);
		flow.setForeign_id(foreign_id);
		flow.setType(type);
		return flowDAO.getFlowByOperation(flow);
	}
	@Override
	public void deleteByPerformanceOP(int foreign_id) {
		// TODO Auto-generated method stub
		flowDAO.deleteByPerformanceOP(foreign_id);
	}
	@Override
	public void updateFlowOperation(Flow flow) {
		// TODO Auto-generated method stub
		flowDAO.updateFlowOperation(flow);
	}
	@Override
	public void updateFlowOperationByFid(int id) {
		// TODO Auto-generated method stub
		flowDAO.updateFlowOperationByFid(id);
	}
	@Override
	public void alertTaskProjectFileSendEmail(int task_id) {
		// TODO Auto-generated meth;od stub
		Task task=taskDAO.getTaskByID(task_id);
		if(task!=null){
			sendMail(3,1,null,new StringBuilder().append("请注意，项目任务单（").append(task.getProject_name())
					.append("）项目材料配置单已经更改( 注：以最新上传为准 )。").toString(),false);
		}
	}
	
	//任务单完成之后 修改备注信息需要发送消息给审核人
	@Override
	public void alertRemarksSendEmail(int uid,int task_id,String project_name) {
		// TODO Auto-generated method stub
		List<Flow> pre_flowList=flowDAO.getFlowListByCondition(1,task_id);
		HashSet<Integer> UIDSet =   new HashSet<Integer>();//移除重复的用户
		for (Flow pre_flow : pre_flowList) {
			if(uid!=pre_flow.getUid() && pre_flow.getUid()>0){
				UIDSet.add(pre_flow.getUid());
			}
		}
		int order_uid;
		Iterator iterator=UIDSet.iterator();
		while (iterator.hasNext()) {
			order_uid = ((Integer) iterator.next()).intValue();
			sendMail(uid,1,userDAO.getUserByID(order_uid),new StringBuilder().append("项目任务单（").append(project_name)
					.append("）创建人更改了备注信息。").toString(),true);
		}
	}

	/**
	 * 根据foreign_id获取所有流程中所有相关的人
	 *
	 * @param foreign_id project_procurement的主键
	 * @return
	 */
	@Override
	public List<Integer> getUidByForeignId(int foreign_id) {

		return flowDAO.getUidByForeign(foreign_id);
	}


}
