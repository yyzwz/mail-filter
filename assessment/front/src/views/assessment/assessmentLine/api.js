// 统一请求路径前缀在libs/axios.js中修改
import { getRequest, postRequest, putRequest, postBodyRequest, getNoAuthRequest, postNoAuthRequest } from '@/libs/axios';

// 分页获取数据
export const getAssessmentLineList = (params) => {
    return getRequest('/assessmentLine/getByPage', params)
}
// 添加
export const addAssessmentLine = (params) => {
    return postRequest('/assessmentLine/insertOrUpdate', params)
}
// 编辑
export const editAssessmentLine = (params) => {
    return postRequest('/assessmentLine/insertOrUpdate', params)
}
// 删除
export const deleteAssessmentLine = (params) => {
    return postRequest('/assessmentLine/delByIds', params)
}