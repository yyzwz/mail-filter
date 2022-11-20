package cn.zwz.mail.controller;

import cn.zwz.basics.utils.PageUtil;
import cn.zwz.basics.utils.ResultUtil;
import cn.zwz.basics.baseVo.PageVo;
import cn.zwz.basics.baseVo.Result;
import cn.zwz.basics.utils.SecurityUtil;
import cn.zwz.data.entity.User;
import cn.zwz.data.service.IUserService;
import cn.zwz.data.utils.ZwzNullUtils;
import cn.zwz.mail.entity.Whitelist;
import cn.zwz.mail.service.IWhitelistService;
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
@Api(tags = "白名单档案管理接口")
@RequestMapping("/zwz/whitelist")
@Transactional
public class WhitelistController {

    @Autowired
    private IWhitelistService iWhitelistService;

    @Autowired
    private SecurityUtil securityUtil;

    @Autowired
    private IUserService iUserService;

    @RequestMapping(value = "/getOne", method = RequestMethod.GET)
    @ApiOperation(value = "查询单条白名单档案")
    public Result<Whitelist> get(@RequestParam String id){
        return new ResultUtil<Whitelist>().setData(iWhitelistService.getById(id));
    }

    @RequestMapping(value = "/count", method = RequestMethod.GET)
    @ApiOperation(value = "查询全部白名单档案个数")
    public Result<Long> getCount(){
        return new ResultUtil<Long>().setData(iWhitelistService.count());
    }

    @RequestMapping(value = "/getAll", method = RequestMethod.GET)
    @ApiOperation(value = "查询全部白名单档案")
    public Result<List<Whitelist>> getAll(){
        return new ResultUtil<List<Whitelist>>().setData(iWhitelistService.list());
    }

    @RequestMapping(value = "/getByPage", method = RequestMethod.GET)
    @ApiOperation(value = "查询白名单档案")
    public Result<IPage<Whitelist>> getByPage(@ModelAttribute Whitelist whitelist ,@ModelAttribute PageVo page){
        QueryWrapper<Whitelist> qw = new QueryWrapper<>();
        User currUser = securityUtil.getCurrUser();
        qw.eq("user_id",currUser.getId());
        if(!ZwzNullUtils.isNull(whitelist.getTitle())) {
            qw.like("title",whitelist.getTitle());
        }
        if(!ZwzNullUtils.isNull(whitelist.getMailAddress())) {
            qw.like("mail_address",whitelist.getMailAddress());
        }
        IPage<Whitelist> data = iWhitelistService.page(PageUtil.initMpPage(page),qw);
        return new ResultUtil<IPage<Whitelist>>().setData(data);
    }

    @RequestMapping(value = "/insertOrUpdate", method = RequestMethod.POST)
    @ApiOperation(value = "增改白名单档案")
    public Result<Whitelist> saveOrUpdate(Whitelist whitelist){
        User currUser = securityUtil.getCurrUser();
        whitelist.setUserId(currUser.getId());
        if(iWhitelistService.saveOrUpdate(whitelist)){
            return new ResultUtil<Whitelist>().setData(whitelist);
        }
        return ResultUtil.error();
    }

    @RequestMapping(value = "/insert", method = RequestMethod.POST)
    @ApiOperation(value = "新增白名单档案")
    public Result<Whitelist> insert(Whitelist whitelist){
        if(ZwzNullUtils.isNull(whitelist.getMailAddress())) {
            return ResultUtil.error("白名单邮箱不能为空");
        }
        QueryWrapper<User> userQw = new QueryWrapper<>();
        userQw.eq("email",whitelist.getMailAddress());
        User findUser = iUserService.getOne(userQw);
        if(findUser == null) {
            return ResultUtil.error("非系统用户邮箱");
        }
        whitelist.setMailId(findUser.getId());
        User currUser = securityUtil.getCurrUser();
        whitelist.setUserId(currUser.getId());
        iWhitelistService.saveOrUpdate(whitelist);
        return new ResultUtil<Whitelist>().setData(whitelist);
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ApiOperation(value = "编辑白名单档案")
    public Result<Whitelist> update(Whitelist whitelist){
        iWhitelistService.saveOrUpdate(whitelist);
        return new ResultUtil<Whitelist>().setData(whitelist);
    }

    @RequestMapping(value = "/delByIds", method = RequestMethod.POST)
    @ApiOperation(value = "删除白名单档案")
    public Result<Object> delByIds(@RequestParam String[] ids){
        for(String id : ids){
            iWhitelistService.removeById(id);
        }
        return ResultUtil.success();
    }
}
