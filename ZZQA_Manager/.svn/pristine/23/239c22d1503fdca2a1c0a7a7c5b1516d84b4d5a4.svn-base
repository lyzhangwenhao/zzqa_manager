package com.zzqa.dao.interfaces.feedback;

import java.util.List;
import java.util.Map;

import com.zzqa.pojo.feedback.Feedback;

public interface IFeedbackDAO {
	public Feedback getFeedbackByID(int id);
	public void insertFeedback(Feedback feedback);
	public void delFeedbackByID(int id);
	public  void updateFeedback(Feedback feedback);
	/*****
	 * 
	 * @param map create_id nowpage(从第几条开始)
	 * @return
	 */
	public List getFeedbackListByCondition(Map map);
	public int getFeedbackCountByCondition(int create_id);
	public int getNewFeedbackIDByCreateID(int create_id);
	/****
	 * map-key:create_id
	 * @param map
	 * @return
	 */
	public List getNotReadReplyFeedbackList(Map map);
}
