// 统一请求路径前缀在libs/axios.js中修改
import { getRequest, postRequest, putRequest, postBodyRequest, getNoAuthRequest, postNoAuthRequest } from '@/libs/axios';

// 分页获取数据
export const getAssessmentTimeList = (params) => {
    return getRequest('/assessmentTime/getByPage', params)
}
// 添加
export const addAssessmentTime = (params) => {
    return postRequest('/assessmentTime/insertOrUpdate', params)
}
// 编辑
export const editAssessmentTime = (params) => {
    return postRequest('/assessmentTime/insertOrUpdate', params)
}
// 删除
export const deleteAssessmentTime = (params) => {
    return postRequest('/assessmentTime/delByIds', params)
}