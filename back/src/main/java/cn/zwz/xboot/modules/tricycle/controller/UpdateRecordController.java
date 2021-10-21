package cn.zwz.xboot.modules.tricycle.controller;

import cn.zwz.xboot.common.utils.PageUtil;
import cn.zwz.xboot.common.utils.ResultUtil;
import cn.zwz.xboot.common.utils.SecurityUtil;
import cn.zwz.xboot.common.vo.PageVo;
import cn.zwz.xboot.common.vo.Result;
import cn.zwz.xboot.modules.base.entity.User;
import cn.zwz.xboot.modules.tricycle.entity.Car;
import cn.zwz.xboot.modules.tricycle.entity.UpdateRecord;
import cn.zwz.xboot.modules.tricycle.service.ICarService;
import cn.zwz.xboot.modules.tricycle.service.IUpdateRecordService;
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
@Api(description = "车主信息修改记录管理接口")
@RequestMapping("/xboot/updateRecord")
@Transactional
public class UpdateRecordController {

    @Autowired
    private IUpdateRecordService iUpdateRecordService;

    @Autowired
    private SecurityUtil securityUtil;

    @Autowired
    private ICarService iCarService;

    @RequestMapping(value = "/get/{id}", method = RequestMethod.GET)
    @ApiOperation(value = "通过id获取")
    public Result<UpdateRecord> get(@PathVariable String id){

        UpdateRecord updateRecord = iUpdateRecordService.getById(id);
        return new ResultUtil<UpdateRecord>().setData(updateRecord);
    }

    @RequestMapping(value = "/getBySellerId", method = RequestMethod.POST)
    @ApiOperation(value = "批量通过id删除")
    public Result<List<UpdateRecord>> getBySellerId(@RequestParam String id){

        QueryWrapper<UpdateRecord> qw = new QueryWrapper<>();
        qw.eq("seller_id",id);
        List<UpdateRecord> updateRecordList = iUpdateRecordService.list(qw);
        return new ResultUtil<List<UpdateRecord>>().setData(updateRecordList);
    }

    @RequestMapping(value = "/passOrDisPass", method = RequestMethod.POST)
    @ApiOperation(value = "批量通过id删除")
    public Result<Object> passOrDisPass(@RequestParam String id,@RequestParam String msg){

        UpdateRecord ur = iUpdateRecordService.getById(id);
        if(ur == null) {
            return ResultUtil.error("NULL");
        }
        User currUser = securityUtil.getCurrUser();

        if(ur.getLookFlag().equals("0") || ur.getLookFlag().equals("1") || ur.getLookFlag().equals("2")) {
            if(msg.equals("2")) {
                ur.setLookFlag("2");
                ur.setLookPeople(currUser.getNickname());
                iUpdateRecordService.saveOrUpdate(ur);
                return ResultUtil.success("OK");
            }
            else {
                Car car = iCarService.getById(ur.getOldId());
                if(car == null) {
                    return ResultUtil.error("NULL");
                }
                car.setOwnerIdcard(ur.getOwnerIdcard1());
                car.setAddressZhu(ur.getAddressZhu1());
                car.setAddressHu(ur.getAddressHu1());
                car.setMobile(ur.getMobile1());
                car.setName(ur.getName1());
                car.setRe1(ur.getRe11());
                car.setRe2(ur.getRe21());
                car.setJia(ur.getJia1());
                car.setGu(ur.getGu1());
                car.setPinPai(ur.getPinPai1());
                car.setXingHao(ur.getXingHao1());
                car.setSellDate(ur.getSellDate1());
                iCarService.saveOrUpdate(car);
                iUpdateRecordService.saveOrUpdate(ur);
                return ResultUtil.success("OK");
            }
        }else {
            if(msg.equals("2")) {
                ur.setLookFlag("6");
                ur.setLookPeople(currUser.getNickname());
                iUpdateRecordService.saveOrUpdate(ur);
                return ResultUtil.success("OK");
            }
            iCarService.removeById(ur.getOldId());
            iUpdateRecordService.saveOrUpdate(ur);
            return ResultUtil.success("OK");
        }
    }


    @RequestMapping(value = "/getAll", method = RequestMethod.GET)
    @ApiOperation(value = "获取全部数据")
    public Result<List<UpdateRecord>> getAll(){

        List<UpdateRecord> list = iUpdateRecordService.list();
        return new ResultUtil<List<UpdateRecord>>().setData(list);
    }

    @RequestMapping(value = "/getByPage", method = RequestMethod.GET)
    @ApiOperation(value = "分页获取")
    public Result<IPage<UpdateRecord>> getByPage(@ModelAttribute UpdateRecord updateRecord,@ModelAttribute PageVo page){
        QueryWrapper<UpdateRecord> qw = new QueryWrapper<>();
        if(updateRecord.getLookFlag() != null && !NullUtils.isNull(updateRecord.getLookFlag())) {
            if(updateRecord.getLookFlag().equals("9")) {
                qw.eq("look_flag","0").or().eq("look_flag","5");
            }else {
                qw.like("look_flag",updateRecord.getLookFlag());
            }
        }
        if(updateRecord.getSellerName() != null && !NullUtils.isNull(updateRecord.getSellerName())) {
            qw.like("seller_name",updateRecord.getSellerName());
        }
        if(updateRecord.getSellDate() != null && !NullUtils.isNull(updateRecord.getSellDate())) {
            qw.eq("sell_date",updateRecord.getSellDate());
        }
        if(updateRecord.getLookPeople() != null && !NullUtils.isNull(updateRecord.getLookPeople())) {
            qw.like("look_people",updateRecord.getLookPeople());
        }
        IPage<UpdateRecord> data = iUpdateRecordService.page(PageUtil.initMpPage(page),qw);
        return new ResultUtil<IPage<UpdateRecord>>().setData(data);
    }

    @RequestMapping(value = "/insertOrUpdate", method = RequestMethod.POST)
    @ApiOperation(value = "编辑或更新数据")
    public Result<UpdateRecord> saveOrUpdate(UpdateRecord updateRecord){

        if(iUpdateRecordService.saveOrUpdate(updateRecord)){
            return new ResultUtil<UpdateRecord>().setData(updateRecord);
        }
        return new ResultUtil<UpdateRecord>().setErrorMsg("操作失败");
    }

    @RequestMapping(value = "/delByIds", method = RequestMethod.POST)
    @ApiOperation(value = "批量通过id删除")
    public Result<Object> delAllByIds(@RequestParam String[] ids){

        for(String id : ids){
            iUpdateRecordService.removeById(id);
        }
        return ResultUtil.success("批量通过id删除数据成功");
    }
}
