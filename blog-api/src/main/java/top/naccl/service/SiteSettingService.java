package top.naccl.service;

import top.naccl.entity.SiteSetting;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public interface SiteSettingService {
    Map<String, List<SiteSetting>> getList();

    Map<String, Object> getSiteInfo();

    List<String> getBannerList();

    String getWebTitleSuffix();

    void updateSiteSetting(List<LinkedHashMap> siteSettings, List<Integer> deleteIds);

    /**
     * 根据名称查询设置
     *
     * @param name 设置名称
     */
    Map<String, List<SiteSetting>> getSiteInfo(String name);
}
