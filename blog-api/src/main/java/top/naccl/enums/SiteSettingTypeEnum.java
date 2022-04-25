package top.naccl.enums;

public enum SiteSettingTypeEnum {

    BASIS("基础设置", 1),
    FOOTER("页脚设置", 2),
    DATACARD("资料卡设置", 3),
    LINKS("友情链接", 4);


    private String desc;

    private Integer type;

    SiteSettingTypeEnum(String desc, Integer type) {
        this.desc = desc;
        this.type = type;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }
}
