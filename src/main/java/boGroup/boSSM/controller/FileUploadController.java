package boGroup.boSSM.controller;

import boGroup.boSSM.Utility;
import boGroup.boSSM.model.UserModel;
import boGroup.boSSM.service.UserService;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

@Controller
public class FileUploadController {
    // 本地
//    String dir = "avatar";
    // 服务器
    String dir = "/var/lib/tomcat9/webapps/images";

    private final HttpServletRequest request;
    private final UserService userService;

    public FileUploadController(HttpServletRequest request, UserService userService) {
        this.request = request;
        this.userService = userService;
    }

    @PostMapping("/upload")
    @ResponseBody
    public String singleFileUpload(@RequestParam MultipartFile file) {
            if (file.isEmpty()) {
            return "upload error";
        } else {
            String path = "";
//            path = String.format("%s/%s", this.dir, file.getOriginalFilename());

            // 本地 avatar/xxx.jpg
            // 服务器 /var/lib/tomcat9/webapps/images/xxx.jpg
            // 用户名作为头像文件名存储
            UserModel u = userService.currentUser(request);
            String avatar = u.getUsername() + ".jpg";

            // 设置 avatar 属性
            userService.updateAvatar(u.getId(), avatar);

            path = String.format("%s/%s", this.dir, avatar);
            // 使用 FileOutputStream 将 file 的数据写入 path 对应的文件
            try(FileOutputStream os = new FileOutputStream(path)) {
                byte[] bytes = file.getBytes();
                os.write(bytes);;
                return "upload success";
            } catch (IOException e) {
                e.printStackTrace();
                return "upload success";
            }
        }
    }

    // 非 static 目录下的图片加载
    @GetMapping("/avatar/{imageName}")
    @ResponseBody
    // 因为图片是二进制数据 返回值类型为 ResponseEntity<byte[]>
    public ResponseEntity<byte[]> avatar(@PathVariable String imageName) {
        String path = String.format("%s/%s", dir, imageName);

        byte[] content;
        try (FileInputStream is = new FileInputStream(path)) {
            content = is.readAllBytes();
        } catch (IOException e) {
            String s = String.format("Load file <%s> error <%s>", path, e);
            throw new RuntimeException(s);
        }

        // 通过链式调用设置: 1. 响应状态码 2. 文件类型 3. body
        return ResponseEntity.ok().
                contentType(MediaType.IMAGE_PNG).
                contentType(MediaType.IMAGE_JPEG).
                body(content);
    }
}
