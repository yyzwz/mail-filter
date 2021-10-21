var util = require('../../utils/util.js');
const app = getApp();
Page({
  data:{
    orderList:[],
  },
  onLoad: function (options) {
    wx.showLoading({});
    var that = this;
    this.getData();
    wx.hideLoading();
  },
  deleteCar(e) {
    console.log(e);
  },
  getData :function(){
    var that = this;
    wx.request({
      url: app.data.appUrl + '/shMsg/getBySellerId?sellerId=' + app.data.id,
      method: "GET",
      header: {
        'content-type': 'application/json'
      },
      success: function (res) {
        console.log(res);
        that.setData({
          orderList: res.data.result
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