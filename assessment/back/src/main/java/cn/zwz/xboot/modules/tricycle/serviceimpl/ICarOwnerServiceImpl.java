package cn.zwz.xboot.modules.tricycle.serviceimpl;

import cn.zwz.xboot.modules.tricycle.entity.Car;
import cn.zwz.xboot.modules.tricycle.mapper.CarOwnerMapper;
import cn.zwz.xboot.modules.tricycle.entity.CarOwner;
import cn.zwz.xboot.modules.tricycle.service.ICarOwnerService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * 买家信息接口实现
 * @author 郑为中
 */
@Slf4j
@Service
@Transactional
public class ICarOwnerServiceImpl extends ServiceImpl<CarOwnerMapper, CarOwner> implements ICarOwnerService {

    @Autowired
    private CarOwnerMapper carOwnerMapper;

    @Override
    public CarOwner changeByCar(Car car) {
        CarOwner carOwner = new CarOwner();
        carOwner.setName(car.getName());
        carOwner.setAddressHu(car.getAddressHu());
        carOwner.setAddressZhu(car.getAddressZhu());
        carOwner.setIsJia(car.getIsJia());
        carOwner.setOwnerIdcard(car.getOwnerIdcard());
        carOwner.setMobile(car.getMobile());
        carOwner.setJiaNumber(car.getJiaNumber());
        carOwner.setRe1(car.getRe1());
        carOwner.setRe2(car.getRe2());
        return carOwner;
    }
}