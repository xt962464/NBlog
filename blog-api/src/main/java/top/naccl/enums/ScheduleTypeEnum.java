package top.naccl.enums;

import java.util.ArrayList;
import java.util.List;

/**
 * 定时任务类型
 */
public enum ScheduleTypeEnum {

    ATTENTION_SCHEDULE("ATTENTION_SCHEDULE","通知服务",true),
    SYSTEM_SCHEDULE("SYSTEM_SCHEDULE","系统任务",true);


    public List<ScheduleTypeEnum> list(){
        ScheduleTypeEnum[] enums = ScheduleTypeEnum.values();
        List<ScheduleTypeEnum> list = new ArrayList<>();
        for (ScheduleTypeEnum type : enums){
            if(type.getEnable()){
                list.add(type);
            }
        }
        return list;
    }

    ScheduleTypeEnum(String type, String desc, Boolean enable) {
        this.type = type;
        this.desc = desc;
        this.enable = enable;
    }

    private String type;

    private String desc;

    private Boolean enable;

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }

    public Boolean getEnable() {
        return enable;
    }

    public void setEnable(Boolean enable) {
        this.enable = enable;
    }

}
