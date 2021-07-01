package cn.zwz.xboot.modules.activiti.vo;

import lombok.Data;

import java.util.List;

/**
 * @author 郑为中
 */
@Data
public class ActPage<T> {

    List<T> content;

    Long totalElements;
}
