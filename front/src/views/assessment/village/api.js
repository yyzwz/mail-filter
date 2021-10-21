// 统一请求路径前缀在libs/axios.js中修改
import { getRequest, postRequest, putRequest, postBodyRequest, getNoAuthRequest, postNoAuthRequest } from '@/libs/axios';

// 分页获取数据
export const getVillageList = (params) => {
    return getRequest('/village/getByPage', params)
}
// 添加
export const addVillage = (params) => {
    return postRequest('/village/insertOrUpdate', params)
}
// 编辑
export const editVillage = (params) => {
    return postRequest('/village/insertOrUpdate', params)
}
// 删除
export const deleteVillage = (params) => {
    return postRequest('/village/delByIds', params)
}