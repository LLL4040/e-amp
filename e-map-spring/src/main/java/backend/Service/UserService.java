package backend.Service;

import backend.Entity.Admin;
import backend.Entity.Friend;
import backend.Entity.User;
import backend.Repository.AdminRepository;
import backend.Repository.FriendRepository;
import backend.Repository.UserRepository;
import net.minidev.json.JSONArray;
import net.minidev.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private AdminRepository adminRepository;

    @Autowired
    private FriendRepository friendRepository;

    public JSONObject register(String name, String phone, String password) {
        JSONObject object = new JSONObject();
        if(name == null || password == null) {
            object.put("status", 0);
            object.put("message", "用户名和密码不能为空！");
            return object;
        }
        if(userRepository.existsByName(name)) {
            object.put("status", 0);
            object.put("message", "用户名已被占用！");
            return object;
        }
        User user = new User(name, phone, password);
        userRepository.save(user);
        object.put("status", 1);
        object.put("message", "注册成功！");
        return object;
    }

    public JSONObject login(String name, String password) {
        JSONObject object = new JSONObject();
        if(name == null || password == null) {
            object.put("status", 0);
            object.put("message", "登录失败！");
            return object;
        }
        if(!userRepository.existsByName(name)) {
            object.put("status", 0);
            object.put("message", "登录失败！");
            return object;
        }
        User user = userRepository.findByName(name);
        if(user.getPassword().equals(password)) {
            object.put("status", 1);
            object.put("message", "登录成功！");
            return object;
        }
        object.put("status", 0);
        object.put("message", "登录失败！");
        return object;
    }

    public JSONObject registerAdmin(String name, String password) {
        JSONObject object = new JSONObject();
        if(name == null || password == null) {
            object.put("status", 0);
            object.put("message", "用户名和密码不能为空！");
            return object;
        }
        if(adminRepository.existsByName(name)) {
            object.put("status", 0);
            object.put("message", "用户名已被占用！");
            return object;
        }
        Admin admin = new Admin(name, password);
        adminRepository.save(admin);
        object.put("status", 1);
        object.put("message", "注册成功！");
        return object;
    }

    public JSONObject loginAdmin(String name, String password) {
        JSONObject object = new JSONObject();
        if(name == null || password == null) {
            object.put("status", 0);
            object.put("message", "登录失败！");
            return object;
        }
        if(!adminRepository.existsByName(name)) {
            object.put("status", 0);
            object.put("message", "登录失败！");
            return object;
        }
        Admin admin = adminRepository.findByName(name);
        if(admin.getPassword().equals(password)) {
            object.put("status", 1);
            object.put("message", "登录成功！");
            return object;
        }
        object.put("status", 0);
        object.put("message", "登录失败！");
        return object;
    }

    public JSONObject getUserMessage(String name) {
        JSONObject object = new JSONObject();
        if(!userRepository.existsByName(name)) {
            object.put("status", 0);
            object.put("message", "用户不存在！");
            return object;
        }
        User user = userRepository.findByName(name);
        object.put("status", 0);
        object.put("experience", user.getExperience());
        object.put("grade", user.getGrade());
        return object;
    }

    public JSONArray getFriendList(String name) {
        JSONArray result = new JSONArray();
        List<Friend> friends = friendRepository.findAllByFriend1(name);
        for(Friend friend : friends) {
            JSONObject object = new JSONObject();
            object.put("name", friend.getFriend2());
            result.add(object);
        }
        return result;
    }

    public JSONObject addFriend(String name, String friend) {
        JSONObject object = new JSONObject();
        if(name == null || friend == null) {
            object.put("status", 0);
            object.put("message", "请输入用户名和好友名！");
            return object;
        }
        if(!userRepository.existsByName(name) || !userRepository.existsByName(friend)) {
            object.put("status", 0);
            object.put("message", "用户不存在！");
            return object;
        }
        Friend friend1 = new Friend(name, friend);
        friendRepository.save(friend1);
        Friend friend2 = new Friend(friend, name);
        friendRepository.save(friend2);
        object.put("status", 1);
        object.put("message", "添加好友成功！");
        return object;
    }
}
