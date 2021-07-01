package cn.zwz.xboot.modules.tricycle.serviceimpl;

import cn.zwz.xboot.modules.tricycle.mapper.CarMapper;
import cn.zwz.xboot.modules.tricycle.entity.Car;
import cn.zwz.xboot.modules.tricycle.service.ICarService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * 车辆接口实现
 * @author 郑为中
 */
@Slf4j
@Service
@Transactional
public class ICarServiceImpl extends ServiceImpl<CarMapper, Car> implements ICarService {

    @Autowired
    private CarMapper carMapper;

    @Override
    public List<String> getAllIdCardList() {
        return carMapper.getAllIdCardList();
    }
}