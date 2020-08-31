package com.zzqa.pojo.performance_content;
/***
 * 考核项
 * @author Administrator
 *
 */
public class Performance_content {
	private int id;
	private int p_id;
	private String target;
	private String plain;
	private float weight;
	private float weight_self;
	private float weight_leader;
	private String situation;
	private String score_self;//自评
	private String score_leader;//终评
	private String assessor;//考核人
	public String getAssessor() {
		return assessor;
	}
	public void setAssessor(String assessor) {
		this.assessor = assessor;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getP_id() {
		return p_id;
	}
	public void setP_id(int p_id) {
		this.p_id = p_id;
	}
	public String getTarget() {
		return target;
	}
	public void setTarget(String target) {
		this.target = target;
	}
	public String getPlain() {
		return plain;
	}
	public void setPlain(String plain) {
		this.plain = plain;
	}
	public float getWeight() {
		return weight;
	}
	public void setWeight(float weight) {
		this.weight = weight;
	}
	public float getWeight_self() {
		return weight_self;
	}
	public void setWeight_self(float weight_self) {
		this.weight_self = weight_self;
	}
	public float getWeight_leader() {
		return weight_leader;
	}
	public void setWeight_leader(float weight_leader) {
		this.weight_leader = weight_leader;
	}
	public String getSituation() {
		return situation;
	}
	public void setSituation(String situation) {
		this.situation = situation;
	}
	public String getScore_self() {
		return score_self;
	}
	public void setScore_self(String score_self) {
		this.score_self = score_self;
	}
	public String getScore_leader() {
		return score_leader;
	}
	public void setScore_leader(String score_leader) {
		this.score_leader = score_leader;
	}
}
