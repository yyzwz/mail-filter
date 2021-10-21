<template>
  <div>
    <Drawer title="导入村社数据" closable v-model="visible" draggable width="450">
      <car>
        <Row>
          <Table
            :loading="hualoading"
            border
            :columns="userColumns"
            :data="huaData"
            sortable="custom"
            @on-selection-change="selectChange"
            @on-row-dblclick="huashowHuaSelect"
            ref="table1"
          ></Table>
          <br>
        </Row>
        <Row type="flex" justify="end" class="page">
          <Page
            :current="huasearchForm.pageNumber"
            :total="huaTotal"
            :page-size="huasearchForm.pageSize"
            @on-change="huachangePage"
            @on-page-size-change="huachangePageSize"
            :page-size-opts="[10,20,50]"
            size="small"
            show-total
            show-elevator
            show-sizer
          ></Page>
        </Row>
        <span style="font-size:30px;color:#f00">请选择村社完成关联！</span><br>
        <Button type="primary" @click="imoprtIn">导入</Button>
        <Button type="primary" @click="closeWindow">退出</Button>
      </car>
    </Drawer>
  </div>
</template>

<script>
import { 
  getVillageList} from "./api.js";
export default {
  name: "add",
  components: {
  },
  props: {
    value: {
      type: Boolean,
      default: false
    },
    data: {
      type: Object
    },
  },
  watch: {
    value(val) {
      this.setCurrentValue(val);
    },
    visible(value) {
      this.$emit("input", value);
    }
  },
  data() {
    return {
      showValue:false,
      visible: this.value,
      title: "",
      submitLoading: false,
      maxHeight: 510,
      form: {},
      formValidate: {
      },
      roleList: [],
      userColumns: [
        {
          type: "selection",
          width: 60,
          align: "center"
        },
        {
          type: "index",
          width: 60,
          align: "center"
        },
        {
          title: "村社名称",
          key: "villageName",
          minWidth: 120,
          sortable: false,
        },
        {
          title: "备注",
          key: "remark",
          minWidth: 120,
          sortable: false,
        }
      ],
      isImportHuaData:true,
      huasearchForm: {
        pageNumber: 1,
        pageSize: 10,
        username: "",
        groupId:'',
        departmentId: ''
      },
      selectHuaList :[],
      selectHuaCount :[],
      huaData:[],
      ansIds: ''
    };
  },
  methods: {
    init() {
      this.getHuaUserList();
    },
    selectChange(ee) {
      var ids = "";
      ee.forEach(function(e) {
        ids += e.id + ",";
      });
      ids = ids.substring(0, ids.length - 1);
      this.ansIds = ids;
    },
    handleSelectDep(e) {
      var that = this;
      e.forEach(function(ee) {
        that.huasearchForm.departmentId = ee.id;
      });
    },
    imoprtIn(e){
      this.$emit("submited", this.ansIds);
    },
    setCurrentValue(value) {
      if (value === this.visible) {
        return;
      }
      this.visible = value;
    },
    closeWindow(){
      this.visible=false;
    },
    huachangePage(v) {
      this.huasearchForm.pageNumber = v;
      this.getHuaUserList();
      this.huaclearSelectAll();
    },
    huachangePageSize(v) {
      this.huasearchForm.pageSize = v;
      this.getHuaUserList();
    },
    getHuaUserList() {
      this.hualoading = true;
      getVillageList(this.huasearchForm).then(res => { // getHuaListData
        this.hualoading = false;
        if (res.success) {
          this.huaData = res.result.records;
          this.huaTotal = res.result.total;
        }
      });
    },
  },
  mounted() {
    this.init();
  }
};
</script>
<style lang="less">
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