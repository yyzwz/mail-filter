// 统一请求路径前缀在libs/axios.js中修改
import { getRequest, postRequest, putRequest, postBodyRequest, getNoAuthRequest, postNoAuthRequest } from '@/libs/axios';

// 分页获取数据
export const getAdminLookArchList = (params) => {
    return getRequest('/adminLookArch/getByPage', params)
}
// 添加
export const addAdminLookArch = (params) => {
    return postRequest('/adminLookArch/insertOrUpdate', params)
}
// 编辑
export const editAdminLookArch = (params) => {
    return postRequest('/adminLookArch/insertOrUpdate', params)
}
// 删除
export const deleteAdminLookArch = (params) => {
    return postRequest('/adminLookArch/delByIds', params)
}