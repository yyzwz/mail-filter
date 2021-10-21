package cn.zwz.xboot.modules.tricycle.controller;

import cn.zwz.xboot.common.utils.PageUtil;
import cn.zwz.xboot.common.utils.ResultUtil;
import cn.zwz.xboot.common.vo.PageVo;
import cn.zwz.xboot.common.vo.Result;
import cn.zwz.xboot.modules.tricycle.entity.ShMsg;
import cn.zwz.xboot.modules.tricycle.service.IShMsgService;
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
@Api(description = "审核信息管理接口")
@RequestMapping("/xboot/shMsg")
@Transactional
public class ShMsgController {

    @Autowired
    private IShMsgService iShMsgService;

    @RequestMapping(value = "/get/{id}", method = RequestMethod.GET)
    @ApiOperation(value = "通过id获取")
    public Result<ShMsg> get(@PathVariable String id){

        ShMsg shMsg = iShMsgService.getById(id);
        return new ResultUtil<ShMsg>().setData(shMsg);
    }

    @RequestMapping(value = "/getAll", method = RequestMethod.GET)
    @ApiOperation(value = "获取全部数据")
    public Result<List<ShMsg>> getAll(){
        List<ShMsg> list = iShMsgService.list();
        return new ResultUtil<List<ShMsg>>().setData(list);
    }

    @RequestMapping(value = "/getBySellerId", method = RequestMethod.GET)
    public Result<List<ShMsg>> getBySellerId(@RequestParam String sellerId){
        QueryWrapper<ShMsg> qw = new QueryWrapper<>();
        qw.eq("seller_id",sellerId);
        qw.orderByDesc("create_time");
        List<ShMsg> list = iShMsgService.list(qw);
        return new ResultUtil<List<ShMsg>>().setData(list);
    }

    @RequestMapping(value = "/getByPage", method = RequestMethod.GET)
    @ApiOperation(value = "分页获取")
    public Result<IPage<ShMsg>> getByPage(PageVo page){

        IPage<ShMsg> data = iShMsgService.page(PageUtil.initMpPage(page));
        return new ResultUtil<IPage<ShMsg>>().setData(data);
    }

    @RequestMapping(value = "/insertOrUpdate", method = RequestMethod.POST)
    @ApiOperation(value = "编辑或更新数据")
    public Result<ShMsg> saveOrUpdate(ShMsg shMsg){

        if(iShMsgService.saveOrUpdate(shMsg)){
            return new ResultUtil<ShMsg>().setData(shMsg);
        }
        return new ResultUtil<ShMsg>().setErrorMsg("操作失败");
    }

    @RequestMapping(value = "/delByIds", method = RequestMethod.POST)
    @ApiOperation(value = "批量通过id删除")
    public Result<Object> delAllByIds(@RequestParam String[] ids){

        for(String id : ids){
            iShMsgService.removeById(id);
        }
        return ResultUtil.success("批量通过id删除数据成功");
    }
}
