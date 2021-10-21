package cn.zwz.xboot.modules.assessment.controller;

import cn.zwz.xboot.common.utils.PageUtil;
import cn.zwz.xboot.common.utils.ResultUtil;
import cn.zwz.xboot.common.vo.PageVo;
import cn.zwz.xboot.common.vo.Result;
import cn.zwz.xboot.modules.assessment.entity.DingRosterUser;
import cn.zwz.xboot.modules.assessment.entity.RosterUserA;
import cn.zwz.xboot.modules.assessment.service.IRosterUserAService;
import cn.hutool.core.util.StrUtil;
import cn.zwz.xboot.modules.utils.WeiChatUtils;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.xxpt.gateway.shared.client.http.ExecutableClient;
import com.alibaba.xxpt.gateway.shared.client.http.PostClient;
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
@Api(description = "考核系统用户管理接口")
@RequestMapping("/xboot/rosterUserA")
@Transactional
public class RosterUserAController {

    @Autowired
    private IRosterUserAService iRosterUserAService;


    @RequestMapping(value = "getLoginUser", method = RequestMethod.GET)
    public Result<DingRosterUser> getLoginUser(@RequestParam String authCode){
        DingRosterUser user = new DingRosterUser();
        ExecutableClient executableClient =ExecutableClient.getInstance();
        executableClient.setAccessKey("CJKH-2vV9AaHI0xyyALw1qxmYJVNBv");
        executableClient.setSecretKey("2w052keMJaxc4vR9NRXEJFNsSi4hqTh03C7a82wd");
        executableClient.setDomainName("openplatform.dg-work.cn");
        executableClient.setProtocal("https");
        executableClient.init();

        String api ="/rpc/oauth2/dingtalk_app_user.json";
        PostClient postClient = executableClient.newPostClient(api);
        postClient.addParameter("access_token", WeiChatUtils.getToken());
        postClient.addParameter("auth_code", authCode);
        String apiResult = postClient.post();
        System.out.println(apiResult);
        JSONObject json1 = JSONObject.parseObject(apiResult);
        Boolean flag = json1.getBoolean("success");
        if(flag) {
            JSONObject content = json1.getJSONObject("content");
            Boolean success = content.getBoolean("success");
            if(success) {
                JSONObject data = content.getJSONObject("data");
                user.setLastName(data.getString("lastName"));
                user.setRealmId(data.getLong("realmId"));
                user.setClientId(data.getString("clientId"));
                user.setOpenid(data.getString("openid"));
                user.setRealmName(data.getString("realmName"));
                user.setNickNameCn(data.getString("nickNameCn"));
                user.setTenantUserId(data.getString("tenantUserId"));
                user.setEmployeeCode(data.getString("employeeCode"));
                user.setAccountId(data.getLong("accountId"));
                user.setTenantName(data.getString("tenantName"));
                user.setReferId(data.getString("referId"));
                user.setNamespace(data.getString("namespace"));
                user.setTenantId(data.getString("tenantId"));
                user.setAccount(data.getString("account"));
                return new ResultUtil<DingRosterUser>().setData(user);
            }
        }
        return new ResultUtil<DingRosterUser>().setErrorMsg("操作失败");
    }


    @RequestMapping(value = "/get/{id}", method = RequestMethod.GET)
    @ApiOperation(value = "通过id获取")
    public Result<RosterUserA> get(@PathVariable String id){

        RosterUserA rosterUserA = iRosterUserAService.getById(id);
        return new ResultUtil<RosterUserA>().setData(rosterUserA);
    }

    @RequestMapping(value = "/getAll", method = RequestMethod.GET)
    @ApiOperation(value = "获取全部数据")
    public Result<List<RosterUserA>> getAll(){

        List<RosterUserA> list = iRosterUserAService.list();
        return new ResultUtil<List<RosterUserA>>().setData(list);
    }

    @RequestMapping(value = "/getByPage", method = RequestMethod.GET)
    @ApiOperation(value = "分页获取")
    public Result<IPage<RosterUserA>> getByPage(PageVo page){

        IPage<RosterUserA> data = iRosterUserAService.page(PageUtil.initMpPage(page));
        return new ResultUtil<IPage<RosterUserA>>().setData(data);
    }

    @RequestMapping(value = "/insertOrUpdate", method = RequestMethod.POST)
    @ApiOperation(value = "编辑或更新数据")
    public Result<RosterUserA> saveOrUpdate(RosterUserA rosterUserA){

        if(iRosterUserAService.saveOrUpdate(rosterUserA)){
            return new ResultUtil<RosterUserA>().setData(rosterUserA);
        }
        return new ResultUtil<RosterUserA>().setErrorMsg("操作失败");
    }

    @RequestMapping(value = "/delByIds", method = RequestMethod.POST)
    @ApiOperation(value = "批量通过id删除")
    public Result<Object> delAllByIds(@RequestParam String[] ids){

        for(String id : ids){
            iRosterUserAService.removeById(id);
        }
        return ResultUtil.success("批量通过id删除数据成功");
    }
}
