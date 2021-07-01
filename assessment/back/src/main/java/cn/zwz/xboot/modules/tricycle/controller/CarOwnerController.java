package cn.zwz.xboot.modules.tricycle.controller;

import cn.zwz.xboot.common.utils.PageUtil;
import cn.zwz.xboot.common.utils.ResultUtil;
import cn.zwz.xboot.common.vo.PageVo;
import cn.zwz.xboot.common.vo.Result;
import cn.zwz.xboot.modules.tricycle.entity.Car;
import cn.zwz.xboot.modules.tricycle.entity.CarOwner;
import cn.zwz.xboot.modules.tricycle.service.ICarOwnerService;
import cn.hutool.core.util.StrUtil;
import cn.zwz.xboot.modules.tricycle.service.ICarService;
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
@Api(description = "买家信息管理接口")
@RequestMapping("/xboot/carOwner")
@Transactional
public class CarOwnerController {

    @Autowired
    private ICarOwnerService iCarOwnerService;

    @Autowired
    private ICarService iCarService;


    @RequestMapping(value = "/get/{id}", method = RequestMethod.GET)
    @ApiOperation(value = "通过id获取")
    public Result<CarOwner> get(@PathVariable String id){

        CarOwner carOwner = iCarOwnerService.getById(id);
        return new ResultUtil<CarOwner>().setData(carOwner);
    }

    @RequestMapping(value = "/getAll", method = RequestMethod.GET)
    @ApiOperation(value = "获取全部数据")
    public Result<List<CarOwner>> getAll(){

        List<CarOwner> list = iCarOwnerService.list();
        return new ResultUtil<List<CarOwner>>().setData(list);
    }

    @RequestMapping(value = "/getByPage", method = RequestMethod.GET)
    @ApiOperation(value = "分页获取")
    public Result<IPage<CarOwner>> getByPage(@ModelAttribute CarOwner carOwner,@ModelAttribute PageVo page){
        QueryWrapper<CarOwner> qw = new QueryWrapper<>();
        if(carOwner.getOwnerIdcard() != null && !NullUtils.isNull(carOwner.getOwnerIdcard())) {
            qw.eq("owner_idcard",carOwner.getOwnerIdcard());
        }
        IPage<CarOwner> data = iCarOwnerService.page(PageUtil.initMpPage(page),qw);
        List<CarOwner> carOwnerList = data.getRecords();
        for (CarOwner owner : carOwnerList) {
            String idcard = owner.getOwnerIdcard();
            QueryWrapper<Car> carQw = new QueryWrapper<>();
            carQw.eq("owner_idcard",idcard);
            carQw.eq("sh","1");
            List<Car> list = iCarService.list(carQw);
            owner.setCarList(list);
        }
        return new ResultUtil<IPage<CarOwner>>().setData(data);
    }

    @RequestMapping(value = "/insertOrUpdate", method = RequestMethod.POST)
    @ApiOperation(value = "编辑或更新数据")
    public Result<CarOwner> saveOrUpdate(CarOwner carOwner){

        if(iCarOwnerService.saveOrUpdate(carOwner)){
            return new ResultUtil<CarOwner>().setData(carOwner);
        }
        return new ResultUtil<CarOwner>().setErrorMsg("操作失败");
    }

    @RequestMapping(value = "/delByIds", method = RequestMethod.POST)
    @ApiOperation(value = "批量通过id删除")
    public Result<Object> delAllByIds(@RequestParam String[] ids){

        for(String id : ids){
            iCarOwnerService.removeById(id);
        }
        return ResultUtil.success("批量通过id删除数据成功");
    }
}
