package top.naccl.model.vo;

import lombok.Data;

/**
 * @Description cdn文件信息
 * @Author 故人听雨
 * @Date 2022/4/26 0:33
 * @Version 1.0
 */
@Data
public class CdnFileInfo {

    private String key;

    private String url;

    private Long fileSize;

    private String hash;

    private String mimeType;

}
