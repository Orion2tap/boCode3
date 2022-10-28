package boGroup.boSSM.controller;

import boGroup.boSSM.Utility;
import boGroup.boSSM.aspect.LoginRequired;
import boGroup.boSSM.aspect.OwnerRequired;
import boGroup.boSSM.model.*;
import boGroup.boSSM.service.TopicCommentService;
import boGroup.boSSM.service.TopicService;
import boGroup.boSSM.service.UserService;
import com.alibaba.fastjson.JSON;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Controller
@RequestMapping("/topic")
public class TopicController {

    private final TopicService topicService;
    private final TopicCommentService topicCommentService;
    private final UserService userService;
    private final HttpServletRequest request;
    static HashMap<Integer, String> detailMap = new HashMap<>();
    static HashMap<Integer, String> editMap = new HashMap<>();

    // 构造函数
    public TopicController(TopicService topicService, TopicCommentService topicCommentService, UserService userService, HttpServletRequest request) {
        this.topicService = topicService;
        this.topicCommentService = topicCommentService;
        this.userService = userService;
        this.request = request;
    }

    // 发表话题页面
    @LoginRequired
    @GetMapping("/create")
    public ModelAndView createView() {
        UserModel u = userService.currentUser(request);
        String token = UUID.randomUUID().toString();
        detailMap.put(u.getId(), token);

        ArrayList<BoardModel> boards = topicService.allBoards();

        ModelAndView mv = new ModelAndView("/topic/create");
        mv.addObject("boards", boards);
        mv.addObject("token", token);

        return mv;
    }

    // 发表话题
    @PostMapping("/create")
    public ModelAndView create(String title, String content, String boardId, String csrfToken) {
        UserModel u = userService.currentUser(request);
        String rightToken = detailMap.get(u.getId());

        if (csrfToken.equals(rightToken)) {
            // 返回的 topicModel 带有数据库自增 id
            TopicModel t = topicService.add(title, content , u.getId(), Integer.valueOf(boardId));
            return new ModelAndView("redirect:/topic/detail/" + t.getId());
        }
        return new ModelAndView("redirect:/");
    }

    // 话题内容及评论
    @LoginRequired
    @GetMapping("/detail/{id}")
    public ModelAndView detailView(@PathVariable Integer id) {
        UserModel u = userService.currentUser(request);
        String token = UUID.randomUUID().toString();
        detailMap.put(u.getId(), token);

        TopicModel topic = topicService.findByIdWithUserAndBoard(id);
        ArrayList<TopicCommentModel> comments = topicCommentService.findCommentsByTopicId(id);

        // 该用户其他话题
        ArrayList<TopicModel> allCreatedTopics = topicService.allCreatedTopics(u.getId());
        List<TopicModel> otherTopics= allCreatedTopics.stream().filter(t -> (!t.getId().equals(id))).collect(Collectors.toList());
        int limit = Math.min(otherTopics.size(), 5);

        // 无人回复的话题
        ArrayList<TopicModel> noReplyTopics = topicService.noReplyTopics();
        int limit2 = Math.min(noReplyTopics.size(), 5);

        ModelAndView mv = new ModelAndView("topic/detail");
        mv.addObject("u", u);
        mv.addObject("token", token);
        mv.addObject("topic", topic);
        mv.addObject("comments", comments);
        mv.addObject("otherTopics", otherTopics.subList(0, limit));
        mv.addObject("noReplyTopics", noReplyTopics.subList(0, limit2));
        return mv;
    }

    // 编辑话题页面
    @OwnerRequired
    @GetMapping("/edit/{id}")
    public ModelAndView editView(@PathVariable Integer id) {
        UserModel u = userService.currentUser(request);
        String token = UUID.randomUUID().toString();
        editMap.put(u.getId(), token);

        TopicModel topic = topicService.findByIdWithBoard(id);
        ArrayList<BoardModel> boards = topicService.allBoards();

        ModelAndView m = new ModelAndView("topic/edit");
        m.addObject("topic", topic);
        m.addObject("boards", boards);
        m.addObject("token", token);
        return m;
    }

    // 编辑话题
    @OwnerRequired
    @PostMapping("/edit/{id}")
    public ModelAndView edit(@PathVariable Integer id, Integer boardId, String title, String content, String csrfToken) {
        UserModel u = userService.currentUser(request);
        String rightToken = editMap.get(u.getId());

        if (csrfToken.equals(rightToken)) {
            topicService.update(id, boardId, title, content);
            return new ModelAndView("redirect:/topic/detail/" + id);
        }
        return new ModelAndView("redirect:/");
    }

    // 删除话题
    @OwnerRequired
    @GetMapping("/delete/{id}/{csrfToken}")
    public ModelAndView delete(@PathVariable Integer id, @PathVariable String csrfToken) {
        UserModel u = userService.currentUser(request);
        String rightToken = detailMap.get(u.getId());

        if (csrfToken.equals(rightToken)) {
            topicService.delete(id);
            return new ModelAndView("/user/createdtopics/" + u.getUsername());
        }
        return new ModelAndView("redirect:/");
    }

    // 收藏话题
    @PostMapping("/star")
    @ResponseBody
    public String star(@RequestBody String jsonString) {
        UserModel u = userService.currentUser(request);
        Integer topicId = JSON.parseObject(jsonString).getInteger("topicId");

        topicService.star(u.getId(), topicId);
        return "success";
    }

    // 取消收藏
    @PostMapping("/unstar")
    @ResponseBody
    public String unstar(@RequestBody String jsonString) {
        UserModel u = userService.currentUser(request);
        Integer topicId = JSON.parseObject(jsonString).getInteger("topicId");

        topicService.unstar(u.getId(), topicId);
        return "success";
    }

    // 检查收藏
    @PostMapping("/starcheck")
    @ResponseBody
    public String starCheck(@RequestBody String jsonString) {
        UserModel u = userService.currentUser(request);
        Integer topicId = JSON.parseObject(jsonString).getInteger("topicId");

        Integer result = topicService.starCheck(u.getId(), topicId);
        return String.valueOf(result);
    }

    // 指定版块和页数的话题
    @GetMapping("/{boardId}/{page}")
    public ModelAndView pageTopics(@PathVariable Integer boardId, @PathVariable Integer page) {
        UserModel u = userService.currentUser(request);
        ArrayList<BoardModel> boards = topicService.allBoards();

        int limit = 30;                                                          // 显示最新的 30 个话题
        int size;
        int offset = (page - 1) * limit;
        ArrayList<TopicModel> pageTopics;

        if (boardId == 0) {
            size = topicService.allTopics().size();
            pageTopics = topicService.pageTopics(limit, offset);
        } else {
            size = topicService.allTopicsByBoardId(boardId).size();
            pageTopics = topicService.pageTopicsByBoardId(boardId, limit, offset);
        }

        Integer pages = size / limit + (size % limit != 0 ? 1 : 0);
        Utility.log("pages: %s", pages);

        ArrayList<TopicModel> noReplyTopics = topicService.noReplyTopics();
        int limit2 = Math.min(noReplyTopics.size(), 5);                          // 显示最新的 5 个无人回复话题
        int limit3 = 10;                                                         // 显示积分榜前 10
        ArrayList<UserModel> rankingUsers = userService.rankingUsers(limit3);

        ModelAndView mv = new ModelAndView("index");
        mv.addObject("u", u);                                       // 当前用户
        mv.addObject("boardId", String.valueOf(boardId));           // 当前版块
        mv.addObject("page", String.valueOf(page));                 // 当前页
        mv.addObject("boards", boards);                             // 所有版块
        mv.addObject("pages", pages);                               // 所有页
        mv.addObject("pageTopics", pageTopics);
        mv.addObject("noReplyTopics", noReplyTopics.subList(0, limit2));
        mv.addObject("rankingUsers", rankingUsers);

        Utility.log("boardId: %s", boardId);
        Utility.log("page: %s", page);
        Utility.log("pageTopics size: %s", pageTopics.size());

        return mv;
    }

}
