package cn.zwz.xboot.modules.base.serviceimpl;

import cn.zwz.xboot.modules.base.dao.DepartmentHeaderDao;
import cn.zwz.xboot.modules.base.entity.DepartmentHeader;
import cn.zwz.xboot.modules.base.service.DepartmentHeaderService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * 部门负责人接口实现
 * @author Exrick
 */
@Slf4j
@Service
@Transactional
public class DepartmentHeaderServiceImpl implements DepartmentHeaderService {

    @Autowired
    private DepartmentHeaderDao departmentHeaderDao;

    @Override
    public DepartmentHeaderDao getRepository() {
        return departmentHeaderDao;
    }


    @Override
    public List<String> findHeaderByDepartmentId(String departmentId, Integer type) {

        List<String> list = new ArrayList<>();
        List<DepartmentHeader> headers = departmentHeaderDao.findByDepartmentIdAndType(departmentId, type);
        headers.forEach(e->{
            list.add(e.getUserId());
        });
        return list;
    }

    @Override
    public List<DepartmentHeader> findByDepartmentIdIn(List<String> departmentIds) {

        return departmentHeaderDao.findByDepartmentIdIn(departmentIds);
    }

    @Override
    public void deleteByDepartmentId(String departmentId) {

        departmentHeaderDao.deleteByDepartmentId(departmentId);
    }

    @Override
    public void deleteByUserId(String userId) {

        departmentHeaderDao.deleteByUserId(userId);
    }
}