import { getRequest, postRequest, putRequest, postBodyRequest, getNoAuthRequest, postNoAuthRequest } from '@/libs/axios';

export const getBlacklistOne = (params) => {
    return getRequest('/blacklist/getOne', params)
}
export const getBlacklistList = (params) => {
    return getRequest('/blacklist/getByPage', params)
}
export const getBlacklistCount = (params) => {
    return getRequest('/blacklist/count', params)
}
export const addBlacklist = (params) => {
    return postRequest('/blacklist/insert', params)
}
export const editBlacklist = (params) => {
    return postRequest('/blacklist/update', params)
}
export const addOrEditBlacklist = (params) => {
    return postRequest('/blacklist/insertOrUpdate', params)
}
export const deleteBlacklist = (params) => {
    return postRequest('/blacklist/delByIds', params)
}