import auth from './utils/auth';
import config from './utils/config';


// 郑为中
// 全局JS文件
App({
  data: {
    openId: '',
    sessionkey: '',
    shopName: '',
    shopDuty:'',
    remark: '',
    mobile: '',
    idCard: '',
    id: '',
    yyzz: '',
    date: '',
    address: '',
    sh: 0,
    ewmFlag: 0,
    // appUrl: 'https://localhost:8080/xboot',
    appUrl: 'https://changjienongye.cn:8080/xboot',
  },
  onLoad: function (options) {
    console.log("app页面获取的loginID = " + options.loginID);
  },
  onLaunch: function () {
    // 展示本地存储能力
    var logs = wx.getStorageSync('logs') || []
    logs.unshift(Date.now())
    wx.setStorageSync('logs', logs)

    // 登录
    var that = this;
    wx.login({
      success: function (res) {
        var codee = res.code;
        wx.request({
          url: 'https://changjienongye.cn/docs/getOpenId_zc.jsp?code=' + codee,
          method: 'POST',
          header: {
            'content-type': 'application/json'
          },
          success: function (res) {
            that.data.sessionkey = res.data.session_key;
            that.data.openId = res.data.openid;
            wx.request({
              url: 'https://changjienongye.cn:8080/xboot/seller/getByOpenId',
              data: {
                openId: that.data.openId
              },
              method: 'GET',
              header: {
                'content-type': 'application/x-www-form-urlencoded'
              },
              success: function (ress) {
                console.log(ress);
                if(ress.data.result.idCard == 'admin') {
                  that.data.openId = ress.data.result.openId;
                  that.data.shopName = ress.data.result.shopName;
                  that.data.mobile = ress.data.result.mobile;
                  that.data.idCard = ress.data.result.idCard;
                  wx.navigateTo({
                    url: '/pages/main2/main',
                    success:function() {
                      wx.showToast({
                        title: '管理员登入成功',
                      })
                    }
                  })
                }
                else if(ress.data.result.idCard != '') {
                  that.data.openId = ress.data.result.openId;
                  that.data.shopName = ress.data.result.shopName;
                  that.data.shopDuty = ress.data.result.shopDuty;
                  that.data.remark = ress.data.result.remark;
                  that.data.mobile = ress.data.result.mobile;
                  that.data.idCard = ress.data.result.idCard;
                  that.data.id = ress.data.result.id;
                  that.data.yyzz = ress.data.result.yyzz;
                  that.data.date = ress.data.result.date;
                  that.data.address = ress.data.result.address;
                  that.data.sh = ress.data.result.sh;
                  if(that.data.ewmFlag == 0) {
                    wx.navigateTo({
                      url: '/pages/main/main',
                      success:function() {
                        wx.showToast({
                          title: '登入成功!',
                        })
                      }
                    })
                  }
                }else {
                  that.data.id = ress.data.result.id;
                  wx.navigateTo({
                    url: '/pages/Information/Information',
                    success:function() {
                      wx.showToast({
                        title: '请先注册!',
                      })
                    }
                  })
                }
              }
            })
          }
        })
      }
    })
    // 获取用户信息
    wx.getSetting({
      success: res => {
        if (res.authSetting['scope.userInfo']) {
          // 已经授权，可以直接调用 getUserInfo 获取头像昵称，不会弹框
          wx.getUserInfo({
            success: res => {
              // 可以将 res 发送给后台解码出 unionId
              this.globalData.userInfo = res.userInfo

              // 由于 getUserInfo 是网络请求，可能会在 Page.onLoad 之后才返回
              // 所以此处加入 callback 以防止这种情况
              if (this.userInfoReadyCallback) {
                this.userInfoReadyCallback(res)
              }
            }
          })
        }
      }
    })
  },
  globalData: {
    userInfo: null
  }
})