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
        <FormItem label="考核线" prop="lineId"  >
          <Select v-model="form.lineId" placeholder="请选择" clearable style="width: 570px" @on-change="changeLine">
            <Option v-for="item in lineList" :value="item.id" :key="item.id">{{ item.lineName }}</Option>
          </Select>
          <!-- <Input v-model="form.lineName" clearable style="width:570px"/> -->
        </FormItem>
        <FormItem label="排序值" prop="sortNumber"  >
          <Input v-model="form.sortLevel" clearable style="width:570px"/>
        </FormItem>
          <FormItem label="考核细要求" prop="itemTitle"  >
            <Input v-model="form.itemTitle" clearable type="textarea" :rows="4" style="width:570px"/>
          </FormItem>
          <!-- <FormItem label="排序值" prop="itemTitle"  >
            <InputNumber :max="10000" :min="0" v-model="form.sortLevel" style="width:570px"></InputNumber>
          </FormItem> -->
          
          <FormItem label="备注" prop="remark"  >
            <Input v-model="form.remark" clearable style="width:570px"/>
          </FormItem>
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
import { addAssessmentLineItem,getNowTimes,getAllAssessmentLine } from "./api.js";
export default {
  name: "add",
  components: {
    },
  data() {
    return {
      submitLoading: false, // 表单提交状态
      form: { // 添加或编辑表单对象初始化数据
        lineId: "",
        timeId: "",
        lineName: "",
        timeName: "",
        itemTitle: "",
        remark: "",
      },
      // 表单验证规则
      formValidate: {
      },
      nowTimeList: [],
      lineList: []
    };
  },
  methods: {
    init() {
      this.getAllAssessmentLineFx();
      // this.getNowTimesFx();
    },
    getAllAssessmentLineFx() {
      var that = this;
      getAllAssessmentLine().then(res => {
        that.lineList = res.result;
      })
    },
    getNowTimesFx() {
      var that = this;
      getNowTimes().then(res => {
        that.nowTimeList = res.result;
        that.form.timeId = res.result[0].id;
        that.form.timeName = res.result[0].timeName;
      })
    },
    changeLine(e) {
      console.log(e);
    },
    handleReset() {
      this.$refs.form.resetFields();
    },
    handleSubmit() {
      this.$refs.form.validate(valid => {
        if (valid) {
          addAssessmentLineItem(this.form).then(res => {
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