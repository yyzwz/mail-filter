// 郑为中
// 分页面1的JS文件
const app = getApp();
Page({
  data: {
    sellDate: '未填写', // 出售日期
    jia: '', // 车架号
    gu: '', // 车骨号
    pinPai: '', // 车品牌
    xingHao: '', // 车型号
    type: '未选择', // 车类型
    typeList: ['电动三轮车','汽油三轮车','其他'],
    region: ['浙江省', '宁波市', '宁海县'],
    regionData: '未选择户籍地址区县',
    ownerAddress1: '',
    region2: ['浙江省', '宁波市', '宁海县'],
    regionData2: '未选择住址区县',
    ownerAddress2: '',
    ownerName: '',
    ownerMobile: '',
    ownerIdcard: '',
    ownerAddress1: '',
    height: 40,
    primarySize: 'mini',
    images: [] ,//存放图片的数组
    sh: 0,
  },
  onLoad: function (options) {
    this.setData({
      sh: app.data.sh
    })
  },
  bindRegionChange: function (e) {
    console.log(e);
    this.setData({
      regionData: e.detail.value[0] + e.detail.value[1] + e.detail.value[2]
    })
  },
  bindRegionChange2: function (e) {
    console.log(e);
    this.setData({
      regionData2: e.detail.value[0] + e.detail.value[1] + e.detail.value[2]
    })
  },
  changeOwnerAddress1: function(e) {
    this.setData({
      ownerAddress1: e.detail.value
    })
  },
  changeOwnerAddress2: function(e) {
    this.setData({
      ownerAddress2: e.detail.value
    })
  },
  sellDate: function(e) {
    this.setData({
      sellDate: e.detail.value
    })
  },
  changeCarType: function(e) {
    var that = this;
    this.setData({
      type: that.data.typeList[e.detail.value]
    })
  },
  changeJia: function (e) {
    this.setData({
      jia: e.detail.value
    })
  },
  changeGu: function (e) {
    this.setData({
      gu: e.detail.value
    })
  },
  changePinPai: function (e) {
    this.setData({
      pinPai: e.detail.value
    })
  },
  changeXingHao: function (e) {
    this.setData({
      xingHao: e.detail.value
    })
  },
  changeJia: function (e) {
    this.setData({
      jia: e.detail.value
    })
  },
  changeOwnerName: function (e) {
    this.setData({
      ownerName: e.detail.value
    })
  },
  changeOwnerMobile: function (e) {
    this.setData({
      ownerMobile: e.detail.value
    })
  },
  changeOwnerIdCard: function (e) {
    this.setData({
      ownerIdcard: e.detail.value
    })
  },
  addHouse: function () {
    var images_list = [];
    var that = this;
    var mobile_reg = /^((13[0-9])|(14[0-9])|(15[0-9])|(16[0-9])|(17[0-9])|(18[0-9])|(19[0-9]))\\d{8}$/;
    var idcard_reg = /^[1-9]\d{5}(18|19|([23]\d))\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$/;
    if(that.data.sellDate == '未填写') {
      wx.showToast({
        title: '未选择出售日',
      })
      return ;
    }
    if(that.data.type == '未选择') {
      wx.showToast({
        title: '未选择车类型',
      })
      return ;
    }
    if(that.data.jia == '') {
      wx.showToast({
        title: '车架号为空',
      })
      return ;
    }
    if(that.data.gu == '') {
      wx.showToast({
        title: '车骨号为空',
      })
      return ;
    }
    if(that.data.pinPai == '') {
      wx.showToast({
        title: '车品牌为空',
      })
      return ;
    }
    if(that.data.xingHao == '') {
      wx.showToast({
        title: '车型号为空',
      })
      return ;
    }
    if(that.data.ownerName == '') {
      wx.showToast({
        title: '驾驶人姓名为空',
      })
      return ;
    }
    if(that.data.ownerMobile.length != 11) {
      wx.showToast({
        title: '驾驶人手机错误',
      })
      return ;
    }
    if(idcard_reg.test(that.data.ownerIdcard) == false) {
      wx.showToast({
        title: '身份证错误',
      })
      return ;
    }
    if(that.data.regionData == '未选择户籍地址区县') {
      wx.showToast({
        title: '户籍地址未选择',
      })
      return ;
    }
    if(that.data.regionData2 == '未选择住址区县') {
      wx.showToast({
        title: '住址未选择',
      })
      return ;
    }
    if(that.data.ownerAddress1 == '') {
      wx.showToast({
        title: '详细户籍地址为空',
      })
      return ;
    }
    if(that.data.ownerAddress2 == '') {
      wx.showToast({
        title: '详细住址为空',
      })
      return ;
    }

      // 如果没有图片
      if (that.data.images.length == 0) {
        wx.showLoading({});
        wx.request({
          url: app.data.appUrl + '/car/appAddCar?g=api&m=banana&a=upload_info',
          method: 'POST',
          data: {
            sellDate: that.data.sellDate,
            jia: that.data.jia,
            gu: that.data.gu,
            pinPai: that.data.pinPai,
            xingHao: that.data.xingHao,
            type: that.data.type,
            sellerId: app.data.id,
            ownerName: that.data.ownerName,
            ownerMobile: that.data.ownerMobile,
            ownerIdcard: that.data.ownerIdcard,
            ownerAddress1: that.data.ownerAddress1,
            ownerAddress2: that.data.ownerAddress2,
            re1: that.data.regionData,
            re2: that.data.regionData2
          },
          header: {
            "Content-Type": "application/x-www-form-urlencoded" // 默认值
          },
          success: function (res) {
            if(res.data.success) {
              wx.navigateBack({
                delta: 1,
                success: function() {
                  wx.showToast({
                    title: '添加成功',
                  })
                }
              })
            }else {
              // wx.showToast({
              //   title: '系统正在维护',
              // })
            }
          },
          complete:function(){
            wx.hideLoading();
          }  
        })
      }
      else {
        wx.showLoading({});   
          wx.uploadFile({
            url: app.data.appUrl + '/car/appAddCar?g=api&m=banana&a=upload_info',
            filePath: that.data.images[0],
            name: 'photo',
            formData: {
              sellDate: that.data.sellDate,
              jia: that.data.jia,
              gu: that.data.gu,
              pinPai: that.data.pinPai,
              xingHao: that.data.xingHao,
              type: that.data.type,
              sellerId: app.data.id,
              ownerName: that.data.ownerName,
              ownerMobile: that.data.ownerMobile,
              ownerIdcard: that.data.ownerIdcard,
              ownerAddress1: that.data.ownerAddress1,
              ownerAddress2: that.data.ownerAddress2,
              re1: that.data.regionData,
              re2: that.data.regionData2
            },
            success: function (res) {
              console.log("图片 = " + that.data.images)
              var resJson = JSON.parse(res.data).result;
              wx.uploadFile({
                url: app.data.appUrl + '/car/uploadFaPiaoImages?g=api&m=banana&a=upload_info',
                filePath: that.data.images[0],
                method: 'POST',
                name: 'file',
                header: { "Content-Type": "application/x-www-form-urlencoded" },
                formData: {
                  id: resJson
                },
                success: function (res) {
                  wx.navigateBack({
                    delta: 1,
                    success: function() {
                      wx.showToast({
                        title: '添加成功',
                      })
                    }
                  })
                },
                fail: function (res) {
                  console.log(res);
                },
              })
              if(res.data.success) {
                wx.navigateBack({
                  delta: 1,
                  success: function() {
                    wx.showToast({
                      title: '添加成功',
                    })
                  }
                })
              }else {
                // wx.showToast({
                //   title: '系统正在维护',
                // })
              }
            },
            fail: function (error) {
            },
            complete:function(){
              wx.hideLoading();
            }    
          })
      }
  },
  // 选择照片
  chooseImage: function (e) {
    wx.chooseImage({
      sizeType: ['compressed'], //可选择原图或压缩后的图片
      sourceType: ['album', 'camera'], //可选择性开放访问相册、相机
      success: res => {
        console.log(res);
        if (this.data.images.length <= 0) {
          if(res.tempFiles[0].size > 5242870) {
            wx.showToast({
              title: '发票图片最大5MB,请重新上传',
              icon: 'none',
              duration: 2000,
              mask: true
            })
          }else {
            const images = this.data.images.concat(res.tempFilePaths)
            this.setData({
              images: images
            })
          }
        } else {
          wx.showToast({
            title: '最多只能选择一张照片',
            icon: 'none',
            duration: 2000,
            mask: true
          })
        }
      }
    })
  },
  // 移除图片
  removeImage(e) {
    const idx = e.target.dataset.idx;
    console.log(e.target.dataset.idx);
    this.data.images.splice(idx, 1);
    var del_image = this.data.images;
    this.setData({
      images: del_image
    })
  },
  // 预览图片
  handleImagePreview(e) {
    const idx = e.target.dataset.idx
    const images = this.data.images
    wx.previewImage({
      current: images[idx], //当前预览的图片
      urls: images, //所有要预览的图片
    })
  },
})