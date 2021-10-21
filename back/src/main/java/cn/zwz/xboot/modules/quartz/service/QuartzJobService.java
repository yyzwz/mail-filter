package cn.zwz.xboot.modules.quartz.service;

import cn.zwz.xboot.base.XbootBaseService;
import cn.zwz.xboot.modules.quartz.entity.QuartzJob;

import java.util.List;

/**
 * 定时任务接口
 * @author Exrick
 */
public interface QuartzJobService extends XbootBaseService<QuartzJob,String> {

    /**
     * 通过类名获取
     * @param jobClassName
     * @return
     */
    List<QuartzJob> findByJobClassName(String jobClassName);
}