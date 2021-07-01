// 统一请求路径前缀在libs/axios.js中修改
import { getRequest, postRequest, putRequest, postBodyRequest, getNoAuthRequest, postNoAuthRequest } from '@/libs/axios';

// 分页获取数据
export const getTwoWindowsList = (params) => {
    return getRequest('/twoWindows/getAll', params)
}
// 添加
export const addTwoWindows = (params) => {
    return postRequest('/twoWindows/insertOrUpdate', params)
}
// 编辑
export const editTwoWindows = (params) => {
    return postRequest('/twoWindows/insertOrUpdate', params)
}
// 删除
export const deleteTwoWindows = (params) => {
    return postRequest('/twoWindows/delByIds', params)
}
export const getNowTimes = (params) => {
    return getRequest('/assessmentTime/getNowTimes', params)
}
export const getAllAssessmentLine = (params) => {
    return getRequest('/assessmentLine/getAll', params)
}
export const updateTwoWindows = (params) => {
    return postRequest('/twoWindows/update', params)
}
export const getAllVillageList = (params) => {
    return getRequest('/village/getAll', params)
}
export const getFourWindowsList = (params) => {
    return getRequest('/s4ShenShu/getByVillage', params)
}