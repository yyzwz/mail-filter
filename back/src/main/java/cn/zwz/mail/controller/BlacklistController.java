package cn.zwz.mail.controller;

import cn.zwz.basics.utils.PageUtil;
import cn.zwz.basics.utils.ResultUtil;
import cn.zwz.basics.baseVo.PageVo;
import cn.zwz.basics.baseVo.Result;
import cn.zwz.basics.utils.SecurityUtil;
import cn.zwz.data.entity.User;
import cn.zwz.data.service.IUserService;
import cn.zwz.data.utils.ZwzNullUtils;
import cn.zwz.mail.entity.Blacklist;
import cn.zwz.mail.service.IBlacklistService;
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
@Api(tags = "黑名单档案管理接口")
@RequestMapping("/zwz/blacklist")
@Transactional
public class BlacklistController {

    @Autowired
    private IBlacklistService iBlacklistService;

    @Autowired
    private SecurityUtil securityUtil;

    @Autowired
    private IUserService iUserService;

    @RequestMapping(value = "/getOne", method = RequestMethod.GET)
    @ApiOperation(value = "查询单条黑名单档案")
    public Result<Blacklist> get(@RequestParam String id){
        return new ResultUtil<Blacklist>().setData(iBlacklistService.getById(id));
    }

    @RequestMapping(value = "/count", method = RequestMethod.GET)
    @ApiOperation(value = "查询全部黑名单档案个数")
    public Result<Long> getCount(){
        return new ResultUtil<Long>().setData(iBlacklistService.count());
    }

    @RequestMapping(value = "/getAll", method = RequestMethod.GET)
    @ApiOperation(value = "查询全部黑名单档案")
    public Result<List<Blacklist>> getAll(){
        return new ResultUtil<List<Blacklist>>().setData(iBlacklistService.list());
    }

    @RequestMapping(value = "/getByPage", method = RequestMethod.GET)
    @ApiOperation(value = "查询黑名单档案")
    public Result<IPage<Blacklist>> getByPage(@ModelAttribute Blacklist blacklist ,@ModelAttribute PageVo page){
        QueryWrapper<Blacklist> qw = new QueryWrapper<>();
        User currUser = securityUtil.getCurrUser();
        qw.eq("user_id",currUser.getId());
        if(!ZwzNullUtils.isNull(blacklist.getTitle())) {
            qw.like("title",blacklist.getTitle());
        }
        if(!ZwzNullUtils.isNull(blacklist.getMailAddress())) {
            qw.like("mail_address",blacklist.getMailAddress());
        }
        IPage<Blacklist> data = iBlacklistService.page(PageUtil.initMpPage(page),qw);
        return new ResultUtil<IPage<Blacklist>>().setData(data);
    }

    @RequestMapping(value = "/insertOrUpdate", method = RequestMethod.POST)
    @ApiOperation(value = "增改黑名单档案")
    public Result<Blacklist> saveOrUpdate(Blacklist blacklist){
        if(ZwzNullUtils.isNull(blacklist.getMailId())) {
            return ResultUtil.error("黑名单邮箱不能为空");
        }
        User currUser = securityUtil.getCurrUser();
        blacklist.setUserId(currUser.getId());
        if(iBlacklistService.saveOrUpdate(blacklist)){
            return new ResultUtil<Blacklist>().setData(blacklist);
        }
        return ResultUtil.error();
    }

    @RequestMapping(value = "/insert", method = RequestMethod.POST)
    @ApiOperation(value = "新增黑名单档案")
    public Result<Blacklist> insert(Blacklist blacklist){
        if(ZwzNullUtils.isNull(blacklist.getMailAddress())) {
            return ResultUtil.error("黑名单邮箱不能为空");
        }
        QueryWrapper<User> userQw = new QueryWrapper<>();
        userQw.eq("email",blacklist.getMailAddress());
        User findUser = iUserService.getOne(userQw);
        if(findUser == null) {
            return ResultUtil.error("非系统用户邮箱");
        }
        blacklist.setMailId(findUser.getId());
        User currUser = securityUtil.getCurrUser();
        blacklist.setUserId(currUser.getId());
        iBlacklistService.saveOrUpdate(blacklist);
        return new ResultUtil<Blacklist>().setData(blacklist);
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ApiOperation(value = "编辑黑名单档案")
    public Result<Blacklist> update(Blacklist blacklist){
        iBlacklistService.saveOrUpdate(blacklist);
        return new ResultUtil<Blacklist>().setData(blacklist);
    }

    @RequestMapping(value = "/delByIds", method = RequestMethod.POST)
    @ApiOperation(value = "删除黑名单档案")
    public Result<Object> delByIds(@RequestParam String[] ids){
        for(String id : ids){
            iBlacklistService.removeById(id);
        }
        return ResultUtil.success();
    }
}
