package cn.zwz.xboot.modules.tricycle.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Accessors(chain = true)
public class CarImportBaoXianVo2 {
    private String idCard;
    private String bdh;
    private String startTime;
    private String endTime;
    private String jia;
}
