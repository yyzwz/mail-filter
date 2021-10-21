<template>
  <div>
    <Card>
      <div slot="title">
        <div class="edit-head">
          <a @click="close" class="back-title">
            <Icon type="ios-arrow-back" />返回
          </a>
          <div class="head-name">添加</div>
          <span></span>
          <a @click="close" class="window-close">
            <Icon type="ios-close" size="31" class="ivu-icon-ios-close" />
          </a>
        </div>
      </div>
      <Form ref="form" :model="form" :label-width="100" :rules="formValidate" label-position="left" >
        <FormItem label="考核期名称" prop="timeName"  >
            <Input v-model="form.timeName" clearable style="width:570px"/>
          </FormItem>
          <FormItem label="考核期备注" prop="timeRemark"  >
            <Input v-model="form.timeRemark" clearable style="width:570px"/>
          </FormItem>
          <FormItem label="开始时间" prop="startDate"  >
            <DatePicker format="yyyy-MM-dd" type="date" style="width: 570px" @on-change="changeStartDate"></DatePicker>
          </FormItem>
          <FormItem label="结束时间" prop="endDate"  >
            <DatePicker format="yyyy-MM-dd" type="date" style="width: 570px" @on-change="changeEndDate"></DatePicker>
          </FormItem>
          <FormItem label="排序值" prop="sortLevel"  >
            <Input v-model="form.sortLevel" clearable style="width:570px"/>
          </FormItem>
          <!-- <FormItem label="是否运行" prop="isRun"  >
            <Select v-model="form.isRun" clearable style="width:570px">
                  <Option value="1">运行</Option>
                  <Option value="0">未启用</Option>
                  <Option value="2">历史</Option>
            </Select>
          </FormItem> -->
          <Form-item class="br">
            <Button
              @click="handleSubmit"
              :loading="submitLoading"
              type="primary"
            >提交并保存</Button>
            <Button @click="handleReset">重置</Button>
            <Button type="dashed" @click="close">关闭</Button>
          </Form-item>
        </Form>
    </Card>
  </div>
</template>

<script>
// 根据你的实际请求api.js位置路径修改
import { addAssessmentTime } from "./api.js";
export default {
  name: "add",
  components: {
    },
  data() {
    return {
      submitLoading: false, // 表单提交状态
      form: { // 添加或编辑表单对象初始化数据
        timeName: "",
        timeRemark: "",
        isRun: "",
      },
      // 表单验证规则
      formValidate: {
      }
    };
  },
  methods: {
    init() {},
    changeStartDate(e) {
      this.form.startDate = e;
    },
    changeEndDate(e) {
      this.form.endDate = e;
    },
    handleReset() {
      this.$refs.form.resetFields();
    },
    handleSubmit() {
      this.$refs.form.validate(valid => {
        if (valid) {
          addAssessmentTime(this.form).then(res => {
            this.submitLoading = false;
            if (res.success) {
              this.$Message.success("操作成功");
              this.submited();
            }
          });
        }
      });
    },
    close() {
      this.$emit("close", true);
    },
    submited() {
      this.$emit("submited", true);
    }
  },
  mounted() {
    this.init();
  }
};
</script>
<style lang="less">
// 建议引入通用样式 具体路径自行修改 可删除下面样式代码
// @import "../../../styles/single-common.less";
.edit-head {
    display: flex;
    align-items: center;
    justify-content: space-between;
    position: relative;

    .back-title {
        color: #515a6e;
        display: flex;
        align-items: center;
    }

    .head-name {
        display: inline-block;
        height: 20px;
        line-height: 20px;
        font-size: 16px;
        color: #17233d;
        font-weight: 500;
        overflow: hidden;
        text-overflow: ellipsis;
        white-space: nowrap;
    }

    .window-close {
        z-index: 1;
        font-size: 12px;
        position: absolute;
        right: 0px;
        top: -5px;
        overflow: hidden;
        cursor: pointer;

        .ivu-icon-ios-close {
            color: #999;
            transition: color .2s ease;
        }
    }

    .window-close .ivu-icon-ios-close:hover {
        color: #444;
    }
}
</style>