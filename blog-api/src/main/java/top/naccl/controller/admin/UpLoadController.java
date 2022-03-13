package top.naccl.controller.admin;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import top.naccl.model.vo.Result;
import top.naccl.util.qiniu.QinIuService;

import java.io.IOException;

/**
 * @Description 文件上传
 * @Author 故人听雨
 * @Date 2022/3/13 23:30
 * @Version 1.0
 */
@Slf4j
@RestController
@RequestMapping("admin/upload")
public class UpLoadController {

    @Autowired
    private QinIuService qinIuService;

    @PostMapping("/file/qiniu")
    public Result uploadQiNiu(@RequestBody MultipartFile file){

        String url = null;
        try {
            url = qinIuService.uploadImage(file);
        } catch (IOException e) {
            log.error("七牛云文件上传失败..[{}]",e.getMessage());
        }
        return Result.ok("success",url);
    }





}
