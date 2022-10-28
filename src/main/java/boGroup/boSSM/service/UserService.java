package boGroup.boSSM.service;

import boGroup.boSSM.Utility;
import boGroup.boSSM.mapper.UserMapper;
import boGroup.boSSM.model.UserModel;
import boGroup.boSSM.model.UserRole;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;

@Service
public class UserService {
    UserMapper mapper;

    public UserService(UserMapper mapper) {
        // 依赖注入: Spring 自动 new 一个 UserMapper 接口的实例 mapper 传入 UserService 的构造函数
        this.mapper = mapper;
    }

    @Transactional
    public UserModel add(String username, String password, String email) {
        UserModel m = new UserModel();
        m.setUsername(username);
        m.setPassword(password);
        m.setRole(UserRole.normal);
        m.setEmail(email);
        m.setRegistrationTime(Utility.formattedTime(System.currentTimeMillis() / 1000L));

//        Utility.log("m before insert id %s", m.getId());    // id = null
        mapper.insert(m);
//        Utility.log("m after insert id %s", m.getId());     // id = 数据库取回的id
        return m;
    }

    @Transactional
    public void deleteById(Integer id) {
        mapper.delete(id);
    }

    // 更新信息
    @Transactional
    public void update(Integer id, String site, String location, String github, String note) {
        UserModel m = new UserModel();
        m.setId(id);
        m.setSite(site);
        m.setLocation(location);
        m.setGithub(github);
        m.setNote(note);
        mapper.update(m);
    }

    // 更新头像
    @Transactional
    public void updateAvatar(Integer id, String avatar) {
        UserModel m = new UserModel();
        m.setId(id);
        m.setAvatar(avatar);
        mapper.updateAvatar(m);
    }

    // 更新密码
    @Transactional
    public void updatePassword(Integer id, String password) {
        UserModel m = new UserModel();
        m.setId(id);
        m.setPassword(password);
        mapper.updatePassword(m);
    }

    // 根据 id 查询用户
    public  UserModel findById(Integer id) {
        return mapper.selectOneById(id);
    }

    // 根据 username 查询用户
    public  UserModel findByUsername(String username) {
        return mapper.selectOneByUsername(username);
    }

    // 查询所有用户
    public  ArrayList<UserModel> all() {
        return mapper.selectAll();
    }

    // 登录验证
    public Boolean loginAuthentication (String username, String password) {
        // 根据输入的用户名在数据库中查找该用户
        UserModel u = findByUsername(username);
        // 不存在该用户
        if (u == null) {
            Utility.log("[登录验证]: 数据库不存在用户名为 %s 的用户", username);
            return false;
        }

        // 存在该用户 密码验证
        if (u.getPassword().equals(password)) {
            Utility.log("[登录验证]: 数据库存在该用户 密码正确");
            return true;
        } else {
            Utility.log("[登录验证]: 数据库存在该用户 密码错误");
            return false;
        }
    }

    // 获取当前用户
    public UserModel currentUser (HttpServletRequest request) {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("user_id");

        if (userId == null) {
            Utility.log("[currentUser] 获取当前用户: session 中不存在用户");
            // 也可以用 return guest();
            return this.guest();
        }

        UserModel u = findById(userId);
        if (u == null) {
            Utility.log("[currentUser] 获取当前用户: session 中存在但数据库不存在用户 %s", userId);
            // 也可以用 return guest();
            return this.guest();

        } else {
            Utility.log("[currentUser] 获取当前用户: 数据库存在用户 %s", userId);
            return u;
        }
    }

    // 生成游客用户
    public UserModel guest() {
        UserModel guest = new UserModel();
        guest.setId(-1);
        guest.setUsername("游客");
        guest.setPassword("");
        guest.setRole(UserRole.guest);
        guest.setEmail("");
        guest.setRegistrationTime("");
        guest.setAvatar("guest.jpg");
        guest.setScore(0);

        return guest;
    }

    // 积分榜前 limit 位
    public ArrayList<UserModel> rankingUsers (Integer limit) {
        return mapper.rankingUsers(limit);
    }
}
