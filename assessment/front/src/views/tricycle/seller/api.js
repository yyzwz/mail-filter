// 统一请求路径前缀在libs/axios.js中修改
import { getRequest, postRequest, putRequest, postBodyRequest, getNoAuthRequest, postNoAuthRequest } from '@/libs/axios';

// 分页获取数据
export const getSellerList = (params) => {
    return getRequest('/seller/getByPage', params)
}
// 添加
export const addSeller = (params) => {
    return postRequest('/seller/insertOrUpdate', params)
}
// 编辑
export const editSeller = (params) => {
    return postRequest('/seller/insertOrUpdate', params)
}
// 删除
export const deleteSeller = (params) => {
    return postRequest('/seller/delByIds', params)
}