package cn.zwz.xboot.modules.tricycle.controller;

import cn.zwz.xboot.common.utils.PageUtil;
import cn.zwz.xboot.common.utils.ResultUtil;
import cn.zwz.xboot.common.vo.PageVo;
import cn.zwz.xboot.common.vo.Result;
import cn.zwz.xboot.modules.base.entity.User;
import cn.zwz.xboot.modules.base.entity.UserRole;
import cn.zwz.xboot.modules.base.service.RoleService;
import cn.zwz.xboot.modules.base.service.UserRoleService;
import cn.zwz.xboot.modules.tricycle.entity.AdminLookArch;
import cn.zwz.xboot.modules.tricycle.entity.Car;
import cn.zwz.xboot.modules.tricycle.entity.Seller;
import cn.zwz.xboot.modules.tricycle.entity.ShMsg;
import cn.zwz.xboot.modules.tricycle.service.*;
import cn.hutool.core.util.StrUtil;
import cn.zwz.xboot.modules.utils.DateUtils;
import cn.zwz.xboot.modules.utils.NullUtils;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * @author 郑为中
 */
@Slf4j
@RestController
@Api(description = "卖家管理接口")
@RequestMapping("/xboot/seller")
@Transactional
public class SellerController {

    @Autowired
    private ISellerService iSellerService;

    @Autowired
    private IAdminLookArchService iAdminLookArchService;

    @Autowired
    private IShMsgService iShMsgService;

    @Autowired
    private ICarService iCarService;

    @Autowired
    private IUserService iUserService;

    @Autowired
    private UserRoleService userRoleService;

    /**
     * 获取所有车辆
     * @return
     */
    @RequestMapping(value = "/getAll", method = RequestMethod.GET)
    public Result<List<Seller>> getAll(@RequestParam(required = false) int pageNumber,@RequestParam(required = false) String name){
        int pageSize = 5;
        QueryWrapper<Seller> qw = new QueryWrapper<>();
        if(name != null && !NullUtils.isNull(name)) {
            qw.like("shop_name",name);
        }
        qw.eq("sh","1");
        qw.orderByDesc("create_time");
        List<Seller> list = iSellerService.list(qw);
        List<Seller> carList1 = new ArrayList<>();
        for(int i = pageNumber * pageSize; i < (pageNumber + 1) * pageSize && i < list.size(); i ++) {
            carList1.add(list.get(i));
        }
        return new ResultUtil<List<Seller>>().setData(carList1);
    }

    @RequestMapping(value = "/get/{id}", method = RequestMethod.GET)
    @ApiOperation(value = "通过id获取")
    public Result<Seller> get(@PathVariable String id){

        Seller seller = iSellerService.getById(id);
        return new ResultUtil<Seller>().setData(seller);
    }

    @RequestMapping(value = "/getByNotSh", method = RequestMethod.GET)
    public Result<List<Seller>> getByPageNotSh(){
        QueryWrapper<Seller> qw = new QueryWrapper<>();
        qw.isNotNull("mobile");
        qw.eq("sh","0");
        qw.eq("tj","1");
        List<Seller> data = iSellerService.list(qw);
        return new ResultUtil<List<Seller>>().setData(data);
    }

    @Transactional
    @RequestMapping(value = "/sh", method = RequestMethod.POST)
    @ApiOperation(value = "获取全部数据")
    public Result<List<Seller>> sh(@RequestParam String id,@RequestParam String msg){
        Seller seller = iSellerService.getById(id);
        if(seller != null) {
            QueryWrapper<ShMsg> qw = new QueryWrapper<>();
            qw.eq("type","卖家资质审核");
            qw.eq("form_id",seller.getId());
            qw.orderByDesc("create_time");
            List<ShMsg> list = iShMsgService.list(qw);
            if(msg.equals("OK")) {
                seller.setSh("1");
                if(list.size() > 0) {
                    list.get(0).setStatus("已通过");
                    list.get(0).setMsg("审核通过");
                    list.get(0).setDate(DateUtils.getCompleteNowDate() + " " + DateUtils.getNowTime());
                }
            } else {
                seller.setSh("2");
                if(list.size() > 0) {
                    list.get(0).setStatus("未通过");
                    list.get(0).setMsg(msg);
                    list.get(0).setDate(DateUtils.getCompleteNowDate() + " " + DateUtils.getNowTime());
                }
            }
            if(list.size() > 0) {
                iShMsgService.saveOrUpdate(list.get(0));
            }
            iSellerService.saveOrUpdate(seller);
            if(seller.getSh().equals("1")) {
                User user = new User();
                String mobile = seller.getMobile();
                user.setUsername(mobile);
                user.setNickname(seller.getShopName());
                user.setEmail(UUID.randomUUID().toString().substring(20) + "@cj.com");
                user.setPassword(new BCryptPasswordEncoder().encode(mobile.substring(3)));
                user.setMobile(mobile);
                user.setStatus(0);
                try {
                    iUserService.saveOrUpdate(user);
                } catch (Exception e) {
                    System.out.println(e);
                }

                UserRole ur = new UserRole();
                ur.setUserId(user.getId());
                ur.setRoleId("1384462977951993857");
                userRoleService.save(ur);
            }
            return new ResultUtil<List<Seller>>().setSuccessMsg("OK");
        }
        return new ResultUtil<List<Seller>>().setErrorMsg("FAIL");
    }


    @RequestMapping(value = "/getByOpenId", method = RequestMethod.GET)
    @ApiOperation(value = "获取全部数据")
    public Result<Seller> getByOpenId(@RequestParam(required = false) String openId){
        if(openId == null) {
            return new ResultUtil<Seller>().setErrorMsg("openId is Null!");
        }
        // 优先判断管理员
        QueryWrapper<AdminLookArch> qwww = new QueryWrapper<>();
        qwww.eq("open_id",openId);
        qwww.orderByDesc("create_time");
        List<AdminLookArch> list1 = iAdminLookArchService.list(qwww);
        if(list1.size() > 0) {
            AdminLookArch adminLookArch = list1.get(0);
            Seller seller = new Seller();
            seller.setShopName(adminLookArch.getName());
            seller.setMobile(adminLookArch.getMobile());
            seller.setIdCard("admin");
            seller.setOpenId(openId);
            return new ResultUtil<Seller>().setData(seller);
        }
        QueryWrapper<Seller> qw = new QueryWrapper<>();
        qw.eq("open_id",openId);
        qw.orderByDesc("create_time");
        List<Seller> list = iSellerService.list(qw);
        if(list.size() == 0) {
            Seller seller = new Seller();
            seller.setOpenId(openId);
            seller.setIdCard("");
            seller.setSh("0");
            seller.setTj("0");
            iSellerService.saveOrUpdate(seller);
            return new ResultUtil<Seller>().setData(seller);
        }
        return new ResultUtil<Seller>().setData(list.get(0));
    }

    @RequestMapping(value = "/getByMobile", method = RequestMethod.GET)
    @ApiOperation(value = "获取全部数据")
    public Result<Seller> getByMobile(@RequestParam(required = false) String mobile,@RequestParam(required = false) String openId){
        if(mobile == null) {
            mobile = "";
        }
        // 管理员未绑定
        if(openId != null) {
            QueryWrapper<AdminLookArch> qww = new QueryWrapper<>();
            qww.eq("mobile",mobile);
            List<AdminLookArch> adminLookArchList = iAdminLookArchService.list(qww);
            if(adminLookArchList.size() > 0) {
                AdminLookArch adminLookArch = adminLookArchList.get(0);
                adminLookArch.setOpenId(openId);
                iAdminLookArchService.saveOrUpdate(adminLookArch);
                Seller seller = new Seller();
                seller.setShopName(adminLookArch.getName());
                seller.setMobile(adminLookArch.getMobile());
                seller.setIdCard("admin");
                seller.setOpenId(openId);
                return new ResultUtil<Seller>().setData(seller);
            }
        }
        QueryWrapper<Seller> qw = new QueryWrapper<>();
        qw.eq("mobile",mobile);
        List<Seller> list = iSellerService.list(qw);
        if(list.size() < 1) {
            return new ResultUtil<Seller>().setErrorMsg("未注册");
        }
        return new ResultUtil<Seller>().setData(list.get(0));
    }

    @RequestMapping(value = "/getByPage", method = RequestMethod.GET)
    @ApiOperation(value = "分页获取")
    public Result<IPage<Seller>> getByPage(@ModelAttribute Seller seller,@ModelAttribute PageVo page){
        QueryWrapper<Seller> qw = new QueryWrapper<>();
        qw.isNotNull("mobile");
        if(seller.getAddress() != null && !NullUtils.isNull(seller.getAddress())) {
            qw.like("address",seller.getAddress());
        }
        if(seller.getDate() != null && !NullUtils.isNull(seller.getDate())) {
            qw.eq("date",seller.getDate());
        }
        if(seller.getIdCard() != null && !NullUtils.isNull(seller.getIdCard())) {
            qw.eq("id_card",seller.getIdCard());
        }
        if(seller.getMobile() != null && !NullUtils.isNull(seller.getMobile())) {
            qw.like("mobile",seller.getMobile());
        }
        if(seller.getRemark() != null && !NullUtils.isNull(seller.getRemark())) {
            qw.like("remark",seller.getRemark());
        }
        if(seller.getShopDuty() != null && !NullUtils.isNull(seller.getShopDuty())) {
            qw.like("shop_duty",seller.getShopDuty());
        }
        if(seller.getShopName() != null && !NullUtils.isNull(seller.getShopName())) {
            qw.like("shop_name",seller.getShopName());
        }
        if(seller.getYyzz() != null && !NullUtils.isNull(seller.getYyzz())) {
            qw.like("yyzz",seller.getYyzz());
        }
        QueryWrapper<Car> qww = new QueryWrapper<>();
        qww.eq("sh","1");
        qw.and(wrapper -> wrapper.isNull("remark").or().ne("remark","虚拟车辆"));
        List<Car> carList = iCarService.list(qww);
        IPage<Seller> data = iSellerService.page(PageUtil.initMpPage(page),qw);
        for (Seller se : data.getRecords()) {
            List<Car> carTempList = new ArrayList<>();
            for (Car car : carList) {
                if(car.getSellerId().equals(se.getId())) {
                    carTempList.add(car);
                }
            }
            se.setCarList(carTempList);
        }
        return new ResultUtil<IPage<Seller>>().setData(data);
    }

    @RequestMapping(value = "/insertOrUpdate", method = RequestMethod.POST)
    @ApiOperation(value = "编辑或更新数据")
    public Result<Seller> saveOrUpdate(Seller seller){
        if(NullUtils.isNull(seller.getId())) {
            seller.setDate(DateUtils.getCompleteNowDate());
        }
        if(iSellerService.saveOrUpdate(seller)){
            return new ResultUtil<Seller>().setData(seller);
        }
        return new ResultUtil<Seller>().setErrorMsg("操作失败");
    }

    @RequestMapping(value = "/delByIds", method = RequestMethod.POST)
    @ApiOperation(value = "批量通过id删除")
    public Result<Seller> delAllByIds(@RequestParam String[] ids){

        for(String id : ids){
            iSellerService.removeById(id);
        }
        return ResultUtil.success("批量通过id删除数据成功");
    }

    @RequestMapping(value = "/appUpdate", method = RequestMethod.POST)
    @ApiOperation(value = "批量通过id删除")
    public Result<Seller> appUpdate(@RequestParam String id,@RequestParam String shopName,@RequestParam String shopDuty,@RequestParam String yyzz,@RequestParam String idCard,@RequestParam String address,@RequestParam String mobile){
        Seller seller = iSellerService.getById(id);
        if(seller != null) {
            seller.setDate(DateUtils.getCompleteNowDate());
            seller.setShopName(shopName);
            seller.setAddress(address);
            seller.setIdCard(idCard);
            seller.setYyzz(yyzz);
            seller.setShopDuty(shopDuty);
            seller.setDate(DateUtils.getCompleteNowDate());
            seller.setMobile(mobile);
            seller.setTj("1");
            seller.setSh("0");
            iSellerService.saveOrUpdate(seller);
            QueryWrapper<ShMsg> qww = new QueryWrapper<>();
            qww.like("type","卖家资质审核");
            qww.eq("form_id",seller.getId());
            qww.eq("status","尚未审核");
            iShMsgService.remove(qww);

            ShMsg shMsg = new ShMsg();
            shMsg.setDate(DateUtils.getCompleteNowDate() + DateUtils.getNowTime());
            shMsg.setFormId(seller.getId());
            shMsg.setMsg("");
            shMsg.setSellerId(seller.getId());
            shMsg.setStatus("尚未审核");
            shMsg.setType("卖家资质审核");
            shMsg.setName(seller.getShopName());
            iShMsgService.saveOrUpdate(shMsg);
            return new ResultUtil<Seller>().setData(seller);
        }
        return ResultUtil.error("NULL");
    }

    @RequestMapping(value = "/getShStatus", method = RequestMethod.GET)
    public Result<String> getShStatus(@RequestParam String openId){
        QueryWrapper<Seller> qw = new QueryWrapper<>();
        qw.eq("open_id",openId);
        qw.orderByDesc("create_time");
        List<Seller> sellerList = iSellerService.list(qw);
        if(sellerList.size() > 0) {
            String sh = sellerList.get(0).getSh();
            return new ResultUtil<String>().setData(sh);
        }
        return new ResultUtil<String>().setData("0");
    }
}
