package cn.zwz.xboot.modules.assessment.controller;

import cn.zwz.xboot.common.utils.PageUtil;
import cn.zwz.xboot.common.utils.ResultUtil;
import cn.zwz.xboot.common.vo.PageVo;
import cn.zwz.xboot.common.vo.Result;
import cn.zwz.xboot.modules.assessment.entity.SystemUserRole;
import cn.zwz.xboot.modules.assessment.entity.Village;
import cn.zwz.xboot.modules.assessment.service.ISystemUserRoleService;
import cn.hutool.core.util.StrUtil;
import cn.zwz.xboot.modules.assessment.service.IVillageService;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @author 郑为中
 */
@Slf4j
@RestController
@Api(description = "考核系统权限管理接口")
@RequestMapping("/xboot/systemUserRole")
@Transactional
public class SystemUserRoleController {

    @Autowired
    private ISystemUserRoleService iSystemUserRoleService;

    @Autowired
    private IVillageService iVillageService;

    @RequestMapping(value = "/init", method = RequestMethod.GET)
    @ApiOperation(value = "获取全部数据")
    public Result<List<SystemUserRole>> init(){
        List<Village> villageList = iVillageService.list();
        for (Village village : villageList) {
            SystemUserRole role = new SystemUserRole();
            role.setLevel("四");
            role.setRemark("无备注");
            role.setType("行政村");
            role.setName(village.getVillageName());
            iSystemUserRoleService.save(role);
        }
        return new ResultUtil<List<SystemUserRole>>().setSuccessMsg("OK");
    }

    @RequestMapping(value = "/get/{id}", method = RequestMethod.GET)
    @ApiOperation(value = "通过id获取")
    public Result<SystemUserRole> get(@PathVariable String id){

        SystemUserRole systemUserRole = iSystemUserRoleService.getById(id);
        return new ResultUtil<SystemUserRole>().setData(systemUserRole);
    }

    @RequestMapping(value = "/getAll", method = RequestMethod.GET)
    @ApiOperation(value = "获取全部数据")
    public Result<List<SystemUserRole>> getAll(){

        List<SystemUserRole> list = iSystemUserRoleService.list();
        return new ResultUtil<List<SystemUserRole>>().setData(list);
    }

    @RequestMapping(value = "/getByPage", method = RequestMethod.GET)
    @ApiOperation(value = "分页获取")
    public Result<IPage<SystemUserRole>> getByPage(PageVo page){

        IPage<SystemUserRole> data = iSystemUserRoleService.page(PageUtil.initMpPage(page));
        return new ResultUtil<IPage<SystemUserRole>>().setData(data);
    }

    @RequestMapping(value = "/insertOrUpdate", method = RequestMethod.POST)
    @ApiOperation(value = "编辑或更新数据")
    public Result<SystemUserRole> saveOrUpdate(SystemUserRole systemUserRole){

        if(iSystemUserRoleService.saveOrUpdate(systemUserRole)){
            return new ResultUtil<SystemUserRole>().setData(systemUserRole);
        }
        return new ResultUtil<SystemUserRole>().setErrorMsg("操作失败");
    }

    @RequestMapping(value = "/save", method = RequestMethod.GET)
    @ApiOperation(value = "编辑或更新数据")
    public Result<SystemUserRole> save(@RequestParam String level,@RequestParam String type,@RequestParam String name,@RequestParam String remark){
        SystemUserRole role = new SystemUserRole();
        role.setLevel(level);
        role.setName(name);
        role.setRemark(remark);
        role.setType(type);
        iSystemUserRoleService.saveOrUpdate(role);
        return new ResultUtil<SystemUserRole>().setSuccessMsg("OK");
    }

    @RequestMapping(value = "/delByIds", method = RequestMethod.POST)
    @ApiOperation(value = "批量通过id删除")
    public Result<Object> delAllByIds(@RequestParam String[] ids){

        for(String id : ids){
            iSystemUserRoleService.removeById(id);
        }
        return ResultUtil.success("批量通过id删除数据成功");
    }
}
