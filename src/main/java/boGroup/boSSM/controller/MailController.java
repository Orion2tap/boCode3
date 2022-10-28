package boGroup.boSSM.controller;
import boGroup.boSSM.Utility;
import boGroup.boSSM.model.UserModel;
import boGroup.boSSM.service.UserService;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import org.springframework.boot.autoconfigure.mail.MailProperties;
import org.springframework.mail.MailException;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.view.RedirectView;

import java.util.HashMap;
import java.util.UUID;


@Component
class AsyncTask {
    private final MailSender sender;
    private final MailProperties mailProperties;

    public AsyncTask(MailSender sender, MailProperties mailProperties) {
        this.sender = sender;
        this.mailProperties = mailProperties;
    }

    @Async
    public void sendMail(String address, String title, String content) {
        SimpleMailMessage mailMessage = new SimpleMailMessage();
        // 根据 application.properties 的配置获得用户名 (发信人邮箱)
        mailMessage.setFrom(mailProperties.getUsername());
        // 填写收信人邮箱、 邮件标题、 内容
        mailMessage.setTo(address);
        mailMessage.setSubject(title);
        mailMessage.setText(content);
        try {
            sender.send(mailMessage);
        } catch (MailException ex) {
            throw new RuntimeException(ex);
        }
    }
}

@Controller
@RequestMapping("/reset")
public class MailController {
    private final AsyncTask async;
    private final UserService userService;
    HashMap<String, Integer> map = new HashMap<>();

    public MailController(AsyncTask async, UserService userService) {
        this.async = async;
        this.userService = userService;
    }

    @PostMapping("/send")
    @ResponseBody
    public String resetSend(@RequestParam String username) {
        UserModel u = userService.findByUsername(username);

        if (u != null) {
            // 生成随机 token, 映射到 username 并保存
            String token = UUID.randomUUID().toString();
            map.put(token, u.getId());

            String email = u.getEmail();
            String title = "重置密码";
//            String content = "<a href=\"http://localhost:8080/reset/view?token=" + token + "\">点此链接重置您的密码</a>";
            String content = "<a href=\"http://119.45.22.158:8080/reset/view?token=" + token + "\">点此链接重置您的密码</a>";

            this.async.sendMail(email, title, content);
            return "发送成功";
        } else {
            return "发送失败 不存在该用户";
        }
    }

    @GetMapping("/view")
    public ModelAndView resetView(String token) {
        Integer userId = map.get(token);

        // 返回 reset.ftl , 加载内置 js, 弹出 modal, 输入新密码, 点击确定,
        // 发请求到 /reset/update 路由并带上 token 和 password
        ModelAndView mv = new ModelAndView("/user/reset");
        mv.addObject("token", token);

        return mv;
    }

    @PostMapping("/update")
    public RedirectView resetUpdate(String token, String password, RedirectAttributes attrs) {
        // 更新密码
        Integer userId = map.get(token);
        userService.updatePassword(userId, password);
        // 自动登录
        UserModel u = userService.findById(userId);
        attrs.addFlashAttribute("username", u.getUsername());
        attrs.addFlashAttribute("password", password);
        // RedirectView 仅支持 get 方法
        return new RedirectView("/user/login");
    }
}


