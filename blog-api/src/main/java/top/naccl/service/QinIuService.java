package top.naccl.service;

import com.alibaba.fastjson.JSONObject;
import com.qiniu.common.QiniuException;
import com.qiniu.http.Response;
import com.qiniu.storage.BucketManager;
import com.qiniu.storage.Configuration;
import com.qiniu.storage.Region;
import com.qiniu.storage.UploadManager;
import com.qiniu.storage.model.FileInfo;
import com.qiniu.util.Auth;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import top.naccl.entity.SiteSetting;
import top.naccl.model.vo.CdnFileInfo;
import top.naccl.model.vo.Result;
import top.naccl.service.SiteSettingService;

import javax.annotation.PostConstruct;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

/**
 * @description: 七牛云文件服务
 * @author: ※狗尾巴草
 * @date: 2020-08-28 13:38
 **/
@Slf4j
@Component
public class QinIuService {

    @Autowired
    private SiteSettingService siteSettingService;

    // 图片允许的后缀扩展名
    private final String[] IMAGE_FILE_EXTD = new String[]{"png", "jpg", "jpeg", "gif"};
    // 设置好账号的ACCESS_KEY和SECRET_KEY
    private String ACCESS_KEY;
    private String SECRET_KEY;
    // 要上传的空间
    private String bucketName;
    private String zoneStr;

    // 域名
    private String QINIU_IMAGE_DOMAIN;

    private com.qiniu.storage.BucketManager bucketManager = null;

    @PostConstruct
    private void init(){
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
                this.ACCESS_KEY = ak;
                this.SECRET_KEY = sk;
                this.bucketName = name;
                this.zoneStr = zone;
                this.QINIU_IMAGE_DOMAIN = doMain;
                this.bucketManager = new BucketManager(getAuth(), getConfiguration());
            }
        }
    }

    //上传
    private UploadManager getUploadManager() {
        return new UploadManager(getConfiguration());
    }

    private Auth getAuth() {
        return Auth.create(ACCESS_KEY, SECRET_KEY);
    }

    // 配置
    private Configuration getConfiguration() {
        return new Configuration(getRegion());
    }

    // 地区
    private Region getRegion() {
        if ("华东".equals(zoneStr)) {
            return Region.region0();
        } else if ("华北".equals(zoneStr)) {
            return Region.region1();
        } else if ("华南".equals(zoneStr)) {
            return Region.region2();
        } else if ("北美".equals(zoneStr)) {
            return Region.regionNa0();
        } else if ("东南亚".equals(zoneStr)) {
            return Region.regionAs0();
        }
        return Region.autoRegion();
    }

    /**
     * @param fileName
     * @description: 检查文件后缀
     * @return:
     * @author: 小谭
     * @time: 2020-08-28 13:39
     */
    private boolean isFileAllowed(String fileName) {
        for (String ext : IMAGE_FILE_EXTD) {
            if (ext.equals(fileName)) {
                return true;
            }
        }
        return false;
    }

    //token
    private String getUpToken() {
        return getAuth().uploadToken(bucketName);
    }

    //上传图片
    public String uploadImage(MultipartFile file) throws IOException {
        try {
            int dotPos = file.getOriginalFilename().lastIndexOf(".");
            if (dotPos < 0) {
                return null;
            }
            String fileExt = file.getOriginalFilename().substring(dotPos + 1).toLowerCase();
            // 判断是否是合法的文件后缀
            if (!isFileAllowed(fileExt)) {
                return null;
            }
            String fileName = UUID.randomUUID().toString().replaceAll("-", "") + "." + fileExt;

            // 调用put方法上传
            Response res = getUploadManager().put(file.getBytes(), fileName, getUpToken());
            // 打印返回的信息
            if (res.isOK() && res.isJson()) {
                // 返回这张存储照片的地址
                return QINIU_IMAGE_DOMAIN + "/" + JSONObject.parseObject(res.bodyString()).get("key");
            } else {
                System.out.println("七牛异常:" + res.bodyString());
                return null;
            }
        } catch (QiniuException e) {
//             请求失败时打印的异常的信息
            System.out.println("七牛异常:" + e.getMessage());
        }
        return null;
    }

    //删除图片
    public boolean deleteFile(String imgUrl) {
        try {
            if (StringUtils.isNotBlank(imgUrl) && this.bucketManager != null) {
                String key = imgUrl.replace(this.QINIU_IMAGE_DOMAIN + "/", "");
                this.bucketManager.delete(this.bucketName, key);
                log.info("删除七牛云文件成功: [{}]", imgUrl);
                return true;
            }
        } catch (QiniuException e) {
            log.error("删除七牛云文件失败: url:[{}],msg:[{}]", imgUrl, e.getMessage());
        }
        return false;
    }


    public List<CdnFileInfo> getFileList(Integer index, Integer limit) {
        if(bucketManager == null){
            log.warn("七牛云未初始化.....");
            return new ArrayList<>();
        }
        //文件名前缀
        String prefix = "";
        //每次迭代的长度限制，最大1000，推荐值 1000
        if (limit == null) {
            limit = 50;
        }
        if (index == null) {
            index = 1;
        }
        //指定目录分隔符，列出所有公共前缀（模拟列出目录效果）。缺省值为空字符串
        String delimiter = "";
        //列举空间文件列表
        BucketManager.FileListIterator fileListIterator = bucketManager.createFileListIterator(bucketName, prefix, limit, delimiter);
        List<CdnFileInfo> list = new ArrayList<>();
        int i = 1;
        while (fileListIterator.hasNext()) {
            //处理获取的file list结果
            FileInfo[] items = fileListIterator.next();
            if (i == index) {
                for (FileInfo item : items) {
                    CdnFileInfo fileInfo = new CdnFileInfo();
                    fileInfo.setKey(item.key);
                    fileInfo.setUrl(this.QINIU_IMAGE_DOMAIN + "/" + item.key);
                    fileInfo.setFileSize(item.fsize);
                    fileInfo.setHash(item.hash);
                    fileInfo.setMimeType(item.mimeType);
                    list.add(fileInfo);
                }
                break;
            }
            i++;
        }
        return list;
    }
}
