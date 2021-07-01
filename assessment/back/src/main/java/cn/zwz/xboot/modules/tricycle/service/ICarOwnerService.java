package cn.zwz.xboot.modules.tricycle.service;

import cn.zwz.xboot.modules.tricycle.entity.Car;
import com.baomidou.mybatisplus.extension.service.IService;
import cn.zwz.xboot.modules.tricycle.entity.CarOwner;

import java.util.List;

/**
 * 买家信息接口
 * @author 郑为中
 */
public interface ICarOwnerService extends IService<CarOwner> {

    CarOwner changeByCar(Car car);
}