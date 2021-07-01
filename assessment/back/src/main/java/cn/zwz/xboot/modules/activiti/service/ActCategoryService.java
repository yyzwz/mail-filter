package cn.zwz.xboot.modules.activiti.service;

import cn.zwz.xboot.base.XbootBaseService;
import cn.zwz.xboot.modules.activiti.entity.ActCategory;

import java.util.List;

/**
 * 流程分类接口
 * @author Exrick
 */
public interface ActCategoryService extends XbootBaseService<ActCategory,String> {

    /**
     * 通过父id获取
     * @param parentId
     * @return
     */
    List<ActCategory> findByParentIdOrderBySortOrder(String parentId);

    /**
     * 通过名称模糊搜索
     * @param title
     * @return
     */
    List<ActCategory> findByTitleLikeOrderBySortOrder(String title);
}