package cn.zwz.xboot.modules.tricycle.controller;

import cn.zwz.xboot.common.utils.PageUtil;
import cn.zwz.xboot.common.utils.ResultUtil;
import cn.zwz.xboot.common.vo.PageVo;
import cn.zwz.xboot.common.vo.Result;
import cn.zwz.xboot.modules.tricycle.entity.*;
import cn.zwz.xboot.modules.tricycle.service.*;
import cn.zwz.xboot.modules.tricycle.vo.CarImportBaoXianVo;
import cn.zwz.xboot.modules.tricycle.vo.CarImportBaoXianVo2;
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
import org.springframework.web.bind.annotation.*;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ModelAndView;

/**
 * @author 郑为中
 */
@Slf4j
@RestController
@Api(description = "车辆管理接口")
@RequestMapping("/xboot/car")
@Transactional
public class CarController {

    @Autowired
    private ICarService iCarService;

    @Autowired
    private ISellerService iSellerService;

    @Autowired
    private IAdminLookArchService iAdminLookArchService;

    @Autowired
    private IShMsgService iShMsgService;

    @Autowired
    private ICarOwnerService iCarOwnerService;

    private String changeDate(long number) {
        Date date = new Date(number*86400L*1000L - 25569L*86400L*1000L);
        int year = date.getYear() + 1900;
        int month = date.getMonth() + 1;
        int date1 = date.getDate();
        return year + "-" + (month < 10 ? "0" + month : month) + "-" + (date1 < 10 ? "0" + date1 : date1);
    }

    @RequestMapping(value = "/importData2", method = RequestMethod.POST)
    public Result<String> importData2(@RequestBody List<CarImportBaoXianVo2> voList) {
        System.out.println(voList.size() + " -----");
        int i = 0;
        for (CarImportBaoXianVo2 vo : voList) {
            System.out.println("正在进行 --->  " + (i++) );
            String jia = vo.getJia();
            QueryWrapper<Car> qw = new QueryWrapper<>();
            qw.eq("jia",jia);
            List<Car> carList = iCarService.list(qw);
            if(carList.size() > 0) {
                for (Car car : carList) {
                    car.setBdh(vo.getBdh());
                    car.setBaoXian(vo.getStartTime());
                    car.setBaoXian2(vo.getEndTime());
                    iCarService.saveOrUpdate(car);
                }
            } else {
                String idCard = vo.getIdCard();
                QueryWrapper<Car> qw2 = new QueryWrapper<>();
                qw2.eq("owner_idcard",idCard);
                List<Car> carList2 = iCarService.list(qw2);
                if(carList2.size() > 0) {
                    for (Car car : carList2) {
                        car.setBdh(vo.getBdh());
                        car.setBaoXian(vo.getStartTime());
                        car.setBaoXian2(vo.getEndTime());
                        iCarService.saveOrUpdate(car);
                    }
                }
            }
        }
        return new ResultUtil<String>().setSuccessMsg("OK");
    }

    @RequestMapping(value = "/importData", method = RequestMethod.POST)
    public Result<String> importData(@RequestBody List<CarImportBaoXianVo> voList) {
        int index = 0;
        List<CarOwner> carOwners = iCarOwnerService.list();
        for (CarImportBaoXianVo vo : voList) {
            String zjh = vo.get证件号();
            String cph = vo.get车牌号();
            boolean hasUser = false;
            for (CarOwner carOwner : carOwners) {
                if(carOwner.getOwnerIdcard().equals(zjh)) {
                    hasUser = true;
                }
            }
            if(!hasUser) {
                CarOwner carOwner = new CarOwner();
                carOwner.setOwnerIdcard(vo.get证件号());
                carOwner.setAddressHu(vo.get地址());
                carOwner.setAddressZhu(vo.get地址());
                carOwner.setMobile(vo.get电话());
                carOwner.setName(vo.get被保人());
                iCarOwnerService.saveOrUpdate(carOwner);
            }
            Car car = new Car();
            car.setBdh(vo.get保单号());
            try {
                car.setBaoXian(changeDate(Long.parseLong((int)(Float.parseFloat(vo.get起保日期())) + "")));
            }catch (Exception e) {
                car.setBaoXian("");
            }
            car.setBaoXian2("");
            car.setSellerName("虚拟店铺");
            car.setSellerId("1385394385809707009");
            car.setJia(vo.get车架号());
            car.setPaiHao(vo.get车牌号());
            car.setName(vo.get被保人());
            car.setOwnerIdcard(vo.get证件号());
            car.setType("电动三轮车");
            car.setRe1("浙江省宁波市宁海县");
            car.setRe2("浙江省宁波市宁海县");
            car.setAddressHu(vo.get地址());
            car.setAddressZhu(vo.get地址());
            car.setRemark("初始数据,批量导入");
            car.setQrCode(vo.get二维码());
            car.setSh("1");
            car.setGu("");
            iCarService.saveOrUpdate(car);
            System.out.println(index++);
        }
        return new ResultUtil<String>().setData("OK");
    }

    /**
     * PC端根据卖家查询车辆信息
     * @param id 卖家ID
     * @return
     */
    @RequestMapping(value = "/getCarDataBySellId", method = RequestMethod.POST)
    public Result<List<Car>> appUpdate(@RequestParam String id,@RequestParam(required = false) int pageNumber,@RequestParam(required = false) String name){
        int pageSize = 5;
        QueryWrapper<Car> qw = new QueryWrapper<>();
        if(!id.equals("ZWZ1314")) {
            qw.eq("seller_id",id);
        }
        qw.orderByDesc("create_time");
        if(name != null && !NullUtils.isNull(name)) {
            qw.like("pai_hao",name);
        }
        List<Car> carList = iCarService.list(qw);
        List<Car> carList1 = new ArrayList<>();
        for(int i = pageNumber * pageSize; i < (pageNumber + 1) * pageSize && i < carList.size(); i ++) {
            carList1.add(carList.get(i));
        }
        return new ResultUtil<List<Car>>().setData(carList1);
    }


    /**
     * PC端审核界面 获取没有审核的车辆
     * @return
     */
    @RequestMapping(value = "/getByNotSh", method = RequestMethod.GET)
    public Result<List<Car>> getByPageNotSh(){
        QueryWrapper<Car> qw = new QueryWrapper<>();
        qw.eq("sh","0");
        List<Car> data = iCarService.list(qw);
        return new ResultUtil<List<Car>>().setData(data);
    }


    /**
     * PC端 / 小程序管理端 车辆审核操作
     * @param id 车辆ID
     * @param msg 审核结果
     * @param msg2 审核原因
     * @return
     */
    @RequestMapping(value = "/sh", method = RequestMethod.POST)
    public Result<List<Car>> sh(@RequestParam String id,@RequestParam String msg,@RequestParam(required = false) String msg2){
        Car car = iCarService.getById(id);
        if(car != null) {
            QueryWrapper<ShMsg> qw = new QueryWrapper<>();
            qw.like("type","车辆");
            qw.eq("form_id",car.getId());
            qw.orderByDesc("create_time");
            List<ShMsg> list = iShMsgService.list(qw);
            if(msg.equals("OK")) {
                car.setSh("1");
                if(list.size() > 0) {
                    if(msg2 == null && !NullUtils.isNull(msg2)) {
                        list.get(0).setMsg("审核通过");
                    }else {
                        list.get(0).setMsg(msg2);
                    }
                    list.get(0).setStatus("已通过");
                    list.get(0).setDate(DateUtils.getCompleteNowDate() + " " + DateUtils.getNowTime());
                }
            } else {
                car.setSh("2");
                if(list.size() > 0) {
                    list.get(0).setStatus("未通过");
                    list.get(0).setMsg(msg);
                    list.get(0).setDate(DateUtils.getCompleteNowDate() + " " + DateUtils.getNowTime());
                }
            }
            iCarService.saveOrUpdate(car);
            if(list.size() > 0) {
                iShMsgService.saveOrUpdate(list.get(0));
            }
            return new ResultUtil<List<Car>>().setSuccessMsg("OK");
        }
        return new ResultUtil<List<Car>>().setErrorMsg("FAIL");
    }



    /**
     * 小程序 加车
     * @return
     */
    @RequestMapping(value = "/appAddCar", method = RequestMethod.POST)
    public Result<String> appUpdate(@RequestParam String sellDate,@RequestParam String jia,@RequestParam String gu,@RequestParam String pinPai,@RequestParam String xingHao,@RequestParam String type,@RequestParam String sellerId,
                                    @RequestParam String ownerName,@RequestParam String ownerMobile,@RequestParam String ownerIdcard,@RequestParam String ownerAddress1,@RequestParam String ownerAddress2,
                                    @RequestParam String re1,@RequestParam String re2){
        Car car = new Car();
        car.setSellDate(sellDate);
        car.setJia(jia);
        car.setGu(gu);
        car.setPinPai(pinPai);
        car.setXingHao(xingHao);
        car.setType(type);
        car.setRe1(re1);
        car.setRe2(re2);
        car.setName(ownerName);
        car.setMobile(ownerMobile);
        car.setOwnerIdcard(ownerIdcard);
        car.setAddressHu(ownerAddress1);
        car.setAddressZhu(ownerAddress2);
        car.setSh("0");
        QueryWrapper<Car> qw = new QueryWrapper<>();
        qw.orderByDesc("file_id");
        List<Car> carList = iCarService.list(qw);
        int newId = 1;
        if(carList == null || carList.size() == 0) {
            newId = 1;
        }else {
            newId = carList.get(0).getFileId() + 1;
        }
        car.setFileId(newId);
        // 车主建档
        if(car.getOwnerIdcard() != null && !NullUtils.isNull(car.getOwnerIdcard())) {
            CarOwner carOwner = iCarOwnerService.changeByCar(car);
            QueryWrapper<CarOwner> carOwnerQw = new QueryWrapper<>();
            carOwnerQw.eq("owner_idcard",car.getOwnerIdcard());
            List<CarOwner> carOwnerList = iCarOwnerService.list(carOwnerQw);
            if(carOwnerList.size() == 0) {
                iCarOwnerService.saveOrUpdate(carOwner);
            }
        }
        // 车辆存档
        Seller seller = iSellerService.getById(sellerId);
        if(seller != null) {
            car.setSellerId(sellerId);
            car.setSellerName(seller.getShopName());
            iCarService.saveOrUpdate(car);
            ShMsg shMsg = new ShMsg();
            shMsg.setDate(DateUtils.getCompleteNowDate() + " " + DateUtils.getNowTime());
            shMsg.setMsg("");
            shMsg.setStatus("尚未审核");
            shMsg.setType("车辆新增审核");
            shMsg.setFormId(car.getId());
            shMsg.setSellerId(seller.getId());
            shMsg.setName(car.getType() + " - " + car.getXingHao());
            iShMsgService.saveOrUpdate(shMsg);
            return new ResultUtil<String>().setData(car.getId());
        }
        return new ResultUtil<String>().setErrorMsg("FAIL");
    }



    /**
     * 小程序 修改车辆信息
     * @return
     */
    @RequestMapping(value = "/appUpdateCar", method = RequestMethod.POST)
    public Result<String> appUpdateCar(@RequestParam String id,@RequestParam String sellDate,@RequestParam String jia,@RequestParam String gu,@RequestParam String pinPai,@RequestParam String xingHao,@RequestParam String type,
                                    @RequestParam String ownerName,@RequestParam String ownerMobile,@RequestParam String ownerIdcard,@RequestParam String ownerAddress1,@RequestParam String ownerAddress2,
                                    @RequestParam String re1,@RequestParam String re2,@RequestParam String sellerId) {
        Car car = iCarService.getById(id);
        if(car == null) {
            return new ResultUtil<String>().setErrorMsg("FAIL");
        }
        car.setSh("0");
        car.setSellDate(sellDate);
        car.setJia(jia);
        car.setGu(gu);
        car.setPinPai(pinPai);
        car.setXingHao(xingHao);
        car.setType(type);
        car.setOwnerIdcard(ownerIdcard);
        car.setName(ownerName);
        car.setMobile(ownerMobile);
        car.setAddressHu(ownerAddress1);
        car.setAddressZhu(ownerAddress2);
        car.setRe1(re1);
        car.setRe2(re2);
        iCarService.saveOrUpdate(car);
        // 车主建档
        if(car.getOwnerIdcard() != null && !NullUtils.isNull(car.getOwnerIdcard())) {
            CarOwner carOwner = iCarOwnerService.changeByCar(car);
            QueryWrapper<CarOwner> carOwnerQw = new QueryWrapper<>();
            carOwnerQw.eq("owner_idcard",car.getOwnerIdcard());
            List<CarOwner> carOwnerList = iCarOwnerService.list(carOwnerQw);
            if(carOwnerList.size() == 0) {
                iCarOwnerService.saveOrUpdate(carOwner);
            }
        }
        // 车辆修改
        QueryWrapper<ShMsg> qww = new QueryWrapper<>();
        qww.like("type","车辆");
        qww.eq("form_id",car.getId());
        qww.eq("status","尚未审核");
        qww.eq("seller_id",sellerId);
        iShMsgService.remove(qww);
        ShMsg shMsg = new ShMsg();
        shMsg.setDate(DateUtils.getCompleteNowDate() + " " + DateUtils.getNowTime());
        shMsg.setMsg("");
        shMsg.setStatus("尚未审核");
        shMsg.setType("车辆修改审核");
        shMsg.setFormId(car.getId());
        shMsg.setName(car.getType() + " - " + car.getXingHao());
        shMsg.setSellerId(sellerId);
        iShMsgService.saveOrUpdate(shMsg);
        return new ResultUtil<String>().setSuccessMsg("提交成功");

    }


    /**
     * 小程序上传车辆发票
     */
    @RequestMapping(value = "/uploadFaPiaoImages", method = { RequestMethod.POST,RequestMethod.GET})
    public ModelAndView uploadImage(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // MultipartResolver resolver = new CommonsMultipartResolver(request.getSession().getServletContext());
        // MultipartHttpServletRequest req = resolver.resolveMultipart(request);
        MultipartHttpServletRequest req =(MultipartHttpServletRequest)request;
        MultipartFile file =  req.getFile("file");
        String carId = (String)request.getParameter("id");
        if(file != null){
            System.out.println("获取图片成功");
        }
        String realPath = "C:\\java\\tomcat\\webapps\\docs\\static\\";
        System.out.println(realPath);
        try {
            File dir = new File(realPath);
            if (!dir.exists()) {
                dir.mkdir();
            }
            String uuid = UUID.randomUUID().toString().replaceAll("-","");
            System.out.println(uuid);
            String name =uuid + ".jpg";
            System.out.println(name);
            Car car = iCarService.getById(carId);
            if(car != null) {
                car.setPiaoPhoto(name);
                iCarService.saveOrUpdate(car);
            }
            java.io.File files  =  new File(realPath, name); // ".jpg"
            file.transferTo(files);
            byte[] data = null;
            // 读取图片字节数组
            try {
                InputStream in = new FileInputStream(realPath+name);
                data = new byte[in.available()];
                in.read(data);
                in.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        } catch (IOException e) {
            e.printStackTrace();
        } catch (IllegalStateException e) {
            e.printStackTrace();
        }
        return null;
    }


    /**
     * 获取单个车辆
     * @param id 车辆ID
     * @return
     */
    @RequestMapping(value = "/get", method = RequestMethod.GET)
    public Result<Car> get(@RequestParam String id){
        Car car = iCarService.getById(id);
        return new ResultUtil<Car>().setData(car);
    }


    /**
     * 小程序扫码查看车辆信息
     * @param id 车辆二维码ID
     * @param openId 用户微信标识
     * @return
     */
    @RequestMapping(value = "/getByOpenId", method = RequestMethod.GET)
    public Result<Car> getByOpenId(@RequestParam String id,@RequestParam String openId){
        QueryWrapper<AdminLookArch> qw = new QueryWrapper<>();
        qw.eq("open_id",openId);
        List<AdminLookArch> adminLookArchList = iAdminLookArchService.list(qw);
        if(adminLookArchList.size() == 0) {
            return new ResultUtil<Car>().setData(null);
        }
        QueryWrapper<Car> qww = new QueryWrapper<>();
        qww.eq("file_id",id);
        List<Car> list = iCarService.list(qww);
        return new ResultUtil<Car>().setData(list.size() == 0 ? null : list.get(0));
    }


    /**
     * 获取所有买家列表
     * @return
     */
    @RequestMapping(value = "/getAllOwner", method = RequestMethod.GET)
    public Result<List<Owner>> getAllOwner(@RequestParam(required = false) int pageNumber,@RequestParam(required = false) int pageSize){
        if(pageNumber == 0) pageNumber = 1;
        if(pageSize == 0) pageSize = 10;
        List<String> idCardListAll = iCarService.getAllIdCardList();

        // 手动分页
        List<String> idCardList = new ArrayList<>();
        for(int i = (pageNumber - 1) * pageSize ; i < pageNumber * pageSize && i < idCardListAll.size() ; i ++ ) {
            idCardList.add(idCardListAll.get(i));
        }

        QueryWrapper<Car> qw = new QueryWrapper<>();
        qw.eq("sh","1");
        qw.ne("remark","虚拟车辆");
        List<Car> carList = iCarService.list(qw);
        List<Car> carList2 = iCarService.list();
        List<Owner> ans = new ArrayList<>();

        for (String idCard : idCardList) {
            Owner owner = new Owner();
            List<Car> tempCarList = new ArrayList<>();
            List<Car> tempCarList2 = new ArrayList<>(); // 包括虚拟车辆
            for (Car car : carList) {
                if(car.getOwnerIdcard().equals(idCard)) {
                    tempCarList.add(car);
                }
            }
            for (Car car : carList2) {
                if(car.getOwnerIdcard().equals(idCard)) {
                    tempCarList2.add(car);
                }
            }
            owner.setCarList(tempCarList);
            owner.setOwnerIdcard(idCard);
            if(tempCarList2.size() > 0) {
                Car car = tempCarList2.get(tempCarList2.size() - 1);
                owner.setRe1(car.getRe1());
                owner.setRe2(car.getRe2());
                owner.setAddressHu(car.getAddressHu());
                owner.setAddressZhu(car.getAddressZhu());
                owner.setJiaNumber(car.getJiaNumber());
                owner.setMobile(car.getMobile());
                owner.setName(car.getName());
            }
            ans.add(owner);
        }
        return new ResultUtil<List<Owner>>().setData(ans);
    }

    /**
     * 买家VO实体类
     */
    @Data
    private static class Owner {
        @ApiModelProperty(value = "姓名")
        private String name;

        @ApiModelProperty(value = "手机号")
        private String mobile;

        @ApiModelProperty(value = "身份证号")
        private String ownerIdcard;

        @ApiModelProperty(value = "户籍地址")
        private String addressHu;

        @ApiModelProperty(value = "住址")
        private String addressZhu;

        @ApiModelProperty(value = "户籍地址")
        private String re1;

        @ApiModelProperty(value = "户籍地址")
        private String re2;

        @ApiModelProperty(value = "是否有驾照")
        private String isJia;

        @ApiModelProperty(value = "驾照号码")
        private String jiaNumber;

        private List<Car> carList;
    }

    /**
     * 获取所有车辆
     * @return
     */
    @RequestMapping(value = "/getAll", method = RequestMethod.GET)
    public Result<List<Car>> getAll(@RequestParam(required = false) int pageNumber,@RequestParam(required = false) String name){
        int pageSize = 5;
        QueryWrapper<Car> qw = new QueryWrapper<>();
        if(name != null && !NullUtils.isNull(name)) {
            qw.like("pai_hao",name);
        }
        qw.orderByDesc("create_time");
        List<Car> list = iCarService.list(qw);
        List<Car> carList1 = new ArrayList<>();
        for(int i = pageNumber * pageSize; i < (pageNumber + 1) * pageSize && i < list.size(); i ++) {
            carList1.add(list.get(i));
        }
        return new ResultUtil<List<Car>>().setData(carList1);
    }

    @RequestMapping(value = "/getAll2", method = RequestMethod.GET)
    public Result<List<Car>> getAll2(@RequestParam(required = false) int pageNumber,@RequestParam(required = false) String name){
        int pageSize = 5;
        QueryWrapper<Car> qw = new QueryWrapper<>();
        if(name != null && !NullUtils.isNull(name)) {
            qw.like("pai_hao",name);
        }
        List<Car> carList = iCarService.list(qw);
        List<Car> carList1 = new ArrayList<>();
        for(int i = pageNumber * pageSize; i < (pageNumber + 1) * pageSize && i < carList.size(); i ++) {
            carList1.add(carList.get(i));
        }
        return new ResultUtil<List<Car>>().setData(carList1);
    }


    /**
     * PC端分页获取车辆
     * @return
     */
    @RequestMapping(value = "/getByPage", method = RequestMethod.GET)
    public Result<IPage<Car>> getByPage(@ModelAttribute Car car,@ModelAttribute PageVo page){
        QueryWrapper<Car> qw = new QueryWrapper<>();
        if(car.getOwnerIdcard() != null && !NullUtils.isNull(car.getOwnerIdcard())) {
            qw.eq("owner_idcard",car.getOwnerIdcard());
        }
        if(car.getBaoXian() != null && !NullUtils.isNull(car.getBaoXian())) {
            qw.like("bao_xian",car.getBaoXian());
        }
        if(car.getXingHao() != null && !NullUtils.isNull(car.getXingHao())) {
            qw.like("xing_hao",car.getXingHao());
        }
        if(car.getGu() != null && !NullUtils.isNull(car.getGu())) {
            qw.like("gu",car.getGu());
        }
        if(car.getJia() != null && !NullUtils.isNull(car.getJia())) {
            qw.like("jia",car.getJia());
        }
        if(car.getPaiHao() != null && !NullUtils.isNull(car.getPaiHao())) {
            qw.like("pai_hao",car.getPaiHao());
        }
        if(car.getPinPai() != null && !NullUtils.isNull(car.getPinPai())) {
            qw.like("pin_pai",car.getPinPai());
        }
        if(car.getRemark() != null && !NullUtils.isNull(car.getRemark())) {
            qw.like("remark",car.getRemark());
        }
        if(car.getSellDate() != null && !NullUtils.isNull(car.getSellDate())) {
            qw.eq("sell_date",car.getSellDate());
        }
        if(car.getType() != null && !NullUtils.isNull(car.getType())) {
            qw.like("type",car.getType());
        }
        if(car.getName() != null && !NullUtils.isNull(car.getName())) {
            qw.like("name",car.getName());
        }
        if(car.getSellerName() != null && !NullUtils.isNull(car.getSellerName())) {
            qw.like("seller_name",car.getSellerName());
        }
        IPage<Car> data = iCarService.page(PageUtil.initMpPage(page),qw);
        return new ResultUtil<IPage<Car>>().setData(data);
    }


    /**
     * PC端新增修改车辆
     * @return
     */
    @RequestMapping(value = "/insertOrUpdate", method = RequestMethod.POST)
    public Result<Car> saveOrUpdate(Car car){
        // 车主建档
        if(car.getOwnerIdcard() != null && !NullUtils.isNull(car.getOwnerIdcard())) {
            CarOwner carOwner = iCarOwnerService.changeByCar(car);
            QueryWrapper<CarOwner> carOwnerQw = new QueryWrapper<>();
            carOwnerQw.eq("owner_idcard",car.getOwnerIdcard());
            List<CarOwner> carOwnerList = iCarOwnerService.list(carOwnerQw);
            if(carOwnerList.size() == 0) {
                iCarOwnerService.saveOrUpdate(carOwner);
            }
        }
        QueryWrapper<Car> qw = new QueryWrapper<>();
        qw.orderByDesc("file_id");
        List<Car> carList = iCarService.list(qw);
        int newId = 1;
        if(carList == null || carList.size() == 0) {
            newId = 1;
        }else {
            newId = carList.get(0).getFileId() + 1;
        }
        car.setFileId(newId);
        if(iCarService.saveOrUpdate(car)){
            return new ResultUtil<Car>().setData(car);
        }
        return new ResultUtil<Car>().setErrorMsg("操作失败");
    }

    /**
     * 根据车主身份证监测完整信息
     * @param idCard
     * @return
     */
    @RequestMapping(value = "/getOwnerByIdCard", method = RequestMethod.POST)
    public Result<Owner> getOwnerByIdCard(@RequestParam String idCard) {
        QueryWrapper<Car> qw = new QueryWrapper<>();
        qw.eq("owner_idcard",idCard);
        qw.orderByDesc("create_time");
        List<Car> carList = iCarService.list(qw);
        if(carList.size() > 0) {
            Car car = carList.get(0);
            Owner owner = new Owner();
            owner.setOwnerIdcard(car.getOwnerIdcard());
            owner.setName(car.getName());
            owner.setMobile(car.getMobile());
            owner.setAddressHu(car.getAddressHu());
            owner.setAddressZhu(car.getAddressZhu());
            owner.setRe1(car.getRe1());
            owner.setRe2(car.getRe2());
            return new ResultUtil<Owner>().setData(owner);
        }
        return new ResultUtil<Owner>().setData(null);
    }


    /**
     * PC端删除车辆
     * @param ids
     * @return
     */
    @RequestMapping(value = "/delByIds", method = RequestMethod.POST)
    @ApiOperation(value = "批量通过id删除")
    public Result<Object> delAllByIds(@RequestParam String[] ids){
        for(String id : ids){
            iCarService.removeById(id);
        }
        return ResultUtil.success("批量通过id删除数据成功");
    }


    /**
     * PC端上传车辆发票照片
     * @return
     */
    @RequestMapping(value = "/uploadPhoto", method = RequestMethod.POST)
    public Result<String> upload(@RequestParam(required = false) MultipartFile file) {
        if(file == null){
            return ResultUtil.error("文件不存在");
        }
        final String realPaths = "C:\\java\\tomcat\\webapps\\docs\\static\\";
        try {
            java.io.File dir = new File(realPaths);
            if (!dir.exists()) {
                dir.mkdir();
            }
            System.out.println(file.getOriginalFilename().substring(0,file.getOriginalFilename().lastIndexOf(".") ));
            String uuid = UUID.randomUUID().toString().replaceAll("-","");
            System.out.println(uuid);
            String name =uuid + "." + file.getOriginalFilename();
            java.io.File files  =  new File(realPaths, name); // ".jpg"
            files.setReadable(true);
            files.setExecutable(true);
            files.setWritable(true);
            file.transferTo(files);
            byte[] data = null;
            try {
                InputStream in = new FileInputStream(realPaths+name);
                data = new byte[in.available()];
                in.read(data);
                in.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
            return new ResultUtil<String>().setData(name);
        } catch (IOException e) {
            e.printStackTrace();
        } catch (IllegalStateException e) {
            e.printStackTrace();
        }
        return ResultUtil.error("FAIL");
    }

    /**
     * PC端上传车辆照片
     * @return
     */
    @RequestMapping(value = "/uploadPhoto2", method = RequestMethod.POST)
    public Result<String> upload2(@RequestParam(required = false) MultipartFile file) {
        if(file == null){
            return ResultUtil.error("文件不存在");
        }
        final String realPaths = "C:\\java\\tomcat\\webapps\\docs\\static2\\";
        try {
            java.io.File dir = new File(realPaths);
            if (!dir.exists()) {
                dir.mkdir();
            }
            System.out.println(file.getOriginalFilename().substring(0,file.getOriginalFilename().lastIndexOf(".") ));
            String uuid = UUID.randomUUID().toString().replaceAll("-","");
            System.out.println(uuid);
            String name =uuid + "." + file.getOriginalFilename();
            java.io.File files  =  new File(realPaths, name); // ".jpg"
            files.setReadable(true);
            files.setExecutable(true);
            files.setWritable(true);
            file.transferTo(files);
            byte[] data = null;
            try {
                InputStream in = new FileInputStream(realPaths+name);
                data = new byte[in.available()];
                in.read(data);
                in.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
            return new ResultUtil<String>().setData(name);
        } catch (IOException e) {
            e.printStackTrace();
        } catch (IllegalStateException e) {
            e.printStackTrace();
        }
        return ResultUtil.error("FAIL");
    }


    /**
     * 小程序删除车辆
     * @param id 车辆ID
     * @param sellerId 卖家ID
     * @return
     */
    @RequestMapping(value = "/appDelete", method = RequestMethod.POST)
    public Result<Object> appDelete(@RequestParam String id,@RequestParam String sellerId){

        Car car = iCarService.getById(id);
        if(car == null) {
            return ResultUtil.error("不存在");
        }
        Seller seller = iSellerService.getById(sellerId);
        if(seller == null) {
            return ResultUtil.error("不存在");
        }
        iCarService.removeById(car.getId());
        return ResultUtil.success("OK");
    }


    @RequestMapping(value = "/getCarByQrCode", method = RequestMethod.GET)
    public Result<Car> appUpdate(@RequestParam String code){
        QueryWrapper<Car> qw = new QueryWrapper<>();
        qw.eq("qr_code",code);
        qw.orderByDesc("create_time");
        List<Car> carList = iCarService.list(qw);
        if(carList.size() > 0) {
            return new ResultUtil<Car>().setData(carList.get(0));
        }
        return new ResultUtil<Car>().setErrorMsg("NULL");
    }
}