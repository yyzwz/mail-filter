// 统一请求路径前缀在libs/axios.js中修改
import { getRequest, postRequest, putRequest, postBodyRequest, getNoAuthRequest, postNoAuthRequest } from '@/libs/axios';

// 分页获取数据
export const getCarList = (params) => {
    return getRequest('/car/getByPage', params)
}
// 添加
export const addCar = (params) => {
    return postRequest('/car/insertOrUpdate', params)
}
// 编辑
export const editCar = (params) => {
    return postRequest('/car/insertOrUpdate', params)
}
// 删除
export const deleteCar = (params) => {
    return postRequest('/car/delByIds', params)
}
export const getSellerList = (params) => {
    return getRequest('/seller/getByPage', params)
}
export const getCarOwnerList = (params) => {
    return getRequest('/carOwner/getByPage', params)
}