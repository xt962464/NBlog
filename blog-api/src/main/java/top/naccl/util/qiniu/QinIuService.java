package top.naccl.util.qiniu;

import com.alibaba.fastjson.JSONObject;
import com.qiniu.common.QiniuException;
import com.qiniu.http.Response;
import com.qiniu.storage.BucketManager;
import com.qiniu.storage.Configuration;
import com.qiniu.storage.Region;
import com.qiniu.storage.UploadManager;
import com.qiniu.util.Auth;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.UUID;

/**
 * @description: 七牛云文件服务
 * @author: ※狗尾巴草
 * @date: 2020-08-28 13:38
 **/
@Component
public class QinIuService {

    // 图片允许的后缀扩展名
    private final String[] IMAGE_FILE_EXTD = new String[]{"png", "jpg", "jpeg", "gif"};
    // 设置好账号的ACCESS_KEY和SECRET_KEY
    @Value("${qiniu.ACCESS_KEY}")
    private String ACCESS_KEY;
    @Value("${qiniu.SECRET_KEY}")
    private String SECRET_KEY;
    // 要上传的空间
    @Value("${qiniu.bucketName}")
    private String bucketName;
    @Value("${qiniu.zone}")
    private String zoneStr;

    // 域名
    @Value("${qiniu.url}")
    private String QINIU_IMAGE_DOMAIN;

    private com.qiniu.storage.BucketManager bucketManager = null;

    public QinIuService() {
    }

    public QinIuService(String ak, String sk, String bucketName, String zone, String domain) {
        this.ACCESS_KEY = ak;
        this.SECRET_KEY = sk;
        this.bucketName = bucketName;
        this.zoneStr = zone;
        this.QINIU_IMAGE_DOMAIN = domain;
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
            // 请求失败时打印的异常的信息
//            System.out.println("七牛异常:" + e.getMessage());
        }
        return null;
    }

    //删除图片
    public boolean deleteImg(String imgUrl) throws QiniuException {
        String key = imgUrl.replace(this.QINIU_IMAGE_DOMAIN + "/", "");
        BucketManager bucketManager = this.bucketManager = new BucketManager(getAuth(), getConfiguration());
        bucketManager.delete(this.bucketName, key);
        return false;
    }


}
