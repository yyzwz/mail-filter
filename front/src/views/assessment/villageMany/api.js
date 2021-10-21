// 统一请求路径前缀在libs/axios.js中修改
import { getRequest, postRequest, putRequest, postBodyRequest, getNoAuthRequest, postNoAuthRequest } from '@/libs/axios';

// 分页获取数据
export const getVillageManyList = (params) => {
    return getRequest('/villageMany/getByPage', params)
}
// 添加
export const addVillageMany = (params) => {
    return postRequest('/villageMany/insertOrUpdate', params)
}
// 编辑
export const editVillageMany = (params) => {
    return postRequest('/villageMany/insertOrUpdate', params)
}
// 删除
export const deleteVillageMany = (params) => {
    return postRequest('/villageMany/delByIds', params)
}
export const getVillageManyVoList = (params) => {
    return getRequest('/villageManyVo/getByPage', params)
}
export const getVillageList = (params) => {
    return getRequest('/village/getByPage', params)
}
export const getByManyId = (params) => {
    return getRequest('/village/getByManyId', params)
}
export const addVillageManyVo = (params) => {
    return postRequest('/villageManyVo/insert', params)
}