package cn.zwz.xboot.modules.tricycle.serviceimpl;

import cn.zwz.xboot.modules.tricycle.mapper.SellerMapper;
import cn.zwz.xboot.modules.tricycle.entity.Seller;
import cn.zwz.xboot.modules.tricycle.service.ISellerService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * 卖家接口实现
 * @author 郑为中
 */
@Slf4j
@Service
@Transactional
public class ISellerServiceImpl extends ServiceImpl<SellerMapper, Seller> implements ISellerService {

    @Autowired
    private SellerMapper sellerMapper;
}