var util = require('../../utils/util.js');
const app = getApp();
Page({
  data:{
    orderList:[],
    nowId: '',
    dataItem:{
      id: '',
      sellDate: '',
      jia: '',
      gu: '',
      pinPai: '',
      xingHao: '',
      type: '',
      sellerName: '',
      name: '',
      mobile: '',
      re1: '',
      re2: '',
      addressHu: '',
      addressZhu: '',
      jiaNumber: ''
    },
    msgTemp: ''
  },
  onLoad: function (options) {
    console.log(options);
    wx.showLoading({});
    var that = this;
    this.setData({
      nowId: options.id
    })
    this.getData();
    wx.hideLoading();
  },
  preview1(event) {
    let currentUrl = "https://changjienongye.cn/docs/static/" + event.currentTarget.dataset.src;
    var tempList = [];
    tempList.push(currentUrl);
    wx.previewImage({
      current: currentUrl,
      urls: tempList
    })
  },
  passItem() {
    var that = this;
    wx.request({      
      url: app.data.appUrl + '/car/sh',
      method: "POST",
      data: {
        id: that.data.dataItem.id,
        msg: 'OK',
        msg2: that.data.msgTemp
      },
      header: {
        'content-type': 'application/x-www-form-urlencoded'
      },
      success: function (res) {
        console.log(res);
        if(res.data.success) {
          wx.navigateBack({
            delta: 1,
            success: function () {
              wx.showToast({
                title: '操作成功!',
              })
            }
          })
        }
      }
    }) 
  },
  notpassItem() {
    var that = this;
    console.log(that.data.dataItem.id);
    wx.request({      
      url: app.data.appUrl + '/car/sh',
      method: "POST",
      data: {
        id: that.data.dataItem.id,
        msg: '2',
        msg2: that.data.msgTemp
      },
      header: {
        'content-type': 'application/x-www-form-urlencoded'
      },
      success: function (res) {
        console.log(res);
        if(res.data.success) {
          wx.navigateBack({
            delta: 1,
            success: function () {
              wx.showToast({
                title: '操作成功!',
              })
            }
          })
        }
      }
    }) 
  },
  changeMsg(e) {
    this.setData({
      msgTemp: e.detail.value
    })
  },
  deleteCar(e) {
    console.log(e);
  },
  getData :function(){
    var that = this;
    wx.request({      
      url: app.data.appUrl + '/car/get?id=' + that.data.nowId,
      method: "GET",
      header: {
        'content-type': 'application/json'
      },
      success: function (res) {
        console.log(res);
        that.setData({
          dataItem: res.data.result
        });
      }
    }) 
  },
  deletePUL:function(res){
    var deleteId = res.currentTarget.dataset.id;
    wx.showModal({
      title: '确认取消预约？',
      confirmText:'删除',
      confirmColor: "#f00",
      cancelText:'取消',
      cancelColor:'#0f0',
      success: function (res) {
        if(res.cancel){
        }else if(res.confirm){
          wx.request({
            url: app.data.appUrl + '/pul/deleteOrder?id=' + deleteId,
            method: "GET",
            header: {
              'content-type': 'application/json'
            },
            success: function (res) {
              wx.navigateBack({
                delta: 1,
              })
            }
          }) 
        }
      }
    })
  }
})