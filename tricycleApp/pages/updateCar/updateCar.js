// 郑为中
// 分页面1的JS文件
const app = getApp();
Page({
  data: {
    id: '',
    sellDate: '未填写', // 出售日期
    jia: '', // 车架号
    gu: '', // 车骨号
    pinPai: '', // 车品牌
    xingHao: '', // 车型号
    type: '未选择', // 车类型
    typeList: ['电动三轮车','汽油三轮车','其他'],
    idCard: '',
    region: ['浙江省', '宁波市', '宁海县'],
    regionData: '',
    ownerAddress1: '',
    region2: ['浙江省', '宁波市', '宁海县'],
    regionData2: '',
    ownerAddress2: '',
    ownerName: '',
    ownerMobile: '',
    ownerIdcard: '',


    //房屋类型部分
    newHouseTypeIdList: [],
    newHouseTypeNameList:[],
    newHouseTypeList:[],
    innn:'0',
    houseTypeMsg: '请选择房子的类型', 
    // 村庄类型部分
    newVillageList:[],
    newVillageIdList: [], // new
    newVillageNameList: [],
    villageMsg: '请选择房子所在村社',
    inn: '0',
    // 界面
    height: 40,
    primarySize: 'mini',
    // 表单
    loginID:'',
    name: '',//房屋名称
    address: '', //详细地址
    about: '', //其他描述说明
    indexx:'',//社区数组下标
    images: [] ,//存放图片的数组
    userAddress:'',
    userRole: '1',
    insertHouseID:'',
  },
  onLoad: function (options) {
    console.log(options);
    this.setData({
      id: options.id
    })
    this.getOneCarData();
  },
  deleteCarData() {
    var that = this;
    console.log(app.data);
    wx.showModal({
      title: '确定删除该车辆?',
      content: '管理员审核通过后才会删除',
      success (res) {
        if (res.confirm) {
          wx.request({
            url: app.data.appUrl + '/car/appDelete',
            method: 'POST',
            data: {
              id: that.data.id,
              sellerId: app.data.id
            },
            header: {
              "Content-Type": "application/x-www-form-urlencoded" // 默认值
            },
            success: function (res) {
              if(res.data.message) {
                wx.showToast({
                  title: '已提交审核',
                })
              }else {
                // wx.showToast({
                //   title: '系统正在维护',
                // })
              }
            }
          });
        } else if (res.cancel) {
        }
      }
    });
  },
  getOneCarData() {
    var that = this;
    wx.request({
      url: app.data.appUrl + '/car/get',
      method: 'GET',
      data: {
        id: that.data.id
      },
      header: {
        "Content-Type": "application/x-www-form-urlencoded" // 默认值
      },
      success: function (res) {
        console.log(res);
        that.setData({
          id: res.data.result.id,
          sellDate: res.data.result.sellDate,
          jia: res.data.result.jia,
          gu: res.data.result.gu,
          pinPai: res.data.result.pinPai,
          xingHao: res.data.result.xingHao,
          ownerAddress1: res.data.result.addressHu,
          ownerAddress2: res.data.result.addressZhu,
          ownerName: res.data.result.name,
          ownerMobile: res.data.result.mobile,
          ownerIdcard: res.data.result.ownerIdcard,
          type: res.data.result.type,
          regionData: res.data.result.re1,
          regionData2: res.data.result.re2
        })
        // that.data.id = res.data.result.id;
        // that.data.sellDate = res.data.result.sellDate;
        // that.data.jia = res.data.result.jia;
        // that.data.gu = res.data.result.gu;
        // that.data.pinPai = res.data.result.pinPai;
        // that.data.xingHao = res.data.result.xingHao;
        // that.data.idCard = res.data.result.idCard;
        // that.data.ownerAddress1 = res.data.result.ownerAddress1;
        // that.data.ownerAddress2 = res.data.result.ownerAddress2;
        // that.data.ownerName = res.data.result.ownerName;
        // that.data.ownerMobile = res.data.result.ownerMobile;
        // that.data.ownerIdcard = res.data.result.ownerIdcard;
      },
      complete:function(){
        wx.hideLoading();
      }
    });
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
    wx.showModal({
      title: '确认提交审核?',
      content: '更改车辆信息,审核通过后生效',
      success (res) {
        if (res.confirm) {
          if (that.data.images.length == 0) {
            wx.showLoading({});
            wx.request({
              url: app.data.appUrl + '/car/appUpdateCar?g=api&m=banana&a=upload_info',
              method: 'POST',
              data: {
                id: that.data.id,
                sellDate: that.data.sellDate,
                jia: that.data.jia,
                gu: that.data.gu,
                pinPai: that.data.pinPai,
                xingHao: that.data.xingHao,
                type: that.data.type,
                ownerName: that.data.ownerName,
                ownerMobile: that.data.ownerMobile,
                ownerIdcard: that.data.ownerIdcard,
                ownerAddress1: that.data.ownerAddress1,
                ownerAddress2: that.data.ownerAddress2,
                re1: that.data.regionData,
                re2: that.data.regionData2,
                sellerId: app.data.id
              },
              header: {
                "Content-Type": "application/x-www-form-urlencoded" // 默认值
              },
              success: function (res) {
                wx.showToast({
                  title: '已提交审核',
                })
              },
              complete:function(){
                wx.hideLoading();
              }  
            })
          }
          else {
            wx.showLoading({});
              wx.uploadFile({
                url: app.data.appUrl + '/car/appUpdateCar?g=api&m=banana&a=upload_info',
                filePath: that.data.images[0],
                name: 'photo',
                formData: {
                  id: that.data.id,
                  sellDate: that.data.sellDate,
                  jia: that.data.jia,
                  gu: that.data.gu,
                  pinPai: that.data.pinPai,
                  xingHao: that.data.xingHao,
                  type: that.data.type,
                  ownerName: that.data.ownerName,
                  ownerMobile: that.data.ownerMobile,
                  ownerIdcard: that.data.ownerIdcard,
                  ownerAddress1: that.data.ownerAddress1,
                  ownerAddress2: that.data.ownerAddress2,
                  re1: that.data.regionData,
                  re2: that.data.regionData2,
                  sellerId: app.data.id
                },
                success: function (res) {
                  console.log("图片 = " + that.data.images)
                  console.log(res);
                  var resJson = JSON.parse(res.data).result;
                  wx.uploadFile({
                    url: app.data.appUrl + '/car/uploadFaPiaoImages?g=api&m=banana&a=upload_info',
                    filePath: that.data.images[0],
                    method: 'POST',
                    name: 'file',
                    header: { "Content-Type": "application/x-www-form-urlencoded" },
                    formData: {
                      id: that.data.id,
                    },
                    success: function (res) {
                      console.log(res);
                      wx.showToast({
                        title: '修改成功',
                      })
                    },
                    fail: function (res) {
                      console.log(res);
                    },
                  })
                },
                fail: function (error) {
                },
                complete:function(){
                  wx.hideLoading();
                }    
              })
            // }
          }
        } else if (res.cancel) {

        }
      }
    })
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