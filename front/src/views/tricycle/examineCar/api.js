// 统一请求路径前缀在libs/axios.js中修改
import { getRequest, postRequest, putRequest, postBodyRequest, getNoAuthRequest, postNoAuthRequest } from '@/libs/axios';

// 分页获取数据
export const getSellerNotShList = (params) => {
    return getRequest('/car/getByNotSh', params)
}
// 添加
export const addElectricAudit = (params) => {
    return postRequest('/electricAudit/insertOrUpdate', params)
}
// 编辑
export const editElectricAudit = (params) => {
    return postRequest('/electricAudit/insertOrUpdate', params)
}
// 删除
export const deleteElectricAudit = (params) => {
    return postRequest('/electricAudit/delByIds', params)
}
// 审核通过
export const pass = (params) => {
    return postRequest('/car/sh', params)
}
// 审核退回
export const dispass = (params) => {
    return postRequest('/electricAudit/dispass', params)
}
// 获取未审核电表
export const getAllNot = (params) => {
    return getRequest('/electricAudit/getAllNot', params)
}