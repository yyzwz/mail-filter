package cn.zwz.xboot.modules.tricycle.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Accessors(chain = true)
public class CarImportBaoXianVo {
    private String 保单号;
    private String 起保日期;
    private String 终止日期;
    private String 被保人;
    private String 证件号;
    private String 电话;
    private String 地址;
    private String 车牌号;
    private String 车架号;
    private String 二维码;
//    private String bdh;
//    private String qbri;
//    private String zzrq;
//    private String userName;
//    private String idCard;
//    private String mobile;
//    private String address;
//    private String cph;
//    private String cjh;
}
