package boGroup.boSSM.aspect;


import boGroup.boSSM.Utility;
import boGroup.boSSM.model.TopicCommentModel;
import boGroup.boSSM.model.TopicModel;
import boGroup.boSSM.model.UserModel;
import boGroup.boSSM.service.TopicCommentService;
import boGroup.boSSM.service.TopicService;
import boGroup.boSSM.service.UserService;
import com.alibaba.fastjson.JSON;
import jdk.jshell.execution.Util;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletInputStream;
import javax.servlet.http.HttpServletRequest;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.util.Map;
import java.util.Scanner;
import java.util.stream.Collectors;

// 注册切面
@Aspect
// 注册 spring bean
@Component
public class PermissionAspect {
    private final HttpServletRequest request;
    private final UserService userService;
    private final TopicService topicService;
    private final TopicCommentService topicCommentService;

    public PermissionAspect(HttpServletRequest request, UserService userService, TopicService topicService, TopicCommentService topicCommentService) {
        this.request = request;
        this.userService = userService;
        this.topicService = topicService;
        this.topicCommentService = topicCommentService;
    }

    // 匹配所有带有 @LoginRequired 注解的方法
    @Around("@annotation(boGroup.boSSM.aspect.LoginRequired)")
    public ModelAndView loginRequired(ProceedingJoinPoint joint) throws Throwable {
        Utility.log("[loginRequired 正在访问的 url]: %s", request.getRequestURI());
        Utility.log("[loginRequired 正在执行的方法]: %s %s", joint.getSignature(), joint.getArgs());

        String username = userService.currentUser(request).getUsername();
        if (username.equals(userService.guest().getUsername())) {
            return new ModelAndView("redirect:/");
        }

        // 执行匹配的方法
        return (ModelAndView) joint.proceed();
    }

    @Around("@annotation(boGroup.boSSM.aspect.OwnerRequired)")
    public ModelAndView ownerRequired(ProceedingJoinPoint joint) throws Throwable {
        Utility.log("[ownerRequired 正在访问的 url]: %s", request.getRequestURI());
        Utility.log("[ownerRequired 正在执行的方法]: %s %s", joint.getSignature(), joint.getArgs());

        Integer userID = userService.currentUser(request).getId();

        // 从 URL 或 Body 中读取参数
//        int topicId = Integer.parseInt(request.getParameter("topicId"));

        // 从动态路由中读取参数
        Map<String, String> map = (Map<String, String>) request.getAttribute(HandlerMapping.URI_TEMPLATE_VARIABLES_ATTRIBUTE);
        String topicId = map.get("id");
        TopicModel topic = topicService.findById(Integer.valueOf(topicId));

        // 当前用户 = 话题作者
        if (userID != -1 && userID.equals(topic.getUserId())) {
            return (ModelAndView) joint.proceed();
        }
        return new ModelAndView("redirect:/topic/detail/" + topicId);
    }

    @Around("@annotation(boGroup.boSSM.aspect.CommentOwnerRequired)")
    public ModelAndView commentOwnerRequired(ProceedingJoinPoint joint) throws Throwable {
        Utility.log("[commentOwnerRequired 正在访问的 url]: %s", request.getRequestURI());
        Utility.log("[commentOwnerRequired 正在执行的方法]: %s %s", joint.getSignature(), joint.getArgs());

        Integer userID = userService.currentUser(request).getId();

        // 从动态路由中读取参数
        Map<String, String> map = (Map<String, String>) request.getAttribute(HandlerMapping.URI_TEMPLATE_VARIABLES_ATTRIBUTE);
        String topicCommentId = map.get("id");
        TopicCommentModel topicComment = topicCommentService.findById(Integer.valueOf(topicCommentId));

        // 当前用户 = 创建评论用户
        if (userID != -1 && userID.equals(topicComment.getUserId())) {
            return (ModelAndView) joint.proceed();
        } else {
            return new ModelAndView("redirect:/topic/detail/" + topicComment.getTopicId());
        }
    }
}
