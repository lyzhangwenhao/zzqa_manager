package com.zzqa.pojo.sales_contract;

import java.util.List;

import com.zzqa.pojo.product_info.Product_info;

/*******
 * 销售合同
 * @author louph
 *
 */
public class Sales_contract {
	private int id;
	private String name;//流程名称
	private String process;//流程进度
	private String project_name;//项目名称
	private long sign_time;//签订时间
	private String sign_date;
	private String contract_no;//销售合同编号
	String saler;//销售人员
	private int payment_method;//付款方式1 2 3
	private String payment_value;
	private String shipping_method;//运输方式
	private String expense_burden;//费用负担
	private String delivery_points;
	private String inspect_time;
	private String service_promise;
	private String company_name1;//供方
	private String company_address1;
	private String postal_code1;
	private String law_person1;
	private String entrusted_agent1;
	private String phone1;
	private String fax1;
	private String bank1;
	private String company_account1;
	private String tariff_item1;
	private String customer_id;//需方id
	private String company_name2;
	private String company_address2;
	private String postal_code2;
	private String law_person2;
	private String entrusted_agent2;
	private String phone2;
	private String fax2;
	private String bank2;
	private String company_account2;
	private String tariff_item2;
	private int create_id;
	private String create_name;
	private int contract_file;//0：有客户合同；1：无
	private long create_time;
	private String create_date;
	private long update_time;
	private String update_date;
	private List<Product_info> product_infos;
	private int purchaseState;//["待批复","已批复","被拒","部分采购","已采购","撤销中","已撤销"];
	public String getSaler() {
		return saler;
	}
	public void setSaler(String saler) {
		this.saler = saler;
	}
	public int getPurchaseState() {
		return purchaseState;
	}
	public void setPurchaseState(int purchaseState) {
		this.purchaseState = purchaseState;
	}
	public List<Product_info> getProduct_infos() {
		return product_infos;
	}
	public void setProduct_infos(List<Product_info> product_infos) {
		this.product_infos = product_infos;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getProcess() {
		return process;
	}
	public void setProcess(String process) {
		this.process = process;
	}
	public String getCustomer_id() {
		return customer_id;
	}
	public int getContract_file() {
		return contract_file;
	}
	public void setContract_file(int contract_file) {
		this.contract_file = contract_file;
	}
	public void setCustomer_id(String customer_id) {
		this.customer_id = customer_id;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getProject_name() {
		return project_name;
	}
	public void setProject_name(String project_name) {
		this.project_name = project_name;
	}
	public long getSign_time() {
		return sign_time;
	}
	public void setSign_time(long sign_time) {
		this.sign_time = sign_time;
	}
	public String getSign_date() {
		return sign_date;
	}
	public void setSign_date(String sign_date) {
		this.sign_date = sign_date;
	}
	public String getContract_no() {
		return contract_no;
	}
	public void setContract_no(String contract_no) {
		this.contract_no = contract_no;
	}
	public int getPayment_method() {
		return payment_method;
	}
	public void setPayment_method(int payment_method) {
		this.payment_method = payment_method;
	}
	public String getPayment_value() {
		return payment_value;
	}
	public void setPayment_value(String payment_value) {
		this.payment_value = payment_value;
	}
	public String getShipping_method() {
		return shipping_method;
	}
	public void setShipping_method(String shipping_method) {
		this.shipping_method = shipping_method;
	}
	public String getExpense_burden() {
		return expense_burden;
	}
	public void setExpense_burden(String expense_burden) {
		this.expense_burden = expense_burden;
	}
	public String getDelivery_points() {
		return delivery_points;
	}
	public void setDelivery_points(String delivery_points) {
		this.delivery_points = delivery_points;
	}
	public String getInspect_time() {
		return inspect_time;
	}
	public void setInspect_time(String inspect_time) {
		this.inspect_time = inspect_time;
	}
	public String getService_promise() {
		return service_promise;
	}
	public void setService_promise(String service_promise) {
		this.service_promise = service_promise;
	}
	public String getCompany_name1() {
		return company_name1;
	}
	public void setCompany_name1(String company_name1) {
		this.company_name1 = company_name1;
	}
	public String getCompany_address1() {
		return company_address1;
	}
	public void setCompany_address1(String company_address1) {
		this.company_address1 = company_address1;
	}
	public String getPostal_code1() {
		return postal_code1;
	}
	public void setPostal_code1(String postal_code1) {
		this.postal_code1 = postal_code1;
	}
	public String getLaw_person1() {
		return law_person1;
	}
	public void setLaw_person1(String law_person1) {
		this.law_person1 = law_person1;
	}
	public String getEntrusted_agent1() {
		return entrusted_agent1;
	}
	public void setEntrusted_agent1(String entrusted_agent1) {
		this.entrusted_agent1 = entrusted_agent1;
	}
	public String getPhone1() {
		return phone1;
	}
	public void setPhone1(String phone1) {
		this.phone1 = phone1;
	}
	public String getFax1() {
		return fax1;
	}
	public void setFax1(String fax1) {
		this.fax1 = fax1;
	}
	public String getBank1() {
		return bank1;
	}
	public void setBank1(String bank1) {
		this.bank1 = bank1;
	}
	public String getCompany_account1() {
		return company_account1;
	}
	public void setCompany_account1(String company_account1) {
		this.company_account1 = company_account1;
	}
	public String getTariff_item1() {
		return tariff_item1;
	}
	public void setTariff_item1(String tariff_item1) {
		this.tariff_item1 = tariff_item1;
	}
	public String getCompany_name2() {
		return company_name2;
	}
	public void setCompany_name2(String company_name2) {
		this.company_name2 = company_name2;
	}
	public String getCompany_address2() {
		return company_address2;
	}
	public void setCompany_address2(String company_address2) {
		this.company_address2 = company_address2;
	}
	public String getPostal_code2() {
		return postal_code2;
	}
	public void setPostal_code2(String postal_code2) {
		this.postal_code2 = postal_code2;
	}
	public String getLaw_person2() {
		return law_person2;
	}
	public void setLaw_person2(String law_person2) {
		this.law_person2 = law_person2;
	}
	public String getEntrusted_agent2() {
		return entrusted_agent2;
	}
	public void setEntrusted_agent2(String entrusted_agent2) {
		this.entrusted_agent2 = entrusted_agent2;
	}
	public String getPhone2() {
		return phone2;
	}
	public void setPhone2(String phone2) {
		this.phone2 = phone2;
	}
	public String getFax2() {
		return fax2;
	}
	public void setFax2(String fax2) {
		this.fax2 = fax2;
	}
	public String getBank2() {
		return bank2;
	}
	public void setBank2(String bank2) {
		this.bank2 = bank2;
	}
	public String getCompany_account2() {
		return company_account2;
	}
	public void setCompany_account2(String company_account2) {
		this.company_account2 = company_account2;
	}
	public String getTariff_item2() {
		return tariff_item2;
	}
	public void setTariff_item2(String tariff_item2) {
		this.tariff_item2 = tariff_item2;
	}
	public int getCreate_id() {
		return create_id;
	}
	public void setCreate_id(int create_id) {
		this.create_id = create_id;
	}
	public String getCreate_name() {
		return create_name;
	}
	public void setCreate_name(String create_name) {
		this.create_name = create_name;
	}
	public long getCreate_time() {
		return create_time;
	}
	public void setCreate_time(long create_time) {
		this.create_time = create_time;
	}
	public String getCreate_date() {
		return create_date;
	}
	public void setCreate_date(String create_date) {
		this.create_date = create_date;
	}
	public long getUpdate_time() {
		return update_time;
	}
	public void setUpdate_time(long update_time) {
		this.update_time = update_time;
	}
	public String getUpdate_date() {
		return update_date;
	}
	public void setUpdate_date(String update_date) {
		this.update_date = update_date;
	}
}
