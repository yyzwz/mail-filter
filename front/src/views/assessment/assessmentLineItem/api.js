// 统一请求路径前缀在libs/axios.js中修改
import { getRequest, postRequest, putRequest, postBodyRequest, getNoAuthRequest, postNoAuthRequest } from '@/libs/axios';

// 分页获取数据
export const getAssessmentLineItemList = (params) => {
    return getRequest('/assessmentLineItem/getByPage', params)
}
// 添加
export const addAssessmentLineItem = (params) => {
    return postRequest('/assessmentLineItem/insertOrUpdate', params)
}
// 编辑
export const editAssessmentLineItem = (params) => {
    return postRequest('/assessmentLineItem/insertOrUpdate', params)
}
// 删除
export const deleteAssessmentLineItem = (params) => {
    return postRequest('/assessmentLineItem/delByIds', params)
}
export const getNowTimes = (params) => {
    return getRequest('/assessmentTime/getNowTimes', params)
}
export const getAllAssessmentLine = (params) => {
    return getRequest('/assessmentLine/getAll', params)
}