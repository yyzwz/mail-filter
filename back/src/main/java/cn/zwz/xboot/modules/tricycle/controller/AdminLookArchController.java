package cn.zwz.xboot.modules.tricycle.controller;

import cn.zwz.xboot.common.utils.PageUtil;
import cn.zwz.xboot.common.utils.ResultUtil;
import cn.zwz.xboot.common.vo.PageVo;
import cn.zwz.xboot.common.vo.Result;
import cn.zwz.xboot.modules.tricycle.entity.AdminLookArch;
import cn.zwz.xboot.modules.tricycle.service.IAdminLookArchService;
import cn.hutool.core.util.StrUtil;
import cn.zwz.xboot.modules.utils.NullUtils;
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
@Api(description = "工作人员档案管理接口")
@RequestMapping("/xboot/adminLookArch")
@Transactional
public class AdminLookArchController {

    @Autowired
    private IAdminLookArchService iAdminLookArchService;

    @RequestMapping(value = "/get/{id}", method = RequestMethod.GET)
    @ApiOperation(value = "通过id获取")
    public Result<AdminLookArch> get(@PathVariable String id){

        AdminLookArch adminLookArch = iAdminLookArchService.getById(id);
        return new ResultUtil<AdminLookArch>().setData(adminLookArch);
    }

    @RequestMapping(value = "/getAll", method = RequestMethod.GET)
    @ApiOperation(value = "获取全部数据")
    public Result<List<AdminLookArch>> getAll(){

        List<AdminLookArch> list = iAdminLookArchService.list();
        return new ResultUtil<List<AdminLookArch>>().setData(list);
    }

    @RequestMapping(value = "/getByPage", method = RequestMethod.GET)
    @ApiOperation(value = "分页获取")
    public Result<IPage<AdminLookArch>> getByPage(@ModelAttribute AdminLookArch adminLookArch,@ModelAttribute PageVo page){
        QueryWrapper<AdminLookArch> qw = new QueryWrapper<>();
        if(adminLookArch.getMobile() != null && !NullUtils.isNull(adminLookArch.getMobile())) {
            qw.like("mobile",adminLookArch.getMobile());
        }
        if(adminLookArch.getName() != null && !NullUtils.isNull(adminLookArch.getName())) {
            qw.like("name",adminLookArch.getName());
        }
        IPage<AdminLookArch> data = iAdminLookArchService.page(PageUtil.initMpPage(page),qw);
        return new ResultUtil<IPage<AdminLookArch>>().setData(data);
    }

    @RequestMapping(value = "/insertOrUpdate", method = RequestMethod.POST)
    @ApiOperation(value = "编辑或更新数据")
    public Result<AdminLookArch> saveOrUpdate(AdminLookArch adminLookArch){

        if(iAdminLookArchService.saveOrUpdate(adminLookArch)){
            return new ResultUtil<AdminLookArch>().setData(adminLookArch);
        }
        return new ResultUtil<AdminLookArch>().setErrorMsg("操作失败");
    }

    @RequestMapping(value = "/delByIds", method = RequestMethod.POST)
    @ApiOperation(value = "批量通过id删除")
    public Result<Object> delAllByIds(@RequestParam String[] ids){

        for(String id : ids){
            iAdminLookArchService.removeById(id);
        }
        return ResultUtil.success("批量通过id删除数据成功");
    }
}
