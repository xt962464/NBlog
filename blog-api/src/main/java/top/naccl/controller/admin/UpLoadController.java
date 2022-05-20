package top.naccl.controller.admin;

import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.MapUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import top.naccl.model.vo.Result;
import top.naccl.service.QinIuService;

import java.io.IOException;
import java.util.Map;

/**
 * @Description 文件上传/删除服务
 * @Author 故人听雨
 * @Date 2022/3/13 23:30
 * @Version 1.0
 */
@Slf4j
@RestController
@RequestMapping("admin/file")
public class UpLoadController {

    @Autowired
    private QinIuService qinIuService;

    @PostMapping("qiniu/upload")
    public Result uploadQiNiu(@RequestBody MultipartFile file) {
        String url = null;
        try {
            url = qinIuService.uploadImage(file);
        } catch (IOException e) {
            log.error("七牛云文件上传失败..[{}]", e.getMessage());
        }
        return Result.ok("上传成功", url);
    }

    @PostMapping("/qiniu/del")
    public Result delFileQiniu(@RequestBody Map<String, String> map) {
        String url = map.get("url");
        if (!qinIuService.deleteFile(url)) {
            log.error("删除七牛云文件失败: url:[{}]", url);
            return Result.error("删除失败");
        }
        return Result.ok();
    }

    @GetMapping("/qiniu/list")
    public Result fileList(@RequestParam Map<String, Object> map) {
        Integer index = MapUtils.getInteger(map, "index", 1);
        Integer limit = MapUtils.getInteger(map, "limit", 50);
        return Result.ok(qinIuService.getFileList(index, limit));
    }


}
