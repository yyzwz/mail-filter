<template>
<div>
    <Card>
        <div slot="title">
            <div class="edit-head">
                <a @click="close" class="back-title">
                    <Icon type="ios-arrow-back" />返回
                </a>
                <div class="head-name">编辑</div>
                <span></span>
                <a @click="close" class="window-close">
                    <Icon type="ios-close" size="31" class="ivu-icon-ios-close" />
                </a>
            </div>
        </div>
        <Form ref="form" :model="form" :label-width="100" :rules="formValidate" label-position="left">
            <Row :gutter="16">
                <Col span="12">
                <FormItem label="邮件标题" prop="title">
                    <Input v-model="form.title" clearable style="width:100%" />
                </FormItem>
                </Col>
                <Col span="12">
                <FormItem label="收件人" prop="toId">
                    <Select v-model="form.toId" clearable style="width:100%">
                        <Option :value="item.id" v-for="(item,index) in mailUserList" :key="index">{{item.nickname}}</Option>
                    </Select>
                </FormItem>
                </Col>
            </Row>
            <Row :gutter="16">
                <Col span="24">
                <FormItem label="邮件内容" prop="content">
                    <Input v-model="form.content" type="textarea" :rows="12" clearable style="width:100%" />
                </FormItem>
                </Col>
            </Row>
            <Divider>可在下方添加邮件附件</Divider>
            <Row :gutter="16">
                <Col span="12">
                <upload-pic-input readonly @on-change="changeFile" v-model="tempFile" style="width:100%"></upload-pic-input>
                </Col>
            </Row>
            <Row :gutter="16">
                <Col span="24">
                <Table :loading="loading" border stripe size="small" :columns="fileColumns" :data="mailFileList"></Table>
                </Col>
            </Row>
            <Form-item class="br">
                <Button @click="saveCaoFx" :loading="submitLoading" type="primary">保存为草稿</Button>
                <Button @click="handleSubmit" :loading="submitLoading" type="primary">直接发送</Button>
                <Button @click="handleReset">重置</Button>
                <Button type="dashed" @click="close">关闭</Button>
            </Form-item>
        </Form>
    </Card>
</div>
</template>

<script>
import {
    addMailArchives,
    editMailArchives,
    saveCao,
    getAllMailUser,
    editCao,
    addFile,
    getAllMailFile,
    deleteMailFile
} from "./api.js";
import uploadPicInput from "@/views/template/upload-pic-input";
export default {
    name: "edit",
    components: {
        uploadPicInput
    },
    props: {
        data: Object
    },
    data() {
        return {
            tempFile: "",
            submitLoading: false, // 表单提交状态
            form: { // 添加或编辑表单对象初始化数据
                title: "",
                toId: "",
                toUser: "",
                content: "",
                file: "",
            },
            // 表单验证规则
            formValidate: {},
            mailUserList: [],
            saveFlag: 0,
            mailFileList: [],
            fileColumns: [{
                    title: "序号",
                    width: 85,
                    align: "center",
                    fixed: "left",
                    type: "index"
                },
                {
                    title: "附件名称",
                    key: "title",
                    minWidth: 120,
                    tooltip: true,
                    sortable: false,
                },
                {
                    title: "附件大小",
                    key: "fileSize",
                    minWidth: 120,
                    tooltip: true,
                    sortable: false,
                },
                {
                    title: "文件地址",
                    key: "fileId",
                    minWidth: 120,
                    tooltip: true,
                    sortable: false,
                },
                {
                    title: "操作",
                    key: "action",
                    align: "center",
                    width: 240,
                    fixed: "right",
                    render: (h, params) => {
                        return h("div", [
                            h(
                                "Button", {
                                    props: {
                                        type: "primary",
                                        size: "small",
                                        icon: "ios-create-outline",
                                        ghost: true,
                                    },
                                    style: {
                                        marginRight: "5px"
                                    },
                                    on: {
                                        click: () => {
                                            this.lookFileFx(params.row);
                                        }
                                    }
                                },
                                "预览"
                            ),
                            h(
                                "Button", {
                                    props: {
                                        type: "error",
                                        size: "small",
                                        icon: "md-trash",
                                        ghost: true,
                                    },
                                    on: {
                                        click: () => {
                                            this.deleteMailFileFx(params.row);
                                        }
                                    }
                                },
                                "删除"
                            )
                        ]);
                    }
                }
            ]
        };
    },
    methods: {
        init() {
            this.getAllMailUserFx();
            this.handleReset();
            this.form = this.data;
            this.getAllMailFileFx();
        },
        lookFileFx(e) {
            window.open(e.fileId + "?preview=true");
        },
        deleteMailFileFx(e) {
            var that = this;
            deleteMailFile({
                ids: e.id
            }).then(res => {
                if (res.success) {
                    that.getAllMailFileFx();
                    this.$Message.success("保存成功");
                }
            })
        },
        getAllMailFileFx() {
            var that = this;
            getAllMailFile({
                mailId: that.form.id
            }).then(res => {
                if (res.success) {
                    that.mailFileList = res.result;
                }
            })
        },
        changeFile() {
            var that = this;
            addFile({
                mailId: that.form.id,
                fileId: that.tempFile
            }).then(res => {
                if (res.success) {
                    that.getAllMailFileFx();
                    this.$Message.success("文件上传成功");
                }
            })
        },
        saveCaoFx() {
            var that = this;
            if (that.saveFlag < 1) {
                saveCao(this.form).then(res => {
                    this.submitLoading = false;
                    if (res.success) {
                        that.saveFlag = 1;
                        that.form.id = res.result.id;
                        this.$Message.success("保存成功");
                    }
                });
            }
            if (that.saveFlag > 0) {
                var tempForm = {};
                tempForm = that.form;
                editCao(tempForm).then(res => {
                    this.submitLoading = false;
                    if (res.success) {
                        this.$Message.success("保存成功");
                    }
                });
            }
        },
        getAllMailUserFx() {
            var that = this;
            getAllMailUser().then(res => {
                if (res.success) {
                    that.mailUserList = res.result;
                }
            })
        },
        handleReset() {
            this.$refs.form.resetFields();
        },
        handleSubmit() {
            this.$refs.form.validate(valid => {
                if (valid) {
                    addMailArchives(this.form).then(res => {
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
