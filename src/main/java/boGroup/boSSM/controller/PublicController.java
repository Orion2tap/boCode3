package boGroup.boSSM.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

// 路由类
@Controller
public class PublicController {
    @GetMapping("/")
    public  ModelAndView indexView(){
        // 转发请求: 不改变浏览器 URL
        return new ModelAndView("forward:/topic/0/1");
    }
}
