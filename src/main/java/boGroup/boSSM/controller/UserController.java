package boGroup.boSSM.controller;

import boGroup.boSSM.Utility;
import boGroup.boSSM.aspect.LoginRequired;
import boGroup.boSSM.model.TopicCommentModel;
import boGroup.boSSM.model.TopicModel;
import boGroup.boSSM.model.UserModel;
import boGroup.boSSM.service.TopicCommentService;
import boGroup.boSSM.service.TopicService;
import boGroup.boSSM.service.UserService;
import com.alibaba.fastjson.JSON;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.UUID;

@Controller
@RequestMapping("/user")
public class UserController {

    private final UserService userService;
    private final TopicService topicService;
    private final HttpServletRequest request;
    static HashMap<Integer, String> tokenMap = new HashMap<>();

    // 构造函数
    public UserController(UserService userService, TopicService topicService, TopicCommentService topicCommentService, HttpServletRequest request) {
        // 依赖注入: 自动 new 一个 topicService 传入
//        this.topicService = new topicService();
        this.userService = userService;
        this.topicService = topicService;
        this.request = request;
    }

    // 用户注册
    @PostMapping("/register")
    public RedirectView add(String username, String password, String email, RedirectAttributes attrs) {
        Utility.log("[register] 用户注册: 用户名[%s] 密码[%s] 邮箱[%s]", username, password, email);
        userService.add(username, password, email);

        // 注册后自动登录, 数据暂存在 session, 重定向后删除
        // 目标方法通过 @ModelAttribute("xxx") 取参数
        attrs.addFlashAttribute("username", username);
        attrs.addFlashAttribute("password", password);
        // RedirectView 仅支持 get 方法
        return new RedirectView("/user/login");
    }

    // 用户登录
    @RequestMapping(value = "/login", method = {RequestMethod.POST, RequestMethod.GET})
    public ModelAndView login(@ModelAttribute("username") String username, @ModelAttribute("password") String password) {
        Utility.log("[login] 用户登录: 用户名[%s] 密码[%s]", username, password);

        if (userService.loginAuthentication(username, password)) {
            UserModel u = userService.findByUsername(username);
            request.getSession().setAttribute("user_id", u.getId());

            return new ModelAndView("redirect:/");
        } else {
            // TODO 用户验证✖
            return new ModelAndView("redirect:/");
        }
    }

    // 退出登录
    @GetMapping("/logout")
    public ModelAndView logout() {
        request.getSession().removeAttribute("user_id");
        return new ModelAndView("redirect:/");
    }

    // 个人主页
    @LoginRequired
    @GetMapping("/homepage/{username}")
    public ModelAndView homepageView(@PathVariable String username) {
        // userId ⇉ user
        UserModel u = userService.findByUsername(username);

        int limit = 5;
        Integer offset = 0;
        ArrayList<TopicModel> latestCreatedTopics = topicService.pageCreatedTopics(u.getId(), limit, offset);
        ArrayList<TopicModel> latestCommentedTopics = topicService.pageCommentedTopics(u.getId(), limit, offset);
        ArrayList<TopicModel> latestStaredTopics = topicService.pageStaredTopics(u.getId(), limit, offset);

        ModelAndView mv = new ModelAndView("user/homepage");
        mv.addObject("latestCreatedTopics", latestCreatedTopics);
        mv.addObject("latestCommentedTopics", latestCommentedTopics);
        mv.addObject("latestStaredTopics", latestStaredTopics);
        mv.addObject("u", u);

        return mv;
    }

    // 用户创建的所有话题
    @LoginRequired
    @GetMapping("/createdtopics/{username}")
    public ModelAndView createdTopics(@PathVariable String username, @RequestParam(required = false, defaultValue = "1") Integer page) {
        // 当前页数 page
        // 用户创建的话题总数 count
        // 总页数 pages = count / 10 + 1
        // 跳过前 offset 行数据, 最多取 limit 行数据
        UserModel u = userService.findByUsername(username);
        int limit = 10;
        Integer offset = (page - 1) * limit;
        // (userId, limit, offset) ⇉ pageCreatedTopics
        ArrayList<TopicModel> pageTopics = topicService.pageCreatedTopics(u.getId(), limit, offset);
        Integer pages = topicService.allCreatedTopics(u.getId()).size() / 10 + 1;

        ModelAndView mv = new ModelAndView("user/createdtopics");
        mv.addObject("u", u);
        mv.addObject("pageTopics", pageTopics);
        mv.addObject("page", page);
        mv.addObject("pages", pages);

        return mv;
    }

    // 用户参与的所有话题
    @LoginRequired
    @GetMapping("/commentedtopics/{username}")
    public ModelAndView commentedTopics(@PathVariable String username, @RequestParam(required = false, defaultValue = "1") Integer page) {
        // 当前页数 page
        // 用户创建的话题总数 count
        // 总页数 pages = count / 10 + 1
        // 跳过前 offset 行数据, 最多取 limit 行数据
        UserModel u = userService.findByUsername(username);
        int limit = 10;
        Integer offset = (page - 1) * limit;
        // (userId, limit, offset) ⇉ pageCommentedTopics
        ArrayList<TopicModel> pageTopics = topicService.pageCommentedTopics(u.getId(), limit, offset);
        Integer pages = topicService.allCommentedTopics(u.getId()).size() / 10 + 1;

        ModelAndView mv = new ModelAndView("user/commentedtopics");
        mv.addObject("u", u);
        mv.addObject("pageTopics", pageTopics);
        mv.addObject("page", page);
        mv.addObject("pages", pages);

        return mv;
    }

    // 用户收藏的所有话题
    @LoginRequired
    @GetMapping("/staredtopics/{username}")
    public ModelAndView staredTopics(@PathVariable String username, @RequestParam(required = false, defaultValue = "1") Integer page) {
        // 当前页数 page
        // 用户收藏的话题总数 count
        // 总页数 pages = count / 10 + 1
        // 跳过前 offset 行数据, 最多取 limit 行数据
        UserModel u = userService.findByUsername(username);
        int limit = 10;
        Integer offset = (page - 1) * limit;
        // (userId, limit, offset) ⇉ pageStaredTopics
        ArrayList<TopicModel> pageTopics = topicService.pageStaredTopics(u.getId(), limit, offset);
        Integer pages = topicService.allStaredTopics(u.getId()).size() / 10 + 1;

        ModelAndView mv = new ModelAndView("user/staredtopics");
        mv.addObject("u", u);
        mv.addObject("pageTopics", pageTopics);
        mv.addObject("page", page);
        mv.addObject("pages", pages);

        return mv;
    }

    // 更新信息
    @PostMapping("/setting")
    public ModelAndView setting(String site, String location, String github, String note, String csrfToken) {
        UserModel u = userService.currentUser(request);
        String rightToken = tokenMap.get(u.getId());

        if (csrfToken.equals(rightToken)) {
            userService.update(u.getId(), site, location, github, note);
            return new ModelAndView("redirect:/user/homepage/" + u.getUsername());
        } else {
            return new ModelAndView("redirect:/");
        }
    }

    // 积分榜
    @LoginRequired
    @GetMapping("/top")
    public ModelAndView topView() {
        UserModel u = userService.currentUser(request);
        int limit = 50;
        ArrayList<UserModel> rankingUsers = userService.rankingUsers(limit);

        ModelAndView mv = new ModelAndView("/user/top");
        mv.addObject("rankingUsers", rankingUsers);
        mv.addObject("u", u);
        return mv;
    }

    // 入门页面
    @LoginRequired
    @GetMapping("/greener")
    public ModelAndView greenerView() {
        UserModel u = userService.currentUser(request);

        ModelAndView mv = new ModelAndView("/user/greener");
        mv.addObject("u", u);
        return mv;
    }

    // 关于页面
    @LoginRequired
    @GetMapping("/about")
    public ModelAndView aboutView() {
        UserModel u = userService.currentUser(request);

        ModelAndView mv = new ModelAndView("/user/about");
        mv.addObject("u", u);
        return mv;
    }

    // 设置页面
    @LoginRequired
    @GetMapping("/setting")
    public ModelAndView settingView() {
        UserModel u = userService.currentUser(request);
        String token = UUID.randomUUID().toString();
        tokenMap.put(u.getId(), token);

        ModelAndView mv = new ModelAndView("/user/setting");
        mv.addObject("u", u);
        mv.addObject("token", token);
        return mv;
    }
}
