package com.zzqa.dao.interfaces.user;

import java.util.List;

import com.zzqa.pojo.user.User;

public interface IUserDAO {
	/**
     * 登陆服务，传入用户名与密码即可
     *
     * @param username 用户名
     * @param password 密码
     */
	public User log(User user);
	//查询用户是否存在
    public boolean checkName(String name);
    //获取所有用户
	public List<User> getAllUserOrderByLevel();
	//按条件搜索用户
	public List<User> getUserListByKeywords(String keywords);
	//根据ID查找用户
    public User getUserByID(int id);
    //通过昵称查找用户
    public User getUserByName(String name);
    //根据ID删除用户
    public void delUserByID(int id);
    //添加用户 管理员用户调用时可以指定level值
    public void insertUser(User user);
    //修改账户
    public void updateUser(User user);
    //返回不同职位的用户
    public List<User> getUserListByPositionID(int position_id);
    //返回不同权限的用户
    public List<User> getUserListByLevel(int level);
    //返回有指定权限的用户
    public List<User> getUserListByPermissionsID(int permissions_id);
    //返回领导
    public List<User> getParentListByChildUid(int uid);
    //返回领导
    public List<User> getParentUserByChildPosition(int position_id);
    //返回下级
    public List<Integer> getSonListByParentPosition(int position_id);
    //返回总经理
    public User getTopUser();
    //通过邮箱查询用户
    public User getUserByEmail(String email);
    /***
     * 不存在："用户"+id
     * @param id
     * @return
     */
    public String getUserNameByID(int id);
	public List<User> getSonListByParentUid(int uid);
}
