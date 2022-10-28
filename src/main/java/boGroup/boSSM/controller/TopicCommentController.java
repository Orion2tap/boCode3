package boGroup.boSSM.controller;

import boGroup.boSSM.aspect.CommentOwnerRequired;
import boGroup.boSSM.model.UserModel;
import boGroup.boSSM.service.TopicCommentService;
import boGroup.boSSM.service.UserService;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

import static boGroup.boSSM.controller.TopicController.detailMap;

@Controller
public class TopicCommentController {

    private final TopicCommentService topicCommentService;
    private final HttpServletRequest request;
    private final UserService userService;

    // 构造函数
    public TopicCommentController(TopicCommentService topicCommentService, HttpServletRequest request, UserService userService) {
        // 依赖注入
        this.topicCommentService = topicCommentService;
        this.request = request;
        this.userService = userService;
    }

    // 添加评论
    @PostMapping("/topicComment/add/{topicId}")
    public ModelAndView add(@PathVariable String topicId, String content, String csrfToken) {
        UserModel u = userService.currentUser(request);
        String rightToken = detailMap.get(u.getId());

        if (csrfToken.equals(rightToken)) {
            topicCommentService.add(content, topicId , u.getId());
            return new ModelAndView("redirect:/topic/detail/" + topicId);
        }
        return new ModelAndView("redirect:/");
    }

    // 删除评论
    @GetMapping("/topicComment/delete/{id}")
    @CommentOwnerRequired
    public ModelAndView delete(@PathVariable Integer id) {
        UserModel u = userService.currentUser(request);

        // 先通过评论 id 获得 topicId, 再删除评论
        Integer topicId = topicCommentService.findById(id).getTopicId();
        topicCommentService.delete(id);

        return new ModelAndView("redirect:/topic/detail/" + topicId);
    }
}
