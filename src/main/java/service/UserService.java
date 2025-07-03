package service;

import java.util.List;

import bean.User;
import dao.UserDao;

public class UserService {
    public boolean registerUser(User user) {
        UserDao dao = new UserDao();
        return dao.registerUser(user);
    }

    public User getUserByEmailOrPhone(String email, String phoneNumber) {
        UserDao dao = new UserDao();
        return dao.getUserByEmailOrPhone(email, phoneNumber);
    }
    
    public User getUserByIdAndPassword(String userId, String password) {
        UserDao dao = new UserDao();
        return dao.getUserByIdAndPassword(userId, password);
    }
    
    public List<User> getAllCustomers() {
		UserDao dao = new UserDao();
		return dao.getAllCustomers();
	}
}
