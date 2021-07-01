<template>
  <div class="search">
    <!-- <add v-if="currView=='add'" @close="currView='index'" @submited="submited" />
    <edit v-if="currView=='edit'" @close="currView='index'" @submited="submited" :data="formData" /> -->
    <Card v-show="currView=='index'">
      <Row @keydown.enter.native="handleSearch">
        <Form ref="searchForm" :model="searchForm" inline :label-width="90">
          <Form-item label="四级村社" prop="timeName">
            <!-- <Input type="text" v-model="searchForm.timeName" placeholder="请输入考核期名称" clearable style="width: 200px"/> -->
            <Select placeholder="请选择" clearable style="width: 200px" @on-change="changeLine">
              <Option v-for="item in villageList" :value="item.id" :key="item.id">{{ item.villageName }}</Option>
            </Select>
          </Form-item>
          <Form-item style="margin-left:-35px;" class="br">
            <!-- <Button @click="handleSearch" type="primary" icon="ios-search">搜索</Button>
            <Button @click="handleReset">重置</Button> -->
            <span style="color:#f00;font-size:20px"> 请选择四级村社 </span>
          </Form-item>
        </Form>
      </Row>
      <Row class="operation">
        <Button @click="add" type="primary" icon="md-add">添加</Button>
        <Button @click="delAll" icon="md-trash">批量删除</Button>
        <Button @click="getDataList" icon="md-refresh">刷新</Button>
        <Button type="dashed" @click="openTip=!openTip">{{openTip ? "关闭提示" : "开启提示"}}</Button>
      </Row>
      <Row>
        <Table :loading="loading" ref="table" sortable="custom" :columns="columns14" :data="dataList" border ></Table>
        <!-- :span-method="handleSpan" -->
      </Row>
    </Card>
    <Modal
      v-model="isShenShu"
      title="四级账户申述"
      @on-ok="shenShuFx">
      <span>请输入申述的原因</span>
      <input v-model="shenShuReason" />
    </Modal>
  </div>
</template>

<script>
// 根据你的实际请求api.js位置路径修改
import { getAllVillageList,getFourWindowsList, deleteTwoWindows,getNowTimes,getAllAssessmentLine,updateTwoWindows } from "./api.js";
// 根据你的实际添加编辑组件位置路径修改
// import add from "./add.vue";
// import edit from "./edit.vue";
export default {
  name: "single-window",
  components: {
    // add,
    // edit
  },
  data() {
    return {
      dataList: [],
      villageList: [],
      shenShuReason: '',
      isShenShu: false,
      currView: 'index',
      columns14: [
        {
          type: "index",
          width: 60,
          align: "center"
        },
        {
          title: '条线', // 条线
          key: 'requireText',
          minWidth: 60,
          align: "center",
        },
        {
          title: '村庄名', // 内容编号
          key: 'villageName',
          minWidth: 60,
          align: "center",
        },
        {
          title: '子项', // 内容
          key: 'itemName',
          minWidth: 300,
          align: "center",
        },
        {
          title: '考核意见', // 加减分原因
          key: 'requireReason',
          minWidth: 200,
          align: "center",
        },
        {
          title: '成绩', // 加减分
          key: 'grade',
          minWidth: 80,
          align: "center",
        },
        {
          title: 'F', // 申述
          key: 'state',
          minWidth: 100,
          align: "center",
          render: (h, params) => {
          var that = this;
          if(params.row.content != '总计') {
            return h('div', [
              h('Button', {
                props: {
                  type: 'error',
                  // size: 'small',
                },
                on: {
                  "on-blur": function(){
                    // that.nowInputRow = params.row;
                    // that.saveByInput();
                  },
                  click: (e) => {
                    console.log(params);
                    that.isShenShuFx(params)
                    // params.row.c = e;
                  }
                }
              },"申述")
            ])
          } else {
            return h('div',[
              h('span', {
                style: {
                    color: '#000000'
                }
              }, ""),
            ]);
          }
        }
        }
      ],
      data5: [
        {
          line: '条线',
          number: '内容',
          reason: '我村的情况',
        },
        { 
          line: '城建',
          number: '1',
          content: '城建容积率大于1.0',
          reason: '做得很好',
          star: '+1',
          state: '按钮',
        },{
          line: '城建',
          number: '2',
          content: '城市建设符合欧盟标准',
          reason: '做得很好',
          star: '+1',
          state: '按钮',
        },{
          line: '城建',
          number: '3',
          content: '城建符合OSI标准',
          reason: '做得很好',
          star: '+1',
          state: '按钮',
        },{
          line: '城建',
          number: '4',
          content: '城建符合IEEO标准',
          reason: '做得很好',
          star: '+1',
          state: '按钮',
        },{
          line: '',
          number: '',
          content: '总计',
          reason: '',
          star: '+4',
          state: '',
        },
        {
          line: '农办',
          number: '3',
          content: '农民要丰收',
          reason: '做得不错',
          star: '+2',
          state: '按钮',
        },{
          line: '农办',
          number: '4',
          content: '农民要很开心',
          reason: '做得很不错',
          star: '+3',
          state: '按钮',
        },{
          line: '',
          number: '',
          content: '总计',
          reason: '',
          star: '+5',
          state: '',
        },
      ],
      selectVillageId: '',
    };
  },
  methods: {
    init() {
      this.getAllVillageListFx();
      // this.getFourWindowsListFx();
    },
    getFourWindowsListFx() {
      var that = this;
      getFourWindowsList({villageId: that.selectVillageId,timeId: '1376067966306750464'}).then(res => {
        that.dataList = res.result;
      })
    },
    getAllVillageListFx() {
      var that = this;
      getAllVillageList().then(res => {
        that.villageList = res.result;
      })
    },
    changeLine(e) {
      this.selectVillageId = e;
      this.getFourWindowsListFx();
    },
    shenShuFx() {
      this.$Message.success("申述提交成功;" + this.shenShuReason);
    },
    isShenShuFx(e) {
      console.log(e);
      this.isShenShu = true;
    },
    handleSpan ({ row, column, rowIndex, columnIndex }) {
      if (rowIndex === 0 && columnIndex === 0) {
          return {
              rowspan: 1,
              colspan: 1
          };
      } else if (rowIndex === 0 && columnIndex === 1) {
          return {
              rowspan: 1,
              colspan: 2
          };
      }
      else if (rowIndex === 0 && columnIndex === 2) {
          return {
              rowspan: 0,
              colspan: 0
          };
      }else if (rowIndex === 0 && columnIndex === 3) {
          return {
              rowspan: 1,
              colspan: 3
          };
      }
    }   
  },
  mounted() {
    this.init();
  }
};
</script>
<style lang="less">
// 建议引入通用样式 具体路径自行修改 可删除下面样式代码
// @import "../../../styles/table-common.less";
.search {
    .operation {
        margin-bottom: 2vh;
    }
    .select-count {
        font-weight: 600;
        color: #40a9ff;
    }
    .select-clear {
        margin-left: 10px;
    }
    .page {
        margin-top: 2vh;
    }
    .drop-down {
        margin-left: 5px;
    }
}
</style>