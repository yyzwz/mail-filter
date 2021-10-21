package cn.zwz.xboot.modules.tricycle.controller;

import cn.zwz.xboot.common.utils.PageUtil;
import cn.zwz.xboot.common.utils.ResultUtil;
import cn.zwz.xboot.common.utils.SecurityUtil;
import cn.zwz.xboot.common.vo.PageVo;
import cn.zwz.xboot.common.vo.Result;
import cn.zwz.xboot.modules.base.entity.User;
import cn.zwz.xboot.modules.tricycle.entity.AdminLookArch;
import cn.zwz.xboot.modules.tricycle.entity.Car;
import cn.zwz.xboot.modules.tricycle.entity.Seller;
import cn.zwz.xboot.modules.tricycle.entity.ShMsg;
import cn.zwz.xboot.modules.tricycle.service.*;
import cn.zwz.xboot.modules.utils.DateUtils;
import cn.zwz.xboot.modules.utils.NullUtils;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiModelProperty;
import io.swagger.annotations.ApiOperation;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.constraints.Pattern;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * @author 郑为中
 */
@Slf4j
@RestController
@Api(description = "车辆管理接口")
@RequestMapping("/xboot/carForSeller")
@Transactional
public class CarForSellerController {

    @Autowired
    private ICarService iCarService;

    @Autowired
    private ISellerService iSellerService;

    @Autowired
    private IUpdateRecordService iUpdateRecordService;

    @Autowired
    private IAdminLookArchService iAdminLookArchService;

    @Autowired
    private IShMsgService iShMsgService;

    @Autowired
    private SecurityUtil securityUtil;

    @RequestMapping(value = "/getByPage", method = RequestMethod.GET)
    @ApiOperation(value = "分页获取")
    public Result<IPage<Car>> getByPage(@ModelAttribute Car car,@ModelAttribute PageVo page){
        User user = securityUtil.getCurrUser();
        String username = user.getUsername();
        QueryWrapper<Seller> qww = new QueryWrapper<>();
        qww.eq("mobile",username);
        qww.orderByDesc("create_time");
        List<Seller> sellerList = iSellerService.list(qww);

        if(sellerList.size() > 0) {
            QueryWrapper<Car> qw = new QueryWrapper<>();
            qw.eq("seller_id",sellerList.get(0).getId());
            IPage<Car> data = iCarService.page(PageUtil.initMpPage(page),qw);
            return new ResultUtil<IPage<Car>>().setData(data);
        } else {
            return new ResultUtil<IPage<Car>>().setData(null);
        }


    }

    @RequestMapping(value = "/insertOrUpdate", method = RequestMethod.POST)
    @ApiOperation(value = "编辑或更新数据")
    public Result<Car> saveOrUpdate(Car car){

        User user = securityUtil.getCurrUser();
        String username = user.getUsername();
        QueryWrapper<Seller> qww = new QueryWrapper<>();
        qww.eq("mobile",username);
        qww.orderByDesc("create_time");
        List<Seller> sellerList = iSellerService.list(qww);

        if(sellerList.size() > 0) {
            car.setSellerId(sellerList.get(0).getId());
            car.setSellerName(sellerList.get(0).getShopName());
            if(iCarService.saveOrUpdate(car)){
                return new ResultUtil<Car>().setData(car);
            }
            return new ResultUtil<Car>().setErrorMsg("操作失败");
        }
        return new ResultUtil<Car>().setErrorMsg("操作失败");
    }

    @RequestMapping(value = "/delByIds", method = RequestMethod.POST)
    @ApiOperation(value = "批量通过id删除")
    public Result<Object> delAllByIds(@RequestParam String[] ids){

        for(String id : ids){
            iCarService.removeById(id);
        }
        return ResultUtil.success("批量通过id删除数据成功");
    }

}
