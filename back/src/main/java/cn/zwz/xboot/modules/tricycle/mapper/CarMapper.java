package cn.zwz.xboot.modules.tricycle.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import cn.zwz.xboot.modules.tricycle.entity.Car;

import java.util.List;

/**
 * 车辆数据处理层
 * @author 郑为中
 */
public interface CarMapper extends BaseMapper<Car> {
    List<String> getAllIdCardList();
}