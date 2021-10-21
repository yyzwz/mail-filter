package cn.zwz.xboot.modules.assessment.serviceimpl;

import cn.zwz.xboot.modules.assessment.mapper.TwoWindowsMapper;
import cn.zwz.xboot.modules.assessment.entity.TwoWindows;
import cn.zwz.xboot.modules.assessment.service.ITwoWindowsService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * 二级页面接口实现
 * @author 郑为中
 */
@Slf4j
@Service
@Transactional
public class ITwoWindowsServiceImpl extends ServiceImpl<TwoWindowsMapper, TwoWindows> implements ITwoWindowsService {

    @Autowired
    private TwoWindowsMapper twoWindowsMapper;
}