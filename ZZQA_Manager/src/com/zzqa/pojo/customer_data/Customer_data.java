package com.zzqa.pojo.customer_data;
/***
 * 客户资料表
 * @author louph
 *
 */
public class Customer_data {
	private String customer_id;//客户编码，K001...（供应商编码用G001...）
	private int type;//类型1：客户；2：供应商
	private String company_name;//单位名称
	private String company_address;//单位地址
	private String postal_code;//邮政编码
	private String law_person;//法人代表
	private String entrusted_agent;//委托代理人
	private String phone;//电话
	private String fax;//传真
	private String bank;//开户行
	private String company_account;//公司账户
	private String tariff_item;//税号
	public String getCustomer_id() {
		return customer_id;
	}
	public void setCustomer_id(String customer_id) {
		this.customer_id = customer_id;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String getCompany_name() {
		return company_name;
	}
	public void setCompany_name(String company_name) {
		this.company_name = company_name;
	}
	public String getCompany_address() {
		return company_address;
	}
	public void setCompany_address(String company_address) {
		this.company_address = company_address;
	}
	public String getPostal_code() {
		return postal_code;
	}
	public void setPostal_code(String postal_code) {
		this.postal_code = postal_code;
	}
	public String getLaw_person() {
		return law_person;
	}
	public void setLaw_person(String law_person) {
		this.law_person = law_person;
	}
	public String getEntrusted_agent() {
		return entrusted_agent;
	}
	public void setEntrusted_agent(String entrusted_agent) {
		this.entrusted_agent = entrusted_agent;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getFax() {
		return fax;
	}
	public void setFax(String fax) {
		this.fax = fax;
	}
	public String getBank() {
		return bank;
	}
	public void setBank(String bank) {
		this.bank = bank;
	}
	public String getCompany_account() {
		return company_account;
	}
	public void setCompany_account(String company_account) {
		this.company_account = company_account;
	}
	public String getTariff_item() {
		return tariff_item;
	}
	public void setTariff_item(String tariff_item) {
		this.tariff_item = tariff_item;
	}
}
