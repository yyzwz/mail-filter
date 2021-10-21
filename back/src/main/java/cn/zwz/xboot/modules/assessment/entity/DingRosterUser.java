package cn.zwz.xboot.modules.assessment.entity;

import lombok.Data;

@Data
public class DingRosterUser {
    private String lastName;
    private long realmId;
    private String clientId;
    private String openid;
    private String realmName;
    private String nickNameCn;
    private String tenantUserId;
    private String employeeCode;
    private long accountId;
    private String tenantName;
    private String referId;
    private String namespace;
    private String tenantId;
    private String account;
}

/*
*  "lastName":"郑为中",
    "realmId":50175828,
    "clientId":"CJKH",
    "openid":"df2e4b3df9fd4eb3f07b42acb62aaf06",
    "realmName":"宁海县长街镇资产经营投资公司",
    "nickNameCn":"郑为中",
    "tenantUserId":"50175828$736687",
    "employeeCode":"GE_5d22b747744f45bf8d53abf54211b916",
    "accountId":736687,
    "tenantName":"宁海县长街镇资产经营投资公司",
    "referId":"736687",
    "namespace":"local",
    "tenantId":50175828,
    "account":"ISV-zwz"
},
* */