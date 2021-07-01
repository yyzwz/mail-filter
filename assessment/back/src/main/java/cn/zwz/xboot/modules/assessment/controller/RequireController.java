package cn.zwz.xboot.modules.assessment.controller;


import cn.zwz.xboot.common.utils.PageUtil;
import cn.zwz.xboot.common.utils.ResultUtil;
import cn.zwz.xboot.common.vo.PageVo;
import cn.zwz.xboot.common.vo.Result;
import cn.zwz.xboot.modules.assessment.entity.Require;
import cn.zwz.xboot.modules.assessment.service.IRequireService;
import cn.hutool.core.util.StrUtil;
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
@Api(description = "考核要求管理接口")
@RequestMapping("/xboot/require")
@Transactional
public class RequireController {

    @Autowired
    private IRequireService iRequireService;

    @RequestMapping(value = "/get", method = RequestMethod.GET)
    @ApiOperation(value = "通过id获取")
    public Result<Require> get(@RequestParam String id){

        Require require = iRequireService.getById(id);
        return new ResultUtil<Require>().setData(require);
    }

    @RequestMapping(value = "/getAll", method = RequestMethod.GET)
    @ApiOperation(value = "获取全部数据")
    public Result<List<Require>> getAll(@RequestParam(required = false) String type){
        QueryWrapper<Require> qw = new QueryWrapper<>();
        if(type != null) {
            qw.eq("require_type",type);
        }
        List<Require> list = iRequireService.list(qw);
        return new ResultUtil<List<Require>>().setData(list);
    }

    @RequestMapping(value = "/getByPage", method = RequestMethod.GET)
    @ApiOperation(value = "分页获取")
    public Result<IPage<Require>> getByPage(PageVo page){

        IPage<Require> data = iRequireService.page(PageUtil.initMpPage(page));
        return new ResultUtil<IPage<Require>>().setData(data);
    }

    @RequestMapping(value = "/insertOrUpdate", method = RequestMethod.POST)
    @ApiOperation(value = "编辑或更新数据")
    public Result<Require> saveOrUpdate(Require require){

        if(iRequireService.saveOrUpdate(require)){
            return new ResultUtil<Require>().setData(require);
        }
        return new ResultUtil<Require>().setErrorMsg("操作失败");
    }

    @RequestMapping(value = "/delByIds", method = RequestMethod.POST)
    @ApiOperation(value = "批量通过id删除")
    public Result<Object> delAllByIds(@RequestParam String[] ids){

        for(String id : ids){
            iRequireService.removeById(id);
        }
        return ResultUtil.success("批量通过id删除数据成功");
    }
}
