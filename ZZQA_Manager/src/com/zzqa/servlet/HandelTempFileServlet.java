package com.zzqa.servlet;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.locks.ReadWriteLock;
import java.util.concurrent.locks.ReentrantReadWriteLock;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import jxl.read.biff.BiffException;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import net.sf.json.JSONArray;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.springframework.web.context.support.WebApplicationContextUtils;

import com.zzqa.pojo.customer_data.Customer_data;
import com.zzqa.pojo.file_path.File_path;
import com.zzqa.pojo.leave.Leave;
import com.zzqa.pojo.materials_info.Materials_info;
import com.zzqa.pojo.operation.Operation;
import com.zzqa.pojo.procurement.Procurement;
import com.zzqa.pojo.travel.Travel;
import com.zzqa.service.interfaces.customer_data.Customer_dataManager;
import com.zzqa.service.interfaces.file_path.File_pathManager;
import com.zzqa.service.interfaces.leave.LeaveManager;
import com.zzqa.service.interfaces.materials_info.Materials_infoManager;
import com.zzqa.service.interfaces.operation.OperationManager;
import com.zzqa.service.interfaces.procurement.ProcurementManager;
import com.zzqa.service.interfaces.travel.TravelManager;
import com.zzqa.util.FileUploadUtil;
import com.zzqa.util.SendMessage;

public class HandelTempFileServlet extends HttpServlet {
	private File_pathManager file_pathManager;
	private ProcurementManager procurementManager;
	private TravelManager travelManager;
	private LeaveManager leaveManager;
	private Materials_infoManager materials_infoManager;
	private OperationManager operationManager;
	private Customer_dataManager customer_dataManager;
	
	public static final ReadWriteLock lock = new ReentrantReadWriteLock(false);

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		resp.setCharacterEncoding("utf-8");
		String type = req.getParameter("type");
		HttpSession session = req.getSession();
		Object uidObj = session.getAttribute("uid");
		if (uidObj == null) {
			resp.setContentType("application/text;charset=utf-8");
			resp.setHeader("pragma", "no-cache");
			resp.setHeader("cache-control", "no-cache");
			PrintWriter out = resp.getWriter();
			out.print(3);
			out.flush();
			return;
		}
		int uid = (Integer) uidObj;
		String sessionID = session.getId();
		if ("upload".equals(type)) {
			int file_type = Integer.parseInt(req.getParameter("file_type"));
			int flag = 0;// 表示上传失败
			ServletFileUpload sfu = FileUploadUtil.initFileUpload2();
			try {
				List<FileItem> filelist = sfu.parseRequest(req);
				int fLen = filelist.size();
				flag = cacheFile(uid, sessionID, filelist, file_type);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
				System.out.println("HandelTempFileServlet->upload出错！");
				flag = 0;
			}
			resp.setContentType("application/text;charset=utf-8");
			resp.setHeader("pragma", "no-cache");
			resp.setHeader("cache-control", "no-cache");
			PrintWriter out = resp.getWriter();
			out.print(flag);
			out.flush();
		} else if("upload_communicate".equals(type)){
			int file_type = Integer.parseInt(req.getParameter("file_type"));
			String filename="";//"" 表示上传失败
			ServletFileUpload sfu = FileUploadUtil.initFileUpload2();
			try {
				List<FileItem> filelist = sfu.parseRequest(req);
				int fLen = filelist.size();
				Thread.sleep(1);
				if(cacheFile(uid, sessionID, filelist, file_type)==1){
					filename=filelist.get(0).getName();
				}
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
				System.out.println("HandelTempFileServlet->upload出错！");
			}
			resp.setContentType("application/text;charset=utf-8");
			resp.setHeader("pragma", "no-cache");
			resp.setHeader("cache-control", "no-cache");
			PrintWriter out = resp.getWriter();
			out.print(filename);
			out.flush();
		}else if ("delete".equals(type)) {
			int file_type = Integer.parseInt(req.getParameter("file_type"));
			String file_name = req.getParameter("file");
			Map<String, File_path> map = file_pathManager.getFileMapByKey(Integer.toString(file_type));
			int flag = 0;// 0表示文件不存在
			if (map != null) {
				String key = file_name + 'い' + sessionID;
				File_path file_path = map.get(key);
				if (map.containsKey(key)) {
					map.remove(key);
					flag = 1;
				}
				if (file_path != null) {
					File file = new File(FileUploadUtil.getFilePath()
							+ file_path.getPath_name());
					if (file.isFile() && file.exists()) {
						file.delete();
						flag = 1;
					}
				}
			}
			resp.setContentType("application/text;charset=utf-8");
			resp.setHeader("pragma", "no-cache");
			resp.setHeader("cache-control", "no-cache");
			PrintWriter out = resp.getWriter();
			out.print(flag);
			out.flush();
		} else if ("upload_excel".equals(type)) {
			//excel导入
			String nowFlow=req.getParameter("nowFlow");
			ServletFileUpload sfu = FileUploadUtil.initFileUpload4();
			JSONArray jsonArray = new JSONArray();
			InputStream in;
			if("material_report".equals(nowFlow)){
				// 从Excel导入数据
				int flag = 1;// 0：表示上传失败 1:成功；2：型号有重复；3：不支持该xslx格式；4：没有数据
				try {
					List<FileItem>filelist = sfu.parseRequest(req);
					int fLen = filelist.size();
					in = filelist.get(0).getInputStream();
					Workbook book = Workbook.getWorkbook(in);
					// 获得第一个工作表对象
					Sheet sheet = book.getSheet(0);
					int rownum = sheet.getRows();// 得到行数
					List<Materials_info> list=new ArrayList<Materials_info>();
					Set<String> set=new HashSet<String>();
					for (int i = 1; i < rownum; i++) {// 循环进行读写
						Materials_info materials_info = new Materials_info();
						String model=sheet.getCell(1, i).getContents();
						if(materials_infoManager.getMaterials_infoByModel(model)!=null){
							flag=2;
							break;
						}
						materials_info.setMaterials_id(sheet.getCell(0, i).getContents());
						materials_info.setModel(model);
						materials_info.setRemark(sheet.getCell(2, i).getContents());
						materials_info.setUnit(sheet.getCell(3, i).getContents());
						list.add(materials_info);
						set.add(model);
					}
					if(flag==1&&list.size()!=set.size()){
						flag=2;
					}
					if(flag==1&&list.size()==0){
						flag=4;
					}
					book.close();
					in.close();
					if(flag==1){
						for (Materials_info materials : list) {
							materials_infoManager.insertMaterials_info(materials);
						}
						Operation operation=new Operation();
						operation.setUid(uid);
						operation.setContent("通过excel导入物料信息");
						operation.setCreate_time(System.currentTimeMillis());
						operationManager.insertOperation(operation);
					}
				} catch (FileUploadException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
					flag=0;
					System.out.println("HandelTempFileServlet->upload出错！");
				}catch (BiffException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
					System.out.println("HandelTempFileServlet->book = Workbook.getWorkbook(in);出错！");
					flag=3;
				}
				List list2=new ArrayList<Map<String,Integer>>();
				Map<String,Integer> map=new HashMap<String,Integer>();
				map.put("flag",flag);
				list2.add(map);
				jsonArray=JSONArray.fromObject(list2);
			}else if("customer_report".equals(nowFlow)||"supplier_report".equals(nowFlow)){
				// 从Excel导入数据
				int flag = 1;// 0：表示上传失败 1:成功；2：型号有重复；3：不支持该xslx格式；4：没有数据
				int customer_type="customer_report".equals(nowFlow)?1:2;
				try {
					List<FileItem>filelist = sfu.parseRequest(req);
					int fLen = filelist.size();
					in = filelist.get(0).getInputStream();
					Workbook book = Workbook.getWorkbook(in);
					// 获得第一个工作表对象
					Sheet sheet = book.getSheet(0);
					int rownum = sheet.getRows();// 得到行数
					List<Customer_data> list=new ArrayList<Customer_data>();
					Set<String> set=new HashSet<String>();
					int offset=sheet.getCell(0, 0).getContents().indexOf("编码")==-1?0:1;//第一列为编码是从第二行开始计算
					for (int i = 1; i < rownum; i++) {// 循环进行读写
						Customer_data customer_data=new Customer_data();
						String company_name=sheet.getCell(offset, i).getContents();
						if(customer_dataManager.getCustomer_dataByCName(company_name, customer_type)!=null){
							flag=2;
							break;
						}
						customer_data.setType(customer_type);
						customer_data.setCompany_name(company_name);
						customer_data.setCompany_address(sheet.getCell(1+offset, i).getContents());
						customer_data.setPostal_code(sheet.getCell(2+offset, i).getContents());
						customer_data.setLaw_person(sheet.getCell(3+offset, i).getContents());
						customer_data.setEntrusted_agent(sheet.getCell(4+offset, i).getContents());
						customer_data.setPhone(sheet.getCell(5+offset, i).getContents());
						customer_data.setFax(sheet.getCell(6+offset, i).getContents());
						customer_data.setBank(sheet.getCell(7+offset, i).getContents());
						customer_data.setCompany_account(sheet.getCell(8+offset, i).getContents());
						customer_data.setTariff_item(sheet.getCell(9+offset, i).getContents());
						list.add(customer_data);
						set.add(company_name);
					}
					if(flag==1&&list.size()==0){
						flag=4;
					}
					if(flag==1&&list.size()!=set.size()){
						flag=2;
					}
					book.close();
					in.close();
					if(flag==1){
						for (Customer_data customer : list) {
							customer_dataManager.insertCustomer_data(customer);
						}
						Operation operation=new Operation();
						operation.setUid(uid);
						operation.setContent("通过excel导入"+(customer_type==1?"客户资料":"供应商资料"));
						operation.setCreate_time(System.currentTimeMillis());
						operationManager.insertOperation(operation);
					}
				} catch (FileUploadException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
					flag=0;
					System.out.println("HandelTempFileServlet->upload出错！");
				}catch (BiffException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
					System.out.println("HandelTempFileServlet->book = Workbook.getWorkbook(in);出错！");
					flag=3;
				}
				List list2=new ArrayList<Map<String,Integer>>();
				Map<String,Integer> map=new HashMap<String,Integer>();
				map.put("flag",flag);
				list2.add(map);
				jsonArray=JSONArray.fromObject(list2);
			}else{
				// 从Excel导入采购单数据
				int flag = 0;// 表示上传失败
				try {
					List<FileItem>filelist = sfu.parseRequest(req);
					int fLen = filelist.size();
					in = filelist.get(0).getInputStream();
					Workbook book = Workbook.getWorkbook(in);
					// 获得第一个工作表对象
					Sheet sheet = book.getSheet(0);
					int columnum = sheet.getColumns();// 得到列数
					int rownum = sheet.getRows();// 得到行数
					List<Procurement> list = new ArrayList<Procurement>();
					int[] orderArray={0,1,2,3,4,5,6,7,8};//关联对应位置 值为excel列索引对应表格的列索引
					for (int j = 0; j < columnum; j++) {
						Cell cell = sheet.getCell(j, 0);
						String result = cell.getContents();
						int res_len=result.length();
						if(result.contains("产品名称")){
							orderArray[j]=0;
						}else if(result.contains("品牌/制造商")){
							orderArray[j]=1;
						}else if(result.contains("规格/型号")){
							orderArray[j]=2;
						}else if(result.contains("物料编码")){
							orderArray[j]=3;
						}else if(result.contains("数量")){
							orderArray[j]=4;
						}else if(result.contains("单位")){
							orderArray[j]=5;
						}else if(result.contains("合格率")){
							orderArray[j]=6;
						}else if(result.contains("")){
							orderArray[j]=7;
						}
					}
					SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
					for (int i = 1; i < rownum; i++) {// 循环进行读写
						Procurement procurement = new Procurement();
						for (int j = 0; j < columnum; j++) {
							Cell cell = sheet.getCell(j, i);
							String result = cell.getContents();
							int res_len=result.length();
							switch (orderArray[j]) {
							case 0:
								procurement.setName(result);
								break;
							case 1:
								procurement.setAgent(result);
								break;
							case 2:
								procurement.setModel(result);
								break;
							case 3:
								procurement.setMaterials_code(result);
								break;
							case 4:
								try {
									procurement.setNum(Integer.parseInt(result.substring(0, Math.min(res_len, 10))));
								} catch (NumberFormatException e) {
									// TODO: handle exception
									procurement.setNum(0);// 没有数据时显示0
								}
								break;
							case 5:
								procurement.setUnit(result);
								break;								
							case 6:
								try {
									Float.parseFloat(result);//判断格式是否为浮点型
									procurement.setPercent(result != null ? result.substring(0, Math.min(res_len, 6))
											: "");
								} catch (NumberFormatException e) {
									// TODO: handle exception
									//e.printStackTrace();
									procurement.setPercent("");
								}
								break;
							case 7:
								try {
									sdf.parse(result);//判断时间格式是否正确
									procurement.setAog_date(result);
								} catch (ParseException e) {
									// TODO Auto-generated catch block
									//e.printStackTrace();
									procurement.setAog_date("");
								}
								break;
							default:
								break;
							}
						}
						list.add(procurement);
					}
					jsonArray = JSONArray.fromObject(list);
					book.close();
					in.close();
				} catch (FileUploadException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
					Map<String,Integer> map=new HashMap<String,Integer>();
					System.out.println("HandelTempFileServlet->upload出错！");
				}catch (BiffException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
					System.out.println("HandelTempFileServlet->book = Workbook.getWorkbook(in);出错！");
					Map<String,Integer> map=new HashMap<String,Integer>();
					map.put("flag", 0);
					List list=new ArrayList<Map<String,Integer>>();
					list.add(map);
					jsonArray=JSONArray.fromObject(list);
				}
			}
			resp.setContentType("application/text;charset=utf-8");
			resp.setHeader("pragma", "no-cache");
			resp.setHeader("cache-control", "no-cache");
			PrintWriter out = resp.getWriter();
			out.print(jsonArray);
			out.flush();
		} else if ("export_excel".equals(type)) {
			// 导出到excel
			String flag = "0";// 表示上传失败
			try {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
				flag = System.currentTimeMillis()+"" + uid + ".xls";
				String filePath = FileUploadUtil.getExcelFilePath() + flag;
				File excelFile = new File(filePath);
				if (!excelFile.getParentFile().exists()) {
					excelFile.getParentFile().mkdirs();
				}
				excelFile.createNewFile();
				// 打开文件
				WritableWorkbook book = Workbook.createWorkbook(excelFile);
				// 生成名为“第一页”的工作表，参数0表示这是第一页
				WritableSheet sheet = book.createSheet("第一页", 0);
				// 在Label对象的构造子中指名单元格位置是第一列第一行(0,0)
				// 以及单元格内容为test
				jxl.write.Number number = null;
				Label label = null;
				String excel_data = req.getParameter("excel_data");
				String[] excelArray = excel_data.split("い");
				for (int i = 0; i < excelArray.length; i++) {
					String data = excelArray[i];
					String[] dataArray = data.split("の");
					if (i == 0) {
						sheet.setColumnView(0, 30);
						label = new Label(0, 0, "产品名称");
						sheet.addCell(label);
						sheet.setColumnView(1, 30);
						label = new Label(1, 0, "品牌/制造商");
						sheet.addCell(label);
						sheet.setColumnView(2, 30);
						label = new Label(2, 0, "规格/型号");
						sheet.addCell(label);
						sheet.setColumnView(3, 30);
						label = new Label(3, 0, "物料编码");
						sheet.addCell(label);
						sheet.setColumnView(4, 10);
						label = new Label(4, 0, "数量");
						sheet.addCell(label);
						sheet.setColumnView(5, 10);
						label = new Label(5, 0, "单位");
						sheet.addCell(label);
						if (dataArray.length == 7) {
							sheet.setColumnView(6, 10);
							label = new Label(6, 0, "合格率%");
							sheet.addCell(label);
						}
					}
					for (int j = 0; j < dataArray.length; j++) {
						if (j == 4) {
							// 数量为数字
							number = new jxl.write.Number(j, i + 1,
									Integer.parseInt(dataArray[j]));
							sheet.addCell(number);
						} else if (j == 6) {
							// 合格率为数字
							number = new jxl.write.Number(j, i + 1,
									Double.parseDouble(dataArray[j]));
							sheet.addCell(number);
						} else {
							label = new Label(j, i + 1, dataArray[j]);
							sheet.addCell(label);
						}
					}
				}
				// 写入数据并关闭文件
				book.write();
				book.close();
			} catch (Exception e) {
				flag = "0";
				e.printStackTrace();
			} finally {
				resp.setContentType("application/text;charset=utf-8");
				resp.setHeader("pragma", "no-cache");
				resp.setHeader("cache-control", "no-cache");
				PrintWriter out = resp.getWriter();
				out.print(flag);
				out.flush();
			}
		} else if ("exportexcel_out".equals(type)) {
			// 导出到excel
			String flag = "0";// 表示上传失败
			try {
				flag = System.currentTimeMillis()+""+ uid + ".xls";
				String filePath = FileUploadUtil.getExcelFilePath() + flag;
				File excelFile = new File(filePath);
				if (!excelFile.getParentFile().exists()) {
					excelFile.getParentFile().mkdirs();
				}
				excelFile.createNewFile();
				// 打开文件
				WritableWorkbook book = Workbook.createWorkbook(excelFile);
				// 生成名为“第一页”的工作表，参数0表示这是第一页
				WritableSheet sheet = book.createSheet("第一页", 0);
				// 在Label对象的构造子中指名单元格位置是第一列第一行(0,0)
				// 以及单元格内容为test
				jxl.write.Number number = null;
				Label label = null;
				sheet.setColumnView(0, 30);
				label = new Label(0, 0, "产品名称");
				sheet.addCell(label);
				sheet.setColumnView(1, 30);
				label = new Label(1, 0, "品牌/制造商");
				sheet.addCell(label);
				sheet.setColumnView(2, 30);
				label = new Label(2, 0, "规格/型号");
				sheet.addCell(label);
				sheet.setColumnView(3, 30);
				label = new Label(3, 0, "物料编码");
				sheet.addCell(label);
				sheet.setColumnView(4, 10);
				label = new Label(4, 0, "数量");
				sheet.addCell(label);
				sheet.setColumnView(5, 10);
				label = new Label(5, 0, "单位");
				sheet.addCell(label);
				sheet.setColumnView(6, 15);
				label = new Label(6, 0, "预计时间");
				sheet.addCell(label);
				sheet.setColumnView(7, 15);
				label = new Label(7, 0, "到货时间");
				sheet.addCell(label);
				sheet.setColumnView(8, 10);
				label = new Label(8, 0, "合格率%");
				sheet.addCell(label);
				List<Procurement> list = procurementManager
						.getProcurementListLimit(
								Integer.parseInt(req.getParameter("flowType")),
								Integer.parseInt(req.getParameter("flowID")));
				for (int i = 0; i < list.size(); i++) {
					int row = i + 1;
					Procurement procurement = list.get(i);
					label = new Label(0, row, procurement.getName());
					sheet.addCell(label);
					label = new Label(1, row, procurement.getAgent());
					sheet.addCell(label);
					label = new Label(2, row, procurement.getModel());
					sheet.addCell(label);
					label = new Label(3, row, procurement.getMaterials_code()==null?"":procurement.getMaterials_code());
					sheet.addCell(label);
					// 数量为数字
					number = new jxl.write.Number(4, row, procurement.getNum());
					sheet.addCell(number);
					label = new Label(5, row, procurement.getUnit());
					sheet.addCell(label);
					label = new Label(6, row, procurement.getPredict_date());
					sheet.addCell(label);
					label = new Label(7, row, procurement.getAog_date());
					sheet.addCell(label);
					if (procurement.getPass_percent() > -1) {
						label = new Label(8, row, String.valueOf(procurement
								.getPass_percent()));
						sheet.addCell(label);
					}
				}
				// 写入数据并关闭文件
				book.write();
				book.close();
			} catch (Exception e) {
				flag = "0";
				e.printStackTrace();
			} finally {
				resp.setContentType("application/text;charset=utf-8");
				resp.setHeader("pragma", "no-cache");
				resp.setHeader("cache-control", "no-cache");
				PrintWriter out = resp.getWriter();
				out.print(flag);
				out.flush();
			}
		} else if ("exportreport".equals(type)) {
			// 导出月报表
			String flag = "0";// 表示上传失败
			int flowType = Integer.parseInt(req.getParameter("flowType"));
			int year = Integer.parseInt(req.getParameter("year"));
			int month = Integer.parseInt(req.getParameter("month"));
			flag = System.currentTimeMillis()+""+ uid + ".xls";
			String filePath = FileUploadUtil.getExcelFilePath() + flag;
			File excelFile = new File(filePath);
			if (!excelFile.getParentFile().exists()) {
				excelFile.getParentFile().mkdirs();
			}
			excelFile.createNewFile();
			try {
				if (flowType == 1) {
					// 打开文件
					WritableWorkbook book = Workbook.createWorkbook(excelFile);
					List<Travel> travelList = travelManager
							.getTravelListReport(year, month);
					// 生成名为“第一页”的工作表，参数0表示这是第一页
					WritableSheet sheet = book.createSheet("第一页", 0);
					// 以及单元格内容为test
					jxl.write.Number number = null;
					Label label = null;
					sheet.setColumnView(0, 15);
					label = new Label(0, 0, "部门");
					sheet.addCell(label);
					sheet.setColumnView(1, 15);
					label = new Label(1, 0, "姓名");
					sheet.addCell(label);
					sheet.setColumnView(2, 30);
					label = new Label(2, 0, "出差地点");
					sheet.addCell(label);
					sheet.setColumnView(3, 25);
					label = new Label(3, 0, "开始时间");
					sheet.addCell(label);
					sheet.setColumnView(4, 25);
					label = new Label(4, 0, "结束时间");
					sheet.addCell(label);
					sheet.setColumnView(5, 10);
					label = new Label(5, 0, "天数");
					sheet.addCell(label);
					sheet.setColumnView(6, 50);
					label = new Label(6, 0, "事由");
					sheet.addCell(label);
					int len = travelList.size();
					for (int i = 0; i < len; i++) {
						Travel travel = travelList.get(i);
						int k = i + 1;
						label = new Label(0, k, travel.getDepartment_name());
						sheet.addCell(label);
						label = new Label(1, k, travel.getCreate_name());
						sheet.addCell(label);
						label = new Label(2, k, travel.getAddress().replace(" ", ""));
						sheet.addCell(label);
						label = new Label(3, k, travel.getStartDate().replace("<br/>", "").replace(" ", ""));
						sheet.addCell(label);
						label = new Label(4, k, travel.getEndDate().replace("<br/>", "").replace(" ", ""));
						sheet.addCell(label);
						label = new Label(5, k, travel.getAlldays());
						sheet.addCell(label);
						label = new Label(6, k, travel.getReason());
						sheet.addCell(label);
					}
					book.write();
					if(book!=null){
						book.close();
					}
				} else if (flowType == 2) {
					// 打开文件
					WritableWorkbook book = Workbook.createWorkbook(excelFile);
					List<Leave> leaveList = leaveManager.getLeaveListReport(year, month);
					// 生成名为“第一页”的工作表，参数0表示这是第一页
					WritableSheet sheet = book.createSheet("第一页", 0);
					// 以及单元格内容为test
					jxl.write.Number number = null;
					Label label = null;
					sheet.setColumnView(0, 15);
					label = new Label(0, 0, "部门");
					sheet.addCell(label);
					sheet.setColumnView(1, 15);
					label = new Label(1, 0, "姓名");
					sheet.addCell(label);
					sheet.setColumnView(2, 15);
					label = new Label(2, 0, "请假类型");
					sheet.addCell(label);
					sheet.setColumnView(3, 25);
					label = new Label(3, 0, "开始时间");
					sheet.addCell(label);
					sheet.setColumnView(4, 25);
					label = new Label(4, 0, "结束时间");
					sheet.addCell(label);
					sheet.setColumnView(5, 10);
					label = new Label(5, 0, "天数");
					sheet.addCell(label);
					sheet.setColumnView(6, 50);
					label = new Label(6, 0, "事由");
					sheet.addCell(label);
					int len = leaveList.size();
					for (int i = 0; i < len; i++) {
						Leave leave = leaveList.get(i);
						int k = i + 1;
						label = new Label(0, k, leave.getDepartment_name());
						sheet.addCell(label);
						label = new Label(1, k, leave.getCreate_name());
						sheet.addCell(label);
						label = new Label(2, k, leave.getLeaveType_name());
						sheet.addCell(label);
						label = new Label(3, k, leave.getStartDate().replace("<br/>", ""));
						sheet.addCell(label);
						label = new Label(4, k, leave.getEndDate().replace("<br/>", ""));
						sheet.addCell(label);
						label = new Label(5, k, leave.getAlldays());
						sheet.addCell(label);
						label = new Label(6, k, leave.getReason());
						sheet.addCell(label);
					}
					book.write();
					if(book!=null){
						book.close();
					}
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				flag = "0";
				e.printStackTrace();
			} finally {
				resp.setContentType("application/text;charset=utf-8");
				resp.setHeader("pragma", "no-cache");
				resp.setHeader("cache-control", "no-cache");
				PrintWriter out = resp.getWriter();
				out.print(flag);
				out.flush();
			}
		}else if("exporttrack_out".equals(type)){
			// 导出到excel
			String flag = "0";// 表示上传失败
			try {
				flag = System.currentTimeMillis()+""+ uid + ".xls";
				String filePath = FileUploadUtil.getExcelFilePath() + flag;
				File excelFile = new File(filePath);
				if (!excelFile.getParentFile().exists()) {
					excelFile.getParentFile().mkdirs();
				}
				excelFile.createNewFile();
				// 打开文件
				WritableWorkbook book = Workbook.createWorkbook(excelFile);
				// 生成名为“第一页”的工作表，参数0表示这是第一页
				// 在Label对象的构造子中指名单元格位置是第一列第一行(0,0)
				// 以及单元格内容为test
				String data=req.getParameter("data");
				String[] rowArray=data.split("い");
				WritableSheet sheet = book.createSheet("第一页", 0);
				Label label = null;
				for (int j=0;j<rowArray.length;j++) {
					String[] colArray=rowArray[j].split("の");
					for (int i=0;i<colArray.length;i++) {
						sheet.setColumnView(i, 10);
						label = new Label(i, j, colArray[i]);
						sheet.addCell(label);
					}
				}
				// 写入数据并关闭文件
				book.write();
				book.close();
			} catch (Exception e) {
				flag = "0";
				e.printStackTrace();
			} finally {
				resp.setContentType("application/text;charset=utf-8");
				resp.setHeader("pragma", "no-cache");
				resp.setHeader("cache-control", "no-cache");
				PrintWriter out = resp.getWriter();
				out.print(flag);
				out.flush();
			}
		}else if("exportMaterials".equals(type)){
			String flag = "0";// 表示上传失败
			flag = System.currentTimeMillis()+""+ uid + ".xls";
			String filePath = FileUploadUtil.getExcelFilePath() + flag;
			File excelFile = new File(filePath);
			if (!excelFile.getParentFile().exists()) {
				excelFile.getParentFile().mkdirs();
			}
			excelFile.createNewFile();
			try {
				List<Materials_info> list=materials_infoManager.getMaterials_infos();
				if  (list!=null&&list.size() !=0) {
					// 打开文件
					WritableWorkbook book = Workbook.createWorkbook(excelFile);
					// 生成名为“第一页”的工作表，参数0表示这是第一页
					WritableSheet sheet = book.createSheet("第一页", 0);
					// 以及单元格内容为test
					jxl.write.Number number = null;
					Label label = null;
					sheet.setColumnView(0, 15);
					label = new Label(0, 0, "物料编号");
					sheet.addCell(label);
					sheet.setColumnView(1, 30);
					label = new Label(1, 0, "型号");
					sheet.addCell(label);
					sheet.setColumnView(2, 40);
					label = new Label(2, 0, "产品描述");
					sheet.addCell(label);
					sheet.setColumnView(3, 15);
					label = new Label(3, 0, "单位");
					sheet.addCell(label);
					int k = 0;
					for (Materials_info materials_info : list) {
						k++;
						label = new Label(0, k, materials_info.getMaterials_id());
						sheet.addCell(label);
						label = new Label(1, k, materials_info.getModel());
						sheet.addCell(label);
						label = new Label(2, k, materials_info.getRemark());
						sheet.addCell(label);
						label = new Label(3, k, materials_info.getUnit());
						sheet.addCell(label);
					}
					book.write();
					if(book!=null){
						book.close();
					}
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				flag = "0";
				e.printStackTrace();
			} finally {
				resp.setContentType("application/text;charset=utf-8");
				resp.setHeader("pragma", "no-cache");
				resp.setHeader("cache-control", "no-cache");
				PrintWriter out = resp.getWriter();
				out.print(flag);
				out.flush();
			}
		}else if("exportCustomer".equals(type)){
			String flag = "0";// 表示上传失败
			flag = System.currentTimeMillis()+""+ uid + ".xls";
			int customer_type=Integer.parseInt(req.getParameter("customer_type"));
			String filePath = FileUploadUtil.getExcelFilePath() + flag;
			File excelFile = new File(filePath);
			if (!excelFile.getParentFile().exists()) {
				excelFile.getParentFile().mkdirs();
			}
			excelFile.createNewFile();
			try {
				List<Customer_data> list=customer_dataManager.getCustomer_datas(customer_type);
				if  (list!=null&&list.size() !=0) {
					// 打开文件
					WritableWorkbook book = Workbook.createWorkbook(excelFile);
					// 生成名为“第一页”的工作表，参数0表示这是第一页
					WritableSheet sheet = book.createSheet("第一页", 0);
					// 以及单元格内容为test
					jxl.write.Number number = null;
					Label label = null;
					sheet.setColumnView(0, 15);
					label = new Label(0, 0, customer_type==1?"客户编码":"供应商编码");
					sheet.addCell(label);
					sheet.setColumnView(1, 15);
					label = new Label(1, 0, "单位名称");
					sheet.addCell(label);
					sheet.setColumnView(2, 15);
					label = new Label(2, 0, "单位地址");
					sheet.addCell(label);
					sheet.setColumnView(3, 15);
					label = new Label(3, 0, "邮政编码");
					sheet.addCell(label);
					sheet.setColumnView(4, 15);
					label = new Label(4, 0, "法人代表");
					sheet.addCell(label);
					sheet.setColumnView(5, 15);
					label = new Label(5, 0, "委托代理人");
					sheet.addCell(label);
					sheet.setColumnView(6, 15);
					label = new Label(6, 0, "电话");
					sheet.addCell(label);
					sheet.setColumnView(7, 15);
					label = new Label(7, 0, "传真");
					sheet.addCell(label);
					sheet.setColumnView(8, 15);
					label = new Label(8, 0, "开户银行");
					sheet.addCell(label);
					sheet.setColumnView(9, 15);
					label = new Label(9, 0, "公司账号");
					sheet.addCell(label);
					sheet.setColumnView(10, 15);
					label = new Label(10, 0, "税号");
					sheet.addCell(label);
					int k = 0;
					for (Customer_data customer_data : list) {
						k++;
						label = new Label(0, k, customer_data.getCustomer_id());
						sheet.addCell(label);
						label = new Label(1, k, customer_data.getCompany_name());
						sheet.addCell(label);
						label = new Label(2, k, customer_data.getCompany_address());
						sheet.addCell(label);
						label = new Label(3, k, customer_data.getPostal_code());
						sheet.addCell(label);
						label = new Label(4, k, customer_data.getLaw_person());
						sheet.addCell(label);
						label = new Label(5, k, customer_data.getEntrusted_agent());
						sheet.addCell(label);
						label = new Label(6, k, customer_data.getPhone());
						sheet.addCell(label);
						label = new Label(7, k, customer_data.getFax());
						sheet.addCell(label);
						label = new Label(8, k, customer_data.getBank());
						sheet.addCell(label);
						label = new Label(9, k, customer_data.getCompany_account());
						sheet.addCell(label);
						label = new Label(10, k, customer_data.getTariff_item());
						sheet.addCell(label);
					}
					book.write();
					if(book!=null){
						book.close();
					}
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				flag = "0";
				e.printStackTrace();
			} finally {
				resp.setContentType("application/text;charset=utf-8");
				resp.setHeader("pragma", "no-cache");
				resp.setHeader("cache-control", "no-cache");
				PrintWriter out = resp.getWriter();
				out.print(flag);
				out.flush();
			}
		}
	}

	@Override
	public void init() throws ServletException {
		// TODO Auto-generated method stub
		file_pathManager=(File_pathManager)WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean(
						"file_pathManager");
		procurementManager = (ProcurementManager) WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean(
						"procurementManager");
		travelManager = (TravelManager) WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean(
						"travelManager");
		leaveManager = (LeaveManager) WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean(
						"leaveManager");
		materials_infoManager=(Materials_infoManager)WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean("materials_infoManager");
		operationManager=(OperationManager)WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean("operationManager");
		customer_dataManager=(Customer_dataManager)WebApplicationContextUtils
				.getRequiredWebApplicationContext(getServletContext()).getBean("customer_dataManager");
	}
	//缓存文件
	public int cacheFile(int uid, String sessionID, List<FileItem> fiList,
			int file_type) {
		HandelTempFileServlet.lock.writeLock().lock();
		try {
			long save_time = System.currentTimeMillis();
			Thread.sleep(1);// 防止时间相同
			int length = fiList.size();
			Map<String, File_path> map = file_pathManager.getFileMapByKey(Integer.toString(file_type));
			if (map == null) {
				map = new Hashtable<String, File_path>();
			}
			for (int i = 0; i < length; i++) {
				boolean flag = false;// true表示已存在
				FileItem item = fiList.get(i);
				File_path file_path = new File_path();
				String fileName = item.getName();
				if (fileName == null || "".equals(fileName)) {
					continue;
				}
				if (fileName.length() > 255) {
					return 2;// 2表示文件名太长
				}
				String key = fileName + "い" + sessionID;
				flag = map.containsKey(key);// 用户刷新页面后，之前已上传的临时文件不在重复存储
				int index = fileName.lastIndexOf("/");
				if (index != -1) {
					fileName = fileName.substring(index + 1);
				}
				file_path.setFile_name(fileName);
				int index2 = fileName.lastIndexOf(".");
				if (index2 != -1) {
					String point = fileName.substring(index2);// 后缀名 如：.jpg
					file_path.setPath_name(save_time + point);
				} else {
					return 0;
				}
				String formatString = item.getContentType();
				if (formatString == null) {
					return 0;
				} else if (formatString.contains("image")) {
					file_path.setFormat(1);
				} else {
					file_path.setFormat(2);
				}
				file_path.setUid(uid);
				file_path.setFile_type(file_type);
				file_path.setSize(item.getSize());
				file_path.setCreate_time(save_time);
				File file = new File("D:/");
				if (file.getFreeSpace() < 1024 * 1024 * 1000) {
					String title = "OA办公系统.2 D盘内存预警";
					String tomail1 = "fangxl@windit.com.cn";
					String msg1 = "方偕廉 您好！<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;系统检测到10.100.0.2上的D:内存不满1G，可能影响文件上传，请及时处理。";
					String tomail2 = "louph@windit.com.cn";
					String msg2 = "楼鹏晖 您好！<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;系统检测到10.100.0.2上的D:内存不满1G，可能影响文件上传，请及时处理。";
					SendMessage sendMessage = new SendMessage(title, msg1,
							tomail1);
					new Thread(sendMessage).start();
					sendMessage = new SendMessage(title, msg2, tomail2);
					new Thread(sendMessage).start();
				}
				if (file.getFreeSpace() > 1024 * 1024 * 100) {
					// d:/可用空间不足100M时或同一用户已上传相同文件时不再写入
					item.write(new File(FileUploadUtil.getFilePath()
							+ file_path.getPath_name()));
					item.delete();
					map.put(key, file_path);
				} else {
					return 0;
				}
			}
			file_pathManager.addFileMap(Integer.toString(file_type), map);
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		} finally {
			HandelTempFileServlet.lock.writeLock().unlock();
		}
	}
	

}
