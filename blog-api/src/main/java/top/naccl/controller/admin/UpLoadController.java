package top.naccl.controller.admin;

import com.alibaba.fastjson.JSONObject;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.collections4.MapUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import top.naccl.entity.SiteSetting;
import top.naccl.model.vo.CdnFileInfo;
import top.naccl.model.vo.Result;
import top.naccl.service.SiteSettingService;
import top.naccl.util.qiniu.QinIuService;

import java.io.IOException;
import java.util.List;
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
    SiteSettingService siteSettingService;

    @PostMapping("qiniu/upload")
    public Result uploadQiNiu(@RequestBody MultipartFile file) {
        String url = null;
        try {
            Map<String, List<SiteSetting>> siteInfo = siteSettingService.getSiteInfo("qiniu");
            List<SiteSetting> siteSettings = siteInfo.get("qiniu");
            if (siteSettings.size() > 0) {
                SiteSetting setting = siteSettings.get(0);
                if (StringUtils.isNoneBlank(setting.getValue())) {
                    JSONObject object = JSONObject.parseObject(setting.getValue());
                    String ak = object.getString("ak");
                    String sk = object.getString("sk");
                    String zone = object.getString("region");
                    String name = object.getString("name");
                    String doMain = object.getString("doMain");
                    QinIuService qinIuService = new QinIuService(ak, sk, name, zone, doMain);
                    url = qinIuService.uploadImage(file);
                }
            } else {
                return Result.error("cdn配置为空");
            }
        } catch (IOException e) {
            log.error("七牛云文件上传失败..[{}]", e.getMessage());
        }
        return Result.ok("上传成功", url);
    }

    @PostMapping("/qiniu/del")
    public Result delFileQiniu(@RequestBody Map<String, String> map) {
        String url = map.get("url");
        Map<String, List<SiteSetting>> siteInfo = siteSettingService.getSiteInfo("qiniu");
        List<SiteSetting> siteSettings = siteInfo.get("qiniu");
        if (siteSettings.size() > 0) {
            SiteSetting setting = siteSettings.get(0);
            if (StringUtils.isNoneBlank(setting.getValue())) {
                JSONObject object = JSONObject.parseObject(setting.getValue());
                String ak = object.getString("ak");
                String sk = object.getString("sk");
                String zone = object.getString("region");
                String name = object.getString("name");
                String doMain = object.getString("doMain");
                QinIuService qinIuService = new QinIuService(ak, sk, name, zone, doMain);
                if (!qinIuService.deleteFile(url)) {
                    log.error("删除七牛云文件失败: url:[{}]", url);
                    return Result.error("删除失败");
                }
            }
        } else {
            log.warn("七牛云cdn配置为空");
            return Result.error("cdn配置为空");
        }
        return Result.ok();
    }

    @GetMapping("/qiniu/list")
    public Result fileList(@RequestParam Map<String, Object> map) {
        Map<String, List<SiteSetting>> siteInfo = siteSettingService.getSiteInfo("qiniu");
        List<SiteSetting> siteSettings = siteInfo.get("qiniu");
        if (siteSettings.size() > 0) {
            SiteSetting setting = siteSettings.get(0);
            if (StringUtils.isNoneBlank(setting.getValue())) {
                JSONObject object = JSONObject.parseObject(setting.getValue());
                String ak = object.getString("ak");
                String sk = object.getString("sk");
                String zone = object.getString("region");
                String name = object.getString("name");
                String doMain = object.getString("doMain");
                QinIuService qinIuService = new QinIuService(ak, sk, name, zone, doMain);
                Integer index = MapUtils.getInteger(map, "index", 1);
                Integer limit = MapUtils.getInteger(map, "limit", 50);
                return Result.ok(qinIuService.getFileList(index, limit));
            }
        } else {
            log.warn("七牛云cdn配置为空");
            return Result.error("cdn配置为空");
        }
        return Result.ok();
    }


}
